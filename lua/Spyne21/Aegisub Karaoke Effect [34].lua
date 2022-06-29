include("karaskel.lua")

script_name = "Aegisub Karaoke Effect [34]"
script_author = "Spyne21"
script_version = "1.0"

--Function fx33--
function fx33(subs, config, index)
	aegisub.progress.task("Getting header data...")
	local meta, styles  = karaskel.collect_head(subs)
	aegisub.progress.task("Applying effect...")
	local maxi = #index
	for ai, i in ipairs(index) do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxi))
		aegisub.progress.set((ai-1)/maxi*100)
		local l = subs[i]
		karaskel.preproc_line(subs, meta, styles, l)
		do_fx(subs, meta, l, config)
		l.comment = true
		subs[i] = l
	end
end

--Function do_fx--
function do_fx(subs, meta, line, config)
	for i = 1, line.kara.n do		--text lead-in
		local syl = line.kara[i]
		if syl.duration > 0 then
			local l = table.copy(line)
			if config.color_rand_start == true then config.primary_color_start = ass_color(math.random(255),math.random(255),math.random(255)) end
			if config.color_outline_rand_start == true then config.outline_color_start = ass_color(math.random(255),math.random(255),math.random(255)) end
			if config.color_shadow_rand_start == true then config.shadow_color_start = ass_color(math.random(255),math.random(255),math.random(255)) end
			l.start_time = line.start_time -500 + i * 60
			l.end_time = line.start_time + syl.start_time
			if(config.lead_in_out=="fad(300,0)/fad(0,300)") then
				l.text=string.format("{\\an5\\1c%s\\3c%s\\4c%s\\1a%s\\3a%s\\4a%s\\bord%0.3f\\shad%0.3f\\blur%0.3f\\pos(%d,%d)\\fad(300,0)}%s",config.primary_color_start, config.outline_color_start, config.shadow_color_start, config.primary_alpha_start, config.outline_alpha_start, config.shadow_alpha_start, config.outline_start, config.shadow_start,config.blur_start,line.left+syl.center,line.middle,syl.text_stripped)
			else
				l.text=string.format("{\\an5\\1c%s\\3c%s\\4c%s\\1a%s\\3a%s\\4a%s\\bord%0.3f\\shad%0.3f\\blur%0.3f\\org(%d,%d)\\pos(%d,%d)\\fry90\\t(0,500,\\fry0)}%s",config.primary_color_start, config.outline_color_start, config.shadow_color_start, config.primary_alpha_start, config.outline_alpha_start, config.shadow_alpha_start, config.outline_start, config.shadow_start,config.blur_start,line.left+syl.center,line.middle,line.left+syl.center,line.middle,syl.text_stripped)
			end
			l.layer=1
			subs.append(l)
		end
	end
	
	for i = 1, line.kara.n do		--text lead-out
		local syl = line.kara[i]
		if syl.duration > 0 then
			local l = table.copy(line)
			if config.color_rand_end == true then config.primary_color_end = ass_color(math.random(255),math.random(255),math.random(255)) end
			if config.color_outline_rand_end == true then config.outline_color_end = ass_color(math.random(255),math.random(255),math.random(255)) end
			if config.color_shadow_rand_end == true then config.shadow_color_end = ass_color(math.random(255),math.random(255),math.random(255)) end
			l.start_time = line.start_time + syl.end_time
			l.end_time=line.end_time -500 + i * 60
			l_dur = l.end_time - l.start_time 
			if(config.lead_in_out=="fad(300,0)/fad(0,300)") then
				l.text=string.format("{\\an5\\1c%s\\3c%s\\4c%s\\1a%s\\3a%s\\4a%s\\bord%0.3f\\shad%0.3f\\blur%0.3f\\pos(%d,%d)\\fad(0,300)}%s",config.primary_color_end, config.outline_color_end, config.shadow_color_end, config.primary_alpha_end, config.outline_alpha_end, config.shadow_alpha_end, config.outline_end, config.shadow_end,config.blur_end,line.left+syl.center,line.middle,syl.text_stripped)
			else
				l.text=string.format("{\\an5\\1c%s\\3c%s\\4c%s\\1a%s\\3a%s\\4a%s\\bord%0.3f\\shad%0.3f\\blur%0.3f\\org(%d,%d)\\pos(%d,%d)\\t(%d,%d,\\fry-90)}%s",config.primary_color_end, config.outline_color_end, config.shadow_color_end, config.primary_alpha_end, config.outline_alpha_end, config.shadow_alpha_end, config.outline_end, config.shadow_end,config.blur_end,line.left+syl.center,line.middle,line.left+syl.center,line.middle,l_dur-500,l_dur,syl.text_stripped)
			end
			l.layer=1
			subs.append(l)
		end
	end
	
	if (config.effect=="Syl") then
		for i = 1, line.kara.n do		--text hilight "Syl"
			local syl = line.kara[i]
			if syl.duration > 0 then
				local l = table.copy(line)
				if config.color_rand_start == true then config.primary_color_start = ass_color(math.random(255),math.random(255),math.random(255)) end
				if config.color_rand_end == true then config.primary_color_end = ass_color(math.random(255),math.random(255),math.random(255)) end
				if config.color_rand_middle == true then config.primary_color_middle = ass_color(math.random(255),math.random(255),math.random(255)) end
				if config.color_outline_rand_start == true then config.outline_color_start = ass_color(math.random(255),math.random(255),math.random(255)) end
				if config.color_outline_rand_middle == true then config.outline_color_middle = ass_color(math.random(255),math.random(255),math.random(255)) end
				if config.color_outline_rand_end == true then config.outline_color_end = ass_color(math.random(255),math.random(255),math.random(255)) end
				if config.color_shadow_rand_start == true then config.shadow_color_start = ass_color(math.random(255),math.random(255),math.random(255)) end
				if config.color_shadow_rand_middle == true then config.shadow_color_middle = ass_color(math.random(255),math.random(255),math.random(255)) end
				if config.color_shadow_rand_end == true then config.shadow_color_end = ass_color(math.random(255),math.random(255),math.random(255)) end
				l.start_time = line.start_time + syl.start_time
				l.end_time = l.start_time + syl.duration
				l_dur = l.end_time - l.start_time
				if(l.start_time + syl.duration>line.end_time -500 + i * 60 and config.lead_in_out=="fad(300,0)/fad(0,300)") then
					fad="\\fad(0,300)"
				elseif(l.start_time + syl.duration>line.end_time -500 + i * 60 and config.lead_in_out=="fry90/fry-90") then
					t0=l.end_time - l.start_time-500
					t1=l.end_time - l.start_time
					fad=string.format("\\t(%d,%d,\\fry-90)",t0,t1)
				else
					fad=""
				end
				l.text=string.format("{\\an5\\1c%s\\3c%s\\4c%s\\1a%s\\3a%s\\4a%s\\bord%0.3f\\shad%0.3f\\blur%0.3f\\org(%d,%d)\\pos(%d,%d)\\fry0\\t(0,%f,\\fscx120\\fscy120\\1c%s\\3c%s\\4c%s\\1a%s\\3a%s\\4a%s\\bord%0.3f\\shad%0.3f\\blur%0.3f)\\t(%f,%f,\\1c%s\\3c%s\\4c%s\\1a%s\\3a%s\\4a%s\\bord%0.3f\\shad%0.3f\\blur%0.3f\\fscx100\\fscy100)%s}%s",config.primary_color_start, config.outline_color_start, config.shadow_color_start, config.primary_alpha_start, config.outline_alpha_start, config.shadow_alpha_start, config.outline_start, config.shadow_start,config.blur_start,line.left+syl.center,line.middle,line.left+syl.center,line.middle,syl.duration/2,config.primary_color_middle, config.outline_color_middle, config.shadow_color_middle, config.primary_alpha_middle, config.outline_alpha_middle, config.shadow_alpha_middle, config.outline_middle, config.shadow_middle,config.blur_middle,syl.duration/2,syl.duration,config.primary_color_end, config.outline_color_end, config.shadow_color_end, config.primary_alpha_end, config.outline_alpha_end, config.shadow_alpha_end, config.outline_end, config.shadow_end,config.blur_end,fad,syl.text_stripped)
				l.layer=1
				subs.append(l)
			end
		end
	else
		for i = 1, line.kara.n do		--text hilight "Char"
			local syl = line.kara[i] 	
			local charx = table.copy(syl)	
			local pos_x = 0
			for c in unicode.chars(syl.text_stripped) do 
				charx.text = c
				if syl.duration > 0 then
					local l = table.copy(line)
					if config.color_rand_start == true then config.primary_color_start = ass_color(math.random(255),math.random(255),math.random(255)) end
					if config.color_rand_end == true then config.primary_color_end = ass_color(math.random(255),math.random(255),math.random(255)) end
					if config.color_rand_middle == true then config.primary_color_middle = ass_color(math.random(255),math.random(255),math.random(255)) end
					if config.color_outline_rand_start == true then config.outline_color_start = ass_color(math.random(255),math.random(255),math.random(255)) end
					if config.color_outline_rand_middle == true then config.outline_color_middle = ass_color(math.random(255),math.random(255),math.random(255)) end
					if config.color_outline_rand_end == true then config.outline_color_end = ass_color(math.random(255),math.random(255),math.random(255)) end
					if config.color_shadow_rand_start == true then config.shadow_color_start = ass_color(math.random(255),math.random(255),math.random(255)) end
					if config.color_shadow_rand_middle == true then config.shadow_color_middle = ass_color(math.random(255),math.random(255),math.random(255)) end
					if config.color_shadow_rand_end == true then config.shadow_color_end = ass_color(math.random(255),math.random(255),math.random(255)) end
					x_width = aegisub.text_extents(line.styleref, charx.text)
					l.start_time = line.start_time + syl.start_time
					l.end_time = l.start_time + syl.duration
					l.text=string.format("{\\an5\\1c%s\\3c%s\\4c%s\\1a%s\\3a%s\\4a%s\\bord%0.3f\\shad%0.3f\\blur%0.3f\\pos(%d,%d)\\t(0,%f,\\fscx120\\fscy120\\1c%s\\3c%s\\4c%s\\1a%s\\3a%s\\4a%s\\bord%0.3f\\shad%0.3f\\blur%0.3f)\\t(%f,%f,\\1c%s\\3c%s\\4c%s\\1a%s\\3a%s\\4a%s\\bord%0.3f\\shad%0.3f\\blur%0.3f\\fscx100\\fscy100\\)}%s",config.primary_color_start, config.outline_color_start, config.shadow_color_start, config.primary_alpha_start, config.outline_alpha_start, config.shadow_alpha_start, config.outline_start, config.shadow_start,config.blur_start,line.left+syl.left+x_width/2+pos_x,line.middle,syl.duration/2,config.primary_color_middle, config.outline_color_middle, config.shadow_color_middle, config.primary_alpha_middle, config.outline_alpha_middle, config.shadow_alpha_middle, config.outline_middle, config.shadow_middle,config.blur_middle,syl.duration/2,syl.duration,config.primary_color_end, config.outline_color_end, config.shadow_color_end, config.primary_alpha_end, config.outline_alpha_end, config.shadow_alpha_end, config.outline_end, config.shadow_end,config.blur_end,charx.text)
					l.layer=1
					subs.append(l)
					pos_x=pos_x+x_width
				end
			end
		end
	end
