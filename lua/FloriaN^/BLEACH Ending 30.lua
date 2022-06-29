include("karaskel.lua")

script_name = "BLEACH Ending X"
script_description = "wakaranai"
script_author = "FloriaN"
script_version = "beta v2"

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

shape = "m 0 0 l 2 0 l 2 2 l 0 2"
particle_base_size = 2
particle_size = particle_base_size * ratio

function bleach(subs)
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

function do_fx(subs, meta, line, styles)
   for i = 1, line.kara.n do
   
		local syl = line.kara[i]
		local x = line.left + syl.center
		local y = line.middle
		local l=table.copy(line)
		local x_kanji = line.styleref.margin_l + line.margin_l
		local y_kanji = line.styleref.margin_v + syl.left
   
   			if syl.duration > 0 then
			local l = table.copy(line)
			l.start_time = line.start_time -1000 + i * 100
			l.end_time = line.start_time + syl.start_time 
			l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\fad(300,0)\\pos(%d,%d)}%s",line.styleref.color1, line.styleref.color3, line.styleref.color4, line.left+syl.center, line.middle, syl.text)
			l.layer = 0
			subs.append(l)
		end
   
		--text hilight
		if syl.duration > 0 then
			local l = table.copy(line)
			l.start_time = line.start_time + syl.end_time + 300 
			l.end_time = l.start_time + 200
			l_duration = l.end_time - l.start_time
			l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\pos(%d,%d)\\clip(%d,%d,%d,%d)\\t(%d,%d,\\clip(%d,%d,%d,%d))}%s",line.styleref.color1, line.styleref.color3, line.styleref.color4, line.left + syl.center, line.middle, line.left + syl.left - line.styleref.outline, line.top -100, line.left + syl.right + 100, line.bottom + 100, 0, l_duration, line.left + syl.right + line.styleref.outline, line.top - 100, line.left + syl.right + line.styleref.outline, line.bottom + 100, syl.text)
			l.layer = 0
			subs.append(l)
		end
		
		--Syl
		l.text=string.format("{\\3c%s\\1c%s\\an5\\bord2.5\\blur5\\pos(%d,%d)\\t(0,%d,\\fscx120\\fscy200)\\t(%d,%d,\\fscx100\\fscy100}%s",line.styleref.color3,line.styleref.color1,x,y,syl.duration/2,syl.duration/2,syl.duration,syl.text_stripped)
		l.start_time=line.start_time+syl.start_time
		l.end_time=line.start_time+syl.end_time
		l.layer=2
		subs.append(l)
   
		--Syl2
		l.text = string.format("{\\shad0\\an5\\pos(%d,%d)\\be5\\t($start,$mid,\\fscy150)\\t($mid,$end,\\fscx150\\fscy350)\\t(!$end-80!,$end,\\alpha&HFF&)\\1c&HFFFFFF&\\bord0)}%s",x,y,syl.text)
		l.start_time = line.start_time + syl.start_time
		l.end_time = l.start_time + 30 + syl.duration 
		l.layer = 2
		subs.append(l)

		--Template
		l.text=string.format("{\\an5\\be1\\org(%d,%d)\\pos(%d,%d)\\fry0}%s",x,y,x,y,syl.text_stripped)
		l.start_time=line.start_time + syl.end_time
		l.end_time= line.start_time + syl.end_time + 300
		l.layer=1
		subs.append(l)
	
		--particle effect
		if syl.duration > 0 then
			local l = table.copy(line) 
			loop_num = ((line.height * syl.width / (particle_size^2)) / 4) * (100 / 100)
			for j = 1, loop_num  do
				l.start_time = line.start_time + syl.end_time + 300 + (j / loop_num) * syl.duration
				l.end_time = l.start_time + math.random(500,1000)
				l_duration = l.end_time - l.start_time
				xpos = line.left + syl.center + math.random(-syl.width / 2, syl.width / 2)  
				ypos = line.middle+math.random(-line.height / 4, line.height / 4)
				l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\move(%d,%d,%d,%d)\\shad0\\fad(0,300)\\bord%f\\blur%f\\t(0,100,\\3c%s\\bord%f\\blur0\\3a&HA0&)\\fscx%d\\fscy%d%s\\p1}%s",line.styleref.color1, line.styleref.color3, line.styleref.color4, xpos, ypos, xpos - math.random(syl.duration/5) * ratio, ypos + math.random(-50, 50) * ratio, 2 * ratio, 1 * ratio, line.styleref.color3, 1 * ratio, 100 * ratio, 100 * ratio, glitter(l_duration), shape) 
				l.layer = 0
				subs.append(l)
				end

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
		local size1 = math.random(150,250) * ratio
		local size2 = math.random(50,100) * ratio
		tag = string.format("\\t(%d,%d,\\fscx%d\\fscy%d\\1c&HFFFFFF&\\3c&HFFFFFF&\\bord%f\\blur%f)\\t(%d,%d,\\fscx%d\\fscy%d\\1c&HFFFFFF&\\3c&H000000&\\bord%f\\blur%f)",time1, time2, size1, size1, 2*ratio, 3*ratio, time3, time4, size2, size2,1*ratio, 1*ratio) 
		time = time4
	end 
	return tag 
end

function macro_MF(subs, sel)

	aegisub.set_undo_point("before run macro")

	bleach(subs, {ismacro=true, sel=sel})

end	

aegisub.register_macro("BLEACH Ending X","", macro_MF)

aegisub.register_filter("BLEACH Ending X","",2000,bleach)