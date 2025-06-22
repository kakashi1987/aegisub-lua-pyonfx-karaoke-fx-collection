include("karaskel.lua")

script_name = "Usagi Drop Ending 1"
script_description = "None"
script_author = "FloriaN"
script_version = "Final"

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

function usagi(subs)
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

sf_lead = 250
sf_dx = 40
chari = 0

	if (line.style == "English") then
	 
	pox = 0
	chari = 0
	 
	local l=table.copy(line)
	 
	local char = {} 
	if line.duration > 0 then
	for char in unicode.chars(line.text_stripped) do
			cx,cy = aegisub.text_extents(line.styleref,char)
			local charx = line.left + (cx/2) + pox
			local chary = line.middle
			pox = pox + cx
			chari = 1+chari
	
	 	 l.text=string.format("{\\an5\\move(%d,%d,%d,%d,%d,%d)\\fad(%d,%d)}%s",charx,chary,charx-sf_dx,chary,0,sf_lead,0,sf_lead,char)
	 l.start_time=line.end_time
	 l.end_time=line.end_time + sf_lead
	 l.layer=3
	 subs.append(l)
	 
	 --Template
	 l.text=string.format("{\\an5\\move(%d,%d,%d,%d,%d,%d)\\fad(%d,%d)}%s",charx+sf_incdx(),chary,charx,chary,0,sf_lead,sf_lead,0,char)
	 l.start_time=line.start_time -sf_lead
	 l.end_time=line.start_time
	 l.layer=3
	 subs.append(l)
	 
	 --Template
	 l.text=string.format("{\\an5\\pos(%d,%d)}%s",charx,chary,char)
	 l.start_time=line.start_time
	 l.end_time=line.end_time
	 l.layer=3
	 subs.append(l)
	 
		end
	end
end

	for i = 1, line.kara.n do
	
		local syl = line.kara[i]
		local x = line.left + syl.center
		local y = line.middle
		local l=table.copy(line)
		shape = "m 20 0  b  20 10  30 20  40 20  b  30 20  20 30  20 40  b  20 30  10 20  0 20  b  10 20  20 10  20 0"
		
	--Template
	 l.text=string.format("{\\an5\\1c%s\\bord0\\move(%d,%d,%d,%d,%d,%d)\\fad(%d,%d)}%s",line.styleref.color3,line.left+syl.center+sf_incdx(),y,line.left+syl.center,y,0,sf_lead,sf_lead,0,syl.text_stripped)
	 l.start_time=line.start_time -sf_lead
	 l.end_time=line.start_time
	 l.layer=3
	 subs.append(l)
	 
	 --Template
	 l.text=string.format("{\\1c%s\\an5\\bord0\\pos(%d,%d)}%s",line.styleref.color3,x,y,syl.text_stripped)
	 l.start_time=line.start_time
	 l.end_time=line.start_time + syl.start_time
	 l.layer=3
	 subs.append(l)
	
	 for highlightindex = 1, #syl.highlights do 
	 local hl = syl.highlights[highlightindex]

	 color = _G.ass_color(math.random(255),math.random(255),math.random(255))
	 
	 for i=0, 15 do
	 color2 = _G.ass_color(math.random(255),math.random(255),math.random(255))
	 l.start_time=line.start_time+syl.start_time+(syl.duration/20)*i
	 l.end_time=line.start_time+syl.end_time+500+(syl.duration/20)*i
	 l_duration = l.end_time - l.start_time
	 l.text=string.format("{\\an5\\blur3\\1c&HFFFFFF&\\3c%s\\move(%d,%d,%d,%d)%s\\org(%d,%d)\\t(0,150,0.5,\\fr%d)\\t(150,500,2,\\fr%d)\\fad(0,100)\\p1\\fscx15\\fscy15}%s",color2,line.left+math.random(syl.left,syl.right),y,line.left+math.random(syl.left-30,syl.right+30),y,glitter(l_duration),line.center-400,y,math.random(3,5),math.random(-4,-2),shape)
	 l.layer=1
	 subs.append(l)
	 end
	 
	--Syl
   	l.text=string.format("{\\3c%s\\1c&HFFFFFF&\\an5\\bord2.5\\blur5\\pos(%d,%d)\\t(0,%d,\\fscx120\\fscy200)\\t(%d,%d,\\fscx100\\fscy100}%s",color,x,y,syl.duration/2,syl.duration/2,syl.duration,syl.text_stripped)
	l.start_time=line.start_time+hl.start_time
	l.end_time=line.start_time+hl.end_time
	l.layer=4
	subs.append(l)
   
	end
	
	--Template
	 l.text=string.format("{\\3c%s\\1c&HFFFFFF&\\an5\\bord2\\blur1\\pos(%d,%d)}%s",color,x,y,syl.text_stripped)
	 l.start_time=line.start_time + syl.end_time
	 l.end_time=line.end_time
	 l.layer=3
	 subs.append(l)
	 
	 --Template
	 l.text=string.format("{\\an5\\3c%s\\bord0\\move(%d,%d,%d,%d,%d,%d)\\fad(%d,%d)}%s",color,line.left+syl.center,y,line.left+syl.center-sf_dx,y,0,sf_lead,0,sf_lead,syl.text_stripped)
	 l.start_time=line.end_time
	 l.end_time=line.end_time + sf_lead
	 l.layer=3
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

function sf_incdx() sf_dx = sf_dx + math.random(0,10); return sf_dx end

function macro_MF(subs, sel)
	aegisub.set_undo_point("before run macro")
	usagi(subs, {ismacro=true, sel=sel})
end

aegisub.register_macro("Usagi Drop Opening 1","", macro_MF)
aegisub.register_filter("Usagi Drop Opening 1","",2000,usagi)