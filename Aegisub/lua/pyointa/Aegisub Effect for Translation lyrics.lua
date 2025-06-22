include("karaskel.lua")

script_name = "Aegisub Effect for Translation Subtitles"
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

max_space = 3
particle_base_size = 2
particle_size = particle_base_size * ratio
line_counter = 0
particle_shape = "m 0 0 l 2 0 l 2 2 l 0 2"
flame_shape = "m 5 0 b 2 0 0 2 0 5 b 0 8 2 10 5 10 b 8 10 10 8 10 5 b 10 2 8 0 5 0"
bezier_shape = "m 30 23 b 24 23 24 33 30 33 b 36 33 37 23 30 23 m 35 27 l 61 28 l 35 29 m 26 27 l 0 28 l 26 29 m 29 23 l 30 0 l 31 23 m 29 33 l 30 57 l 31 33"
sakura_shape = "m 9 23 b 8 22 7 21 6 20 b 4 18 3 16 2 12 b 2 9 3 5 4 3 b 5 2 6 1 7 1 b 8 3 8 4 9 5 b 10 4 10 3 11 1 b 13 2 14 3 14 3 b 15 5 16 8 16 12 b 15 16 14 18 12 20 b 11 21 10 22 9 23","m 9 23 b 8 22 7 21 5 19 b 4 18 2 16 1 11 b 1 8 2 5 4 3 b 5 2 6 1 7 1 b 8 3 8 4 9 5 b 10 4 10 3 11 1 b 13 2 14 3 14 3 b 16 5 17 8 17 11 b 16 16 14 18 13 19 b 11 21 10 22 9 23"

function trans_effect(subs, config, index)
	aegisub.progress.task("Getting header data...")
	local meta, styles  = karaskel.collect_head(subs)

	aegisub.progress.task("Applying effect...")
	local maxi = #index
	for ai, i in ipairs(index) do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxi))
		aegisub.progress.set((ai-1)/maxi*100)
		local l = subs[i]
		karaskel.preproc_line(subs, meta, styles, l)
		if config.effect == "flame-effect" then
			do_fx1(subs, meta, l, config)
		elseif config.effect == "particle(blow)" then
			do_fx2(subs, meta, l, config)
		elseif config.effect == "particle(explosion)" then
			do_fx3(subs, meta, l, config)
		elseif config.effect == "motion-blur" then
			do_fx4(subs, meta, l, config)
		elseif config.effect == "flash-effect" then
			do_fx5(subs, meta, l, config)
		elseif config.effect == "3D-effect" then
			do_fx6(subs, meta, l, config)
		elseif config.effect == "horror" then
			do_fx7(subs, meta, l, config)
		elseif config.effect == "bezier-curve" then
			do_fx8(subs, meta, l, config)
		elseif config.effect == "sakura-effect" then
			do_fx9(subs, meta, l, config)
		elseif config.effect == "Oh-effect" then
			do_fx10(subs, meta, l, config)
		end
		l.comment = true
		subs[i] = l
	end
	
end

--Flame Effect--
function do_fx1(subs, meta, line, config)
	local l = table.copy(line)
	local char = {} 
	if line.duration > 0 then
		local cn = unicode.len(line.text_stripped:gsub(" ",""))
		local ci = 0
		local left, width = line.left, 0
		l.layer = 1
		l.effect = "FX"
		for c in unicode.chars(line.text_stripped) do
			ci = ci + 1
			width = aegisub.text_extents(line.styleref, c)
			char.left = left
			char.center = left + width / 2
			char.right = left + width
			l.start_time = line.start_time 
			l.end_time = line.end_time
			l.dur = l.end_time - l.start_time
			l.text = string.format("{\\1c%s\\3c%s\\4c%s\\1a%s\\3a%s\\4a%s\\bord%0.3f\\shad%0.3f\\an5\\pos(%d,%d)\\1a&HFF&\\4a&HFF&\\t(%d,%d,\\1a&H00&\\4a&H00&)\\fad(300,0)\\t(%d,%d,\\alpha&HFF&)}%s", config.primary_color, config.outline_color, config.shadow_color, config.primary_alpha, config.outline_alpha, config.shadow_alpha, config.outline, config.shadow,char.center, line.middle, ci * 42,ci * 42 + 300,l.dur - 300, l.dur, c)
			subs.append(l)
			left = left + width
		end
	end

	l = table.copy(line)
	char = {}
	if line.duration > 0 then
		local cn = unicode.len(line.text_stripped:gsub(" ",""))
		local ci = 0
		local left, width = line.left, 0
		l.layer = 1
		l.effect = "FX"
		for c in unicode.chars(line.text_stripped) do
			ci = ci + 1
			width = aegisub.text_extents(line.styleref, c)
			char.left = left
			char.center = left + width / 2
			char.right = left + width
			l.start_time = line.start_time + ci * 42
			l.end_time = l.start_time + config.adv.flame_dur + 300
			l.dur = l.end_time - l.start_time
			randflame = math.random(-line.height,line.height / 2)
			for j = 1, 20 do
				randtime1 = math.random(300)
				scale1 = math.random(40,120)
				scale2 = math.random(40,240)
				if config.adv.gradient then
					flame_color = interpolate_color(math.random() * 0.5,asscolor(config.adv.flame_color1),asscolor(config.adv.flame_color2))
				else
					flame_color = asscolor(config.adv.flame_color1)
				end
				l.text = string.format("{\\1c%s\\an5\\org(%d,%d)\\fad(200,0)\\alpha&H60&\\t(%d,%d,\\alpha&HFF&)\\blur%0.3f\\fscx%d\\fscy%d\\bord0\\shad0\\t(500,%d,\\fscx%d\\fscy%d\\fr%d)\\move(%d,%d,%d,%d,%d,%d)\\p1}%s",flame_color, char.center, line.middle - 20, math.random(100,300), l.dur - randtime1, 1.8 * ratio, scale1, scale1, math.random(l.dur-300,l.dur), scale2, scale2, math.random(-20,20), char.center + math.random(-16,16) * ratio, line.middle + math.random(-10,10) * ratio, char.center + math.random(-10,10) * ratio, line.middle - config.adv.flame_height + math.random(20,60) + randflame, math.random(150), l.dur - randtime1,  flame_shape)
				subs.append(l)
			end
			left = left + width
		end
	end
end

