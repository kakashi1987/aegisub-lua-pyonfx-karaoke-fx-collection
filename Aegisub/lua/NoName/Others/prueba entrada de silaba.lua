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
	script_name = "un efecto mas"              /
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
				(l.style == "Estilo1" or l.style == "Estilo2" or l.style == "Estilo3") then  -- en esta linea coloca el nombre del estilo al que afectará el script lua
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
        local x=syl.center + line.left
		local y=line.margin_v +20 		
		local sstart=0
		local send=syl.end_time
		local smid=syl.duration / 2	
		local actor=line.actor
		
		if i == 1 then
			tiempo=0
		end
		tiempo = tiempo + (1000 / line.kara.n)

		-- AGREGAMOS TAMBIEN ESTA FUNCIÓN
		function sil()
			silaba = ""..syl.text_stripped..""
			return silaba
		end		
		
--////////////////EMPIEZAN LOS FX'S//////////////////////////////////////////////////////////////////////////////////////////

		--FX DE ENTRADA	
		l = table.copy(line)
		l.text = "{"..an(5)..move(x-30, y+rand(50), x, y)..frz(rand(15,360))..t(c(1,line.styleref.color2))..t(frz(0))..color(1,'ffffff')..bord(0).."}"..sil()
		l.start_time = line.start_time + tiempo - 800
		l.end_time = line.start_time + syl.start_time
		l.layer=2
		subs.append(l)			
	
		--FX SILABAS ESTATICA (DESPUES DE CANTADA)
		l = table.copy(line)
		l.text = "{"..an(5)..pos(x,y)..c(1,line.styleref.color2).."}"..sil()
		l.start_time = line.start_time + syl.start_time
		l.end_time = line.end_time
		l.layer = 0
		subs.append(l)




--------------------------------------HASTA AQUI TERMINAN LOS EFECTOS-----------------------------------------------------
--NO LOS QUITES
	end
end
---------------------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("Aplicar Efecto", "APLICAR EFECTO", Alki_FX)
aegisub.register_filter("Aplicar Efecto", "APLICAR EFECTO", 2000, Alki_FX)
----------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------------