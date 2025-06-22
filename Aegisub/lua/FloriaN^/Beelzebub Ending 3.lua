include("karaskel.lua")

script_name = "Beelzebub Ending 3"
script_description = "BLEACH Fillers end 2013"
script_author = "FloriaN"
script_version = "Final until Jecht modifies the description!"

xres, yres = aegisub.video_size()		--get video resolution 
if xres == nil  then 
	ratio = 1 
else 
	ratio = yres/576
end
msa = aegisub.ms_from_frame(1)		--get frame duration 
msb = aegisub.ms_from_frame(100) 
if msa == nil and msb == nil then 
	frame_dur = 33  
else 
	frame_dur = (msb-msa)/100 
end

function beelbo(subs)
	local meta, styles = karaskel.collect_head(subs)
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and l.style ~= "English" and
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

chari = 0

	for i = 1, line.kara.n do
	
		local syl = line.kara[i]
		local x = line.left + syl.center
		local y = line.middle
		local l=table.copy(line)
		
  	pox = 0
	
	for char in unicode.chars(syl.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.left + syl.left + (cx/2) + pox
		local chary = y
		pox = pox + cx
		chari = 1+chari
		l.text = string.format("{\\an5\\bord0.2\\be10\\3c%s\\1c%s\\fad(%d,%d)\\move(%d,%d,%d,%d,%d,%d)\\fscy100\\fry360\\fscx100\\t(%d,%d,\\fscx120\\frz0\\fry0\\frx0\\fscy170)\\t(%d,%d,\\fscx100\\fscy100\\be0\\bord1.5\\3c&H000000&)}%s",line.styleref.color3,line.styleref.color1,200,0,charx+math.random(-40,40),chary+math.random(-20,20),charx,chary,0,400,0,400,400,800,char)
		l.start_time = line.start_time - 400 + (chari-1)*10
		l.end_time = line.start_time + syl.start_time
		l.layer=3
		subs.append(l)
	end
	
	--Template
	l.text=string.format("{\\an5\\be1\\org(%d,%d)\\pos(%d,%d)}%s",x,y,x,y,syl.text_stripped)
	l.start_time=line.start_time + syl.end_time
	l.end_time=line.end_time-10
	l.layer=2
	subs.append(l)
	
	--Syl
   	l.text=string.format("{\\3c&HC8B2D4&\\1c&HFFFFFF&\\an5\\bord2.5\\blur5\\pos(%d,%d)\\t(0,%d,\\fscx120\\fscy200)\\t(%d,%d,\\fscx100\\fscy100}%s",x,y,syl.duration/2,syl.duration/2,syl.duration,syl.text_stripped)
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time
	l.layer=4
	subs.append(l)
   
    --Syl2
	 l.text = string.format("{\\shad0\\an5\\pos(%d,%d)\\be5\\t(\\fscy150)\\t(\\fscx150\\fscy350)\\t(\\alpha&HFF&)\\1c&HFFFFFF&\\bord0)}%s",x,y,syl.text)
	 l.start_time = line.start_time + syl.start_time
	 l.end_time = l.start_time + 30 + syl.duration 
     l.layer = 3
	 subs.append(l)

	 --Feather
	 scale = math.random(20,30)* ratio 
	 for i=0,10 do
	 l.start_time = line.end_time-11
	 l.end_time = line.end_time + math.random(1000,2000)
	 l_duration = l.end_time - l.start_time
	 l.text = string.format("{\\an5\\fscx%d\\fscy%d\\bord%d\\1c&HFFFFFF&\\3c&HFFFFFF&\\shad0\\blur%d\\move(%d,%d,%d,%d)\\t(0.2,\\frx%d\\fry%d\\frz%d%s)\\fad(%d,%d)\\p1}m 26 37 l 38 27 l 45 19 l 52 11 l 57 7 b 66 0 72 9 64 29 l 59 26 l 62 31 b 58 36 52 43 46 47 l 41 44 l 44 48 b 41 52 37 56 33 58 l 28 52 l 30 58 l 27 61 l 24 58 l 24 61 l 21 58 l 17 61 l 17 59 b 11 62 6 64 0 64 l 0 60 b 5 60 12 57 16 54 l 14 51 l 18 51 l 17 47 l 20 50 l 20 42 l 24 38 l 25 45)}",scale,scale,ratio,ratio*2,x,y,x+math.random(480*0.07,480*0.6),y+math.random(-240*0.13,240*0.04),math.random(-360,360),math.random(-360,360),math.random(-360,360),glitter(l_duration),0,100)
     l.layer = 1
	 subs.append(l)
	 end
	
	end
end

function glitter(dur) 
	local tag = "" 
	local time = 0 

	while  (dur > time) do 
		local time1 = time + math.random(dur / 2)
		local time2 = time1 + 1
		local time3 = time2 + frame_dur
		local time4 = time3 + 100
		local size1 = math.random(2,25)*ratio
		local size2 = math.random(1,13)*ratio
		tag = string.format("\\t(%d,%d,\\fscx%d\\fscy%d\\1c&HFFFFFF&\\3c&HFFFFFF&\\bord%f\\blur%f)\\t(%d,%d,\\fscx%d\\fscy%d\\1c&HFFFFFF&\\3c&H000000&\\bord%f\\blur%f)",time1, time2, size1, size1, 2*ratio, 3*ratio, time3, time4, size2, size2,1*ratio, 1*ratio) 
		time = time4
	end 
	return tag 
end

function macro_MF(subs, sel)
	aegisub.set_undo_point("before run macro")
	beelbo(subs, {ismacro=true, sel=sel})
end

aegisub.register_macro("Beelzebub Ending 3","", macro_MF)
aegisub.register_filter("Beelzebub Ending 3","",2000,beelbo)