--Particle Effect (blow)--
function do_fx2(subs, meta, line, config)				--text lead-in
	if line.duration > 0 then
		local l = table.copy(line)
		l.effect = "FX"
		l.start_time = line.start_time -1000 
		l.end_time = line.end_time - 1000
		l.dur = l.end_time - l.start_time
		l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\fad(300,0)\\pos(%d,%d)\\clip(%d,%d,%d,%d)\\t(%d,%d,\\clip(%d,%d,%d,%d))}%s", config.primary_color, config.outline_color, config.shadow_color, line.center, line.middle, line.left - line.styleref.outline, line.top - 100, line.right + 100, line.bottom + 100, l.dur - 400, l.dur, line.right + line.styleref.outline, line.top - 100, line.right + line.styleref.outline, line.bottom + 100, line.text_stripped)
		l.layer = 0
		subs.append(l)
	end
													--particle effect
	if line.duration > 0 then
		local l = table.copy(line) 
		l.effect = "FX"
		local loop_num = ((line.height * line.width / (particle_size^2)) / 4) * (config.adv.particle / 100)
		for j = 1, loop_num  do
			l.start_time = line.end_time - 1400 + (j / loop_num) * 400
			l.end_time = l.start_time + math.random(500,1000)
			l.dur = l.end_time - l.start_time
			local xpos = math.floor((j - 1) / (line.height / (particle_size * 4))) / (config.adv.particle / 100) * particle_size + line.left
			local ypos = line.middle+math.random(-line.height / 2, line.height / 2)
			l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\shad0\\bord%f\\move(%d,%d,%d,%d)\\fad(0,300)\\3a&HA0&\\fscx%d\\fscy%d%s\\p1}%s", config.primary_color, config.outline_color, config.shadow_color, 1.6 * ratio, xpos, ypos, xpos + math.random(270) * ratio, ypos + math.random(-50, 30) * ratio, 100 * ratio, 100 * ratio, glitter(l.dur, config), particle_shape) 
			l.layer = 0
			subs.append(l)
		end
	end
end

--Particle Effect (explosion)--
function do_fx3(subs, meta, line, config)		
	local word = line_per_word(line)
													--text lead-in
	if line.duration > 0 then
		local l = table.copy(line)
		l.effect = "FX"
		for i = 1, word.n do
			l.start_time = line.start_time -1000 
			l.end_time = line.end_time - 1000
			l.dur = l.end_time - l.start_time
			l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\fad(300,0)\\pos(%d,%d)\\t(%d,%d,\\bord%f\\blur%f\\3c&HFFFFFF&)%s}%s", config.primary_color, config.outline_color, config.shadow_color, word.center[i], line.middle, line.duration - 66, line.duration - 33, 5 * ratio, 3 * ratio, jitter((l.dur > 900) and l.dur - 600 or 0, l.dur, line), word.text[i])
			l.layer = 0
			subs.append(l)
		end
	end
													--particle effect
	if line.duration > 0 then
		local l = table.copy(line) 
		l.effect = "FX"
		local loop_num = ((line.height * line.width / (particle_size^2)) / 4) * (config.adv.particle / 100)
		for j = 1, loop_num  do
			l.start_time = line.end_time -1000
			l.end_time = l.start_time + math.random(300,1500)
			l.dur = l.end_time - l.start_time
			local xpos = line.center + math.random(-line.width / 2, line.width / 2)
			local ypos = line.middle + math.random(-line.height / 2, line.height / 2)
			l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\shad0\\bord%f\\move(%d,%d,%d,%d)\\fad(0,300)\\3a&HA0&%s\\p1}%s", config.primary_color, config.outline_color, config.shadow_color, 1.6 * ratio, xpos, ypos, xpos + math.random(-200, 200) * ratio, ypos + math.random(-80, 80) * ratio, glitter(l.dur, config), particle_shape) 
			l.layer = 0
			subs.append(l)
		end
	end 
end

--Motion Blur--
function do_fx4(subs, meta, line, config)	
	local position = loadstring("return function(config, meta, line) return {x1="..config.adv.x1..",y1="..config.adv.y1..",x2="..config.adv.x2..",y2="..config.adv.y2..",x3="..config.adv.x3..",y3="..config.adv.y3..",x4="..config.adv.x4..",y4="..config.adv.y4.."} end")()
	local pos = position(config, meta, line)	
	local posx, posy
	if line.duration > 0 then
		local l = table.copy(line)
		l.effect = "FX"
		local t = 0
		local t1 = config.adv.start_add
		local s_accel = config.adv.s_accel
		local dur = math.abs(t1)
		local a_t = frame_dur / dur
		while t <= 1 do
			a_t, posx, posy = motion_blur(pos.x1, pos.y1, pos.x2, pos.y2, t1, s_accel, t, a_t)
			l.start_time = line.start_time + t1 + t * dur 
			l.end_time = line.start_time + t1 + (t + a_t) * dur + frame_dur * 2
			l.text = string.format("{\\1c%s\\bord0\\shad%0.3f\\blur%0.3f\\an5\\pos(%0.3f,%0.3f)\\t(%d,%d,\\alpha&HFF&)}%s",interpolate_color(0.5,config.primary_color,config.outline_color), config.shadow, 4 - t * 1.5, posx,posy, 0, frame_dur*2, line.text_stripped)
			l.layer = 0
			subs.append(l)
			t = t + a_t
		end
	end

	if line.duration > 0 then
		local l = table.copy(line)
		l.effect = "FX"
		local t1 = config.adv.start_add
		local t2 = config.adv.end_add
		l.start_time = line.start_time + ((t1 > 0) and t1 or 0)
		l.end_time = line.end_time + ((t2 < 0) and t2 or 0)
		l.text = string.format("{\\1c%s\\3c%s\\4c%s\\1a%s\\3a%s\\4a%s\\bord%0.3f\\shad%0.3f\\blur%0.3f\\an5\\move(%0.3f,%0.3f,%0.3f,%0.3f)}%s", config.primary_color, config.outline_color, config.shadow_color, config.primary_alpha, config.outline_alpha, config.shadow_alpha, config.outline, config.shadow, config.blur, pos.x2, pos.y2, pos.x3, pos.y3, line.text_stripped)
		l.layer = 0
		subs.append(l)
	end 

	if line.duration > 0 then
		l = table.copy(line)
		l.effect = "FX"
		local t = 0
		local t2 = config.adv.end_add
		local e_accel = config.adv.e_accel
		local dur = math.abs(t2)
		local a_t = frame_dur / dur
		while t <= 1 do
			local a_t, posx, posy = motion_blur(pos.x3, pos.y3, pos.x4, pos.y4, t2, e_accel, t, a_t)
			l.start_time = line.end_time + t2 + t * dur
			l.end_time = line.end_time + t2 + (t + a_t) * dur + frame_dur * 2
			l.text = string.format("{\\1c%s\\bord0\\shad%0.3f\\blur%0.3f\\an5\\pos(%0.3f,%0.3f)\\t(%d,%d,\\alpha&HFF&)}%s",interpolate_color(0.5,config.primary_color,config.outline_color), config.shadow, 4 - t * 1.5, posx,posy, 0, frame_dur*2, line.text_stripped)
			l.layer = 0
			subs.append(l)
			t = t + a_t
		end
	end
end

