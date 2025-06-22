include("karaskel.lua")

script_name = "Moves Shape 12"
script_description = "Moves Shape 12"
script_author = "KaraLaura"
script_version = "1.0"

function generator_lua(subs, config, index)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)

	aegisub.progress.task("Applying effect...")
	local maxi = #index
	for _, i in ipairs(index) do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", i, maxi))
		aegisub.progress.set((i-1)/maxi*100)
		local l = subs[i]
		karaskel.preproc_line(subs, meta, styles, l)
		do_fx(subs, meta, l, config)
		maxi = maxi - 1
		l.comment = true
		subs[i] = l
	end
	aegisub.progress.task("Finished")
	aegisub.progress.set(100)
end

function do_fx(subs, meta, line, config)
	for i = 1, line.kara.n do
		local syl = line.kara[i]
		local x = syl.center + line.left
		local y = line.middle
		
		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%s,%s)\\1vc(&HFFFFFF&,&HFFFFFF&,&H49A2DA&,&H49A2DA&)\\shad0\\fad(100,0)}%s",x,y,syl.text_stripped)
		l.start_time = line.start_time + 50*(syl.i-line.kara.n)
		l.end_time = line.start_time + syl.start_time
		l.layer = 1
		subs.append(l)
		
		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%s,%s)\\shad0\\t(0,60,\\fscx120\\fscy120\\3c&HFFFFFF&\\blur3)\\t(60,%d,\\fscx100\\fscy100\\3c&HE1C192&\\1a&HFF&\\blur0\\shad2\\4c&H124463&)}%s",x,y,syl.duration,syl.text_stripped)
		l.start_time = line.start_time + syl.start_time
		l.end_time = l.start_time + syl.duration
		l.layer = 2
		subs.append(l)

		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%s,%s)\\shad2\\4c&H124463&\\fscx100\\fscy100\\3c&HE1C192&\\1a&HFF&\\fad(0,300)}%s",x,y,syl.text_stripped)
		l.start_time = line.start_time + syl.end_time
		l.end_time = line.end_time + 80*(syl.i-line.kara.n)
		l.layer = 1
		subs.append(l)
		
		if syl.i == 1 then
			shape = "m 0 0 l 0 100 l 100 100 l 100 0 l 0 0"
			vertical_loop = 4
			size_shape = syl.height/vertical_loop
			loop_height = vertical_loop + 1
			loop_width = math.ceil(line.width/(2*size_shape)) + 1
			n = loop_height*loop_width
				
				for j = 1, n do
				x_pos = syl.center + line.left - syl.width/2 + size_shape*(1 + (-1)^(loop_height - loop_height*math.ceil(j/loop_height) + j - 1))/2 - size_shape
				y_pos = y - syl.height/2
				x_pos_relative = x_pos + (math.ceil(j/loop_height) - 1)*size_shape*2
				y_pos_relative = y_pos + (loop_height - loop_height*math.ceil(j/loop_height) + j - 1)*size_shape
				x_pos_relative_i = x_pos_relative + math.random(4*syl.height,5*syl.height)
				y_pos_relative_i = y_pos_relative + math.random(-2*syl.height,2*syl.height)
				delay = 50*(line.kara.n + 6)
				delay_f = 800 + 16*j
				color_a = _G.ass_color(_G.HSV_to_RGB(config.hue,math.random(50,100)/100,math.random(20,100)/100))
				color_b = _G.ass_color(_G.HSV_to_RGB(config.hue,math.random(50,100)/100,math.random(20,100)/100))
				color_c = _G.ass_color(_G.HSV_to_RGB(config.hue,math.random(50,100)/100,math.random(20,100)/100))
				color_d = _G.ass_color(_G.HSV_to_RGB(config.hue,math.random(50,100)/100,math.random(20,100)/100))
				
				l = table.copy(line)
				l.text = string.format("{\\an5\\move(%s,%s,%s,%s,0,400)\\1vc(%s,%s,%s,%s)\\alpha&H33&\\shad0\\bord0\\fscx%s\\fscy%s\\frx%s\\fry%s\\frz%s\\t(0,400,\\frx0\\fry0\\frz0)\\fad(200,0)\\p1}%s",x_pos_relative_i,y_pos_relative_i,x_pos_relative,y_pos_relative,color_a,color_b,color_c,color_d,2*size_shape,size_shape,math.random(-360,360),math.random(-360,360),math.random(-360,360),shape)
				l.start_time = line.start_time - delay*(1 - (j-1)/(n-1))
				l.end_time = line.end_time - delay*(1 - (j-1)/(n-1))
				l.layer = 0
				subs.append(l)
				
				--[[l = table.copy(line)
				l.text = string.format("{\\an5\\move(%s,%s,%s,%s,450,%s)\\1vc(%s,%s,%s,%s)\\alpha&H33&\\shad0\\bord0\\fscx%s\\fscy%s\\frx0\\fry0\\frz0\\t(400,%s,\\frx%s\\fry%s\\frz%s)\\fad(0,300)\\p1}%s",x_pos_relative,y_pos_relative,x_pos_relative + math.random(-syl.height/2,syl.height/2),y_pos_relative - math.random(1.5*syl.height,3*syl.height),delay_f,color_a,color_b,color_c,color_d,2*size_shape,size_shape,delay_f,math.random(60,720)*(-1)^math.random(2),math.random(60,720)*(-1)^math.random(2),math.random(60,720)*(-1)^math.random(2),shape)
				l.start_time = line.start_time - delay*(1 - (j-1)/(n-1)) + 400
				l.end_time = l.start_time + delay_f
				l.layer = 0
				subs.append(l)]]
				end
		end
			
	end
