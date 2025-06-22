include("karaskel.lua")

script_name = "BLEACH Ending 29"
script_description = "BLEACH Fillers end 2013"
script_author = "FloriaN"
script_version = ""

xres, yres = aegisub.video_size()		--get video resolution 
if xres == nil  then 
	ratio = 1 
	x_rat = 1
	y_rat = 1
else 
	ratio = yres/576
	x_rat = xres/1024 
	y_rat = x_rat
end
msa = aegisub.ms_from_frame(1)		--get frame duration 
msb = aegisub.ms_from_frame(100) 
if msa == nil and msb == nil then 
	frame_dur = 33  
else 
	frame_dur = (msb-msa)/100 
end

function bleach(subs)
	local meta, styles = karaskel.collect_head(subs)
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
temp = {};
chari = 0

if (line.style == "English") then

 	pox = 0
	chari = 0
 
local l = table.copy(line)
	local char = {} 
	if line.duration > 0 then
		for char in unicode.chars(line.text_stripped) do
			cx,cy = aegisub.text_extents(line.styleref,char)
			local charx = line.left + (cx/2) + pox
			local chary = line.middle
			pox = pox + cx
			chari = 1+chari
			for i=0,10 do
			l.text = string.format("{\\3c%s\\an5\\bord0.1\\blur2\\alpha&E1&\\fad(360,0)\\move(%d,%d,%d,%d,%d,%d)\\t(0,400,\\3c%s)\\t(400,600,\\bord1\\be2\\blur2)}%s",line.styleref.color1,charx+math.random(-30,30),chary,charx,chary,0,400,line.styleref.color3,char)
			l.start_time = line.start_time - 400 + (chari-1)*20
			l.end_time = line.start_time + (chari-1)*20
			l.layer = 1
			subs.append(l)
			end
			
		--Template
		l.text=string.format("{\\an5\\pos(%d,%d)}%s",charx,chary,char)
		l.start_time=line.start_time + (chari-1)*20
		l.end_time=line.end_time
		l.layer=1
		subs.append(l)
		end
	end
end

   for i = 1, line.kara.n do
   
		local syl = line.kara[i]
		if i == 1 then FF = 0 end
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
		for i=0,10 do
		l.text = string.format("{\\3c%s\\an5\\bord0.1\\blur2\\alpha&E1&\\fad(360,0)\\move(%d,%d,%d,%d,%d,%d)\\t(0,400,\\3c%s)\\t(400,600,\\bord1\\be2\\blur2)}%s",line.styleref.color1,charx+math.random(-30,30),chary,charx,chary,0,400,line.styleref.color3,char)
		l.start_time = line.start_time - 400 + (chari-1)*40
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
		end
	end
	
	 --# Syl
	 l.start_time = line.start_time + syl.start_time
	 l.end_time = line.start_time + syl.end_time
     l.text = string.format("{\\shad1.5\\an5\\pos(%d,%d)\\fay0.01\\blur5\\4a&HAA&\\3c&HFFFFFF&\\3a&H77&\\t(%d,%d,\\fscy200\\fscx120)\\t(%d,%d,\\fscy100\\fscx100)\\1c&HFFFFFF&\\bord2}%s",x,y,0,syl.duration/2,syl.duration/2,syl.duration,syl.text_stripped)
     l.layer = 3
	 subs.append(l)
	--# Syl #2
	 l.start_time = line.start_time + syl.start_time
	 l.end_time = line.start_time + syl.end_time + 30
     l.text = string.format("{\\shad0\\an5\\pos(%d,%d)\\be5\\t(%d,%d,\\fscy150)\\t(%d,%d,\\fscx150\\fscy300)\\t(%d,%d,\\alpha&HFF&)\\1c&HFFFFFF&\\bord0}%s",x,y,0,syl.duration/2,syl.duration/2,syl.duration,syl.duration-80,syl.duration,syl.text_stripped)
     l.layer = 2
	 subs.append(l)
	 
	 l.start_time = line.start_time + syl.end_time
	 l.end_time = line.end_time
     l.text = string.format("{\\bord1\\be2\\blur2\\1c%s\\fad(0,360)\\an5\\pos(%d,%d)\\t(\\1c%s)}%s","&H9F9F9F&",x,y,line.styleref.color1,syl.text_stripped)
     l.layer = 2
	 subs.append(l)
	 
	
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

function set_temp(ref,val) temp[ref] = val; return val; end

function macro_MF(subs, sel)
	aegisub.set_undo_point("before run macro")
	bleach(subs, {ismacro=true, sel=sel})
end

aegisub.register_macro("BLEACH Ending 29","", macro_MF)
aegisub.register_filter("BLEACH Ending 29","",2000,bleach)