--Flash--
function do_fx5(subs, meta, line, config)		
	if line.duration > 0 then
		local l = table.copy(line)
		l.effect = "FX"
		l.start_time = line.start_time -500 
		l.end_time = line.end_time 
		l.dur = l.end_time - l.start_time
		l.text = string.format("{\\an5\\pos(%0.3f,%0.3f)\\bord%0.3f\\blur%0.3f\\fscx80\\fscy80\\t(0,50,\\fscx105\\fscy105\\3c&HFFFFFF&)\\t(50,%d,\\fscx100\\fscy100)\\t(50,%d,0.5,\\blur%0.3f\\bord%0.3f\\3c&H000000&)\\fad(0,300)}%s", line.center, line.middle, 3 * ratio, 8 * ratio, l.dur, l.dur, 4 * ratio, 1 * ratio, line.text_stripped)
		l.layer = 0
		subs.append(l)
	end

	if line.duration > 0 then
		local l = table.copy(line)
		l.effect = "FX"
		l.start_time = line.start_time -500 
		l.end_time = line.end_time 
		l.dur = l.end_time - l.start_time
		l.text = string.format("{\\1c%s\\3c%s\\4c%s\\an5\\pos(%0.3f,%0.3f)\\fscx80\\fscy80\\t(0,50,\\fscx105\\fscy105\\3c&HFFFFFF&)\\t(50,%d,\\fscx100\\fscy100)\\t(50,%d,%0.3f,\\3c%s)\\fad(0,300)}%s", config.primary_color, config.outline_color, config.shadow_color, line.center, line.middle, l.dur, l.dur, 0.3, config.outline_color, line.text_stripped)
		l.layer = 1
		subs.append(l)
	end
end

--3D--
function do_fx6(subs, meta, line, config)
	line_counter = line_counter + 1		
	if line.duration > 0 then
		local l = table.copy(line)
		l.effect = "FX"
		local xpos = math.random(xres / 5,xres / 5 * 4)
		for i = 1, 10 do
			l.start_time = line.start_time - config.adv.leadin_dur + i * 150 
			l.end_time = line.start_time 
			l.dur = l.end_time - l.start_time
			l.text = string.format("{\\shad0\\alpha%s\\fad(%d,0)\\org(%0.3f,%0.3f)\\an5\\move(%0.3f,%0.3f,%0.3f,%0.3f,0,%d)\\blur%0.3f\\fscx30\\fscy30\\fr%0.3f\\t(0,%d,\\blur0\\fscx100\\fscy100\\fr%0.3f)\\1c&HFFFFFF&\\3c%s\\bord%0.3f\\fry%0.3f\\frx%0.3f}%s", ass_alpha((i/10)*200), l.dur, line.center, line.bottom, xpos, line.middle - math.cos(math.rad(config.adv.angle)) * config.adv.z_distance, line.center, line.middle, config.adv.leadin_dur - i * 150, 2 + 3 * (i / 10), (math.mod(line_counter,2) == 1) and 15 or -15, config.adv.leadin_dur - i * 150, (math.mod(line_counter,2) == 1) and -5 or 5, ass_color(HSV_to_RGB(53,i/10,1)), 1 * ratio, (math.mod(line_counter,2) == 1) and -10 or 10, config.adv.angle-90, line.text_stripped)
			l.layer = 10 - i
			subs.append(l)
		end
	end

	if line.duration > 0 then
		local char = {}
		local l = table.copy(line)
		local cn = unicode.len(line.text_stripped:gsub(" ",""))
		local ci = 0
		local left, width = line.left, 0
		l.effect = "FX"
		for c in unicode.chars(line.text_stripped) do
			ci = ci + 1
			width = aegisub.text_extents(line.styleref, c)
			char.left = left
			char.center = left + width / 2
			char.right = left + width
			l.start_time = line.start_time 
			l.end_time = line.end_time
			l.dur = l.end_time - l.start_time
			for i = 1, 5 do
				l.text = string.format("{\\an5\\pos(%0.3f,%0.3f)\\1c%s\\4c&H000000&\\fscx%d\\fscy%d\\fad(0,500)\\3c&HFFFFFF&\\shad%0.3f\\bord%0.3f\\blur%0.3f\\3a%s\\4a&HFF&\\t(0,500,\\4a%s\\3a%s\\1a&H80&)\\org(%0.3f,%0.3f)\\fr%d\\fry%d\\t(0,%d,\\fr0\\fry0\\frx0)\\frx%d\\t(%d,%d,\\3c%s\\bord%0.3f\\blur%0.3f\\4c&HFFFFFF&)\\t(%d,%d,\\bord%0.3f\\blur%0.3f)}%s", char.center, line.middle, interpolate_color(0.5,config.primary_color,"&HFFFFFF&"), 100 + i,100 + i, 1 * ratio, (i==1) and 2 * ratio or 0, (i==1) and 1 * ratio or 0, (i==1) and "&H00&" or "&HFF&", ass_alpha(255-127 * i /5), (i==1) and "&H00&" or "&HFF&", line.center, line.bottom, (math.mod(line_counter,2) == 1) and -5 or 5, (math.mod(line_counter,2) == 1) and -10 or 10, l.dur, config.adv.angle-90, ci * 42, ci * 42 + 33, ass_color(HSV_to_RGB((ci - 1) / cn * 360,1,1)), 5 * ratio, 5 * ratio, ci * 42 + 33, ci * 42 + 500, 1 * ratio, 1 * ratio, c)
				l.layer = 11
				subs.append(l)
			end
			left = left + width
		end
	end 
	
	if line.duration > 0 then		--shdow--
		local l = table.copy(line)
		l.effect = "FX"
		l.start_time = line.start_time  
		l.end_time = line.end_time 
		l.dur = l.end_time - l.start_time
		l.text = string.format("{\\an5\\fad(500,500)\\pos(%0.3f,%0.3f)\\fscy150\\org(%d,%d)\\blur%0.3f\\1c&H808080&\\3c%s\\fr%d\\fry%d\\t(\\fr0\\fry0)\\frx%d}%s", line.center, line.middle, line.center, line.bottom, 3 * ratio, interpolate_color(0.5,config.primary_color,"&H000000&"), (math.mod(line_counter,2) == 1) and -2 or 2, (math.mod(line_counter,2) == 1) and -5 or 5, (config.adv.angle > 90) and 90 or config.adv.angle, line.text_stripped)
		l.layer = 0
		subs.append(l)
	end

	if line.duration > 0 then		--flash--
		local l = table.copy(line)
		l.effect = "FX"
		l.start_time = line.start_time  
		l.end_time = l.start_time + 700
		l.dur = l.end_time - l.start_time
		l.text = string.format("{\\an5\\pos(%0.3f,%0.3f)\\fad(0,700)\\1a&HFF&\\4a&HFF&\\3c&HFFFFFF&\\bord%0.3f\\t(0,33,\\bord%0.3f\\blur%0.3f)\\org(%d,%d)\\fr%d\\fry%d\\frx%d}%s", line.center, line.middle, 1 * ratio, 5 * ratio, 5 * ratio, line.center, line.bottom, (math.mod(line_counter,2) == 1) and -5 or 5, (math.mod(line_counter,2) == 1) and -10 or 10, config.adv.angle-90, line.text_stripped)
		l.layer = 0
		subs.append(l)
	end
end



