include("karaskel.lua")

script_name = "new Bezier Move"
script_author = "pyointa2001"
script_version = "1.0.1"

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



shape = "m 5 0 b -2 0 -2 10 5 10 b 12 10 12 0 5 0 {\\1c&HFFFFFF&\\3c&HFFFFFF&} m 2 0 b 9 0 9 10 2 10 b -5 10 -5 0 2 0 "
shape2 = "m 30 23 b 24 23 24 33 30 33 b 36 33 37 23 30 23 m 35 27 l 61 28 l 35 29 m 26 27 l 0 28 l 26 29 m 29 23 l 30 0 l 31 23 m 29 33 l 30 57 l 31 33"
max_space = 3 * ratio

function new_bezier_curve_move(subs,config,index)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)

	aegisub.progress.task("Applying effect...")
	local maxi = #index
	for ai, i in ipairs(index) do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxi))
		aegisub.progress.set((ai-1)/maxi*100)
		local l = subs[i]
		
		karaskel.preproc_line(subs, meta, styles, l)
		if config.effect == "type1(basic)" then
			do_fx1(subs, meta, l, config)
		elseif config.effect == "type2(advanced)" then
			do_fx2(subs, meta, l, config)
		end
		l.comment = true
		subs[i] = l
		
	end
	aegisub.progress.task("Finished!")
	aegisub.progress.set(100)
end

function do_fx1(subs, meta, line, config)	--type1 (basic)
	for i = 1, line.kara.n do		--text lead-in
		local syl = line.kara[i]
		if syl.duration > 0 then
			local l = table.copy(line)
			l.effect = "FX"
			l.start_time = line.start_time -1000 + i * 60
			l.end_time = line.start_time + syl.start_time 
			l.text = string.format("{\\an5\\fad(1000,0)\\pos(%d,%d)\\blur3\\1c%s\\3c%s\\4c%s\\1a%s\\3a%s\\4a%s\\bord%f\\shad%f}%s",line.left+syl.center,line.middle, asscolor(config.text_color1), asscolor(config.text_color3), asscolor(config.text_color4),assalpha(config.text_alpha1), assalpha(config.text_alpha3),assalpha(config.text_alpha4), config.outline, config.shadow, syl.text)
			l.layer = 1
			subs.append(l)
		end
	end
	
	for i = 1, line.kara.n do		--text hilight
		local syl = line.kara[i]
		if syl.duration > 0 then
			local l = table.copy(line)
			l.effect = "FX"
			l.start_time = line.start_time + syl.start_time
			l.end_time = l.start_time + syl.duration
			l.text = string.format("{\\an5\\pos(%d,%d)\\blur3\\1c%s\\3c%s\\4c%s\\1a%s\\3a%s\\4a%s\\bord%f\\shad%f\\t(0,33,\\fscx120\\fscy120\\3c&HFFFFFF&\\1c&HFFFFFF&)\\t(33,%d,\\fscx100\\fscy100)\\fad(0,300)}%s",line.left + syl.center,line.middle,asscolor(config.text_color1), asscolor(config.text_color3), asscolor(config.text_color4), assalpha(config.text_alpha1), assalpha(config.text_alpha3),assalpha(config.text_alpha4), config.outline, config.shadow, syl.duration,syl.text)
			l.layer = 2
			subs.append(l)
		end
	end
	
	for i = 1, line.kara.n do		--bezier effect
		local syl = line.kara[i]
		if syl.duration > 0 then
			local l = table.copy(line) local syl_center = line.left + syl.center local syl_left = line.left + syl.left local syl_right = line.left + syl.right local syl_middle = line.middle
			local syl_dur = syl.duration
			local t = 0	
			local t1 = -800			
			local t2 = 0			
			local accel = 2.2			
			local dur = t2 - t1			
			local afterimage_dur = 400		 
			local f_t = 1 / (dur / frame_dur)	
			local X1 = math.random(30,50) * ratio
			local Y1 = math.random(20,50) * ratio
			local X2 = math.random(-300,300) * ratio
			local Y2 = math.random(-80,80) * ratio
			local X3 = math.random(-300,300) * ratio
			local Y3 = -80 * ratio
			
			if math.mod(i,2) == 1 then		
				cont_points = {syl_center + X1,syl_middle + Y1,syl_center + X1 + X2,syl_middle + Y2,syl_center - X1 + X3,syl_middle + Y3,syl_center,syl_middle}		
			else	
				cont_points = {syl_center - X1,syl_middle - Y1,syl_center + X1 + X2,syl_middle + Y2,syl_center - X1 + X3,syl_middle + Y3,syl_center,syl_middle}		
			end
			while t <= 1 do
				l.effect = "FX"
				l.start_time = line.start_time + syl.start_time + t1 + t * dur
				x_pos,y_pos,t = Bezier_Move(t1,t2,accel,t,f_t,unpack(cont_points))
				l.end_time = line.start_time + syl.start_time + t1 + t * dur + afterimage_dur 
				l.layer = 0
				temp_text = string.format("{\\move(%f,%f,%%f,%%f,%%d,%%d)\\an5\\fscx%f\\fscy%f\\1c%s\\3c%s\\shad0\\blur%f\\t(\\fscx%f\\fscy%f)\\fad(100,300)%%s\\p1}%s",x_pos,y_pos,10*ratio,10*ratio,ass_color(HSV_to_RGB(360*(syl.i/line.kara.n)*t,1,1)),ass_color(HSV_to_RGB(360*(syl.i/line.kara.n)*t,1,1)),1 * ratio,2.5 * ratio,2.5 * ratio,shape)

				local x_blur = 0 * ratio		 
				local y_blur = 0 * ratio		
				l.text = string.format(temp_text,x_pos + x_blur, y_pos + y_blur, 0, l.end_time-l.start_time,"")
				subs.append(l)
			end
		end
	end
