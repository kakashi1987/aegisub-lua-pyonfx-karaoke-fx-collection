include("karaskel.lua")

script_name = "Moves Shape 13"
script_description = "Moves Shape 13"
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
		local lateral_margin = 40
		local x_i = lateral_margin + syl.left
		local y_i = line.middle
		local x_f = x_i - line.width - lateral_margin
		local y_f = y_i
		
		l = table.copy(line)
		l.text = string.format("{\\an4\\move(%s,%s,%s,%s,0,200)\\shad0\\1c&HFFFFFF&\\3c&HFFFFFF&\\bord5\\blur3\\t(0,400,\\1c%s\\3c%s\\bord%s\\blur0)}%s",x_f,y_f,x_i,y_i,line.styleref.color1,line.styleref.color3,line.styleref.outline,syl.text_stripped)
		l.start_time = line.start_time - 400
		l.end_time = line.start_time + syl.start_time
		l.layer = 1
		subs.append(l)
		
		l = table.copy(line)
		l.text = string.format("{\\an4\\pos(%s,%s)\\shad0\\org(-10000,%s)\\t(0,100,\\fr0.04\\1c&HFFFFFF&\\3c&HFFFFFF&\\bord3\\blur3)\\t(100,%s,\\fr0\\1a&HFF&\\bord%s\\blur0)}%s",x_i,y_i,line.middle,syl.duration,line.styleref.outline,syl.text_stripped)
		l.start_time = line.start_time + syl.start_time
		l.end_time = l.start_time + syl.duration
		l.layer = 2
		subs.append(l)
		
		l = table.copy(line)
		l.text = string.format("{\\an4\\pos(%s,%s)\\shad0\\3c&HFFFFFF&\\1a&HFF&}%s",x_i,y_i,syl.text_stripped)
		l.start_time = line.start_time + syl.end_time
		l.end_time = line.end_time
		l.layer = 1
		subs.append(l)
		
		l = table.copy(line)
		l.text = string.format("{\\an4\\move(%s,%s,%s,%s)\\shad0\\3c&HFFFFFF&\\1a&HFF&\\t(\\blur10\\alpha&HFF&)}%s",x_i,y_i,x_i,y_i + 3*syl.height,syl.text_stripped)
		l.start_time = line.end_time
		l.end_time = l.start_time + 300
		l.layer = 1
		subs.append(l)
		
		if syl.i == 1 then
			curve = math.ceil(syl.height*(2/5))
			b_curve = math.ceil(curve/3)
			margin_offset = -b_curve
			curve_i = curve + 2*margin_offset + syl.height
			curve_base = curve_i + curve
			curve_f = curve + 2*margin_offset + line.width
			curve_lade = curve_f + curve
			arrow = math.ceil(line.width/4)*(1 + (1 + (-1)^33))
			size_arrow = 20
			arrow_o = arrow + size_arrow*(1 + (-1)^(33 + 1))/2
			shape = string.format("m %d 0 b %d 0 0 %d 0 %d l 0 %d b 0 %d %d %d %d %d l %d %d l %d %d l %d %d l %d %d b %d %d %d %d %d %d l %d %d b %d %d %d %d %d %d" ,curve,b_curve,b_curve,curve,curve_i,curve_base - b_curve,b_curve,curve_base,curve,curve_base,arrow,curve_base,arrow_o,curve_base + size_arrow,arrow + size_arrow,curve_base,curve_f,curve_base,curve_f + curve - b_curve,curve_base,curve_lade,curve_base - b_curve,curve_lade,curve_base - curve,curve_lade,curve,curve_lade,b_curve,curve_lade - b_curve,0,curve_lade - curve,0)
			x_pos_f = lateral_margin - curve + b_curve
			y_pos_f = y_i + size_arrow/2
			x_pos_i = -curve_lade - lateral_margin + 2*curve + b_curve
			y_pos_i = y_pos_f
			
			l = table.copy(line)
			l.text = string.format("{\\an4\\move(%s,%s,%s,%s,0,200)\\shad0\\bord2\\3c&HFFFFFF&\\1c&HFFFFFF&\\1a&HEF&\\p1}%s",x_pos_i,y_pos_i,x_pos_f,y_pos_f,shape)
			l.start_time = line.start_time - 400
			l.end_time = line.start_time
			l.layer = 0
			subs.append(l)
			
			l = table.copy(line)
			l.text = string.format("{\\an4\\pos(%s,%s)\\shad0\\bord2\\3c&HFFFFFF&\\1c&HFFFFFF&\\1a&HDD&\\p1}%s",x_pos_f,y_pos_f,shape)
			l.start_time = line.start_time
			l.end_time = l.end_time
			l.layer = 0
			subs.append(l)
			
			l = table.copy(line)
			l.text = string.format("{\\an4\\move(%s,%s,%s,%s)\\shad0\\bord2\\3c&HFFFFFF&\\1c&HFFFFFF&\\1a&HDD&\\t(\\blur10\\1a&HFF&\\3a&HFF&)\\p1}%s",x_pos_f,y_pos_f,x_pos_f,y_pos_f + 3*syl.height,shape)
			l.start_time = line.end_time
			l.end_time = l.start_time + 300
			l.layer = 0
			subs.append(l)
		end	
	end
end

--[[esta es la configuración de la macro que permitirá elegir a qué estilo queremos aplicar el efecto
	es ideal para cuando el script tiene más de un estilo y solo queramos aplicarlo a uno de ellos.]]

Moves_Shape_13_conf = {
	[1] = { name = "applyto"; class = "dropdown"; x = 5; y = 0; height = 2; width = 4; items = { }; value = "" },
	[2] = { class = "label"; x = 0; y = 0; height = 1; width = 4; label = "Apply to" },
	}

function Moves_Shape_13_preprosses_macro(subtitles, config, selected_lines)
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

function Moves_Shape_13_prepareconfig(styles, subtitles, has_selected_lines)
	Moves_Shape_13_conf[1].items = {}
	local astyles = {}
	for i = 1, #subtitles do
		if subtitles[i].class == "dialogue" and subtitles[i].effect ~= "FX" and
			not subtitles[i].comment then
			if subtitles[i].style ~= "" and not astyles[subtitles[i].style] then 
				astyles[subtitles[i].style] = true
				applytostyle = subtitles[i].style
				table.insert(Moves_Shape_13_conf[1].items, applytostyle)
			end
		end 
	end
	if  #Moves_Shape_13_conf[1].items > 0 then 
		Moves_Shape_13_conf[1].value = "SelectAll"
		table.insert(Moves_Shape_13_conf[1].items, Moves_Shape_13_conf[1].value) 
	end
	if has_selected_lines and #Moves_Shape_13_conf[1].items > 0 then 
		table.insert(Moves_Shape_13_conf[1].items,"Selected lines")
	end
end

function Moves_Shape_13_macro(subtitles, selected_lines, active_line)
	local meta, styles = karaskel.collect_head(subtitles)
	Moves_Shape_13_prepareconfig(styles, subtitles, #selected_lines > 0)
	local cfg_res, config = aegisub.dialog.display(Moves_Shape_13_conf)
	if cfg_res then
		Moves_Shape_13_preprosses_macro(subtitles, config, selected_lines)
		aegisub.set_undo_point("Moves_Shape_13")
		aegisub.progress.task("Finished") 
	else
		aegisub.progress.task("Cancelled");	
	end
end

aegisub.register_macro("Moves_Shape_13", "", Moves_Shape_13_macro)