--Horror--
function do_fx7(subs, meta, line, config)		
	local word = line_per_word(line)
													--text lead-in
	if line.duration > 0 then
		local l = table.copy(line)
		l.effect = "FX"
		for i = 1, word.n do
			l.start_time = line.start_time
			l.end_time = line.end_time 
			l.dur = l.end_time - l.start_time
			l.text = string.format("{\\an5\\bord%0.3f\\blur%0.3f\\3a&HA0&\\fad(300,300)\\pos(%0.3f,%0.3f)\\org(%d,%d)%s}%s", 1.5 * ratio, 2 * ratio, word.center[i], line.middle, word.center[i], line.middle - yres, jitter2(line.duration, config), word.text[i])
			l.layer = 0
			subs.append(l)
		end
	end

	if line.duration > 0 then
		local l = table.copy(line)
		l.effect = "FX"
		for i = 1, word.n do
			for j = 1, 15 do
				l.start_time = line.start_time + math.random(l.duration - 300)
				l.end_time = l.start_time + frame_dur * 1.2
				l.dur = l.end_time - l.start_time
				l.text = string.format("{\\an5\\pos(%0.3f,%0.3f)\\alpha&H80&\\shad0\\bord0}%s", word.center[i] + ((math.random(0,1) == 1) and line.height / 3 or - line.height / 3), line.middle + ((math.random(0,1) == 1) and line.height / 3 or - line.height / 3), word.text[i])
				l.layer = 0
				subs.append(l)
			end
		end
	end

end

--Bezier--
function do_fx8(subs, meta, line, config)
	if line.duration > 0 then
		local l = table.copy(line)
		l.effect = "FX"
		l.start_time = line.start_time - 500
		l.end_time = line.end_time -500
		l.text = string.format("{\\1c%s\\3c%s\\4c%s\\1a%s\\3a%s\\4a%s\\bord%0.3f\\shad%0.3f\\blur%0.3f\\an5\\move(%0.3f,%0.3f,%0.3f,%0.3f,0,500)\\fad(300,300)}%s",config.primary_color, config.outline_color, config.shadow_color, config.primary_alpha, config.outline_alpha, config.shadow_alpha, config.outline, config.shadow, config.blur, -line.width / 2, line.middle, line.center, line.middle, line.text_stripped)
		l.layer = 0
		subs.append(l)
	end

	local x_pos, y_pos
	local color1, color3
	if line.duration > 0 then
		local l = table.copy(line)
		local parameters = loadstring("return function(config, meta, syl, line) return {"..config.adv.parameters.."} end")()
		config.param = parameters(config, meta, syl, line)
		if config.param.start_time then config.start_time = config.param.start_time end
		if config.param.end_time then config.end_time = config.param.end_time end
		if config.param.accel then config.accel = config.param.accel end
		local controlpoints = loadstring("return function(config, meta, syl, line) return {".. config.adv.cont_points .."} end")()
		config.c_point = controlpoints(config, meta, syl, line)
		l.effect = "FX"
		if config.adv.rand_color1 == true then
			color1 = ass_color(math.random(255),math.random(255),math.random(255))
		else
			color1 = asscolor(config.adv.curve_color1)
		end
		if config.adv.rand_color3 == true then
			color3 = ass_color(math.random(255),math.random(255),math.random(255))
		else
			color3 = asscolor(config.adv.curve_color3)
		end
		local t1, t2 = config.start_time, config.end_time
		local t = 0
		local dur = t2 - t1
		local f_t = 1 / (dur / frame_dur)
		local accel = config.accel			
		while t <= 1 do
			config.randparam = parameters(config, meta, syl, line)
			if config.randparam.x_blur then config.x_blur = config.randparam.x_blur end
			if config.randparam.y_blur then config.y_blur = config.randparam.y_blur end
			if config.randparam.afterimage_dur then config.afterimage_dur = config.randparam.afterimage_dur end
	
			local afterimage_dur = config.afterimage_dur
			local scale = math.random(20,60)
			local x_blur = config.x_blur
			local y_blur = config.y_blur
			l.start_time = line.start_time + t1 + t^accel * dur
			x_pos,y_pos,t = Bezier_Move(t1,t2,accel,t,f_t,unpack(config.c_point))
			l.end_time = line.start_time + t1 + t^accel * dur + afterimage_dur 
			l.dur = l.end_time - l.start_time
			l.layer = 1
			l.text = string.format("{\\an5\\move(%0.3f,%0.3f,%0.3f,%0.3f)\\fr45\\bord%0.3f\\shad0\\1c%s\\fad(0,300)\\fscx%d\\fscy%d\\blur%0.3f\\3c%s\\t(\\3c&HFFFFFF&)%s\\p1}%s", x_pos, y_pos, x_pos + x_blur, y_pos + y_blur, 1 * ratio, color1, 50 * ratio, 50 * ratio, 3 * ratio, color3, glitter2(l.dur,config,t), shape2(l.dur,t)) 
			subs.append(l)
		end
	end
end

--Sakura Effect--
function do_fx9(subs, meta, line, config)
	if line.duration > 0 then
		local char = {}
		local l = table.copy(line)
		local cn = unicode.len(line.text_stripped:gsub(" ",""))
		local ci = 0
		local left, width = line.left, 0
		l.effect = "FX"
		for c in unicode.chars(line.text_stripped) do
			ci = ci + 1
			width = aegisub.text_extents(line.styleref, c)
			char.left = left
			char.center = left + width / 2
			char.right = left + width
			l.start_time = line.start_time - cn * 20 + ci * 20
			l.end_time = line.end_time - cn * 20 + ci * 20
			l.dur = l.end_time - l.start_time
			l.text = string.format("{\\1c%s\\3c%s\\4c%s\\1a%s\\3a%s\\4a%s\\bord%0.3f\\shad%0.3f\\blur%0.3f\\fad(300,300)\\an5\\pos(%0.3f,%0.3f)}%s", config.primary_color, config.outline_color, config.shadow_color, config.primary_alpha, config.outline_alpha, config.shadow_alpha, config.outline, config.shadow, config.blur, char.center, line.middle, c)
			l.layer = 2
			subs.append(l)
			left = left + width
		end
	end

	if line.duration > 0 then
		local char = {}
		local l = table.copy(line)
		local cn = unicode.len(line.text_stripped:gsub(" ",""))
		local ci = 0
		local left, width = line.left, 0
		l.effect = "FX"
		for c in unicode.chars(line.text_stripped) do
			ci = ci + 1
			width = aegisub.text_extents(line.styleref, c)
			char.left = left
			char.center = left + width / 2
			char.right = left + width
			l.start_time = line.start_time - cn * 20 + ci * 20
			l.end_time = line.end_time - cn * 20 + ci * 20
			l.dur = l.end_time - l.start_time
			l.text = string.format("{\\fad(300,300)\\an5\\pos(%0.3f,%0.3f)\\bord4\\blur3\\3c&H000000&\\3a&H80&}%s", char.center, line.middle, c)
			l.layer = 1
			subs.append(l)
			left = left + width
		end
	end

	if line.duration > 0 then
		local char = {}
		local l = table.copy(line)
		local cn = unicode.len(line.text_stripped:gsub(" ",""))
		local ci = 0
		local left, width = line.left, 0
		l.effect = "FX"
		for c in unicode.chars(line.text_stripped) do
			ci = ci + 1
			width = aegisub.text_extents(line.styleref, c)
			char.left = left
			char.center = left + width / 2
			char.right = left + width
			l.start_time = line.start_time - cn * 20 + ci * 20
			l.end_time = line.end_time + 600 -cn * 20 + ci * 20
			l.dur = l.end_time - l.start_time
			for i = 1, 10 do
				l.text = string.format("{\\fad(300,300)\\fr%d\\frx%d\\fry%d\\bord0\\shad0\\1c%s\\an1\\move(%0.3f,%0.3f,%0.3f,%0.3f,%d,%d)\\t(0,%d,\\frx%d\\fry%d\\frz%d)\\fscx%d\\fscy%d\\t(%d,%d,0.5,\\frx%d\\fry%d\\frz%d)\\p1}%s", math.random(360), math.random(360), math.random(360), (math.random(0,1) == 1) and "&HF4D7FC&" or "&HE686FF&", char.center + math.random(-15,15) * ratio, line.middle + math.random(-15,15) * ratio, char.center + math.random(0,180) * ratio, line.middle + math.random(-30,30) * ratio, l.dur - 900, l.dur, l.dur - 900, math.random(-250,250), math.random(-500,500), math.random(-250,250), 60 * ratio, 60 * ratio, l.dur -900, l.dur, math.random(-500,500), math.random(-1000,1000), math.random(-500,500), sakura_shape)
				l.layer = 0
				subs.append(l)
			end
			left = left + width
		end
	end
