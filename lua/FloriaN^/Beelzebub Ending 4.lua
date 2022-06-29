include("karaskel.lua")

script_name = "Beelzebub Ending 4"
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
remember_values = {};
particle = { "m 0 0 l 0 5 l 5 5 l 5 0 l 0 0", "m 0 0 l 0 5 l 3 8 l 5 0 l 0 0", "m 0 0 l 1 4 l 4 6 l 7 4 l 0 0", "m 0 0 l 0 4 l 6 3 l 7 1 l 0 0", "m 0 0 l 5 2 l 0 5 l 0 0"}
chari = 0

	for i = 1, line.kara.n do
	
		local syl = line.kara[i]
		if(i == line.kara.n) then
		syl2 = ""
		else
		syl2=line.kara[i+1]
		x2 = line.left + syl2.center
		end
		local x = line.left + syl.center
		local y = line.middle
		local l=table.copy(line)
		local time1=line.kara.n*50
		sx,sy = aegisub.text_extents(line.styleref,syl.text)
		
	pox=0
		
	if (line.effect == "jump") then
	
	if (syl.text_stripped=="Jan") then
	
	for char in unicode.chars(syl.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.left + syl.left+ (cx/2) + pox
		local chary = y
		pox = pox + cx
		chari = 1+chari
		l.text = string.format("{\\an5\\be1\\fade(255,128,0,0,90,90,360)\\pos(%d,%d)\\frx180\\t(0,360,\\frx0)}%s",charx,chary,char)
		l.start_time = line.start_time - 600 + (chari-1)*40
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
	end
	
	remember("time2",line.start_time + syl.start_time)
	
	l.text=string.format("{\\org(2500,30)\\1c&HFFFFFF&\\an5\\bord2.5\\blur5\\pos(%d,%d)\\t(0,%d,\\fscx120\\fscy200)\\t(0,%d,\\frz-0.5)\\t(%d,%d,\\frz0)\\t(%d,%d,\\fscx100\\fscy100)}%s",x,y,syl.duration/2,syl.duration,syl.duration,syl.duration+syl2.duration,syl.duration/2,syl.duration,syl.text_stripped)
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl2.end_time
	l.layer=4
	subs.append(l)
	
	l.text=string.format("{\\org(2500,30)\\an5\\pos(%d,%d)\\t(0,%d,\\frz-0.5)\\t(%d,%d,\\frz0}%s",x2,y,syl.duration,syl.duration,syl.duration+syl2.duration,syl2.text_stripped)
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl2.end_time
	l.layer=4
	subs.append(l)
	
	l.text=string.format("{\\be1\\an5\\pos(%d,%d)\\t(0,%d,\\alpha&HFF&)}%s",x,y,syl.duration,syl.text_stripped)
	l.start_time=line.start_time+syl2.end_time
	l.end_time=line.end_time
	l.layer=4
	subs.append(l)
	
	l.text=string.format("{\\be1\\an5\\pos(%d,%d)\\t(0,%d,\\alpha&HFF&)}%s",x,y,(line.kara.n-syl.i)*30,syl.text_stripped)
	l.start_time=line.start_time+syl2.end_time
	l.end_time=line.end_time
	l.layer=4
	subs.append(l)	
	
	elseif (syl.text_stripped=="pu! ") or (syl.text_stripped=="pu!")  then
	
	for char in unicode.chars(syl.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.left + syl.left+ (cx/2) + pox
		local chary = y
		pox = pox + cx
		chari = 1+chari
		l.text = string.format("{\\an5\\be1\\fade(255,128,0,0,90,90,360)\\pos(%d,%d)\\frx180\\t(0,360,\\frx0)}%s",charx,chary,char)
		l.start_time = line.start_time - 600 + (chari-1)*40
		l.end_time = recall("time2")
		subs.append(l)
	end
	
	l.text=string.format("{\\org(2500,30)\\frz-0.5\\1c&HFFFFFF&\\an5\\bord2.5\\blur5\\pos(%d,%d)\\t(0,%d,\\fscx120\\fscy200)\\t(0,%d,\\frz0)\\t(%d,%d,\\fscx100\\fscy100)}%s",x,y,syl.duration/2,syl.duration,syl.duration/2,syl.duration,syl.text_stripped)
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time
	l.layer=4
	subs.append(l)
	
	l.text=string.format("{\\be1\\an5\\pos(%d,%d)\\t(0,%d,\\alpha&HFF&)}%s",x,y,(line.kara.n-syl.i)*30,syl.text_stripped)
	l.start_time=line.start_time+syl.end_time
	l.end_time=line.end_time
	l.layer=4
	subs.append(l)	
	
	end
	
	elseif (line.effect == "shake") then
	
	for char in unicode.chars(syl.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.left + syl.left + (cx/2) + pox
		local chary = y
		pox = pox + cx
		chari = 1+chari
		l.text = string.format("{\\an5\\be1\\fade(255,128,0,0,90,90,360)\\pos(%d,%d)\\frx180\\t(0,360,\\frx0)}%s",charx,chary,char)
		l.start_time = line.start_time - 600 + (chari-1)*40
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
	end
	
	for j=0,10 do
	l.text=string.format("{\\an5\\pos(%d,%d)\\bord2\\blur2\\be2\\fscx%d\\fscy%d\\alpha&HCC&}%s",x,y,100+(j-1)*4,100+(j-1)*4,syl.text_stripped)
   	l.start_time=line.start_time+syl.start_time+(syl.duration/2/10)*j
	l.end_time=line.start_time+syl.end_time+syl.duration/2-(syl.duration/2/10)*j
	l.layer=3
	subs.append(l)
	end
	
	l.text=string.format("{\\an5\\pos(%d,%d)\\bord2\\blur2\\be2}%s",x,y,syl.text_stripped)
   	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time
	l.layer=2
	subs.append(l)
	
	for i=0,18 do
	l.text=string.format("{\\an5\\be1\\bord0\\move(%d,%d,%d,%d)\\1c%s\\fscx%d\\fscy%d\\t(\\frx%d\\fry%d\\frz%d)\\t(2,\\1a&HFF&)\\p1}%s}",x+math.random(-5,5),y+5+math.random(-5,5),x+math.random(-35,35),y+5+math.random(-35,35),line.styleref.color2,math.random(80,100),math.random(80,100),math.random(-360,360),math.random(-360,360),math.random(-360,360),particle[math.random(5)])
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time+math.random(40,60)*10
	l.layer=3
	subs.append(l)
	end
	
	l.text=string.format("{\\be1\\an5\\pos(%d,%d)\\t(0,%d,\\alpha&HFF&)}%s",x,y,(line.kara.n-syl.i)*30,syl.text_stripped)
	l.start_time=line.start_time+syl.end_time
	l.end_time=line.end_time
	l.layer=4
	subs.append(l)	
	
	else
		
	for char in unicode.chars(syl.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.left + syl.left + (cx/2) + pox
		local chary = y
		pox = pox + cx
		chari = 1+chari
		l.text = string.format("{\\an5\\be1\\fade(255,128,0,0,90,90,360)\\pos(%d,%d)\\frx180\\t(0,360,\\frx0)}%s",charx,chary,char)
		l.start_time = line.start_time - 600 + (chari-1)*40
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
	end
	
	l.text=string.format("{\\org(2500,30)\\shad1.5\\an5\\pos(%d,%d)\\fay0.01\\blur5\\t(0,%d,\\frz0.1\\fscx120\\fscy200)\\t(%d,%d,\\frz0\\fscx100\\fscy100\)}%s",x,y,syl.duration/2,syl.duration/2,syl.duration,syl.text_stripped)
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time
	l.layer=4
	subs.append(l)	
	
	for i=0,18 do
	l.text=string.format("{\\an5\\be1\\bord0\\move(%d,%d,%d,%d)\\1c%s\\fscx%d\\fscy%d\\t(\\frx%d\\fry%d\\frz%d)\\t(2,\\1a&HFF&)\\p1}%s}",x+math.random(-5,5),y+5+math.random(-5,5),x+math.random(-35,35),y+5+math.random(-35,35),line.styleref.color2,math.random(80,100),math.random(80,100),math.random(-360,360),math.random(-360,360),math.random(-360,360),particle[math.random(5)])
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time+math.random(40,60)*10
	l.layer=3
	subs.append(l)
	end
	
	l.text=string.format("{\\be1\\an5\\pos(%d,%d)\\t(0,%d,\\alpha&HFF&)}%s",x,y,(line.kara.n-syl.i)*30,syl.text_stripped)
	l.start_time=line.start_time+syl.end_time
	l.end_time=line.end_time
	l.layer=4
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
	beelbo(subs, {ismacro=true, sel=sel})
end

aegisub.register_macro("Beelzebub Ending 4","", macro_MF)
aegisub.register_filter("Beelzebub Ending 4","",2000,beelbo)