end

function do_fx2(subs, meta, line, config)	--type2 (advanced)
	for i = 1, line.kara.n do		--text lead-in
		local syl = line.kara[i]
		if syl.duration > 0 then
			local l = table.copy(line)
			l.effect = "FX"
			l.start_time = line.start_time -1000 + i * 60
			l.end_time = line.start_time + syl.start_time 
			l.text = string.format("{\\an5\\fad(1000,0)\\pos(%d,%d)\\blur3\\1c%s\\3c%s\\4c%s\\1a%s\\3a%s\\4a%s\\bord%f\\shad%f}%s",line.left+syl.center,line.middle, asscolor(config.text_color1), asscolor(config.text_color3), asscolor(config.text_color4), assalpha(config.text_alpha1), assalpha(config.text_alpha3),assalpha(config.text_alpha4), config.outline, config.shadow, syl.text)
			l.layer = 1
			subs.append(l)
		end
	end
	
	for i = 1, line.kara.n do		--text hilight
		local syl = line.kara[i]
		if syl.duration > 0 then
			local l = table.copy(line)
			l.effect = "FX"
			l.start_time = line.start_time + syl.start_time
			l.end_time = l.start_time + syl.duration
			l.text = string.format("{\\an5\\pos(%d,%d)\\blur3\\1c%s\\3c%s\\4c%s\\1a%s\\3a%s\\4a%s\\bord%f\\shad%f\\t(0,33,\\fscx120\\fscy120\\3c&HFFFFFF&\\1c&HFFFFFF&)\\t(33,%d,\\fscx100\\fscy100)\\fad(0,300)}%s",line.left + syl.center,line.middle,asscolor(config.text_color1), asscolor(config.text_color3), asscolor(config.text_color4), assalpha(config.text_alpha1), assalpha(config.text_alpha3),assalpha(config.text_alpha4), config.outline, config.shadow, syl.duration,syl.text)
			l.layer = 2
			subs.append(l)
		end
	end
	
	if config.glitter then
	for i = 1, line.kara.n do		--text glitter
		local syl = line.kara[i]
		if syl.duration > 0 then
			for j = 1, 5 do
				local l = table.copy(line)
				l.effect = "FX"
				l.start_time = line.start_time + syl.start_time
				if syl.duration < 800 then 
					l.end_time = l.start_time + 800
				else
					l.end_time = l.start_time + syl.duration
				end
				local l_dur = l.end_time - l.start_time
				l.text =string.format("{\\an5\\move(%d,%d,%d,%d)\\shad0\\blur%0.3f\\bord%0.3f\\fr45\\fscx%0.3f\\fscy%0.3f\\1c&HFFFFFF&%s\\3c%s\\p1}%s",line.left + syl.center,line.middle, line.left + syl.center + math.random(-50,50) * ratio, line.middle + math.random(-50,50) * ratio, 3 * ratio, 1 * ratio, 20 * ratio, 20 * ratio, glitter(l_dur,line,config),ass_color(math.random(255),math.random(255),math.random(255)), shape2)
				l.layer = 3
				subs.append(l)
			end
		end
	end
	end

	for i = 1, line.kara.n do		--bezier effect
		local syl = line.kara[i]
		if syl.duration > 0 then
			local l = table.copy(line)  
			local parameters = loadstring("return function(config, meta, syl, line) return {"..config.parameters.."} end")()
			config.param = parameters(config, meta, syl, line)
			if config.param.start_time then config.start_time = config.param.start_time end
			if config.param.end_time then config.end_time = config.param.end_time end
			if config.param.accel then config.accel = config.param.accel end
			if config.param.afterimage_dur then config.afterimage_dur = config.param.afterimage_dur end
			if config.param.x_blur then config.x_blur = config.param.x_blur end
			if config.param.y_blur then config.y_blur = config.param.y_blur end
		
			local t = 0	
			local t1 = config.start_time			
			local t2 = config.end_time			
			local accel = config.accel			
			local dur = t2 - t1			
			local afterimage_dur = config.afterimage_dur		 
			local f_t = 1 / (dur / frame_dur)	
			local advshape = config.shape
			local s1c = asscolor(config.s_curve_color1)
			local s3c = asscolor(config.s_curve_color3)
			local e1c = asscolor(config.e_curve_color1)
			local e3c = asscolor(config.e_curve_color3)
			if config.rand_s_color1 then s1c = ass_color(math.random(255),math.random(255),math.random(255)) end
			if config.rand_s_color3 then s3c = ass_color(math.random(255),math.random(255),math.random(255)) end	
			if config.rand_e_color1 then e1c = ass_color(math.random(255),math.random(255),math.random(255)) end
			if config.rand_e_color3 then e3c = ass_color(math.random(255),math.random(255),math.random(255)) end

			local controlpoints = loadstring("return function(config, meta, syl, line) return {".. config.cont_points .."} end")()
			config.c_point = controlpoints(config, meta, syl, line)
			local cont_points = {}
			for i = 1, #config.c_point do
				if config.c_point[i] then config[i] = config.c_point[i] end
				table.insert(cont_points, config[i]) 
			end
			
			while t <= 1 do
				l.effect = "FX"
				l.start_time = line.start_time + syl.start_time + t1 + t * dur
				x_pos,y_pos,t = Bezier_Move(t1,t2,accel,t,f_t,unpack(cont_points))
				l.end_time = line.start_time + syl.start_time + t1 + t * dur + afterimage_dur
				local l_dur = l.end_time - l.start_time
				l.layer = 0
				
				temp_text = string.format("{\\move(%f,%f,%%f,%%f,%%d,%%d)\\an5\\fscx%f\\fscy%f\\1c%s\\3c%s\\shad0\\blur%f\\t(\\fscx%f\\fscy%f)\\fad(100,300)%%s\\p1}%s",x_pos,y_pos,10 * (config.thickness / 100) * ratio,10 * (config.thickness / 100) * ratio,interpolate_color(t,s1c,e1c) ,interpolate_color(t,s3c,e3c),1 * ratio,2.5 * (config.thickness / 100) * ratio,2.5 * (config.thickness / 100) * ratio, advshape)

				local x_blur = config.x_blur * ratio		 
				local y_blur = config.y_blur * ratio		
				l.text = string.format(temp_text,x_pos + x_blur, y_pos + y_blur, 0, l.end_time-l.start_time,"")
				subs.append(l)
			end
		end
	end