end

--Oh Effect--
function do_fx10(subs, meta, line, config)
	if line.duration > 0 then
		local char = {}
		local l = table.copy(line)
		local cn = unicode.len(line.text_stripped:gsub(" ",""))
		local ci = 0
		local left, width = line.left, 0
		l.effect = "FX"
		for c in unicode.chars(line.text_stripped) do
			ci = ci + 1
			width = aegisub.text_extents(line.styleref, c)
			char.left = left
			char.center = left + width / 2
			char.right = left + width
			l.start_time = line.start_time - cn * 20 + ci * 20
			l.end_time = line.end_time - cn * 20 + ci * 20
			l.dur = l.end_time - l.start_time
			l.text = string.format("{\\1c%s\\3c%s\\4c%s\\1a%s\\3a%s\\4a%s\\bord%0.3f\\shad%0.3f\\blur%0.3f\\an5\\pos(%0.3f,%0.3f)\\fad(230,300)\\fscx0\\fscy0\\t(0,330,\\fscx150\\fscy150)\\t(330,460,\\fscx80\\fscy80)\\t(460,525,\\fscx100\\fscy100)}%s", config.primary_color, config.outline_color, config.shadow_color, config.primary_alpha, config.outline_alpha, config.shadow_alpha, config.outline, config.shadow, config.blur, char.center, line.middle, c)
			l.layer = 1
			subs.append(l)
			left = left + width
		end
	end

	if line.duration > 0 then
		local char = {}
		local l = table.copy(line)
		local cn = unicode.len(line.text_stripped:gsub(" ",""))
		local ci = 0
		local left, width = line.left, 0
		l.effect = "FX"
		for c in unicode.chars(line.text_stripped) do
			ci = ci + 1
			width = aegisub.text_extents(line.styleref, c)
			char.left = left
			char.center = left + width / 2
			char.right = left + width
			for i = 0, 6 do
				l.start_time = line.start_time - 250 - cn * 20 + ci * 20 + i * 99
				l.end_time = l.start_time + 600
				l.dur = l.end_time - l.start_time
				l.text = string.format("{\\an5\\pos(%0.3f,%0.3f)\\fscx0\\fscy0\\t(\\fscx200\\fscy200)\\t(300,600,\\alpha&HFF&)\\shad0\\bord%0.3f\\3c%s\\1c%s}%s",char.center, line.middle, 5 * ratio, config.adv.color[i+1], config.adv.color[i+1], c)
				l.layer = 0
				subs.append(l)
			end
			left = left + width
		end
	end
end

--Basic(Text) configuration table--
trans_effect_conf = {
	[1] = { class = "label"; x = 0; y = 0; height = 1; width = 1; label = "Apply to" }
	,
	[2] = { name = "applyto"; class = "dropdown"; x = 1; y = 0; height = 1; width = 4; items = { }; value = "" }
	,
	[3] = { class = "label"; x = 0; y = 1; height = 1; width = 1; label = "Effect Type" }
	,
	[4] = { name = "effect" ; class = "dropdown" ; x = 1; y = 1; height = 1; width = 4; items = {"flame-effect","particle(blow)","particle(explosion)","motion-blur","flash-effect","3D-effect","bezier-curve","sakura-effect","Oh-effect"} ; value = ""}
	,
	[5] = { class = "label"; x = 0; y = 4; height = 1; width = 1; label = "Text Color" }
	,
	[6] = { class = "label"; x = 1; y = 3; height = 1; width = 1; label = "Primary"}
	,
	[7] = { name = "primary_color"; class = "color"; x = 1; y = 4; height = 2; width = 1; value =  "#FFFFFF" }
	,
	[8] = { class = "label"; x = 2; y = 3; height = 1; width = 1; label = "Secondary"}
	,
	[9] = { name = "secondary_color"; class = "color"; x = 2; y = 4; height = 2; width = 1; value =  "#FF0000" }
	,
	[10] = { class = "label"; x = 3; y = 3; height = 1; width = 1; label = "Outline"}
	,
	[11] = { name = "outline_color"; class = "color"; x = 3; y = 4; height = 2; width = 1; value = "#000000" }
	,
	[12] = { class = "label"; x = 4; y = 3; height = 1; width = 1; label = "Shadow"}
	,
	[13] = { name = "shadow_color"; class = "color"; x = 4; y = 4; height = 2; width = 1; value = "#000000" }
	,
	[14] = { class = "label"; x = 0; y = 6; height = 1; width = 1; label = "Text Alpha" }
	,
	[15] = { name = "primary_alpha"; class = "alpha"; x = 1; y = 6; height = 1; width = 1; value =  "#00" }
	,
	[16] = { name = "secondary_alpha"; class = "alpha"; x = 2; y = 6; height = 1; width = 1; value =  "#00" }
	,
	[17] = { name = "outline_alpha"; class = "alpha"; x = 3; y = 6; height = 1; width = 1; value = "#00" }
	,
	[18] = { name = "shadow_alpha"; class = "alpha"; x = 4; y = 6; height = 1; width = 1; value = "#00" }	
	,
	[19] = { class = "label"; x = 0; y = 8; height = 1; width = 1; label = "Outline" }
	,
	[20] = { class = "label"; x = 1; y = 7; height = 1; width = 1; label = "Outline" }
	,
	[21] = { name = "outline"; class = "floatedit" ; x = 1; y = 8; height = 1; width = 1; min = 0; value = 2 }
	,
	[22] = { class = "label"; x = 2; y = 7; height = 1; width = 1; label = "Shadow" }
	,
	[23] = { name = "shadow"; class = "floatedit" ; x = 2; y = 8; height = 1; width = 1; min = 0; value = 2 }
	,
	[24] = { class = "label"; x = 3; y = 7; height = 1; width = 1; label = "Blur" }
	,
	[25] = { name = "blur" ; class = "floatedit" ; x = 3; y = 8; height = 1; width = 1; min = 0; value = 0}
	,
	[26] = { class = "label"; x = 0; y = 2; height = 1; width = 4; label = "Text Setting" }
} 
trans_effect_conf_key = {2,4,7,9,11,13,15,16,17,18,21,23,25}