end

--[[esta es la configuración de la macro que permitirá elegir a qué estilo queremos aplicar el efecto
	es ideal para cuando el script tiene más de un estilo y solo queramos aplicarlo a uno de ellos.
	Con esta nueva modificación de la Macro, ahora se puede decidir el color de la Shape en el momento de ejecutar el script.]]

Moves_Shape_12_conf = {
	[1] = { name = "applyto"; class = "dropdown"; x = 5; y = 0; height = 2; width = 4; items = { }; value = "" },
	[2] = { class = "label"; x = 0; y = 0; height = 1; width = 4; label = "Apply to" },
	[3] = { name = "hue"; class = "intedit"; x = 6; y = 2; height = 2; width = 2; min = 0; max = 360; value =  20 },
	[4] = { class = "label"; x = 0; y = 2; height = 1; width = 1; label = "Hue(0 to 360)"}
}

function Moves_Shape_12_preprosses_macro(subtitles, config, selected_lines)
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
	generator_lua(subtitles, config, subs)
end

function Moves_Shape_12_prepareconfig(styles, subtitles, has_selected_lines)
	Moves_Shape_12_conf[1].items = {}
	local astyles = {}
	for i = 1, #subtitles do
		if subtitles[i].class == "dialogue" and subtitles[i].effect ~= "FX" and
			not subtitles[i].comment then
			if subtitles[i].style ~= "" and not astyles[subtitles[i].style] then 
				astyles[subtitles[i].style] = true
				applytostyle = subtitles[i].style
				table.insert(Moves_Shape_12_conf[1].items, applytostyle)
			end
		end 
	end
	if  #Moves_Shape_12_conf[1].items > 0 then 
		Moves_Shape_12_conf[1].value = "SelectAll"
		table.insert(Moves_Shape_12_conf[1].items, Moves_Shape_12_conf[1].value) 
	end
	if has_selected_lines and #Moves_Shape_12_conf[1].items > 0 then 
		table.insert(Moves_Shape_12_conf[1].items,"Selected lines")
	end
end

function Moves_Shape_12_macro(subtitles, selected_lines, active_line)
	local meta, styles = karaskel.collect_head(subtitles)
	Moves_Shape_12_prepareconfig(styles, subtitles, #selected_lines > 0)
	local cfg_res, config = aegisub.dialog.display(Moves_Shape_12_conf)
	if cfg_res then
		Moves_Shape_12_preprosses_macro(subtitles, config, selected_lines)
		aegisub.set_undo_point("Moves_Shape_12")
		aegisub.progress.task("Finished") 
	else
		aegisub.progress.task("Cancelled");	
	end
end

aegisub.register_macro("Moves_Shape_12", "", Moves_Shape_12_macro)