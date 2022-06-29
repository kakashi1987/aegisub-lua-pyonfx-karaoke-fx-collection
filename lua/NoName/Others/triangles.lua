-- SCRIPT MODIFICADO Y COMENTADO POR ALQUIMISTA
-- GRACIAS A ZHEO, NICKLE, ASEDARK (ROBE ALGUNOS COMENTARIOS DE TUS EJEMPLOS) Y A TODO EL SOCIAL CLUB DE FXMAKERS
-- SON LIBRES DE MODIFICARLO A SU ANTOJO
-- USEN NOTEPAD++ PARA QUE VEN TODO ACOMODADITO Y CON COLORES xD

--INCLUIR LIBRERIAS
include("karaskel.lua") --SIEMPRE HAY QUE AGREGARLA
include("zheolib.lua") --AGREGAMOS LA LIBRERIA ZHEOLIB
include("formaslib.lua") --AGREGAMOS LA LIBRERIA FORMASLIB

--\\-----------------------------CONFIGURACIONES DE LA MACRO------------------------------\\--

--[[-------------------------------------------/
                                               /
	script_name = "un disque karaoke"          /
	script_description = "EFECTOS EN LUA4"     /
	script_author = "Alquimista"               /
	script_version = "1.0"                     /
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
				(l.style == "Default" or l.style == "Gundam00") then  -- en esta linea coloca el nombre del estilo al que afectará el script lua
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

-- CONFIGURACION DE LA POSICION DEL SUBTITULO
function do_fx(subs, meta, line)
	for i = 1, line.kara.n do
		local syl = line.kara[i]
		local x=syl.center + line.left
		local y=line.margin_v + 40 --AQUI CAMBIAS EL MARGEN DE LA POSICION DE LA LINEA (Que tan abajo estarán de arriba)
		if i == 1 then
			tempo=0
		end
		
		-- AGREGAMOS TAMBIEN ESTA FUNCIÓN
		function sil()
			silaba = ""..syl.text_stripped..""
			return silaba
		end
			
		--FX CIRCULO PARTICULAS
		for n=0, 30 do
			l = table.copy(line)
			l.text = "{"..fad(300,300)..org(x,y+rand(15))..an(5)..bord(0)..frz(rand(0,360))..t(frx(rand(0,360)))..move(x+rand(15), y+rand(12), x-20+rand(15), y+rand(10))..fscxy(40)..color(3,line.styleref.color3)..color(1, RandomColor()).."}"..p(1,'m 17 11 l 0 -15 l -17 11 l 17 11 m 15 10 l -15 10 l 0 -13 l 15 10')
			l.start_time=line.start_time+syl.start_time+ rand(200)
			l.end_time=l.start_time+syl.duration+1500
			l.layer = 0
			subs.append(l)
		end

		--SILABAS ESTATICAS(LINEA DE KARAOKE......las que solo se quedan sin hacer nada)
		l = table.copy(line)
		l.text = "{"..an(5)..pos(x,y)..estilo(1,line.styleref.color2).."}"..sil()
		l.start_time = line.start_time
		l.end_time = line.start_time+syl.start_time
		l.layer=0
		subs.append(l)

		--EFECTO DE SILABAS(Es el efecto de la silaba "ACTIVA" que se canta en el momento)
		l = table.copy(line)
		l.text = "{"..an(5)..move(x,y+3,x,y)..color(1,'H726FDE')..blur(5)..t(blur(0)..bord(1)).."}"..sil()
		l.start_time=line.start_time+syl.start_time
		l.end_time=l.start_time+syl.duration
		l.layer =3
		subs.append(l)

		--FX DE SILABA DESPUES DE CANTADA
		l = table.copy(line)
		frand=rand(10)
		l.text = "{"..fad(400,0)..an(5)..pos(x,y)..estilo(1,line.styleref.color2)..t(fr(frand)..bord(1)..fscxy(150,150)..alpha('ff')..estilo(1,line.styleref.color4)..color(3,'HFFFFFF&')..blur(2)..bord(0)).."}"..sil()
		l.start_time=l.start_time+syl.start_time+100
		l.end_time=l.start_time+syl.duration+1000
		l.layer = 0
		subs.append(l)

--------------------------------------HASTA AQUI TERMINAN LOS EFECTOS-----------------------------------------------------
--NO LOS QUITES
	end
end
---------------------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("kara", "APLICAR EFECTO", Alki_FX)
aegisub.register_filter("kara", "APLICAR EFECTO", 2000, Alki_FX)
----------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------------