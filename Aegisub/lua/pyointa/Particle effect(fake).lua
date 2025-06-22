include("karaskel.lua")

script_name = "Particle Effect (fake)"
script_author = "pyointa2001"
script_version = "1.0"

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

function particle_fake(subs, config, index)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)

	aegisub.progress.task("Applying effect...")
	local maxi = #index
	for _, i in ipairs(index) do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", i, maxi))
		aegisub.progress.set((i-1)/maxi*100)
		local l = subs[i]
		karaskel.preproc_line(subs, meta, styles, l)
		if config.effect == "karaoke-type1 (crash)" then
			do_fx1(subs, meta, l, config)
		elseif config.effect == "karaoke-type2 (blow)" then
			do_fx2(subs, meta, l, config)
		elseif config.effect == "karaoke-type3 (explosion)" then
			do_fx3(subs, meta, l, config)
		elseif config.effect == "trans-type1 (crash-right)" then
			do_fx4(subs, meta, l, config)
		elseif config.effect == "trans-type2 (crash-left)" then
			do_fx5(subs, meta, l, config)
		elseif config.effect == "trans-type3 (crash-center)" then
			do_fx6(subs, meta, l, config)
		elseif config.effect == "trans-type4 (blow)" then
			do_fx7(subs, meta, l, config)
		elseif config.effect == "trans-type5 (explosion)" then
			do_fx8(subs, meta, l, config)
		end
		maxi = maxi - 1
		l.comment = true
		subs[i] = l
	end
	aegisub.progress.task("Finished!")
	aegisub.progress.set(100)
end

function do_fx1(subs, meta, line, config)			--kara type1 crash
	for i = 1, line.kara.n do			--text lead-in
		local syl = line.kara[i]
		if syl.duration > 0 then
			local l = table.copy(line)
			l.effect = "FX"
			l.start_time = line.start_time -1000 + i * 100
			l.end_time = line.start_time
			l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\fad(300,0)\\pos(%d,%d)}%s",asscolor(config.primary_color), asscolor(config.outline_color), asscolor(config.shadow_color), line.left+syl.center,line.middle,syl.text)
			l.layer = 0
			subs.append(l)
		end
	end
	
	for i = 1, line.kara.n do			--text hilight
		local syl = line.kara[i]
		if syl.duration > 0 then
			local l = table.copy(line)
			l.effect = "FX"
			l.start_time = line.start_time + syl.start_time
			l.end_time = l.start_time + syl.duration
			l_duration = l.end_time - l.start_time
			l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\blur%f\\move(%d,%d,%d,%d)\\clip(%d,%d,%d,%d)%s}%s",asscolor(config.primary_color), asscolor(config.outline_color), asscolor(config.shadow_color), 1 * ratio, line.center-(syl.left-line.kara[1].left), line.middle, line.center-((i+1 > line.kara.n) and (syl.right - line.kara[1].left) or (line.kara[i+1].left-line.kara[1].left)), line.middle, line.left - line.styleref.outline, line.top-100, line.right + 100, line.bottom+100, jitter(0,l_duration,line), line.text_stripped)
			l.layer = 0
			subs.append(l)
		end
	end
	
	for i = 1, line.kara.n do			--particle effect
		local syl = line.kara[i]
		if syl.duration > 0 then
			local l = table.copy(line) 
			l.effect = "FX"
			loop_num = ((line.height * syl.width / (particle_size^2)) / 4) * (config.particle / 100)
			for j = 1, loop_num  do
				l.start_time = line.start_time + syl.start_time + (j / loop_num) * syl.duration 
				l.end_time = l.start_time + math.random(300,500) 
				l_duration = l.end_time - l.start_time
				ypos = line.middle+math.random(-line.height / 4, line.height / 4)
				l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\shad0\\bord%f\\move(%d,%d,%d,%d)\\fad(0,300)\\3a&HA0&\\fscx%d\\fscy%d%s\\p1}%s",asscolor(config.primary_color), asscolor(config.outline_color), asscolor(config.shadow_color), 1 * ratio, line.left, ypos, line.left + math.random(50) * ratio, ypos + math.random(-30,30) * ratio, 100 * ratio, 100 * ratio, glitter(l_duration, config), shape) 
				l.layer = 1
				subs.append(l)
			end
		end
	end