end

function glitter(dur,line,config)  
	if dur > 200 then
		local time1 = math.random(dur-200)
		local size1 = math.random(20,80) * ratio
		local size2 = math.random(20,80) * ratio
		local tag =  string.format("\\t(%d,%d,\\fscx%d\\fscy%d)\\t(%d,%d,\\fscx%d\\fscy%d)\\t(%d,%d,\\fscx%d\\fscy%d)\\t(%d,%d,\\fscx%d\\fscy%d)",time1,time1 + 1,size1,size1,time1+2,time1+100,20*ratio,20*ratio,time1+101,time1+102,size2,size2,time1+103,time1+200,20*ratio,20*ratio) 
		return tag 
	else
		return ""
	end
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
new_bezier_conf1 = {
	[1] = { class = "label"; x = 0; y = 0; height = 1; width = 2; label = "Basic Setting"}
	,
	[2] = { class = "label"; x = 0; y = 1; height = 1; width = 1; label = "Applyto" }
	,
	[3] = { name = "applyto"; class = "dropdown"; x = 1; y = 1; height = 1; width = 5; items = { }; value = "" }
	,
	[4] = { class = "label" ; x = 0, y = 2; height = 1; width = 5; label ="If you select Type2, Advanced Setting Dialogue is opend."}
	,
	[5] = { class = "label"; x = 0; y = 3; height = 1; width = 1; label = "EffectType" }
	,
	[6] = { name = "effect" ; class = "dropdown" ; x = 1; y = 3; height = 1; width = 5; items = {"type1(basic)","type2(advanced)" } ; hint = "If you select type2, advanced setting dialogue is opened."; value = ""}
	,
	[7] = { class = "label"; x = 0; y = 4; height = 1; width = 1; label = "Text Setting" }
	,
	[8] = { class = "label"; x = 1; y = 5; height = 1; width = 1; label = "Primary" }
	,
	[9] = { class = "label"; x = 2; y = 5; height = 1; width = 1; label = "Secondary" }
	,
	[10] = { class = "label"; x = 3; y = 5; height = 1; width = 1; label = "Outline" }
	,
	[11] = { class = "label"; x = 4; y = 5; height = 1; width = 1; label = "Shadow" }
	,
	[12] = { class = "label" ; x = 0; y = 6; height = 1; width = 1; label = "Color" }
	,
	[13] = { name = "text_color1" ; class = "color"; x = 1; y = 6; height = 1; width = 1; value = "#FFFFFF" }
	,
	[14] = { name = "text_color2" ; class = "color"; x = 2; y = 6; height = 1; width = 1; value = "#FF0000" }
	,
	[15] = { name = "text_color3" ; class = "color"; x = 3; y = 6; height = 1; width = 1; value = "#000000" }
	,
	[16] = { name = "text_color4" ; class = "color"; x = 4; y = 6; height = 1; width = 1; value = "#000000" }
	,
	[17] = { class = "label"; x = 0; y = 7; height = 1; width = 1; label ="Alpha" }
	,
	[18] = { name = "text_alpha1" ; class = "alpha"; x = 1; y = 7; height = 1; width = 1; value = "#00" }
	,
	[19] = { name = "text_alpha2" ; class = "alpha"; x = 2; y = 7; height = 1; width = 1; value = "#00" }
	,
	[20] = { name = "text_alpha3" ; class = "alpha"; x = 3; y = 7; height = 1; width = 1; value = "#00" }
	,
	[21] = { name = "text_alpha4" ; class = "alpha"; x = 4; y = 7; height = 1; width = 1; value = "#00" }
	,
	[22] = { name = "bold"; class = "checkbox"; x = 0 ; y = 8; height = 1; width = 1; label = "Bold"; value = false }
	,
	[23] = { name = "italic"; class = "checkbox"; x = 1; y = 8; height = 1; width = 1; label = "Italic"; value = false }
	,
	[24] = { class = "label"; x = 2; y = 8; height = 1; width = 1; label = "Outline" }
	,
	[25] = { name = "outline"; class = "floatedit"; x = 2; y = 9; height = 1; width = 1; step = 0.1; value = 2 }
	,
	[26] = { class = "label"; x = 3; y = 8; height = 1; width = 1; label = "Shadow" }
	,
	[27] = { name = "shadow"; class = "floatedit"; x = 3; y = 9; height = 1; width = 1; step = 0.1; value = 1 }
	,
	[28] = { name = "saveconfig"; class = "checkbox"; x = 0; y = 9; height = 1; width = 1; label = "Save Config Data"; value = true }
}