--Advanced configuration tables--
flame_effect_conf = {	
	[1] = { name = "gradient"; class = "checkbox"; x = 0; y = 1; height = 1; width = 2; label = "Gradient"; value = false }
	,
	[2] = { class = "label"; x = 2; y = 1; height = 1; width = 2; label = "Color1" }
	,
	[3] = { class = "label"; x = 4; y = 1; height = 1; width = 2; label = "Color2" }
	,
	[4] = { class = "label"; x = 6; y = 1; height = 1; width = 1; label = "Flame dur" }
	,
	[5] = { class = "label"; x = 0; y = 1; height = 1; width = 2; label = "Flame Color" }	
	,
	[6] = { name = "flame_color1"; class = "color"; x = 2; y = 2; height = 2; width = 1; value = "#F7A10B" } 
	,
	[7] = { name = "flame_color2"; class = "color"; x = 4; y = 2; height = 2; width = 1; value = "#FFFFFF" }
	,
	[8] = { name = "flame_dur"; class = "intedit"; x = 6; y = 2; height = 1; width = 1; min = 600; max = 1600; value = 800 }
	,
	[9] = { name ="flame_height"; class = "intedit" ; x = 7; y = 2; height = 1; width = 1; min = 30; max = 150; value = 60 } 
	,
	[10] = { class = "label"; x = 7; y = 1; height = 1; width = 1; label = "Flame Height" }
} 
flame_effect_conf_key = {1,6,7,8,9}

motion_blur_conf = {
	[1] = { name = "x1"; class = "textbox" ; x = 1; y = 1; height = 1; width = 1; value ="0" }
	,
	[2] = { name = "x2"; class = "textbox" ; x = 2; y = 1; height = 1; width = 1; value ="line.center-30" }
	,
	[3] = { name = "x3"; class = "textbox" ; x = 3; y = 1; height = 1; width = 1; value ="line.center+30" }
	,
	[4] = { name = "x4"; class = "textbox" ; x = 4; y = 1; height = 1; width = 1; value ="xres" }
	,
	[5] = { name = "y1"; class = "textbox" ; x = 1; y = 2; height = 1; width = 1; value ="line.middle" }
	,
	[6] = { name = "y2"; class = "textbox" ; x = 2; y = 2; height = 1; width = 1; value ="line.middle" }
	,
	[7] = { name = "y3"; class = "textbox" ; x = 3; y = 2; height = 1; width = 1; value ="line.middle" }
	,
	[8] = { name = "y4"; class = "textbox" ; x = 4; y = 2; height = 1; width = 1; value ="line.middle" }
	,
	[9] = { name = "start_add"; class = "intedit" ; x = 1; y = 4; height = 1; width = 1; value = -200 }
	,
	[10] = { name = "end_add"; class = "intedit" ; x = 2; y = 4; height = 1; width = 1; value = -200 }
	,
	[11] = { name = "s_accel"; class = "floatedit" ; x = 3; y = 4; height = 1; width = 1; value = 0.5 }
	,
	[12] = { name = "e_accel"; class = "floatedit" ; x = 4; y = 4; height = 1; width = 1; value = 2 }
	,
	[13] = { class = "label"; x = 1; y = 0; height = 1; width = 1; label = "P1" }
	,
	[14] = { class = "label"; x = 2; y = 0; height = 1; width = 1; label = "P2" }
	,
	[15] = { class = "label"; x = 3; y = 0; height = 1; width = 1; label = "P3" }
	,
	[16] = { class = "label"; x = 4; y = 0; height = 1; width = 1; label = "P4" }
	,
	[17] = { class = "label"; x = 0; y = 1; height = 1; width = 1; label = "X" }
	,
	[18] = { class = "label"; x = 0; y = 2; height = 1; width = 1; label = "Y" }
	,
	[19] = { class = "label"; x = 1; y = 3; height = 1; width = 1; label = "Lead-in" }
	,
	[20] = { class = "label"; x = 2; y = 3; height = 1; width = 1; label = "Lead-out" }
	,
	[21] = { class = "label"; x = 3; y = 3; height = 1; width = 1; label = "Lead-int_Accel" }
	,
	[22] = { class = "label"; x = 4; y = 3; height = 1; width = 1; label = "Lead-out_Accel" }
}
motion_blur_conf_key = {1,2,3,4,5,6,7,8,9,10,11,12}

particle_fake_conf = {
	[1] = { name = "particle"; class = "intedit"; x = 2; y = 1; height = 1; width = 2; min = 0; max = 200; value = 100 } 
	,
	[2] = { class = "label"; x = 0; y = 1; height = 1; width = 2; label = "Num of Particle(0 to 200)" }
	,
	[3] = { class = "label"; x = 4; y = 1; height = 1; width = 1; label = "%" }
}
particle_fake_conf_key = {1}

effect_3D_conf = {
	[1] = { name = "angle"; class = "intedit"; x = 1; y = 1; height = 1; width = 1; min = 0; max = 360; value = 70 } 
	,
	[2] = { class = "label"; x = 0; y = 1; height = 1; width = 1; label = "Angle" }
	,
	[3] = { name = "z_distance"; class = "intedit"; x = 1; y = 2; height = 1; width = 1; min = 0; max = 200; value = 120 }
	,
	[4] = { class = "label"; x = 0; y = 2; height = 1; width = 1; label = "Z_distance" }
	,
	[5] = { name = "leadin_dur"; class = "intedit"; x = 1; y = 3; height = 1; width = 1; min = 0; max = 8000; value = 6000 }
	,
	[6] = { class = "label"; x = 0; y = 3; height = 1; width = 1; label = "Leadin_dur" }	
}
effect_3D_conf_key = {1,3,5}

bezier_conf = {
	[1] = { class = "label"; x = 1; y = 0; height = 1; width = 1; label = "Primary Color" }
	,
	[2] = { class = "label"; x = 3; y = 0; height = 1; width = 1; label = "Outline Color"}
	,
	[3] = { class = "label"; x = 0; y = 1; height = 1; width = 1; label = "Color" }
	,
	[4] = { name = "rand_color1" ; class = "checkbox"; x = 1; y = 1; height = 1; width = 1; label = "random"; value = false }
	,
	[5] = { name = "curve_color1" ; class = "color"; x = 2; y = 1; height = 1; width = 1; value = "#FFFFFF" }
	,
	[6] = { name = "rand_color3" ; class = "checkbox"; x = 3; y = 1; height = 1; width = 1; label = "random"; value = true }
	,
	[7] = { name = "curve_color3" ; class = "color"; x = 4; y = 1; height = 1; width = 1; value = "#FFFFFF" }
	,
	[8] = { class = "label"; x = 0; y = 2; height = 1; width = 6; label = "Check it when you want to use  random color." }
	,
	[9] = { class = "label" ; x = 0; y = 3; height = 1; width = 1; label = "Parameter Setting" }
	,
	[10] = { name = "parameters"; class = "textbox"; x = 0; y = 4; height = 3; width = 10; text = "start_time = -700; end_time = -200; accel = 0.3; afterimage_dur = math.random(1000,1500); x_blur = math.random(-line.height*1.5,line.height*1.5); y_blur = math.random(-line.height*1.5,line.height*1.5)" }
	,
	[11] = { class = "label" ; x = 0; y = 7; height = 1; width = 3; label = "Control Points (2 to 20)" }
	,
	[12] = { name = "cont_points"; class = "textbox"; x = 0; y = 8; height = 4; width = 10; text = "0,line.middle,xres,line.middle" }
}
bezier_conf_key = {4,5,6,7}