end

function do_fx2(subs, meta, line, config)			--kara type2 blow
	for i = 1, line.kara.n do			--text lead-in
		local syl = line.kara[i]
		if syl.duration > 0 then
			local l = table.copy(line)
			l.effect = "FX"
			l.start_time = line.start_time -1000 + i * 100
			l.end_time = line.start_time + syl.start_time
			l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\fad(300,0)\\pos(%d,%d)}%s",asscolor(config.primary_color), asscolor(config.outline_color), asscolor(config.shadow_color), line.left+syl.center, line.middle, syl.text)
			l.layer = 0
			subs.append(l)
		end
	end
	
	for i = 1, line.kara.n do			--text hilight
		local syl = line.kara[i]
		if syl.duration > 0 then
			local l = table.copy(line)
			l.effect = "FX"
			l.start_time = line.start_time + syl.start_time
			l.end_time = l.start_time + syl.duration
			l_duration = l.end_time - l.start_time
			l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\pos(%d,%d)\\clip(%d,%d,%d,%d)\\t(%d,%d,\\clip(%d,%d,%d,%d))}%s",asscolor(config.primary_color), asscolor(config.outline_color), asscolor(config.shadow_color), line.left + syl.center, line.middle, line.left + syl.left - line.styleref.outline, line.top -100, line.left + syl.right + 100, line.bottom + 100, 0, l_duration, line.left + syl.right + line.styleref.outline, line.top - 100, line.left + syl.right + line.styleref.outline, line.bottom + 100, syl.text)
			l.layer = 0
			subs.append(l)
		end
	end
	
	for i = 1, line.kara.n do			--particle effect
		local syl = line.kara[i]
		if syl.duration > 0 then
			local l = table.copy(line) 
			l.effect = "FX"
			loop_num = ((line.height * syl.width / (particle_size^2)) / 4) * (config.particle / 100)
			for j = 1, loop_num  do
				l.start_time = line.start_time + syl.start_time + (j / loop_num) * syl.duration
				l.end_time = l.start_time + math.random(500,1000)
				l_duration = l.end_time - l.start_time
				xpos = line.left + syl.center + math.random(-syl.width / 2, syl.width / 2)  
				ypos = line.middle+math.random(-line.height / 4, line.height / 4)
				l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\move(%d,%d,%d,%d)\\shad0\\fad(0,300)\\bord%f\\blur%f\\t(0,100,\\3c%s\\bord%f\\blur0\\3a&HA0&)\\fscx%d\\fscy%d%s\\p1}%s",asscolor(config.primary_color), asscolor(config.outline_color), asscolor(config.shadow_color), xpos, ypos, xpos - math.random(syl.duration) * ratio, ypos + math.random(-50, 50) * ratio, 2 * ratio, 1 * ratio, line.styleref.color3, 1 * ratio, 100 * ratio, 100 * ratio, glitter(l_duration, config), shape) 
				l.layer = 0
				subs.append(l)
			end
		end
	end
end