new_bezier_conf2 = {
	[1] = { class = "label"; x = 0; y = 0; height = 1; width = 3; label = "Advanced Setting (Bezier Curve Setting)" }
	,
	[2] = { class = "label"; x = 1; y = 1; height = 1; width = 1; label = "Primary Color" }
	,
	[3] = { class = "label"; x = 3; y = 1; height = 1; width = 1; label = "Outline Color"}
	,
	[4] = { class = "label"; x = 0; y = 2; height = 1; width = 1; label = "Start Color" }
	,
	[11] = { name = "rand_s_color1" ; class = "checkbox"; x = 1; y = 2; height = 1; width = 1; label = "random"; value = false }
	,
	[5] = { name = "s_curve_color1" ; class = "color"; x = 2; y = 2; height = 1; width = 1; value = "#FFFFFF" }
	,
	[21] = { name = "rand_s_color3" ; class = "checkbox"; x = 3; y = 2; height = 1; width = 1; label = "random"; value = false }
	,
	[6] = { name = "s_curve_color3" ; class = "color"; x = 4; y = 2; height = 1; width = 1; value = "#FF0000" }
	,
	[7] = { class = "label"; x = 0; y = 3; height = 1; width = 1; label = "End Color" }
	,
	[22] = { name = "rand_e_color1" ; class = "checkbox"; x = 1; y = 3; height = 1; width = 1; label = "random"; value = false }
	,
	[8] = { name = "e_curve_color1" ; class = "color"; x = 2; y = 3; height = 1; width = 1; value = "#000000" }
	,
	[23] = { name = "rand_e_color3" ; class = "checkbox"; x = 3; y = 3; height = 1; width = 1; label = "random"; value = false }
	,
	[9] = { name = "e_curve_color3" ; class = "color"; x = 4; y = 3; height = 1; width = 1; value = "#000000" }
	,
	[10] = { class = "label"; x = 0; y = 4; height = 1; width = 6; label = "Check it when you want to use  random color." }
	,
	[12] = { class = "label" ; x = 0; y = 5; height = 1; width = 1; label = "Parameter Setting" }
	,
	[13] = { name = "parameters"; class = "textbox"; x = 0; y = 6; height = 3; width = 10; text = "start_time = -800; end_time = 0; accel = 2.2; afterimage_dur = 400; x_blur = 0; y_blur = 0" }
	,
	[14] = { class = "label" ; x = 0; y = 9; height = 1; width = 3; label = "Control Points (2 to 20)" }
	,
	[15] = { name = "cont_points"; class = "textbox"; x = 0; y = 10; height = 7; width = 10; text = "line.left+syl.center+math.random(30,50),line.middle+math.random(20,50)*(math.mod(syl.i,2) ==1 and 1 or -1),line.left+syl.center+math.random(-300,300),line.middle+math.random(-80,80),line.left+syl.center+math.random(-300,300),line.middle-80,line.left+syl.center,line.middle" }
	,
	[24] = { class = "label"; x = 0; y = 17; height = 1; width = 1; label = "Thickness (0 to 1000%)" }
	,
	[18] = { class = "label"; x = 1; y = 17; height = 1; width = 1; label = "Shape " }
	,
	[20] = { name ="thickness"; class = "intedit" ; x = 0; y = 18; height = 1; width = 1; min = 0; max = 1000; value = 100 }
	,
	[19] = { name = "shape"; class = "textbox"; x = 1; y = 18; height = 3; width = 10; text = "m 5 0 b -2 0 -2 10 5 10 b 12 10 12 0 5 0" }
	,
	[17] = { name = "saveconfig"; class = "checkbox"; x = 0; y = 20; height = 1; width = 1; label = "Save Config Data"; value = true }
	, 
	[26] = { name = "glitter"; class = "checkbox"; x = 0; y =19; height = 1; width = 1; label = "Glitter"; value = false }
	,
	[25] = { class = "label" ; x = 0; y = 23; height = 5; width = 10; label = "Don't use $value.\nExample...\nline.left+syl.center : $scenter\nline.middle : $smiddle\nsyl.duration : $sdur" }
}

