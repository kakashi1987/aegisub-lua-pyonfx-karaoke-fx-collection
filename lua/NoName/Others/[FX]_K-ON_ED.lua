include("karaskel.lua")
include("azheolib.lua")
-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "K-ON ED"
script_description = "K-ON ED"
script_author = "zheo & nickle"
script_version = "2"

--FUNCIÓN GENERADOR FX
function fx_kon(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)
	aegisub.progress.task("Applying effect...")
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

--TERMINA FUNCION GENERADOR

-------------------------------TERMINA CONFIGURACIONES DE LA MACRO------------------------

-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

--CONFIGURACION DE POSICION
function do_fx(subs, meta, line)
	for i = 1, line.kara.n do
		local syl = line.kara[i]
		local x=syl.center + line.left
		local y=line.margin_v + 35
		local actor=line.actor
				
		if i ==1 then
			modi_tiempo=0
			tempo=0
			control_color=' '			
		end
		
		function sil()
			silaba = ""..syl.text_stripped..""
			return silaba
		end
			
		--si es kanji, usamos un y diferente
		if actor=='kan' then
			y=y+45		
		end
		
		arreglo_colores={'8DF6A6','EBF264','B07672','F076D2','8BFFFE'}
		--if line.style == 'End' then
		
		--Efectos entrada [caracter x caracter]
		l = table.copy(line)
		longsil=string.len(sil())	
		posicion_anterior=0
		tent=line.start_time-800+modi_tiempo
		
		cont=false
				while cont==false do	
					color_aleatorio=arreglo_colores[math.random(1,5)]
					if color_aleatorio ~= control_color then
						cont=true
					end
				end
		mod_tstart=0
		for char in unicode.chars(sil()) do
			if char == ' ' or char == '' then -- si no hay texto
				l.text = "{}"
			else -- si hay texto
				
				--Metricas de caracter
				tam_caracter=aegisub.text_extents(line.styleref,char) --obtenemos la longitud del caracter
				x_individual=line.left + syl.left +tam_caracter/2+posicion_anterior --Posicionamos nuestro carácter
				
				--Efecto Entrada
				l.text = "{"..an(5)..fad(150,0)..bord(1)..blur(1)..pos(x_individual,y)..fscxy(20)..color(1,line.styleref.color1)..t(fscxy(350))..t(fscxy(100)).."}"..char
				l.start_time=tent+mod_tstart
				l.end_time=line.start_time+modi_tiempo
				l.layer=0
				subs.append(l)	
				
				--constante
				l = table.copy(line)
				l.start_time=line.start_time+modi_tiempo
				l.end_time=line.start_time+syl.start_time
				l.text = "{"..an(5)..pos(x_individual,y)..bord(1)..blur(1)..fscxy(100)..color(1,line.styleref.color1).."}"..char
				l.layer=2
				subs.append(l)	
				
				--constante
				l = table.copy(line)
				l.start_time=line.start_time+syl.end_time
				l.end_time=line.end_time-500+modi_tiempo+mod_tstart
				l.text = "{"..an(5)..pos(x_individual,y)..fad(0,150)..bord(2)..blur(3)..fscxy(100)..color(1,line.styleref.color1)..color(3,color_aleatorio).."}"..char
				l.layer=2
				subs.append(l)
			
										
				--Modificadores			
				mod_tstart=mod_tstart+((800/line.kara.n)/longsil)
				posicion_anterior=posicion_anterior+tam_caracter 
				
			end
		notas = {'m 0 0 l 0 0 l 0 9 b 0 9 -1 8 -3 9 b -3 9 -5 10 -4 12 b -4 12 -3 13 -1 12 b -1 12 1 11 1 10 b 1 10 1 9 1 9 l 1 1 l 9 -1 l 9 8 b 9 8 8 7 6 8 b 6 8 4 9 5 11 b 5 11 6 12 8 11 b 8 11 10 10 10 9 b 10 8 10 8 10 8 l 10 -3 ',
		 'm 0 0 l 0 0 l 0 9 b 0 9 -1 8 -3 9 b -3 9 -5 10 -4 12 b -4 12 -3 13 -1 12 b -1 12 1 11 1 10 b 1 10 1 9 1 9 l 1 1 l 9 -2 l 9 -3 '}	
		--Notas
		l = table.copy(line)
		for f = 0,10 do
			colora=arreglo_colores[math.random(1,5)]
			l.text = "{"..an(5)..be(3)..bord(2)..move(x+rand(-10,10),y+rand(-10,10), x+rand(-70,70), y+rand(-35,35))..bord(0)..AutoTags(TE2, 200,fscxy(rand(50,100)), fscxy(rand(180,220)))..color(1,colora)..color(3,colora)..t(alpha('ff')).."}"..p(1, notas[rand(1,2)])
			l.start_time = line.start_time+syl.start_time+math.random(-200,500)
			l.end_time = l.start_time+syl.duration+rand(-300,500)
			l.layer=1
			subs.append(l)
		end
		
		  l = table.copy(line) 	
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.start_time+syl.end_time
			l.text = "{"..an(5)..be(2)..fad(0,70)..move(x+math.random(-3,3),y+math.random(-3,3),x,y)..bord(1)..fscxy(100)..color(1,line.styleref.color1)..color(3,line.styleref.color1)..a(1,'96')..a(3,'73')..t(fscxy(150))..t(fscxy(100))..AutoTags(TE2,200,fscxy(rand(0,30)), fscxy(rand(30,60))).."}"..sil()
			l.layer=3
			subs.append(l)
			
			
		l = table.copy(line)
		l.start_time=line.start_time+syl.start_time
		l.end_time=line.start_time+syl.end_time
		l.text = "{"..an(5)..pos(x,y)..bord(1)..blur(1)..fscxy(100)..color(1,line.styleref.color1)..color(3,color_aleatorio)..t(fscxy(150)..blur(2))..t(fscxy(100)..blur(1)).."}"..sil()
		l.layer=4
		subs.append(l)
				
		end
		control_color=color_aleatorio 
		modi_tiempo=modi_tiempo+800/line.kara.n		
		
		--[[elseif line.style == 'End2' then
			--FX INICIAL DOBLETE!!! XD
			l = table.copy(line)
			l.text = "{"..fad(200,0)..an(5)..pos(x,y)..fr(rand(180))..bord(0)..t(fr(0)..bord(2)).."}"..sil()
			l.start_time = line.start_time+tempo-700
			l.end_time = line.start_time+tempo
			l.layer=1
			subs.append(l)

			--SILABAS ESTATICAS + MOVE FRZ
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..c(1, 'ffffff').."}"..sil()
			l.start_time = line.start_time+tempo
			l.end_time = line.start_time+syl.start_time
			l.layer=1
			subs.append(l)


			--FX DE SILABAS
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..color(1,line.styleref.color1)..blur(4)..xbord(3)..color(3, '1B703D')..fscxy(140)..t(fscxy(90)..alpha('ff')).."}"..sil()
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration+500
			l.layer = 3
			subs.append(l)

			tempo=tempo+(700/line.kara.n)

			end]]
		
	end	
end
-------------------------------TERMINA EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("FX K-ON ED", "", fx_kon)
aegisub.register_filter("FX K-ON ED", "", 2000, fx_kon)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------