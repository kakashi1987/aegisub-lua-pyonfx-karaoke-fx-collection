include("karaskel.lua")

script_name = "Beelzebub Opening 4"
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
chari = 0
pox = 0
local l=table.copy(line)

ll = 5
chari=0

	for i = 1, line.kara.n do
	
		local syl = line.kara[i]
		local l=table.copy(line)
		
		if (line.effect == "2nd") then
		x = line.left + syl.center
		y = line.middle + 40
		else
		x = line.left + syl.center
		y = line.middle
		end

	pox = 0		
	
		for char in unicode.chars(syl.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.left + syl.left+ (cx/2) + pox
		local chary = y
		pox = pox + cx
		chari = 1+chari
		l.text = string.format("{\\an5\\pos(%d,%d)\\fad(%d,%d)\\fscx100\\fscy100\\t(%d,%d,\\fscx100\\frz%d\\frx%d\\fry%d\\fscy100\fry0)\\t(%d,%d,\\fscx100\\fscy100\\frx0\\fry0\\frz0)}%s",charx,chary,300,0,0,150,math.random(-360,360),math.random(-360,360),math.random(-360,360),150,300,char)
		l.start_time = line.start_time - 600 + (chari-1)*40
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
		
		l.text = string.format("{\\an5\\1c%s\\3c%s\\bord1.5\\blur1\\be1\\move(%d,%d,%d,%d,%d,%d)\\fscy100\\fscx100\\t(0,%d,\\fscx120\\frz0\\fry0\\frx0\\fscy170)\\t(%d,%d,\\frx90\\fscy100\\fscx100)\\t(0,%d,\\alpha&HFF&)}%s",line.styleref.color1,line.styleref.color3,charx,chary,charx-math.random(10,20),chary-math.random(-20,20),0,400,400,400,800,600,char)
		l.start_time = line.start_time + syl.end_time
		l.end_time = line.end_time
		subs.append(l)
		end
		
	for highlightindex = 1, #syl.highlights do 
	 local hl = syl.highlights[highlightindex]

	--Syl
   	l.text=string.format("{\\3c&H510908&\\1c&HFFFFFF&\\an5\\bord2.5\\blur5\\pos(%d,%d)\\t(0,%d,\\fscx110\\fscy110)\\t(%d,%d,\\fscx100\\fscy100}%s",x,y,syl.duration/2,syl.duration/2,syl.duration,syl.text_stripped)
	l.start_time=line.start_time+hl.start_time
	l.end_time=line.start_time+hl.end_time
	l.layer=5
	subs.append(l)
	
	if syl.duration > 0 then
	l = table.copy(line)
	rr=1
	l.start_time = line.start_time + hl.start_time
	l.end_time = line.start_time + hl.end_time
	l.layer = ll
	for g=0, 9 do
	l.text = string.format("{\\1a&H%d&\\3c&H510908&\\be1\\an5\\shad0\\bord0\\1c&HFFFFFF&\\pos(%d,%d)\\t(0.1\\fscx%d\\fscy%d\\alpha&HFF&)}%s",rr*9, x , y-2, 110+(g*9), 110+(g*9), syl.text_stripped)
	rr = rr + 1
	subs.append(l)
			end
		end
	ll=ll+1
	
	end
	
	for i=0,20 do
	--Syl
   	l.text=string.format("{\\an5\\1c&HFFFFFF&\\3c&HFFFFFF&\\blur1.5\\pos(%d,%d)\\org(%d,%d)\\t(\\frz%d\\alpha&HFF)\\p1}m 0 0 l 0 1 l 1 1 l 1 0}",x+math.random(-8,8),y+math.random(-11,11),x+math.random(-75,75),y+math.random(-25,25),math.random(-160,160))
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time-syl.duration+500
	l.layer=2
	subs.append(l)	
	end	
		
	for i=0,2 do
	--Syl
   	l.text=string.format("{\\an5\\pos(%d,%d)\\alpha&H55\\fscx200\\fscy180\\frx%d\\fry%d\\bord0\\c&H510908&\\t(\\alpha&HFF\\fscx%d\\fscy%d)\\p2}m 20 40 b 31 40 40 31 40 20 b 40 9 31 0 20 0 b 9 0 0 9 0 20 b 0 31 9 40 20 40 m 2 20 b 2 10 10 2 20 2 b 30 2 38 10 38 20 b 38 30 30 38 20 38 b 10 38 2 30 2 20}",x,y,math.random(0,360),math.random(0,360),math.random(260,350),math.random(260,350))
	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time-syl.duration+math.random(450,600)
	l.layer=3
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

aegisub.register_macro("Beelzebub Opening 4","", macro_MF)
aegisub.register_filter("Beelzebub Opening 4","",2000,beelbo)