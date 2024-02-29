from pyonfx import *

from PIL import Image, ImageDraw, ImageFont, ImageFilter, ImageChops
import numpy as np
import random, math
p_sh = Shape.rectangle()

class Pixel:
    def __init__(self, x, y, opacity):
        self.x = x
        self.y = y
        self.opacity = opacity

##### Method_01 

def outline_text_to_pixelsX(obj):
    xy_pairs = []
    for pixel in Convert.text_to_pixels(obj):
        x, y, alpha = int(pixel.x), int(pixel.y), pixel.alpha
        xy_pairs.append([x, y])

    max_x, max_y = np.max(xy_pairs, 0)
    im = Image.new(mode="L", size=(max_x+2, max_y+2))   
    pixels = im.load()
    for xy_temp in xy_pairs:
        pixels[xy_temp[0], xy_temp[1]] = 255

    edge_coords = []
    for x, y in xy_pairs:
        neighbors = [(x+i, y+j) for i in range(-1, 2) for j in range(-1, 2)]
        if any(pixels[nx, ny] == 0 for nx, ny in neighbors if 0 <= nx < max_x+2 and 0 <= ny < max_y+2):
            edge_coords.append((x, y))
    
    # Creating Pixel objects for each coordinate
    outline_pixels = [Pixel(coord[0], coord[1], 255) for coord in edge_coords]
    
    return outline_pixels


##### Method_02

def outline_text_to_pixelsS(obj, supersampling, dilation_size=3, canvas_padding=5):
    xy_pairs = []
    for pixel in Convert.text_to_pixels(obj, supersampling):
        x, y, alpha = int(pixel.y), int(pixel.x), pixel.alpha
        xy_pairs.append([x, y])

    max_x, max_y = np.max(xy_pairs, 0)
    
    im = Image.new(mode="L", size=(max_x+1, max_y+1 + canvas_padding))
    pixels = im.load()
    for xy_temp in xy_pairs:
        pixels[xy_temp[0], xy_temp[1]] = 255

    im2 = im.filter(ImageFilter.FIND_EDGES)

    dilated_im = im2.filter(ImageFilter.MaxFilter(dilation_size))
    edge_coords = np.argwhere(np.array(dilated_im))

    outline_pixels = [Pixel(coord[0], coord[1], 255) for coord in edge_coords]

    return outline_pixels


def sub(line, l, io):
    for syl in Utils.all_non_empty(line.syls):   


        x_fix = 0.5 ### Fix x Pos
        l.start_time = line.start_time -100
        l.end_time =  line.end_time  
        l.layer = 3
        l.text = "{\\bord0\\c&Hffffff&\\an7\\fad(100,100)\\shad0\\pos(%.3f,%.3f)}%s" % (syl.left+x_fix+150, syl.top, syl.text)
        #io.write_line(l)

        l.start_time = line.start_time-100
        l.end_time = line.end_time
        l.layer = 3
        l.text = "{\\bord0\\c&Hffffff&\\an7\\fad(100,100)\\shad0\\pos(%.3f,%.3f)}%s" % (syl.left+x_fix-250, syl.top+60, syl.text)
        #io.write_line(l)

        
        outline_pixels = outline_text_to_pixelsX(syl)
        
        for i, pixel in enumerate(outline_pixels):
            x = pixel.x  + syl.left  
            y = pixel.y + syl.top

            angle = 2 * math.pi * random.random()  
            distance = random.uniform(30, 70)   

            end_x = x + distance * math.cos(angle)
            end_y = y + distance * math.sin(angle)

            pnum = i / len(outline_pixels)

            l.dur  = Utils.interpolate(pnum, 50, line.duration)
            l.start_time = line.start_time  -250
            l.end_time = line.end_time + l.dur
            l.text = "{\\bord0.6\\c&H000000&\\blur0.6\\an7\\fad(50,500)\\shad0\\move(%d,%d,%d,%d,100,%d)\\p1}%s" % (x+150,y , end_x+150 , end_y,l.dur, p_sh)
            l.layer = 1
            io.write_line(l)


        outline_pixels = outline_text_to_pixelsS(syl,4, dilation_size=3, canvas_padding=5)
        
        for i, pixel in enumerate(outline_pixels):

            x = pixel.x  + syl.left  
            y = pixel.y + syl.top+60

            angle = 2 * math.pi * random.random()  
            distance = random.uniform(30, 70)   

            end_x = x + distance * math.cos(angle)
            end_y = y + distance * math.sin(angle)

            pnum = i / len(outline_pixels)
            l.dur  = Utils.interpolate(pnum, 50, line.duration)
            
            l.start_time = line.start_time-250
            l.end_time = line.end_time + l.dur
            l.text = "{\\bord0.4\\c&H000000&\\blur0.4\\an7\\shad0\\fad(50,500)\\move(%d,%d,%d,%d,100,%d)\\p1}%s" % (x-250,y, end_x-250 , end_y,l.dur, p_sh)
            l.layer = 1
            io.write_line(l)


def main():
    io = Ass("in.ass")
    meta, styles, lines = io.get_data()
    
    for line in lines:
        sub(line, line.copy(), io)

    io.save()
    io.open_aegisub()

if __name__ == "__main__":
    main()
