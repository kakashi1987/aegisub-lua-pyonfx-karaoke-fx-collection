include("karaskel.lua")

script_name = "FX_LUA.4"
script_description = "FX_Riuuzaki & Alkoon"

function FX_6(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)
	
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment then
			karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else
			i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("Finished!")
	aegisub.progress.set(100)

end


function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 20
if i ==1 then tiempo=0
end
		
                                   l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\bord0\\shad0\\fad(100,0)}%s",x,y,syl.text)
		l.start_time=line.start_time-80
		l.end_time=line.start_time+syl.start_time
		subs.append(l)
		
		local duracion = syl.duration
		local tempo = 300
		l = table.copy(line)
		l.text = string.format("{\\an5\\fad(0,300)\\3c&HFFFFFF&\\bord0\\move(%d,%d,%d,%d)\\clip(%d,%d,%d,%d)\\t(\\clip(%d,%d,%d,%d)\\t(80,0,\\3c&H1112E4&\\be2\\1c&H1112E4&)}%s",x,y,x,y-25,x-syl.width/2,y-syl.height/2+3,x+syl.width/2,y+3,   x-syl.width/2,y-syl.height/2-23,x+syl.width/2,y-23,syl.text)
		l.start_time=line.start_time+syl.start_time
		l.end_time=l.start_time+duracion+tempo
		subs.append(l)
		l = table.copy(line)
		l.text = string.format("{\\an5\\fad(0,300)\\3c&HFFFFFF&\\bord0\\move(%d,%d,%d,%d)\\clip(%d,%d,%d,%d)\\t(\\clip(%d,%d,%d,%d)\\t(80,0,\\3c&H1112E4&\\be2\\1c&H1112E4&)}%s",x,y,x,y+25, x-syl.width/2+2,y+3,x+syl.width/2,y+syl.height/2+3,   x-syl.width/2,y+26,x+syl.width/2,y+syl.height/2+26,syl.text)
		l.start_time=line.start_time+syl.start_time
		l.end_time=l.start_time+duracion+tempo
		subs.append(l)


		l = table.copy(line)
		l.text = string.format("{\\an5\\fad(0,0)\\1c&H1112E4&\\bord0\\be1\\fscx150\\fscy150\\move(%d,%d,%d,%d)\\p1}m 7 8 b 7 8 7 8 7 8 b 4 8 0 8 1 8 b 0 8 -5 3 -7 3 b -7 3 -22 3 -22 3 b -22 3 -31 6 -31 5 b -31 6 -31 5 -32 9 b -34 9 -35 9 -35 9 b -35 13 -35 15 -35 15 b -36 18 -27 17 -27 17 b -27 10 -19 10 -19 17 b -14 17 -6 17 1 17 b 1 10 9 10 9 17 b 12 17 12 17 15 17 b 15 17 16 16 14 15 b 16 16 15 13 14 9 b 14 9 13 8 11 8 m -2 8 b -11 8 -21 8 -21 8 b -21 8 -21 5 -21 5 b -21 5 -8 5 -7 5 b -7 5 -4 6 -2 8 m -22 5 l -22 8 l -30 8 l -30 7  {\\p0}",x,y-3,x+22,y-3,syl.text)
		l.start_time=line.start_time+syl.start_time
		l.end_time=l.start_time+duracion
		subs.append(l)

		l = table.copy(line)
		l.text = string.format("{\\an5\\fad(0,0)\\1c&HE0E0E0&\\bord0\\be1\\fscx70\\fscy70\\move(%d,%d,%d,%d)\\p1}m -39 13 b -44 13 -45 17 -45 19 b -45 21 -44 25 -39 25 b -34 25 -33 21 -33 19 b -33 17 -34 13 -39 13  {\\p0}",x,y,x+22,y,syl.text)
		l.start_time=line.start_time+syl.start_time
		l.end_time=l.start_time+duracion
		subs.append(l)
		l = table.copy(line)
		l.text = string.format("{\\an5\\fad(0,0)\\1c&HE0E0E0&\\bord0\\be1\\fscx70\\fscy70\\move(%d,%d,%d,%d)\\p1}m -99 13 b -104 13 -105 17 -105 19 b -105 21 -104 25 -99 25 b -94 25 -93 21 -93 19 b -93 17 -94 13 -99 13 {\\p0}",x,y,x+22,y,syl.text)
		l.start_time=line.start_time+syl.start_time
		l.end_time=l.start_time+duracion
		subs.append(l)


		l = table.copy(line)
		for i=0,40 do
    		random_pos = math.random(200,380)
    		l.layer=0
    		l.text = string.format("{\\fad(0,200)\\move(%d,%d,%d,%d)\\an5\\shad0\\bord0\\be1\\1c&H191AA9&\\t(\\fscx%d\\fscy%d))}{\\p%d}m 0 0 m 10 20 b 16 20 20 16 20 10 b 20 4 16 0 10 0 b 2 0 0 6 0 10 b 0 16 4 20 10 20 {\\p0}",x-math.random(-20,20),y-math.random(-20,20),x+math.random(-35,25)*syl.duration/800,y+math.random(-35,25),random_pos,random_pos,math.random(4,6))
   		l.start_time=line.start_time+syl.start_time+20
    		l.end_time=l.start_time+syl.duration+math.random(200,400)+300
    		l.start_time=l.start_time+i
    		subs.append(l)
    		end
		l = table.copy(line)
		for i=0,15 do
    		random_pos = math.random(230,350)
    		l.layer=5
    		l.text = string.format("{\\fad(0,200)\\move(%d,%d,%d,%d)\\an5\\shad0\\bord0\\be1\\1c&H191AA9&\\t(\\fscx%d\\fscy%d))}{\\p%d}m 0 0 m 10 20 b 16 20 20 16 20 10 b 20 4 16 0 10 0 b 2 0 0 6 0 10 b 0 16 4 20 10 20 {\\p0}",x-math.random(-10,10),y-math.random(-10,10),x+math.random(-15,15),y+math.random(-15,15)*syl.duration/800,random_pos,random_pos,math.random(4,6))
    		l.start_time=line.start_time+syl.start_time+20
    		l.end_time=l.start_time+syl.duration+math.random(200,400)+300
    		l.end_time=l.end_time+i
    		subs.append(l)
                   end
         end
end

aegisub.register_filter("FX_6", "~ALKOON~", 2009, FX_6)