end

--Configuration table--
aegisub_karaoke_conf = {
	[1] = { class = "label"; x = 0; y = 0; height = 1; width = 1; label = "Apply To : " }
	,
	[2] = { name = "applyto"; class = "dropdown"; x = 1; y = 0; height = 1; width = 3; items = { }; value = "" }
	,
	[3] = { class = "label"; x = 0; y = 1; height = 1; width = 1; label = "Lead-In/Out Effect Type : " }
	,
	[4] = { name = "lead_in_out"; class = "dropdown"; x = 1; y = 1; height = 1; width = 3; items = {"fad(300,0)/fad(0,300)","fry90/fry-90"}; value = "" }
	,
	[5] = { class = "label"; x = 0; y = 2; height = 1; width = 1; label = "Syl Effect Type : " }
	,
	[6] = { name = "effect"; class = "dropdown"; x = 1; y = 2; height = 1; width = 3; items = {"Syl","Char"}; value = "" }
	,
	[7] = { class = "label"; x = 0; y = 5; height = 1; width = 1; label = "Text Color Start" }
	,
	[8] = { class = "label"; x = 1; y = 4; height = 1; width = 1; label = "Primary"}
	,
	[9] = { name = "primary_color_start"; class = "color"; x = 1; y = 5; height = 2; width = 1; value =  "#FFFFFF" }
	,
	[10] = { class = "label"; x = 2; y = 4; height = 1; width = 1; label = "Outline"}
	,
	[11] = { name = "outline_color_start"; class = "color"; x = 2; y = 5; height = 2; width = 1; value = "#000000" }
	,
	[12] = { class = "label"; x = 3; y = 4; height = 1; width = 1; label = "Shadow"}
	,
	[13] = { name = "shadow_color_start"; class = "color"; x = 3; y = 5; height = 2; width = 1; value = "#000000" }
	,
	[14] = { class = "label"; x = 0; y = 7; height = 1; width = 1; label = "Text Alpha Start" }
	,
	[15] = { name = "primary_alpha_start"; class = "alpha"; x = 1; y = 7; height = 1; width = 1; value =  "#00" }
	,
	[16] = { name = "outline_alpha_start"; class = "alpha"; x = 2; y = 7; height = 1; width = 1; value = "#00" }
	,
	[17] = { name = "shadow_alpha_start"; class = "alpha"; x = 3; y = 7; height = 1; width = 1; value = "#00" }	
	,
	[18] = { class = "label"; x = 0; y = 17; height = 1; width = 1; label = "Text Color End" }
	,
	[19] = { class = "label"; x = 1; y = 16; height = 1; width = 1; label = "Primary"}
	,
	[20] = { name = "primary_color_end"; class = "color"; x = 1; y = 17; height = 2; width = 1; value =  "#FFFFFF" }
	,
	[21] = { class = "label"; x = 2; y = 16; height = 1; width = 1; label = "Outline"}
	,
	[22] = { name = "outline_color_end"; class = "color"; x = 2; y = 17; height = 2; width = 1; value = "#000000" }
	,
	[23] = { class = "label"; x = 3; y = 16; height = 1; width = 1; label = "Shadow"}
	,
	[24] = { name = "shadow_color_end"; class = "color"; x = 3; y = 17; height = 2; width = 1; value = "#000000" }
	,
	[25] = { class = "label"; x = 0; y = 19; height = 1; width = 1; label = "Text Alpha End" }
	,
	[26] = { name = "primary_alpha_end"; class = "alpha"; x = 1; y = 19; height = 1; width = 1; value =  "#00" }
	,
	[27] = { name = "outline_alpha_end"; class = "alpha"; x = 2; y = 19; height = 1; width = 1; value = "#00" }
	,
	[28] = { name = "shadow_alpha_end"; class = "alpha"; x = 3; y = 19; height = 1; width = 1; value = "#00" }	
	,
	[29] = { class = "label"; x = 0; y = 9; height = 1; width = 1; label = "Outline Start" }
	,
	[30] = { class = "label"; x = 1; y = 8; height = 1; width = 1; label = "Outline" }
	,
	[31] = { name = "outline_start"; class = "floatedit" ; x = 1; y = 9; height = 1; width = 1; min = 0; value = 2 }
	,
	[32] = { class = "label"; x = 2; y = 8; height = 1; width = 1; label = "Shadow" }
	,
	[33] = { name = "shadow_start"; class = "floatedit" ; x = 2; y = 9; height = 1; width = 1; min = 0; value = 0 }
	,
	[34] = { class = "label"; x = 3; y = 8; height = 1; width = 1; label = "Blur" }
	,
	[35] = { name = "blur_start" ; class = "floatedit" ; x = 3; y = 9; height = 1; width = 1; min = 0; value = 0}
	,
	[36] = { class = "label"; x = 0; y = 21; height = 1; width = 1; label = "Outline End" }
	,
	[37] = { class = "label"; x = 1; y = 20; height = 1; width = 1; label = "Outline" }
	,
	[38] = { name = "outline_end"; class = "floatedit" ; x = 1; y = 21; height = 1; width = 1; min = 0; value = 2 }
	,
	[39] = { class = "label"; x = 2; y = 20; height = 1; width = 1; label = "Shadow" }
	,
	[40] = { name = "shadow_end"; class = "floatedit" ; x = 2; y = 21; height = 1; width = 1; min = 0; value = 0 }
	,
	[41] = { class = "label"; x = 3; y = 20; height = 1; width = 1; label = "Blur" }
	,
	[42] = { name = "blur_end" ; class = "floatedit" ; x = 3; y = 21; height = 1; width = 1; min = 0; value = 0}
	,
	[43] = { class = "label"; x = 0; y = 3; height = 1; width = 4; label = "Text Setting :" }
	,
	[44] = { class = "label"; x = 0; y = 11; height = 1; width = 1; label = "Text Color Middle" }
	,
	[45] = { class = "label"; x = 1; y = 10; height = 1; width = 1; label = "Primary"}
	,
	[46] = { name = "primary_color_middle"; class = "color"; x = 1; y = 11; height = 2; width = 1; value =  "#FFFFFF" }
	,
	[47] = { class = "label"; x = 2; y = 10; height = 1; width = 1; label = "Outline"}
	,
	[48] = { name = "outline_color_middle"; class = "color"; x = 2; y = 11; height = 2; width = 1; value = "#000000" }
	,
	[49] = { class = "label"; x = 3; y = 10; height = 1; width = 1; label = "Shadow"}
	,
	[50] = { name = "shadow_color_middle"; class = "color"; x = 3; y = 11; height = 2; width = 1; value = "#000000" }
	,
	[51] = { class = "label"; x = 0; y = 13; height = 1; width = 1; label = "Text Alpha Middle" }
	,
	[52] = { name = "primary_alpha_middle"; class = "alpha"; x = 1; y = 13; height = 1; width = 1; value =  "#00" }
	,
	[53] = { name = "outline_alpha_middle"; class = "alpha"; x = 2; y = 13; height = 1; width = 1; value = "#00" }
	,
	[54] = { name = "shadow_alpha_middle"; class = "alpha"; x = 3; y = 13; height = 1; width = 1; value = "#00" }	
	,
	[55] = { class = "label"; x = 0; y = 15; height = 1; width = 1; label = "Outline Middle" }
	,
	[56] = { class = "label"; x = 1; y = 14; height = 1; width = 1; label = "Outline" }
	,
	[57] = { name = "outline_middle"; class = "floatedit" ; x = 1; y = 15; height = 1; width = 1; min = 0; value = 2 }
	,
	[58] = { class = "label"; x = 2; y = 14; height = 1; width = 1; label = "Shadow" }
	,
	[59] = { name = "shadow_middle"; class = "floatedit" ; x = 2; y = 15; height = 1; width = 1; min = 0; value = 0 }
	,
	[60] = { class = "label"; x = 3; y = 14; height = 1; width = 1; label = "Blur" }
	,
	[61] = { name = "blur_middle" ; class = "floatedit" ; x = 3; y = 15; height = 1; width = 1; min = 0; value = 0}
	,
	[62] = { class = "label"; x = 0; y = 22; height = 1; width = 1; label = "Color Primary Random : " }
	,
	[63] = { name = "color_rand_start" ; class = "checkbox" ; x = 1; y = 22; height = 1; width = 1; label = "Color Start"; value = false}
	,
	[64] = { name = "color_rand_middle" ; class = "checkbox" ; x = 2; y = 22; height = 1; width = 1; label = "Color Middle"; value = false}
	,
	[65] = { name = "color_rand_end" ; class = "checkbox" ; x = 3; y = 22; height = 1; width = 1; label = "Color End"; value = false}
	,
	[66] = { class = "label"; x = 0; y = 23; height = 1; width = 1; label = "Color Outline Random : " }
	,	
	[67] = { name = "color_outline_rand_start" ; class = "checkbox" ; x = 1; y = 23; height = 1; width = 1; label = "Color Outline Start"; value = false}
	,
	[68] = { name = "color_outline_rand_middle" ; class = "checkbox" ; x = 2; y = 23; height = 1; width = 1; label = "Color Outline Middle"; value = false}
	,
	[69] = { name = "color_outline_rand_end" ; class = "checkbox" ; x = 3; y = 23; height = 1; width = 1; label = "Color Outline End"; value = false}
	,
	[70] = { class = "label"; x = 0; y = 24; height = 1; width = 1; label = "Color Shadow Random : " }
	,	
	[71] = { name = "color_shadow_rand_start" ; class = "checkbox" ; x = 1; y = 24; height = 1; width = 1; label = "Color Shadow Start"; value = false}
	,
	[72] = { name = "color_shadow_rand_middle" ; class = "checkbox" ; x = 2; y = 24; height = 1; width = 1; label = "Color Shadow Middle"; value = false}
	,
	[73] = { name = "color_shadow_rand_end" ; class = "checkbox" ; x = 3; y = 24; height = 1; width = 1; label = "Color Shadow End"; value = false}
} 
aegisub_karaoke_conf_key = {2,4,6,9,11,13,15,16,17,20,22,24,26,27,28,31,33,35,38,40,42,46,48,50,52,53,54,57,59,61,63,64,65,67,68,69,71,73}