function do_fx3(subs, meta, line, config)			--kara type3 explosion
	for i = 1, line.kara.n do			--text lead-in
		local syl = line.kara[i]
		if syl.duration > 0 then
			local l = table.copy(line)
			l.effect = "FX"
			l.start_time = line.start_time -1000 + i * 100
			l.end_time = line.start_time + syl.start_time + 66
			l_duration = l.end_time - l.start_time
			l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\3c&HD3D3D4&\\fad(300,0)\\pos(%d,%d)\\t(%d,%d,\\bord%f\\blur%f\\3c&HFFFFFF&)}%s",asscolor(config.primary_color), asscolor(config.outline_color), asscolor(config.shadow_color), line.left+syl.center, line.middle, l_duration - 66, l_duration - 33, 5 * ratio, 3 * ratio, syl.text)
			l.layer = 0
			subs.append(l)
		end
	end
	
	for i = 1, line.kara.n do			--particle effect
		local syl = line.kara[i]
		if syl.duration > 0 then
			local l = table.copy(line) 
			l.effect = "FX"
			loop_num = ((line.height * syl.width / (particle_size^2)) / 4) * (config.particle / 100)
			for j = 1, loop_num  do
				l.start_time = line.start_time + syl.start_time
				l.end_time = l.start_time + math.random(300,1500)
				l_duration = l.end_time - l.start_time
				xpos = line.left + syl.center + math.random(-syl.width / 2, syl.width / 2)  
				ypos = line.middle+math.random(-line.height / 2, line.height / 2)
				l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\shad0\\bord%f\\move(%d,%d,%d,%d)\\fad(0,300)\\3a&HA0&\\fscx%d\\fscy%d%s\\p1}%s",asscolor(config.primary_color), asscolor(config.outline_color), asscolor(config.shadow_color), 1 * ratio, xpos, ypos, xpos + math.random(-200, 200) * ratio, ypos + math.random(-80, 80) * ratio, 100 * ratio, 100 * ratio, glitter(l_duration, config), shape) 
				l.layer = 0
				subs.append(l)
			end
		end
	end
	
end

function do_fx4(subs, meta, line, config)			--trans type1 crash-right
	local meta, styles = karaskel.collect_head(subs)

						--text lead-in
	if line.duration > 0 then
		local l = table.copy(line)
		l.effect = "FX"
		l.start_time = line.start_time -1000 
		l.end_time = line.end_time - 1000
		l_duration = l.end_time - l.start_time
		l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\fad(300,0)\\move(%d,%d,%d,%d,%d,%d)\\clip(%d,%d,%d,%d)}%s",asscolor(config.primary_color), asscolor(config.outline_color), asscolor(config.shadow_color), line.center, line.middle, line.center + line.width, line.middle, l_duration - 400, l_duration, line.left -100, line.top - 100, line.right + line.styleref.outline, line.bottom + 100, line.text_stripped)
		l.layer = 0
		subs.append(l)
	end
	
			--particle effect
	if line.duration > 0 then
		local l = table.copy(line) 
		l.effect = "FX"
		loop_num = ((line.height * line.width / (particle_size^2)) / 4) * (config.particle / 100)
		for j = 1, loop_num  do
			l.start_time = line.end_time -1400 + (j / loop_num) * 400
			l.end_time = l.start_time + math.random(300,500)
			l_duration = l.end_time - l.start_time
			ypos = line.middle+math.random(-line.height / 4, line.height / 4)
			l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\shad0\\bord%f\\move(%d,%d,%d,%d)\\fad(0,300)\\3a&HA0&\\fscx%d\\fscy%d%s\\p1}%s", asscolor(config.primary_color), asscolor(config.outline_color), asscolor(config.shadow_color), 1.6 * ratio, line.right, ypos, line.right - math.random(70) * ratio, ypos + math.random(-30, 30) * ratio, 100 * ratio, 100 * ratio, glitter(l_duration, config), shape) 
			l.layer = 0
			subs.append(l)
		end
	end
end

function do_fx5(subs, meta, line, config)			--trans type2 crash left
						--text lead-in
	if line.duration > 0 then
		local l = table.copy(line)
		l.effect = "FX"
		l.start_time = line.start_time -1000 
		l.end_time = line.end_time - 1000
		l_duration = l.end_time - l.start_time
		l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\fad(300,0)\\move(%d,%d,%d,%d,%d,%d)\\clip(%d,%d,%d,%d)}%s", asscolor(config.primary_color), asscolor(config.outline_color), asscolor(config.shadow_color), line.center, line.middle, line.center - line.width, line.middle, l_duration - 400, l_duration, line.left -line.styleref.outline, line.top - 100, line.right + 100, line.bottom + 100, line.text_stripped)
		l.layer = 0
		subs.append(l)
	end
	
			--particle effect
	if line.duration > 0 then
		local l = table.copy(line) 
		l.effect = "FX"
		loop_num = ((line.height * line.width / (particle_size^2)) / 4) * (config.particle / 100)
		for j = 1, loop_num  do
			l.start_time = line.end_time - 1400 + (j / loop_num) * 400
			l.end_time = l.start_time + math.random(300,500)
			l_duration = l.end_time - l.start_time
			ypos = line.middle+math.random(-line.height / 4, line.height / 4)
			l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\shad0\\bord%f\\move(%d,%d,%d,%d)\\fad(0,300)\\3a&HA0&\\fscx%d\\fscy%d%s\\p1}%s", asscolor(config.primary_color), asscolor(config.outline_color), asscolor(config.shadow_color), 1.6 * ratio, line.left, ypos, line.left + math.random(70) * ratio, ypos + math.random(-30, 30) * ratio, 100 * ratio, 100 * ratio, glitter(l_duration, line), shape) 
			l.layer = 0
			subs.append(l)
		end
	end