function asscolor(htmlcolor)
	local r, g, b = string.match(htmlcolor, "(%x%x)(%x%x)(%x%x)")
	return ass_color(tonumber(r,16), tonumber(g,16), tonumber(b,16))
end

function assalpha(htmlalpha)
	local a = string.match(htmlalpha, "(%x%x)")
	return ass_alpha(tonumber(a,16))
end

function new_bezier_prepareconfig(styles, subtitles, has_selected_lines)
	new_bezier_conf1[3].items = {}
	local subs = subtitles

	local astyles = {}
	for i = 1, #subs do
		if subs[i].class == "dialogue" and
			not subs[i].comment and subs[i].effect ~= "FX" then
			if subs[i].style ~= "" and not astyles[subs[i].style] then 
				astyles[subs[i].style] = true
				applytostyle = subs[i].style
				table.insert(new_bezier_conf1[3].items, applytostyle)
			end
		end 
	end
	if  #new_bezier_conf1[3].items > 0 then 
		table.insert(new_bezier_conf1[3].items, "SelectAll") 
	end
	if has_selected_lines and #new_bezier_conf1[3].items > 0 then 
		table.insert(new_bezier_conf1[3].items,"Selected lines")
	end
end

function new_bezier_filter_options_dialog(subtitles, stored_options)
	local meta, styles = karaskel.collect_head(subtitles)
	new_bezier_prepareconfig(styles, subtitles, false)
	return new_bezier_conf
