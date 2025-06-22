include("karaskel.lua")

script_name = "Some Anime Ending 1"
script_description = "BLEACH Fillers end 2013"
script_author = "FloriaN"
script_version = ""

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

function anime(subs)
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

ll=5

function do_fx(subs, meta, line)
remember_values = {};

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
			l.text = string.format("{\\3c%s\\shad0\\an5\\fscx200\\fscy200\\fry%d\\frx%d\\be2\\fad(360,0)\\move(%d,%d,%d,%d,%d,%d)\\t(0,400,\\fscx100\\fscy100\\3c%s\\frx0\\fry0)}%s",line.styleref.color1,math.random(-360,360),math.random(-360,360),charx,chary-20,charx,chary,0,400,line.styleref.color3,char)
			l.start_time = line.start_time - 400 + (chari-1)*20
			l.end_time = line.start_time + (chari-1)*20
			l.layer = 1
			subs.append(l)
			
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
		l.text = string.format("{\\3c%s\\shad0\\an5\\fscx200\\fscy200\\fry%d\\frx%d\\be2\\fad(360,0)\\move(%d,%d,%d,%d,%d,%d)\\t(0,400,\\fscx100\\fscy100\\3c%s\\frx0\\fry0)}%s",line.styleref.color1,math.random(-360,360),math.random(-360,360),charx,chary-20,charx,chary,0,400,line.styleref.color3,char)
		l.start_time = line.start_time - 400 + (chari-1)*20
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
	end
	
	--Syl
   	l.text=string.format("{\\an5\\1a&44\\1c%s\\3c%s\\blur1\\move(%d,%d,%d,%d,%d,%d)\\t(500,1500,\\frz%s\\fscx80\\fscy80\\alpha&FF&)}%s",line.styleref.color2,line.styleref.color1,x,y,x,y+math.random(5,10),500,1500,math.random(-30,30),syl.text_stripped)
	l.start_time=line.start_time+syl.start_time+syl.duration
	l.end_time=line.start_time+syl.end_time+1500
	l.layer=2
	subs.append(l)
   
   for i=0,5 do
	l.text=string.format("{\\an5\\pos(%d,%d)\\be1\\t(0,%d,\\fscx%d\\fscy%d\\be%d\\blur%d\\3c%s\\bord6)\\t(%d,%d,\\fscx100\\fscy100\\be3\\blur2\\bord2)}%s",x,y,syl.kdur*3,110+i*12,110+i*12,1+i*2,1+i*2,line.styleref.color2,syl.kdur*3,syl.duration,syl.text_stripped)
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time
	l.layer=2
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

function remember(name, value) remember_values[name] = value; return value; end; 
function recall(name) return remember_values[name]; end

function macro_MF(subs, sel)
	aegisub.set_undo_point("before run macro")
	anime(subs, {ismacro=true, sel=sel})
end

aegisub.register_macro("Forgot Animu Name Ending 1","", macro_MF)
aegisub.register_filter("Forgot Animu Name Ending 1","",2000,anime)