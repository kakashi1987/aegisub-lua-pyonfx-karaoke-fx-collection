include("karaskel.lua")

script_name = "Moves Shape 10"
script_description = "Moves Shape 10"
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
	aegisub.progress.task("Finished!")
	aegisub.progress.set(100)
end

function do_fx(subs, meta, line, config)
	for i = 1, line.kara.n do
		local syl = line.kara[i]
		local x = syl.center + line.left
		local y = line.middle

		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%s,%s)\\1vc(&HFFFFFF&,&HFFFFFF&,&H49A2DA&,&H49A2DA&)\\shad0\\fad(300,0)}%s",x,y,syl.text_stripped)
		l.start_time = line.start_time + 50*(syl.i-line.kara.n)
		l.end_time = line.start_time + syl.start_time
		l.layer = 0
		subs.append(l)
		
		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%s,%s)\\shad0\\t(0,60,\\fscx120\\fscy120\\3c&HFFFFFF&\\blur3)\\t(60,%d,\\fscx100\\fscy100\\3c&H0D2B4A&\\1c&H0D2B4A&\\blur0\\1va(&H00&,&H00&,&HFF&,&HFF&)\\3va(&H00&,&H00&,&HFF&,&HFF&))\\fad(0,100)}%s",x,y,syl.duration,syl.text_stripped)
		l.start_time = line.start_time + syl.start_time
		l.end_time = l.start_time + syl.duration
		l.layer = 1
		subs.append(l)
		
			--este es el efecto que asemeja al humo, al finalizar las llamas.
			n = math.random(3,5)											--bucles o loops del humo.
			for j = 1, n do												
				time_i = math.random(0,200)								--random para el tiempo inicial.
				size = math.random(30,65)									--modifica el tamaño mínimo y el máximo del humo.
				x_i = x + math.random(-0.5*syl.width,0.5*syl.width)		--coordenadas de posición y de movimiento del humo.
				x_f = x + math.random(-0.5*syl.width,0.5*syl.width)
				y_i = y + math.random(-0.5*syl.height,0.5*syl.height)-0.3*syl.height
				y_f = y + math.random(-0.5*syl.height,0.5*syl.height)-math.random(syl.height,2*syl.height)-0.2*syl.height
				color = _G.interpolate_color(math.random(0,10)/10,"&H93E9F1&","&H339AE2&")
				shape_1 = "m 15 0 b 0 26 18 26 15 47 b 32 20 13 20 15 0"	--shape con forma de "s" alargada elegida para el humo.
								
				l.text = string.format("{\\an5\\move(%s,%s,%s,%s)\\fscx%s\\fscy%s\\blur3\\bord0\\shad0\\c%s\\alpha&H66&\\t(\\fry360\\blur6\\alpha&HFF&)\\p1}%s",x_i,y_i,x_f,y_f,size,size,color,shape_1)
				l.start_time = line.start_time + syl.end_time - 200 + time_i
				l.end_time = l.start_time + 450
				l.layer = 1
				subs.append(l)
			end
				

			--Function Interpolate_Shape--
			
			a = 4									--cantidad de frames entre cada interpolación.
			interpolation = 200						--duración total de una sola interpolación.
			time_shape = interpolation/(a + 1)		--duración de cada uno de los frames.
			n = (syl.duration + 100)/time_shape		--loops o bucles de cada uno de los frames.
			for j = 1, n do
				
				function i_shape()		--function interpolate_shape
				m = ((a - a*math.ceil(j/a)+j)*(-1)^(math.ceil(j/a) + 1) + (a + 2)*(1 + (-1)^math.ceil(j/a))/2 - 1)/a
				--algoritmo de ida y vuelta entre las dos shapes de la interpolación.
				--sobra decir que parece un algoritmo salido de la caverna más profunda de infierno, jajajaja
				--pero es uno de lo más grandes avances para hacer posible esta función.
				
					function i(x_1,x_2)			--función de concatenación de puntos para la interpolación de las shapes
					val = x_1 - (x_1 - x_2)*m		--esta función hace posible transformar una shape en cualquier otra, sin importar la figura
					return val						--puede transformar curvas bezir en líneas rectas y al contrario, es decir, que un círculo
					end								--se puede convertir en un cuadrado o en una estrella, ideal para las animaciones.
				
				--debo preparar un documento o tutorial en donde se explique más claramente la forma en que se deben ingresar
				--las dos shapes a interpolar en la función, más las otras aplicaciones. espero que en una versión 2.0 sólo sea
				--necesario copiar y pegar las dos shapes, una al lado de la otra, y listo,... jajaja, mientras tanto usaré esta XD.
				--olvidaba mencionar que el máximo logro de esta función es que no importa la cantidad de puntos de las shapes, ésta
				--las puede interpolar y no es necesario que tengan la misma cantidad de puntos entre sí.
				
				--frames de interpolación,... shape_i para a=1, y shape_f para a=4;... de forma reiterada en toda la duración de la "syl"
				shape = string.format("m %d %d b %d %d %d %d %d %d b %d %d %d %d %d %d b %d %d %d %d %d %d b %d %d %d %d %d %d b %d %d %d %d %d %d b %d %d %d %d %d %d b %d %d %d %d %d %d b %d %d %d %d %d %d b %d %d %d %d %d %d b %d %d %d %d %d %d b %d %d %d %d %d %d b %d %d %d %d %d %d b %d %d %d %d %d %d b %d %d %d %d %d %d b %d %d %d %d %d %d b %d %d %d %d %d %d b %d %d %d %d %d %d b %d %d %d %d %d %d b %d %d %d %d %d %d",i(17,26), i(104,100), i(0,0), i(125,132), i(10,21), i(149,162), i(43,54), i(154,167), i(28,39), i(145,158), i(26,37), i(136,149), i(29,40), i(127,136), i(33,44), i(138,151), i(49,60), i(147,160), i(49,60), i(129,142), i(49,60), i(114,127), i(34,33), i(109,104), i(50,69), i(93,83), i(48,58), i(98,103), i(48,61), i(101,113), i(51,71), i(104,120), i(51,65), i(88,111), i(62,74), i(93,110), i(63,66), i(76,102), i(72,82), i(87,107), i(58,83), i(100,118), i(63,83), i(111,128), i(67,83), i(121,140), i(78,68), i(125,142), i(72,83), i(143,152), i(78,90), i(139,156), i(85,96), i(132,145), i(87,92), i(121,129), i(93,113), i(137,145), i(88,99), i(148,161), i(77,88), i(154,167), i(121,132), i(146,159), i(120,131), i(112,125), i(98,119), i(88,122), i(111,118), i(133,161), i(76,98), i(89,117), i(84,107), i(77,101), i(92,116), i(63,86), i(79,111), i(45,63), i(92,91), i(31,55), i(73,104), i(39,69), i(79,97), i(60,81), i(69,86), i(69,89), i(82,72), i(32,45), i(50,116), i(14,47), i(70,65), i(0,0), i(42,86), i(12,26), i(64,53), i(30,38), i(48,59), i(53,66), i(53,50), i(44,64), i(50,45), i(30,52), i(38,57), i(26,38), i(48,35), i(51,62), i(14,25), i(60,73), i(25,36), i(84,97), i(39,50), i(114,127), i(12,23), i(129,142), i(17,26), i(104,100))
				return shape
				end
				
			rand_n = math.random(15,45)/10
			size = 30
			size_y = size + rand_n*((5 - 5*math.ceil(j/5)+j)*(-1)^(math.ceil(j/5) + 1) + (7)*(1 + (-1)^math.ceil(j/5))/2 - 1)
			angle = 90*(1+(-1)^syl.i)
			color_f = _G.interpolate_color((j-1)/(n-1),"&HFB5803&","&H101E5A&")
			--cambio de color entre el primer frame y el último, para j = n
			--los dos anteriores colores son los colores de la base de la flama, ya que la parte superior, en este caso, siempre es blanca
			
				if j >= n - 5 then
					tag = string.format("\\t(\\1va(%s,%s,%s,%s))",_G.ass_alpha(255),_G.ass_alpha(255),_G.ass_alpha(255),_G.ass_alpha(255))
				else
					tag = ""
				end
			
			l.text = string.format("{\\an2\\pos(%s,%s)\\fry%s\\fscx%s\\fscy%s\\bord0\\shad0\\blur2.5\\1vc(&HFFFFFF&,&HFFFFFF&,%s,%s)\\1va(&H20&,&H20&,&H60&,&H60&)%s\\p1}%s",x,y+0.3*syl.height,angle,size,size_y,color_f,color_f,tag,i_shape())
			l.start_time = line.start_time + syl.start_time + time_shape*(j-1)
			l.end_time = l.start_time + time_shape
			l.layer = 2
			subs.append(l)
			end
	end
