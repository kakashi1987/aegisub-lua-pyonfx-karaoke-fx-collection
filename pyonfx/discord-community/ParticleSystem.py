from pyonfx import *
import random, math, progressbar

"""
https://blenderartists.org/t/basic-python-particle-class-setup/646106/1
https://editor.p5js.org/codingtrain/sketches/D4ty3DgZB
https://stackoverflow.com/questions/14885349/how-to-implement-a-particle-engine
"""

io = Ass("in.ass")
meta, styles, lines = io.get_data()
bar = progressbar.ProgressBar(max_value=len(lines), prefix="(Progress Bar)")


frame_rate = 23.976
frame_duration = 1000 / frame_rate

class Particle:
    def __init__(self, x, y, total_frames):
        self.x = x
        self.y = y
        self.vx = random.uniform(-2,2)   
        self.vy = random.uniform(-2,-6) 
        self.lifetime = max(1, total_frames // 2)  
        self.alpha = 255
        self.alive = True

    def update(self, center_x, frame_number, total_frames):
        self.vx += math.cos(frame_number / total_frames * math.pi * 2) /2 
        self.x += self.vx
        self.y += self.vy
        self.alpha -= 30
        self.lifetime -= 0.5
        self.alive = self.lifetime > 0 and self.alpha > 0

    def finished(self):
        return self.alpha < 0

    def draw(self):
        return Shape.ring(random.uniform(1,2), 0).move(self.x, self.y)

def particles_per_frame(total_particles, frames):
    return max(1, total_particles // frames)

def update_particles(particle, center_x, frame_number, total_frames, syl, line):
    particle.update(center_x, frame_number, total_frames)
    if particle.alive:
        shape = particle.draw()
        l = line.copy()
        l.layer = 0

        yfix = 7 if syl.duration <= 200 else 3
        _x, _y = syl.left + particle.x, particle.y + syl.top 
        end_y = _y + particle.vy * yfix

        alphaV = '%02X' % (255 - particle.alpha)
        l.start_time = line.start_time + syl.start_time + int(frame_number * frame_duration)
        l.end_time = l.start_time + int(frame_duration) + 160
        l.text = f"{{\\p1\\an7\\bord2\\blur3\\shad0\\3c&HE1CD77&\\fad(0,60)\\3a&H9F&\\1c&HFFFFFF&\\1a&H{alphaV}&\\move({_x},{_y},{_x},{end_y}}}{shape}"
        io.write_line(l)

def create_particles(syl, line):
    particles = []

    syllable_frames = int((syl.duration / frame_duration)+2)  
    particles_per_frame = 10 if syl.duration <= 160 else 3
    total_particles = syllable_frames * particles_per_frame 

    xmov_width = syl.width / 1.6 if syl.postspace else syl.width / 2
    x_width = xmov_width / total_particles
    current_x = 0

    for frame_number in range(syllable_frames):
        new_particles = min(particles_per_frame, total_particles - len(particles))
        for _ in range(new_particles):
            particles.append(Particle(current_x, 15, syllable_frames))
            current_x += x_width 

        for particle in particles[:]:
            update_particles(particle, xmov_width, frame_number, syllable_frames, syl, line)


for li, line in enumerate(lines):
    if not line.comment:
        for syl in Utils.all_non_empty(line.syls):
            l = line.copy()
            l.layer = 0
            _x, _y = syl.left, syl.top  
            l.start_time = line.start_time -5
            l.end_time = line.end_time+5
            l.text = f"{{\\an7\\shad0\\pos({_x},{_y})}}{syl.text}"
            io.write_line(l)

            create_particles(syl, line)

        bar.update(li + 1)

bar.finish()
io.save()
io.open_aegisub()