end

function do_fx6(subs, meta, line, config)			--trans type3 crash center
						--text lead-in
	if line.duration > 0 then
		local l = table.copy(line)
		l.effect = "FX"
		l.start_time = line.start_time -1000 
		l.end_time = line.end_time - 1000
		l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\fad(300,0)\\move(%d,%d,%d,%d,%d,%d)\\clip(%d,%d,%d,%d)}%s", asscolor(config.primary_color), asscolor(config.outline_color), asscolor(config.shadow_color), line.center, line.middle, line.center - line.width / 2, line.middle, line.duration - 400, line.duration, line.center, line.top - 100, line.right + 100, line.bottom + 100, line.text_stripped)
		l.layer = 0
		subs.append(l)
	end
	
	if line.duration > 0 then
		local l = table.copy(line)
		l.effect = "FX"
		l.start_time = line.start_time -1000 
		l.end_time = line.end_time - 1000
		l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\fad(300,0)\\move(%d,%d,%d,%d,%d,%d)\\clip(%d,%d,%d,%d)}%s", asscolor(config.primary_color), asscolor(config.outline_color), asscolor(config.shadow_color), line.center, line.middle, line.center + line.width / 2, line.middle, line.duration - 400, line.duration, line.left - 100, line.top - 100, line.center, line.bottom + 100, line.text_stripped)
		l.layer = 0
		subs.append(l)
	end
			--particle effect
	if line.duration > 0 then
		local l = table.copy(line) 
		l.effect = "FX"
		loop_num = ((line.height * line.width / (particle_size^2)) / 4) * (config.particle / 100)
		for j = 1, loop_num  do
			l.start_time = line.end_time -1400 + (j / loop_num) * 400
			l.end_time = l.start_time + math.random(300,500)
			l_duration = l.end_time - l.start_time
			ypos = line.middle+math.random(-line.height / 4, line.height / 4)
			l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\shad0\\bord%f\\move(%d,%d,%d,%d)\\fad(0,300)\\3a&HA0&\\fscx%d\\fscy%d%s\\p1}%s", asscolor(config.primary_color), asscolor(config.outline_color), asscolor(config.shadow_color), 1.6 * ratio, line.center, ypos, line.center + math.random(-70, 70) * ratio, ypos + math.random(-30, 30) * ratio, 100 * ratio, 100 * ratio, glitter(l_duration, config), shape) 
			l.layer = 0
			subs.append(l)
		end
	end
end

