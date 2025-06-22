include("karaskel.lua")

script_name = "Some Anime Opening 1"
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
	
		for char in unicode.chars(line.text_stripped) do
			cx,cy = aegisub.text_extents(line.styleref,char)
			local charx = line.left + (cx/2) + pox
			local chary = line.middle
			pox = pox + cx
			chari = 1+chari
			l.text = string.format("{\\an5\\be1\\fade(255,128,0,0,90,90,360)\\pos(%d,%d)\\frx180\\t(0,360,\\frx0)}%s",charx,chary,char)
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
		l.text = string.format("{\\an5\\be1\\fade(255,128,0,0,90,90,360)\\pos(%d,%d)\\frx180\\t(0,360,\\frx0)}%s",charx,chary,char)
		l.start_time = line.start_time - 600 + (chari-1)*40
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
	end
	
	 for highlightindex = 1, #syl.highlights do 
	 local hl = syl.highlights[highlightindex]

	--Syl
   	l.text=string.format("{\\3c&H49524A&\\1c&HFFFFFF&\\an5\\bord2.5\\blur5\\pos(%d,%d)\\t(0,%d,\\fscx135\\fscy135)\\t(%d,%d,\\fscx100\\fscy100}%s",x,y,syl.duration/2,syl.duration/2,syl.duration,syl.text_stripped)
	l.start_time=line.start_time+hl.start_time
	l.end_time=line.start_time+hl.end_time
	l.layer=4
	subs.append(l)
   
	if syl.duration > 0 then
	l = table.copy(line)
	rr=1
	l.start_time = line.start_time + hl.start_time
	l.end_time = line.start_time + hl.end_time
	l.layer = ll
	for g=0, 6 do
	l.text = string.format("{\\1a&H%d&\\be1\\an5\\shad0\\bord0\\1c&HFFFFFF&\\pos(%d,%d)\\t(0.1\\fscx%d\\fscy%d\\alpha&HFF&)}%s",rr*9, x , y-2, 110+(g*15), 110+(g*15), syl.text_stripped)
	rr = rr + 1
	subs.append(l)
			end
		end
	ll=ll+1
	end


		--# Syl 2 End
		l.start_time =  l.start_time + syl.duration
		l.end_time =  line.end_time-200
		l.text = string.format("{\\an5\\pos(%d,%d)}%s",x,y,syl.text)
		l.layer = 1   
		subs.append(l)

		--# Post Line 1
		l.start_time = line.end_time - 300
		l.end_time = line.end_time + FF/2
		l.text =string.format("{\\an5\\pos(%d,%d)\\fad(0,500)}%s",x,y,syl.text)
		l.layer = 0
		subs.append(l)
	 
		FF = FF+(1500/line.kara.n)

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

aegisub.register_macro("Forgot Animu Name Opening 1","", macro_MF)
aegisub.register_filter("Forgot Animu Name Opening 1","",2000,anime)