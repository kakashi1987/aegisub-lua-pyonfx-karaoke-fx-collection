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
				(l.style == "Default") then  -- en esta linea coloca el nombre del estilo al que afectará el script lua
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
		local y=line.margin_v + 30 --AQUI CAMBIAS EL MARGEN DE LA POSICION DE LA LINEA (Que tan abajo estarán de arriba)
		if i == 1 then
			tempo=0
		end
		
		-- AGREGAMOS TAMBIEN ESTA FUNCIÓN
		function sil()
			silaba = ""..syl.text_stripped..""
			return silaba
		end
        
        
            --EFECTO INICIAL

			--EFECTO DE SILABAS DESPUES DE LA CANTADA
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..fad(100,100)..color(1,line.styleref.color2)..AutoTags(TE2,100,'1c&H84268F&\\blur1','1c&HEEB7D2&\\blur0.5').."}"..sil()
			l.start_time =line.start_time --line.start_time+syl.start_time+syl.duration--\\fscy100\\fscx105--\\fscy125\\fscx100
			l.end_time = l.end_time
			l.layer=1
			subs.append(l)
            
            
            --EFECTO DE SILABAS ANTES DE LA CANTADA
			l = table.copy(line)
			l.text = "{"..an(5)..fad(0,100)..pos(x,y)..color(1,line.styleref.color2).."}"..sil()
			l.start_time = line.start_time--..AutoTags(TE2,200,'fscy100\\fscx105','fscy125\\fscx100')
			l.end_time = line.start_time+syl.start_time
			l.layer=2
			subs.append(l)

            
			--EFECTO DE SILABA CANTADA
            l = table.copy(line)
            l.text = "{"..an(5)..pos(x,y)..bord(1.5)..color(1,line.styleref.color1)..shad(0)..alpha(50)..t(fscxy(150))..AutoTags(TE3,50,'frz5','frz-5').."}"..sil()
            l.start_time=line.start_time+syl.start_time
            l.end_time=l.start_time+syl.duration
            l.layer =3
            subs.append(l)
            
            --EFECTO DE SALIDA
            
		

--------------------------------------HASTA AQUI TERMINAN LOS EFECTOS-----------------------------------------------------
--NO LOS QUITES
	end
end
---------------------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("kara", "APLICAR EFECTO", Alki_FX)
aegisub.register_filter("kara", "APLICAR EFECTO", 2000, Alki_FX)
----------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------------