function do_fx7(subs, meta, line, config)			--trans type4 blow
													--text lead-in
	if line.duration > 0 then
		local l = table.copy(line)
		l.effect = "FX"
		l.start_time = line.start_time -1000 
		l.end_time = line.end_time - 1000
		l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\fad(300,0)\\pos(%d,%d)\\clip(%d,%d,%d,%d)\\t(%d,%d,\\clip(%d,%d,%d,%d))}%s", asscolor(config.primary_color), asscolor(config.outline_color), asscolor(config.shadow_color), line.center, line.middle, line.left - line.styleref.outline, line.top - 100, line.right + 100, line.bottom + 100, l.end_time - l.start_time - 400, l.end_time - l.start_time, line.right + line.styleref.outline, line.top - 100, line.right + line.styleref.outline, line.bottom + 100, line.text_stripped)
		l.layer = 0
		subs.append(l)
	end
													--particle effect
	if line.duration > 0 then
		local l = table.copy(line) 
		l.effect = "FX"
		loop_num = ((line.height * line.width / (particle_size^2)) / 4) * (config.particle / 100)
		for j = 1, loop_num  do
			l.start_time = line.end_time - 1400 + (j / loop_num) * 400
			l.end_time = l.start_time + math.random(500,1000)
			l_duration = l.end_time - l.start_time
			xpos = math.floor((j - 1) / (line.height / (particle_size * 4))) * particle_size + line.left
			ypos = line.middle+math.random(-line.height / 2, line.height / 2)
			l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\shad0\\bord%f\\move(%d,%d,%d,%d)\\fad(0,300)\\3a&HA0&\\fscx%d\\fscy%d%s\\p1}%s", asscolor(config.primary_color), asscolor(config.outline_color), asscolor(config.shadow_color), 1.6 * ratio, xpos, ypos, xpos + math.random(270) * ratio, ypos + math.random(-50, 30) * ratio, 100 * ratio, 100 * ratio, glitter(l_duration, config), shape) 
			l.layer = 0
			subs.append(l)
		end
	end
end


function do_fx8(subs, meta, line, config)			--trans type5 explosion
	word = line_per_word(line)
													--text lead-in
	if line.duration > 0 then
		local l = table.copy(line)
		l.effect = "FX"
		for i = 1, word.n do
			l.start_time = line.start_time -1000 
			l.end_time = line.end_time - 1000
			l_duration = l.end_time - l.start_time
			l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\fad(300,0)\\pos(%d,%d)\\t(%d,%d,\\bord%f\\blur%f\\3c&HFFFFFF&)%s}%s", asscolor(config.primary_color), asscolor(config.outline_color), asscolor(config.shadow_color), word.center[i], line.middle, line.duration - 66, line.duration - 33, 5 * ratio, 3 * ratio, jitter((l_duration > 900) and l_duration - 600 or 0, l_duration, line), word.text[i])
			l.layer = 0
			subs.append(l)
		end
	end
													--particle effect
	if line.duration > 0 then
		local l = table.copy(line) 
		l.effect = "FX"
		loop_num = ((line.height * line.width / (particle_size^2)) / 4) * (config.particle / 100)
		for j = 1, loop_num  do
			l.start_time = line.end_time -1000
			l.end_time = l.start_time + math.random(300,1500)
			l_duration = l.end_time - l.start_time
			xpos = line.center + math.random(-line.width / 2, line.width / 2)
			ypos = line.middle + math.random(-line.height / 2, line.height / 2)
			l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\shad0\\bord%f\\move(%d,%d,%d,%d)\\fad(0,300)\\3a&HA0&%s\\p1}%s", asscolor(config.primary_color), asscolor(config.outline_color), asscolor(config.shadow_color), 1.6 * ratio, xpos, ypos, xpos + math.random(-200, 200) * ratio, ypos + math.random(-80, 80) * ratio, glitter(l_duration, config), shape) 
			l.layer = 0
			subs.append(l)
		end
	end 
end

function glitter(dur,config) 
	local tag = "" 
	local time = 0 
	while  (dur > time) do 
		local time1 = time + math.random(dur / 2)
		local time2 = time1 + 1
		local time3 = time2 + frame_dur
		local time4 = time3 + 100
		local size1 = math.random(150,250) * ratio
		local size2 = math.random(50,100) * ratio
		tag = tag..string.format("\\t(%d,%d,\\fscx%d\\fscy%d\\1c&HFFFFFF&\\3c&HFFFFFF&\\bord%f\\blur%f)\\t(%d,%d,\\fscx%d\\fscy%d\\1c%s\\3c%s\\bord%f\\blur%f)",time1, time2, size1, size1, 2*ratio, 3*ratio, time3, time4, size2, size2, asscolor(config.primary_color), asscolor(config.outline_color), 1*ratio, 1*ratio) 
		time = time4
	end 
	return tag 
end