--Functions for effect--
function asscolor(htmlcolor)
	local r, g, b = string.match(htmlcolor, "(%x%x)(%x%x)(%x%x)")
	return ass_color(tonumber(r,16), tonumber(g,16), tonumber(b,16))
end

function assalpha(htmlalpha)
	local a = string.match(htmlalpha, "(%x%x)")
	return ass_alpha(tonumber(a,16))
end

--Functions for macro--
function aegisub_karaoke_preprosses_macro(subtitles, config, selected_lines)
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
	if(config.effect~="" and config.lead_in_out~="") then
		fx33(subtitles, config, subs)
	end
end

function aegisub_karaoke_prepareconfig(styles, subtitles, has_selected_lines)
	aegisub_karaoke_conf[2].items = {}
	local astyles = {}
	for i = 1, #subtitles do
		if subtitles[i].class == "dialogue" and subtitles[i].effect ~= "FX" and
			not subtitles[i].comment then
			if subtitles[i].style ~= "" and not astyles[subtitles[i].style] then 
				astyles[subtitles[i].style] = true
				applytostyle = subtitles[i].style
				table.insert(aegisub_karaoke_conf[2].items, applytostyle)
			end
		end 
	end
	if  #aegisub_karaoke_conf[2].items > 0 then 
		table.insert(aegisub_karaoke_conf[2].items, "SelectAll") 
	end
	if has_selected_lines and #aegisub_karaoke_conf[2].items > 0 then 
		table.insert(aegisub_karaoke_conf[2].items,"Selected lines")
	end
	
