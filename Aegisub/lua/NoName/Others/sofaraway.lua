-- SCRIPT MODIFICADO Y COMENTADO POR ALQUIMISTA
-- GRACIAS A ZHEO, NICKLE, ASEDARK Y A TODO EL SOCIAL CLUB DE FXMAKERS
-- SON LIBRES DE MODIFICARLO A SU ANTOJO
-- USEN NOTEPAD++ PARA QUE VEAN TODO ACOMODADITO Y CON COLORES xD

--INCLUIR LIBRERIAS
include("karaskel.lua") --SIEMPRE HAY QUE AGREGARLA
include("zheolib.lua") --AGREGAMOS LA LIBRERIA ZHEOLIB
include("formaslib.lua") --AGREGAMOS LA LIBRERIA FORMASLIB

--\\-----------------------------CONFIGURACIONES DE LA MACRO------------------------------\\--

--[[-------------------------------------------/
                                               /
	script_name = "Grafica de coseno"          /
	script_description = "EFECTOS EN LUA4"     /
	script_author = "Alquimista"               /
	script_version = "0.1 beta"                /
											   /
--------------------------------------------]]--

-- FUNCIÓN GENERADOR DE EFECTO... ¡NO MODIFICABLE!
function Alki_FX(subs)
	aegisub.progress.task("ESPERA MIENTRAS SE CREA EL EFECTO") --los mensajes entre comillas y parentesis se pueden modificar
	local meta, styles = karaskel.collect_head(subs)
	aegisub.progress.task("APLICANDO EFECTO")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("YA CASI (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment and
				(l.style == "Romanji" or l.style == "Kanji" or l.style == "Default") then  -- en esta linea coloca el nombre del estilo al que afectará el script lua
				karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else
			i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("¡PROCESO FINALIZADO!")
	aegisub.progress.set(100)
end
-- TERMINA FUNCION GENERADOR


--\\-----------------------------TERMINA CONFIGURACIONES DE LA MACRO----------------------\\--

--////////////////FUNCIONES//////////////////////////////////////////////////////////////////////////////////////////////

-- CONFIGURACION DE LA POSICION DEL SUBTITULO
function do_fx(subs, meta, line)
	for i = 1, line.kara.n do

		local syl = line.kara[i]

		local sstart=0
		local send=syl.end_time
		local smid=syl.duration / 2

		local actor=line.actor

		if i == 1 then
			tempo=0
		end

		-- AGREGAMOS TAMBIEN ESTA FUNCIÓN
		function sil()
			silaba = ""..syl.text_stripped..""
			return silaba
		end

--////////////////EMPIEZAN LOS FX'S//////////////////////////////////////////////////////////////////////////////////////////


		if actor == '1' then
		
		local x=syl.center + line.left
		local y=line.margin_v + 35

			--EFECTO DE SALIDA
			l = table.copy(line)
			l.text = "{"..an(5)..fscxy(120)..pos(x,y)..c(3,'FFFFFF')..alfa(1,'ff')..t(alpha('ff')..fscxy(160)).."}"..sil()
			l.start_time = line.end_time - 300
			l.end_time = line.end_time + 300
			l.layer=6
			subs.append(l)

			--EFECTO DE SILABAS DESPUES DE LA CANTADA
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..color(1,'E38CDC')..blur(2).."}"..sil()
			l.start_time = line.start_time
			l.end_time = line.start_time+syl.start_time
			l.layer=6
			subs.append(l)


			--EFECTO DE SILABA CANTADA
			l = table.copy(line)
			l.text = "{"..an(5)..bord(0)..alpha('c0')..move(x,y,x-2,y)..fscxy(100)..bord(0)..t(fscxy(115)..blur(1)).."}"..sil()
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration
			l.layer =8
			subs.append(l)

			l = table.copy(line)
			l.text = "{"..an(5)..bord(0)..alpha('c0')..move(x,y,x-3,y)..fscxy(100)..bord(0)..t(fscxy(125)..blur(1)).."}"..sil()
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration
			l.layer =9
			subs.append(l)

			l = table.copy(line)
			l.text = "{"..an(5)..bord(0)..alpha('c0')..move(x,y,x-4,y)..fscxy(100)..t(fscxy(135)..blur(2))..bord(1).."}"..sil()
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration
			l.layer =10
			subs.append(l)

			l = table.copy(line)
			l.text = "{"..an(5)..org(x,y)..pos(x,y)..bord(1)..color(1,'FFC3DF')..t(blur(5)..bord(1.5)).."}"..sil()
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration
			l.layer =8
			subs.append(l)

			--FX particulas
			l = table.copy(line)
			for r=0,60 do
			l.text = "{"..org(x,y+rand(2))..fad(syl.duration/2,syl.duration/2)..an(5)..move(x+rand(12), y+rand(12), x-(r*3), y+(r*0.05))..color(1,'E38ADB')..bord(0)..blur(rand(0,0.5))..fscxy(rand(80,150))..frz(0)..frx(0)..t(estilo(1,'HB343A1')..frz(rand(20))..frx(rand(360))).."}"..p(1,'m 0 0 l 0 1 l 1 1 l 1 0')
			l.start_time=line.start_time+syl.start_time+rand(0,100)
			if syl.duration < 650 then
				l.end_time = line.start_time + syl.start_time + 1500
			else
				l.end_time = l.start_time + syl.duration * 1.5
			end
			l.layer = 7
			subs.append(l)
			end

			--EFECTO DE SILABAS ANTES DE LA CANTADA
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..color(1,'F3A7CF')..blur(2).."}"..sil()
			l.start_time =line.start_time+syl.start_time+syl.duration+tempo--\\fscy100\\fscx105--\\fscy125\\fscx100+tempo
			l.end_time = l.end_time
			l.layer=6
			subs.append(l)
			
		elseif actor == '2'	then
		
			local x=syl.center + line.left
			local y=line.margin_v + 65

			--EFECTO DE SILABAS DESPUES DE LA CANTADA
			l = table.copy(line)
			l.text = "{"..fad(300,0)..an(5)..pos(x,y)..color(1,'E38CDC')..blur(2).."}"..sil()
			l.start_time = line.start_time
			l.end_time = line.start_time+syl.start_time
			l.layer=6
			subs.append(l)


			--EFECTO DE SILABA CANTADA
			l = table.copy(line)
			l.text = "{"..an(5)..bord(0)..alpha('c0')..move(x,y,x-2,y)..fscxy(100)..bord(0)..t(fscxy(115)..blur(1)).."}"..sil()
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration
			l.layer =8
			subs.append(l)

			l = table.copy(line)
			l.text = "{"..an(5)..bord(0)..alpha('c0')..move(x,y,x-3,y)..fscxy(100)..bord(0)..t(fscxy(125)..blur(1)).."}"..sil()
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration
			l.layer =9
			subs.append(l)

			l = table.copy(line)
			l.text = "{"..an(5)..bord(0)..alpha('c0')..move(x,y,x-4,y)..fscxy(100)..t(fscxy(135)..blur(2))..bord(1).."}"..sil()
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration
			l.layer =10
			subs.append(l)

			l = table.copy(line)
			l.text = "{"..an(5)..org(x,y)..pos(x,y)..bord(1)..color(1,'FFC3DF')..t(blur(5)..bord(1.5)).."}"..sil()
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration
			l.layer =8
			subs.append(l)

			--EFECTO DE SILABAS ANTES DE LA CANTADA
			l = table.copy(line)
			l.text = "{"..fad(0,300)..an(5)..pos(x,y)..color(1,'F3A7CF')..blur(2).."}"..sil()
			l.start_time =line.start_time+syl.start_time+syl.duration+tempo--\\fscy100\\fscx105--\\fscy125\\fscx100+tempo
			l.end_time = l.end_time
			l.layer=6
			subs.append(l)
			
		else
		
			local x=syl.center + line.left
			local y=line.margin_v + 445
			
			--ESTATICA
			l = table.copy(line)
			l.text = "{"..be(1)..fad(200,100)..an(5)..fscxy(120)..pos(x,y).."}"..sil()
			l.start_time = line.start_time
			l.end_time = l.end_time
			l.layer=2
			subs.append(l)
		
			--EFECTO DE SALIDA
			l = table.copy(line)
			l.text = "{"..an(5)..fscxy(120)..pos(x,y)..c(3,'FFFFFF')..alfa(1,'ff')..t(alpha('ff')..fscxy(160)).."}"..sil()
			l.start_time = line.end_time - 300
			l.end_time = line.end_time + 300
			l.layer=0
			subs.append(l)
			
		end	
		


--------------------------------------HASTA AQUI TERMINAN LOS EFECTOS-----------------------------------------------------
--NO LOS QUITES
	end
end
---------------------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("fx", "APLICAR EFECTO", Alki_FX)
aegisub.register_filter("fx", "APLICAR EFECTO", 2000, Alki_FX)
----------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------------