Oh_effect_conf = {
	[1] = { class = "label"; x = 1; y = 0; height = 1; width = 1; label = "color1" }
	,
	[2] = { class = "label"; x = 2; y = 0; height = 1; width = 1; label = "color2" }
	,
	[3] = { class = "label"; x = 3; y = 0; height = 1; width = 1; label = "color3" }
	,
	[4] = { class = "label"; x = 4; y = 0; height = 1; width = 1; label = "color4" }
	,
	[5] = { class = "label"; x = 1; y = 2; height = 1; width = 1; label = "color5" }
	,
	[6] = { class = "label"; x = 2; y = 2; height = 1; width = 1; label = "color6" }
	,
	[7] = { class = "label"; x = 3; y = 2; height = 1; width = 1; label = "color7" }
	,
	[8] = { name = "color1"; class = "color"; x = 1; y = 1; height = 1; width = 1; value = "#FDFD68" }
	,
	[9] = { name = "color2"; class = "color"; x = 2; y = 1; height = 1; width = 1; value = "#6AFCFE" }
	,
	[10] = { name = "color3"; class = "color"; x = 3; y = 1; height = 1; width = 1; value = "#7871FD" }
	,
	[11] = { name = "color4"; class = "color"; x = 4; y = 1; height = 1; width = 1; value = "#6DFB70" }
	,
	[12] = { name = "color5"; class = "color"; x = 1; y = 3; height = 1; width = 1; value = "#FDB1A6" }
	,
	[13] = { name = "color6"; class = "color"; x = 2; y = 3; height = 1; width = 1; value = "#FB7AFB" }
	,
	[14] = { name = "color7"; class = "color"; x = 3; y = 3; height = 1; width = 1; value = "#FA7283" }
}
Oh_effect_conf_key = {8,9,10,11,12,13,14}

dummy_conf = {[1] = { class = "label"; x = 0; y = 0; height = 1; width = 1; label = "Click OK there is no configuration item^^;" }}


--Functions for effect--
function shape2(dur,t) 
	local time = math.random(dur) 
	return string.format("{\\alpha&HFF&\\t(%d,%d,\\alpha&H00&\\3a&HA0&\\bord%f} m 30 23 b 24 23 24 33 30 33 b 36 33 37 23 30 23 m 35 27 l 61 28 l 35 29 m 26 27 l 0 28 l 26 29 m 29 23 l 30 0 l 31 23 m 29 33 l 30 57 l 31 33 {\\alpha&H00&\\t(%d,%d,\\alpha&HFF&} m -31 -23 b -38 -23 -38 -13 -31 -13 b -24 -13 -24 -23 -31 -23", time, time + 1, 1 * ratio, time, time + 1) 
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

function motion_blur(x1,y1,x2,y2,dur,accel,t,a_t) 
	local xdist = x2-x1  
	local ydist = y2-y1   
	if (a_t > 1) then  
		a_t = 1 
	end  
	  
	local posX = x1 + xdist * (t^accel)  
	local posY = y1 + ydist * (t^accel) 
	local n_posX = x1 + xdist * ((t+a_t)^accel) 
	local n_posY = y1 + ydist * ((t+a_t)^accel) 
	local dist = math.sqrt(math.abs(n_posX-posX)^2+math.abs(n_posY-posY)^2)  
	a_t = a_t * (max_space/dist) 
	return 	 a_t, posX, posY   
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
		tag = tag..string.format("\\t(%d,%d,\\fscx%d\\fscy%d\\1c&HFFFFFF&\\3c&HFFFFFF&\\bord%f\\blur%f)\\t(%d,%d,\\fscx%d\\fscy%d\\1c%s\\3c%s\\bord%f\\blur%f)",time1, time2, size1, size1, 2*ratio, 3*ratio, time3, time4, size2, size2, config.primary_color, config.outline_color, 1*ratio, 1*ratio) 
		time = time4
	end 
	return tag 
end

function glitter2(dur,donfig,t)  
	local time = math.random(dur) 
	local size = math.random(50,100)*ratio
	local size2 = math.random(50,100)*ratio
	tag =  string.format("\\t(%d,%d,\\fscx%d\\fscy%d)\\t(%d,%d,\\fscx%d\\fscy%d)\\t(%d,%d,\\fscx%d\\fscy%d)\\t(%d,%d,\\fscx%d\\fscy%d)", time, time + 1, size, size, time + 2, time + 100, 25 * ratio, 25 * ratio, time + 101, time + 102, size2, size2, time + 103, time + 200, 25 * ratio, 25 * ratio) 
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

function jitter2(dur, config) 
	local tag = "" 
	local time = 0 
	while  ( dur > time) do 
		time = time + math.random(500,1000)
		tag = tag..string.format("\\t(%d,%d,\\fr-1)\\t(%d,%d,\\fr0)", time, time + frame_dur, time + frame_dur, time + frame_dur * 2) 
	end 
	time = 0 
	while (dur > time) do 
		time = time + math.random(500,1000)
		tag = tag..string.format("\\t(%d,%d,\\1c%s)\\t(%d,%d,\\1c%s)",time, time + frame_dur, config.secondary_color, time + frame_dur, time + frame_dur * 2,config.primary_color) 
	end 
	return tag
end

function Bezier_Move(s_time,e_time,acl,t,f_t,...) 
	local a = {...} 
	local x = {} 
	local y = {}
	local dur = e_time-s_time 
	local n = #a/2 
	for i = 1,n*2-1,2 do 
		x[(i+1)/2] = a[i] 
	end 
	for i = 2, n*2,2 do 
		y[i/2] = a[i] 
	end 
	local pos_x, pos_y = Bezier(n,x,y,t) 
	local n_t = t + f_t 
	local n_x, n_y = Bezier(n,x,y,n_t) 
	local dist = math.sqrt(math.abs(n_x-pos_x)^2+math.abs(n_y-pos_y)^2) 
	local a_t =f_t*(max_space/dist) 
	if (a_t > f_t) then 
		a_t = f_t 
	end 
	t = t + a_t 
	return pos_x,pos_y,t 
end

function Bezier(n,x,y,t) 
	local p_x = 0 
	local p_y = 0 
	for i = 1, n, 1 do 
		p_y = p_y + y[i] * bernstein(i-1,n-1,t) 
		p_x = p_x + x[i] * bernstein(i-1,n-1,t)  
	end 
	return p_x, p_y 