function jitter(s_time, e_time, line) 
	local dur = line.duration
	local tag = "" 
	local time = s_time 
	while  ( (dur > time) and (time < e_time)) do 
		local time1 = time + math.random(50,150)
		local time2 = time1 + frame_dur
		local time3 = time2 + frame_dur
		tag = tag..string.format("\\t(%d,%d,\\fr-0.3)\\t(%d,%d,\\fr0)",time1, time2, time2, time3)
		time = time3 
	end 
	return tag..string.format("\\org(%d,%d)",line.center + xres / 3 * ((math.random(0,1) == 0) and -1 or 1), line.middle +yres * ((math.random(0,1) == 0) and -1 or 1)) 
end

function asscolor(htmlcolor)
	local r, g, b = string.match(htmlcolor, "(%x%x)(%x%x)(%x%x)")
	return ass_color(tonumber(r,16), tonumber(g,16), tonumber(b,16))
end

function line_per_word (line)
	local word = {}; word.n = 1; word.text = {}; word.width = {}; word.total_width = {}; word.center = {}; word.left = {}; word.right = {}

	word.space_width = aegisub.text_extents(line.styleref," ") 
	 
	for w in unicode.chars(string.gsub(line.text_stripped,"(%S+)", "")) do 
		word.n = word.n + 1 
	end 

	local i = 1 
	string.gsub(line.text_stripped,"(%S+)", function(w) word.text[i] = w i = i + 1 end) 

	for i = 1, word.n do 
		if word.text[i] ~= nil then 
			word.width[i] = aegisub.text_extents(line.styleref, word.text[i]) 
		end 
	end
 
	word.total_width[1] = 0 
	for i = 2, word.n do 
		word_width = 0 
		for l = 1, i-1 do 
			word_width = word_width + word.width[l] + word.space_width 
		end 
		word.total_width[i] = word_width 
	end 

	for i = 1, word.n do  
		if (word.total_width[i] ~= nil and word.width[i] ~= nil)  then 
			word.left[i] = line.left+word.total_width[i] 
			word.center[i] = word.left[i] + word.width[i]/2 
			word.right[i] = word.left[i] + word.width[i] 
		end 
	end
	return word
end

particle_fake_conf = {
	
	[1] = { name = "applyto"; class = "dropdown"; x = 1; y = 1; height = 1; width = 4; items = { }; value = "" }
	,
	[2] = { name = "effect" ; class = "dropdown" ; x = 1; y = 3; height = 1; width = 4; items = {"karaoke-type1 (crash)","karaoke-type2 (blow)","karaoke-type3 (explosion)","trans-type1 (crash-right)","trans-type2 (crash-left)","trans-type3 (crash-center)","trans-type4 (blow)" ,"trans-type5 (explosion)"} ; value = "karaoke-type3 (explosion)"}
	,
	[3] = { name = "primary_color"; class = "color"; x = 0; y = 6; height = 2; width = 1; value =  "#FFFFFF" }
	,
	[4] = { name = "secondary_color"; class = "color"; x = 1; y = 6; height = 2; width = 1; value =  "#FF0000" }
	,
	[5] = { name = "outline_color"; class = "color"; x = 2; y = 6; height = 2; width = 1; value = "#000000" }
	,
	[6] = { name = "shadow_color"; class = "color"; x = 3; y = 6; height = 2; width = 1; value = "#000000" }
	,
	[7] = { class = "label"; x = 0; y = 1; height = 1; width = 1; label = "Apply to" }
	,
	[8] = { class = "label"; x = 0; y = 3; height = 1; width = 1; label = "Effect Type" }
	,
	[9] = { class = "label"; x = 0; y = 5; height = 1; width = 1; label = "Primary"}
	,
	[10] = { class = "label"; x = 1; y = 5; height = 1; width = 1; label = "Secondary  "}
	,
	[11] = { class = "label"; x = 2; y = 5; height = 1; width = 1; label = "Outline       "}
	,
	[12] = { class = "label"; x = 3; y = 5; height = 1; width = 1; label = "Shadow      "}
	,
	[13] = { class = "label"; x = 0; y = 0; height = 1; width = 4; label = "Please select the style that applies the effect."}
	,
	[14] = { class = "label" ; x = 0; y = 2; height = 1; width = 4; label ="Please select the effect type."}
	,
	[15] = { class = "label" ; x = 0; y = 4; height = 1; width = 4; label ="Please select the colors."}
	,
	[16] = { name = "particle"; class = "intedit"; x = 2; y = 8; height = 1; width = 2; min = 0; max = 200; value = 100 } 
	,
	[17] = { class = "label"; x = 0; y = 8; height = 1; width = 2; label = "Num of Particle(0 to 200)" }
	,
	[18] = { class = "label"; x = 4; y = 8; height = 1; width = 1; label = "%" }
}

