include("karaskel.lua")

script_name = "Beelzebub Opening 3"
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
		local time1=line.kara.n*50
		
	pox = 0
	
	for char in unicode.chars(syl.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.left + syl.left + (cx/2) + pox
		local chary = y
		pox = pox + cx
		chari = 1+chari
		l.text = string.format("{\\an5\\pos(%d,%d)\\fscy0\\frz90\\t(0,150,\\fscy100\\blur1\\be1\\frz0)}%s",charx,chary,char)
		l.start_time = line.start_time - 350 + (chari-1)*10
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
		
		l.text = string.format("{\\an5\\blur1\\be1\\pos(%d,%d)\\fscy100\\frz0\\t(0,150,\\fscy0\\frz90)}%s",charx,chary,char)
		l.start_time = line.end_time - 350 + (chari-1)*10
		l.end_time = line.end_time
		subs.append(l)
		
		l.start_time=line.start_time + syl.end_time
		l.end_time=line.end_time- 350 + (chari-1)*10
		l.text=string.format("{\\an5\\blur1\\be1\\pos(%d,%d)}%s",charx,chary,char)
		l.layer=1
		subs.append(l)
	end
	
	for j=0,10 do
	l.text=string.format("{\\an5\\be1\\move(%d,%d,%d,%d)\\1c%s\\1a&H%s&\\3a&H%s&\\t(\\fscx%d\\fscy%d)}%s",x,y,x,y,line.styleref.color1,string.format("%2X",158+j*6),string.format("%2X",180+j*6),100+j*10,100+j*10,syl.text_stripped)
   	l.start_time=line.start_time+syl.start_time
	l.end_time=line.start_time+syl.end_time
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

function macro_MF(subs, sel)
	aegisub.set_undo_point("before run macro")
	beelbo(subs, {ismacro=true, sel=sel})
end

aegisub.register_macro("Beelzebub Opening 3","", macro_MF)
aegisub.register_filter("Beelzebub Opening 3","",2000,beelbo)