end

function bernstein(i,n,t) 
	return (factk(n) / (factk(i)*factk(n-i))) * (t^i) * ((1-t)^(n-i)) 
end

function factk(n) 
	local k = 1 
	if (n > 1) then 
		for i = 2, n, 1 do 
			k = k * i 
		end 
	end 
	return k 
end

function asscolor(htmlcolor)
	local r, g, b = string.match(htmlcolor, "(%x%x)(%x%x)(%x%x)")
	return ass_color(tonumber(r,16), tonumber(g,16), tonumber(b,16))
end

function assalpha(htmlalpha)
	local a = string.match(htmlalpha, "(%x%x)")
	return ass_alpha(tonumber(a,16))
end

--Functions for macro--
function trans_effect_preprosses_macro(subtitles, config, selected_lines)
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
	
	
	trans_effect(subtitles, config, subs)
end

function trans_effect_prepareconfig(styles, subtitles, has_selected_lines)
	trans_effect_conf[2].items = {}
	local astyles = {}
	for i = 1, #subtitles do
		if subtitles[i].class == "dialogue" and subtitles[i].effect ~= "FX" and
			not subtitles[i].comment then
			if subtitles[i].style ~= "" and not astyles[subtitles[i].style] then 
				astyles[subtitles[i].style] = true
				applytostyle = subtitles[i].style
				table.insert(trans_effect_conf[2].items, applytostyle)
			end
		end 
	end
	if  #trans_effect_conf[2].items > 0 then 
		table.insert(trans_effect_conf[2].items, "SelectAll") 
	end
	if has_selected_lines and #trans_effect_conf[2].items > 0 then 
		table.insert(trans_effect_conf[2].items,"Selected lines")
	end
	
end

function trans_effect_macro(subtitles, selected_lines, active_line)
	local meta, styles = karaskel.collect_head(subtitles)
	local cfg_res, config, applytocolor1, applytocolor2, applytocolor3, applytocolor4, applytooutline, applytoshadow
	trans_effect_prepareconfig(styles, subtitles, #selected_lines > 0)
	repeat
		cfg_res, config = aegisub.dialog.display(trans_effect_conf,{"OK","Advance Setting","Cancel","Show Style Color"})
	
		if cfg_res == "Show Style Color" then
			if config.applyto == "SelectAll" or config.applyto == "Selected lines" or config.applyto == nil or config.applyto == "" then
				applytocolor1 = styles.Default.color1
				applytocolor2 = styles.Default.color2
				applytocolor3 = styles.Default.color3
				applytocolor4 = styles.Default.color4
				applytooutline = styles.Default.outline
				applytoshadow = styles.Default.shadow
			else	
				applytocolor1 = styles[config.applyto].color1
				applytocolor2 = styles[config.applyto].color2
				applytocolor3 = styles[config.applyto].color3
				applytocolor4 = styles[config.applyto].color4
				applytooutline = styles[config.applyto].outline
				applytoshadow = styles[config.applyto].shadow
			end
			trans_effect_conf[2].value = config.applyto
			trans_effect_conf[4].value = config.effect
			trans_effect_conf[7].value = applytocolor1
			trans_effect_conf[9].value = applytocolor2
			trans_effect_conf[11].value = applytocolor3
			trans_effect_conf[13].value = applytocolor4
			trans_effect_conf[21].value = applytooutline
			trans_effect_conf[23].value = applytoshadow
		elseif cfg_res == "Advance Setting" then
			if config.effect == "flame-effect" then
				cfg_res, config.adv = aegisub.dialog.display(flame_effect_conf,{"OK","Cancel"})
			elseif config.effect == "particle(blow)" or config.effect == "particle(explosion)" then
				cfg_res, config.adv = aegisub.dialog.display(particle_fake_conf,{"OK","Cancel"})
			elseif config.effect == "motion-blur" then
				cfg_res, config.adv = aegisub.dialog.display(motion_blur_conf,{"OK","Cancel"})
			elseif config.effect == "3D-effect" then
				cfg_res, config.adv = aegisub.dialog.display(effect_3D_conf,{"OK","Cancel"})
			elseif config.effect == "bezier-curve" then
				cfg_res, config.adv = aegisub.dialog.display(bezier_conf,{"OK","Cancel"})
			elseif config.effect == "Oh-effect" then
				cfg_res, config.adv = aegisub.dialog.display(Oh_effect_conf,{"OK","Cancel"})
			else
				cfg_res, config.adv = aegisub.dialog.display(dummy_conf,{"OK","Cancel"})
			end
		end
	until cfg_res == "OK" or cfg_res == "Cancel"	

	if cfg_res == "OK" then
		if config.adv == nil or config.effect == "Oh-effect" then
			config.adv = prepare_advconf(config)
		end
		
		config.primary_color = asscolor(config.primary_color)
		config.secondary_color = asscolor(config.secondary_color)
		config.outline_color = asscolor(config.outline_color)
		config.shadow_color = asscolor(config.shadow_color)
		config.primary_alpha = assalpha(config.primary_alpha)
		config.secondary_alpha = assalpha(config.secondary_alpha)
		config.outline_alpha = assalpha(config.outline_alpha)
		config.shadow_alpha = assalpha(config.shadow_alpha)

		trans_effect_preprosses_macro(subtitles, config, selected_lines)
		aegisub.set_undo_point("trans_effect")
		aegisub.progress.set(100)
		aegisub.progress.task("Finished!") 
	elseif cfg_res == "Cancel" then
		   
		aegisub.progress.task("Cancelled")
	end
end

function prepare_advconf(config)
	local adv = {}
		if config.effect == "flame-effect" then
		for i, v in ipairs(flame_effect_conf_key) do
			adv[flame_effect_conf[v].name] = flame_effect_conf[v].value
		end
	elseif config.effect == "particle(crash-right)" or config.effect == "particle(crash-left)" or config.effect == "particle(crash-center)" or config.effect == "particle(blow)" or config.effect == "particle(explosion)" then
		for i, v in ipairs(particle_fake_conf_key) do
			adv[particle_fake_conf[v].name] = particle_fake_conf[v].value
		end
	elseif config.effect == "motion-blur" then
		for i, v in ipairs(motion_blur_conf_key) do
			adv[motion_blur_conf[v].name] = motion_blur_conf[v].value
		end
	elseif config.effect == "3D-effect" then
		for i, v in ipairs(effect_3D_conf_key) do
			adv[effect_3D_conf[v].name] = effect_3D_conf[v].value
		end
	elseif config.effect == "bezier-curve" then
		for i, v in ipairs(bezier_conf_key) do
			adv[bezier_conf[v].name] = bezier_conf[v].value
		end
		adv[bezier_conf[10].name] = bezier_conf[10].text
		adv[bezier_conf[12].name] = bezier_conf[12].text
	elseif config.effect == "Oh-effect" then
		adv.color = {}
		for i, v in ipairs(Oh_effect_conf_key) do
			adv.color[i] = asscolor(Oh_effect_conf[v].value)
		end
		
	end
	return adv
end

aegisub.register_macro("Effect for Translation", "",trans_effect_macro)