end

--esta es la configuración de la macro que permitirá elegir a qué estilo queremos aplicar el efecto
--es ideal para cuando el script tiene más de un estilo y solo queramos aplicarlo a uno de ellos.

Moves_Shape_10_conf = {
	
	[1] = { name = "applyto"; class = "dropdown"; x = 5; y = 0; height = 2; width = 4; items = { }; value = "" },
	[2] = { class = "label"; x = 0; y = 0; height = 1; width = 4; label = "Apply to" }
}

function Moves_Shape_10_preprosses_macro(subtitles, config, selected_lines)
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

function Moves_Shape_10_prepareconfig(styles, subtitles, has_selected_lines)
	Moves_Shape_10_conf[1].items = {}
	local astyles = {}
	for i = 1, #subtitles do
		if subtitles[i].class == "dialogue" and subtitles[i].effect ~= "FX" and
			not subtitles[i].comment then
			if subtitles[i].style ~= "" and not astyles[subtitles[i].style] then 
				astyles[subtitles[i].style] = true
				applytostyle = subtitles[i].style
				table.insert(Moves_Shape_10_conf[1].items, applytostyle)
			end
		end 
	end
	if  #Moves_Shape_10_conf[1].items > 0 then 
		Moves_Shape_10_conf[1].value = "SelectAll"
		table.insert(Moves_Shape_10_conf[1].items, Moves_Shape_10_conf[1].value) 
	end
	if has_selected_lines and #Moves_Shape_10_conf[1].items > 0 then 
		table.insert(Moves_Shape_10_conf[1].items,"Selected lines")
	end
end

function Moves_Shape_10_macro(subtitles, selected_lines, active_line)
	local meta, styles = karaskel.collect_head(subtitles)
	Moves_Shape_10_prepareconfig(styles, subtitles, #selected_lines > 0)
	local cfg_res, config = aegisub.dialog.display(Moves_Shape_10_conf)
	if cfg_res then
		Moves_Shape_10_preprosses_macro(subtitles, config, selected_lines)
		aegisub.set_undo_point("Moves_Shape_10")
		aegisub.progress.task("Finished!") 
	else
		aegisub.progress.task("Cancelled");	
	end
end

aegisub.register_macro("Moves_Shape_10", "", Moves_Shape_10_macro)