function particle_fake_prepareconfig(styles, subtitles, has_selected_lines)
	particle_fake_conf[1].items = {}
	
	local astyles = {}
	for i = 1, #subtitles do
		if subtitles[i].class == "dialogue" and subtitles[i].effect ~= "FX" and
			not subtitles[i].comment then
			if subtitles[i].style ~= "" and not astyles[subtitles[i].style] then 
				astyles[subtitles[i].style] = true
				applytostyle = subtitles[i].style
				table.insert(particle_fake_conf[1].items, applytostyle)
				
			end
		end 
	end
	if  #particle_fake_conf[1].items > 0 then 
		particle_fake_conf[1].value = "SelectAll"
		table.insert(particle_fake_conf[1].items, particle_fake_conf[1].value) 
	end
	if has_selected_lines and #particle_fake_conf[1].items > 0 then 
		table.insert(particle_fake_conf[1].items,"Selected lines")
	end
end

function particle_fake_filter_options_dialog(subtitles, stored_options)
	local meta, styles = karaskel.collect_head(subtitles)
	particle_fake_prepareconfig(styles, subtitles, false)
	return particle_fake_conf
end

function particle_fake_preprosses_macro(subtitles, config, selected_lines)
	local subs = {}
	if config.applyto == "Selected lines" then
		for _, i in ipairs(selected_lines) do
			table.insert(subs, i)
		end
	elseif config.applyto == "SelectAll" then
		for i = 1, #subtitles do
			if subtitles[i].class == "dialogue" and subtitles[i].effect ~= "FX" and not subtitles[i].comment then
				table.insert(subs, i)
			end
		end
	else
		for i = 1, #subtitles do
			if subtitles[i].class == "dialogue" and subtitles[i].effect ~= "FX" and not subtitles[i].comment and config.applyto == subtitles[i].style then
				table.insert(subs, i)
			end
		end
	end
	
	
	particle_fake(subtitles, config, subs)
end

function particle_fake_preprosses_filter(subtitles, config)
	local subs = {}
	if config.applyto == "SelectAll" then
		for i = 1, #subtitles do
			if subtitles[i].class == "dialogue" and subtitles[i].effect ~= "FX" and not subtitles[i].comment then
				table.insert(subs, i)
			end
		end
	else
		for i = 1, #subtitles do
			if subtitles[i].class == "dialogue" and subtitles[i].effect ~= "FX" and not subtitles[i].comment and config.applyto == subtitles[i].style then
				table.insert(subs, i)
			end
		end
	end

	particle_fake(subtitles, config, subs)
	
end

function particle_fake_macro(subtitles, selected_lines, active_line)
	local meta, styles = karaskel.collect_head(subtitles)

	particle_fake_prepareconfig(styles, subtitles, #selected_lines > 0)
	local cfg_res, config = aegisub.dialog.display(particle_fake_conf)
	
	if cfg_res then
		particle_fake_preprosses_macro(subtitles, config, selected_lines)
		aegisub.set_undo_point("particle fake")
		aegisub.progress.task("Finished!") 
		
	else
		aegisub.progress.task("Cancelled");	
	end
end

aegisub.register_macro("Particle Effect", "",particle_fake_macro)
aegisub.register_filter("Particle Effect", "", 2000, particle_fake_preprosses_filter, particle_fake_filter_options_dialog)