end

function new_bezier_preprosses_macro(subtitles, config, selected_lines)
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
	
	
	new_bezier_curve_move(subtitles, config, subs)
end

function new_bezier_macro(subtitles, selected_lines, active_line)
	local meta, styles = karaskel.collect_head(subtitles)
	local cfg_res, config, applytocolor1, applytocolor2, applytocolor3, applytocolor4

	new_bezier_prepareconfig(styles, subtitles, #selected_lines > 0)

	repeat
		cfg_res, config = aegisub.dialog.display(new_bezier_conf1,{"OK","Cancel","Show Style Color"})
	
		if cfg_res == "Show Style Color" then
			if config.applyto == "SelectAll" or config.applyto == "Selected lines" or config.applyto == nil or config.applyto == "" then
				local applytocolor1 = styles.Default.color1
				local applytocolor2 = styles.Default.color2
				local applytocolor3 = styles.Default.color3
				local applytocolor4 = styles.Default.color4
			else	
				applytocolor1 = styles[config.applyto].color1
				applytocolor2 = styles[config.applyto].color2
				applytocolor3 = styles[config.applyto].color3
				applytocolor4 = styles[config.applyto].color4
			end
			new_bezier_conf1[3].value = config.applyto
			new_bezier_conf1[6].value = config.effect
			new_bezier_conf1[13].value = applytocolor1
			new_bezier_conf1[14].value = applytocolor2
			new_bezier_conf1[15].value = applytocolor3
			new_bezier_conf1[16].value = applytocolor4
		end
	until cfg_res == "OK" or cfg_res == "Cancel"	
	
	if config.saveconfig == true then
			new_bezier_conf1[3].value = config.applyto
			new_bezier_conf1[6].value = config.effect
			new_bezier_conf1[13].value = config.text_color1
			new_bezier_conf1[14].value = config.text_color2
			new_bezier_conf1[15].value = config.text_color3
			new_bezier_conf1[16].value = config.text_color4
			new_bezier_conf1[18].value = config.text_alpha1
			new_bezier_conf1[19].value = config.text_alpha2
			new_bezier_conf1[20].value = config.text_alpha3
			new_bezier_conf1[21].value = config.text_alpha4
			new_bezier_conf1[22].value = config.bold
			new_bezier_conf1[23].value = config.italic
			new_bezier_conf1[25].value = config.outline
			new_bezier_conf1[27].value = config.shadow
	end
			
	if cfg_res == "OK" then
		if config.effect == "type2(advanced)" then 
			cfg_res, config2 = aegisub.dialog.display(new_bezier_conf2)
			config.s_curve_color1 = config2.s_curve_color1
			config.s_curve_color3 = config2.s_curve_color3
			config.e_curve_color1 = config2.e_curve_color1
			config.e_curve_color3 = config2.e_curve_color3
			config.parameters = config2.parameters
			config.cont_points = config2.cont_points
			config.saveconfig = config2.saveconfig
			config.shape = config2.shape
			config.rand_s_color1 = config2.rand_s_color1
			config.rand_s_color3 = config2.rand_s_color3
			config.rand_e_color1 = config2.rand_e_color1
			config.rand_e_color3 = config2.rand_e_color3
			config.thickness = config2.thickness
			config.glitter = config2.glitter
			if config.saveconfig == true then 
				new_bezier_conf2[5].value = config.s_curve_color1
				new_bezier_conf2[6].value = config.s_curve_color3
				new_bezier_conf2[8].value = config.e_curve_color1
				new_bezier_conf2[9].value = config.e_curve_color3
				new_bezier_conf2[13].text = config.parameters 
				new_bezier_conf2[15].text = config.cont_points
				new_bezier_conf2[19].text = config.shape
				new_bezier_conf2[11].value = config.rand_s_color1
				new_bezier_conf2[21].value = config.rand_s_color3
				new_bezier_conf2[22].value = config.rand_e_color1
				new_bezier_conf2[23].value = config.rand_e_color3
				new_bezier_conf2[20].value = config.thickness
				new_bezier_conf2[26].value = config.glitter
			end
		end
		if cfg_res then
			new_bezier_preprosses_macro(subtitles, config, selected_lines)
			aegisub.set_undo_point("particle fake")
			aegisub.progress.task("Finished!") 
		else   
			aegisub.progress.task("Cancelled")
		end
	else
		aegisub.progress.task("Cancelled")
	end
end


aegisub.register_macro("new Bezier Move", "",new_bezier_macro)

