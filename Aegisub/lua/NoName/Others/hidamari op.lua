include("karaskel.lua")

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Test_Hidamari"
script_description = "Test Script LUA"
script_author = "nickle"
script_version = "1.0"

--FUNCIÓN GENERADOR FX
function fx_pruebahida(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment and 
				(l.style == "Default")then
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

--TERMINA FUNCION GENERADOR

-------------------------------TERMINA CONFIGURACIONES DE LA MACRO------------------------

-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

--CONFIGURACION DE POSICION
function do_fx(subs, meta, line)
	for i = 1, line.kara.n do
	local syl = line.kara[i]
	local x=syl.center + line.left
	local y
	local alineamiento
	local actor=line.actor --flag en script .ass
	local inicio=syl.start_time
	local fin=syl.end_time
	local medio=syl.start_time + syl.duration / 2
	
	if i ==1 then
		tiempo=0
	end
		if actor=='1' then
		y=line.margin_v + 45
			else
			y=line.margin_v + 30
	end
			
	if actor ~= '1' then --FX Normal
		
		--FX INICIAL
			l = table.copy(line)
			l.text = string.format("{\\fad(100,0)\\an5\\be3\\pos(%d,%d)\\frx360\\bord0\\1c&HFFFFFF&\\t(\\frx0\\be0\\1c%s\\bord1)}%s",x,y,line.styleref.color1, syl.text_stripped)
			l.start_time=line.start_time-800+tiempo
			l.end_time=line.start_time
			l.layer=0
			subs.append(l)
		
		--FX DE SILABAS
		l = table.copy(line)
			for i=0, 3 do
				if i==0 then
					tiempoi=0
				end
		--Circulos seguimiento			
			l.text = string.format("{\\p1\\1c&HBC4FF6&\\an5\\be6\\bord0\\shad0\\1a&H64&\\move(%d,%d,%d,%d)\\fscx100\\fscy100\\t(\\fscx270\\fscy270)\\t(\\fscx100\\fscy100)}m 14 27 b 22 26 28 21 28 13 b 28 5 22 0 14 0 b 3 0 0 8 0 13 b 0 21 6 27 14 27{\\p0}",x-syl.width/2,y,x+syl.width/2,y,syl.text_stripped)
			l.start_time=line.start_time+syl.start_time+tiempoi
			l.end_time=l.start_time+syl.duration+tiempoi
			subs.append(l)
				--Tiempos de salida de los circulos
				if syl.duration<170 then
				tiempoi=tiempoi+60
				elseif syl.duration<230 then
				tiempoi=tiempoi+70
				elseif syl.duration<300 then
				tiempoi=tiempoi+syl.duration/4
				else
				tiempoi=tiempoi+80
				end
			
			end
		
		--SILABAS ESTATICAS+efecto+salida
			l = table.copy(line)
			l.text = string.format("{\\an5\\pos(%d,%d)\\blur0\\be0\\1c%s\\fad(0,200)\\fscx100\\fscy100\\t(%d,%d,\\1c%s\\fscx120\\fscy120\\blur5\\be5\\bord3)\\t(%d,%d,\\1c%s\\fscx100\\fscy100\\blur0\\be0\\bord1)}%s",x,y,line.styleref.color1,inicio,medio,line.styleref.color2,medio,fin,line.styleref.color1,syl.text_stripped)
			l.end_time=line.end_time-300+tiempo
			l.layer='1'
			subs.append(l)
				
		else --Lineas WASSOI!
			
			--FX INICIAL
			l = table.copy(line)
			l.text=string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(100,0)\\1c%s\\bord0\\be4\\t(\\1c%s\\bord1\\be0)}%s",x+300,y,x,y,line.styleref.color2,line.styleref.color1,syl.text_stripped)
			l.start_time = line.start_time-300+tiempo
			l.end_time= line.start_time+tiempo
			l.layer='2'
			subs.append(l)
			--ESTATICAS
			l = table.copy(line)
			l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s}%s",x,y,line.styleref.color1,syl.text_stripped)
			l.start_time = line.start_time+tiempo
			l.end_time = line.start_time+syl.start_time
			l.layer=0
			subs.append(l)
			--Efecto
			rot={'5','-5'}
			if math.mod(i,2)==0 then --test de arreglos, se pueden usar directamente los valores
			rotacion=rot[1]
			else
			rotacion=rot[2]
			end
			l = table.copy(line)
			l.text=string.format("{\\an5\\pos(%d,%d)\\org(%d,%d)\\1c%s\\3c%s\\frz0\\t(%d,%d,\\frz%d)\\t(%d,%d,\\blur5\\be5\\bord10\\1c&HFFFFFF&\\3c&HFFFFFF&)\\t(%d,%d,\\blur0\\bord1\\be0\\1c%s\\3c%s)}%s",x,y,x,y,line.styleref.color1,line.styleref.color3,0,syl.duration,rotacion,0,syl.duration/2,syl.duration/2,syl.duration,line.styleref.color1,line.styleref.color3,syl.text_stripped)
			l.start_time = line.start_time+syl.start_time
			l.layer='3'
			subs.append(l)
			--particulas
			color={"&HB4D8F3&","&HEFEEF8&","&H79FFFA&","&HEEBBDA&","&H86F4CC&", "&H5B86FF&", "&HE0A175&"}
			inicio={0,0.4,0.5,0.6,0.7,0.8,0.9,1} --no sirve para nada...
			l = table.copy(line)
			for r=0,25 do
			local pcolor=color[math.random(1,7)]
			local pos=inicio[math.random(1,8)]
			l.text = string.format("{\\p2\\org(%d,%d)\\fad(50,70)\\1c%s\\3c%s\\1a&H64&\\an5\\be3\\blur2\\bord1\\fscx50\\fscy50\\move(%d,%d,%d,%d)}m 14 27 b 22 26 28 21 28 13 b 28 5 22 0 14 0 b 3 0 0 8 0 13 b 0 21 6 27 14 27{\\p0}", x,y,pcolor,pcolor,x+((syl.width/2)/2)+pos,y+((syl.height/2)/2)+pos,x+math.random(-50,50),y+math.random(-50,50))
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration+650
			subs.append(l)
			end
			--salida
			l = table.copy(line)
			l.text=string.format("{\\an5\\pos(%d,%d)\\1c%s\\3c%s\\frz%d\\fscx100\\fscy100\\alpha&H00&\\t(\\b3\\blur3\\fscx%d\\fscy%d\\1c&HFFFFFF&\\3c&HFFFFFF&\\alpha&HFF&)}%s",x,y,line.styleref.color1,line.styleref.color2,rotacion,200,200,syl.text_stripped)
			l.start_time=line.end_time
			l.end_time=line.end_time+400
			subs.append(l)

	end
	tiempo=tiempo+(1000/line.kara.n)
	end
end
-------------------------------TERMINA EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("FX Hidamari OP", "", fx_pruebahida)
aegisub.register_filter("FX Hidamari OP", "", 2000, fx_pruebahida)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------