end

function aegisub_karaoke_macro(subtitles, selected_lines, active_line)
	local meta, styles = karaskel.collect_head(subtitles)
	local cfg_res, config
	aegisub_karaoke_prepareconfig(styles, subtitles, #selected_lines > 0)
	cfg_res, config = aegisub.dialog.display(aegisub_karaoke_conf,{"OK","Cancel"})	
	if cfg_res == "OK" then		
		config.primary_color_start = asscolor(config.primary_color_start)
		config.outline_color_start = asscolor(config.outline_color_start)
		config.shadow_color_start = asscolor(config.shadow_color_start)
		config.primary_alpha_start = assalpha(config.primary_alpha_start)
		config.outline_alpha_start = assalpha(config.outline_alpha_start)
		config.shadow_alpha_start = assalpha(config.shadow_alpha_start)
		config.primary_color_end = asscolor(config.primary_color_end)
		config.outline_color_end = asscolor(config.outline_color_end)
		config.shadow_color_end = asscolor(config.shadow_color_end)
		config.primary_alpha_end = assalpha(config.primary_alpha_end)
		config.outline_alpha_end = assalpha(config.outline_alpha_end)
		config.shadow_alpha_end = assalpha(config.shadow_alpha_end)
		config.primary_color_middle = asscolor(config.primary_color_middle)
		config.outline_color_middle = asscolor(config.outline_color_middle)
		config.shadow_color_middle = asscolor(config.shadow_color_middle)
		config.primary_alpha_middle = assalpha(config.primary_alpha_middle)
		config.outline_alpha_middle = assalpha(config.outline_alpha_middle)
		config.shadow_alpha_middle = assalpha(config.shadow_alpha_middle)

		aegisub_karaoke_preprosses_macro(subtitles, config, selected_lines)
		aegisub.set_undo_point("fx34")
		aegisub.progress.set(100)
		aegisub.progress.task("Finished!") 
	elseif cfg_res == "Cancel" then
		aegisub.progress.task("Cancelled")
	end
end

aegisub.register_macro("Aegisub Karaoke Effect [34]","",aegisub_karaoke_macro)