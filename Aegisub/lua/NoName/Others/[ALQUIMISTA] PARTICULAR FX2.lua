-- SCRIPT MODIFICADO Y COMENTADO POR ALQUIMISTA
-- GRACIAS A ZHEO, NICKLE, ASEDARK (ROBE ALGUNOS COMENTARIOS DE TUS EJEMPLOS) Y A TODO EL SOCIAL CLUB DE FXMAKERS
-- SON LIBRES DE MODIFICARLO A SU ANTOJO
-- USEN NOTEPAD++ PARA QUE VEN TODO ACOMODADITO Y CON COLORES xD

--INCLUIR LIBRERIAS
include("karaskel.lua") --SIEMPRE HAY QUE AGREGARLA
include("zheolib.lua") --AGREGAMOS LA LIBRERIA ZHEOLIB
include("formaslib.lua") --AGREGAMOS LA LIBRERIA FORMASLIB
include('utils.lua')

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
		local y=line.margin_v + 454 --AQUI CAMBIAS EL MARGEN DE LA POSICION DE LA LINEA (Que tan abajo estarán de arriba)
		local lbottom = math.floor(line.bottom + 0.5)
		local ltop = math.floor(line.top + 0.5)
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
        
l = table.copy(line)        
l.text = "{"..fad(800,0)..an(5)..move(x-20,y,x,y)..color('ffffff','000000',0).."}"..sil() --ESTOS SON LOS EFECTOS (Aqui es donde agregarás tus efectos de entrada)
l.start_time = line.start_time -800 --TIEMPO INICIAL DEL EFECTO (-800 = entrará 0.8 segundos antes de lo normal ( del tiempo timeado)
l.end_time = line.start_time ---TIEMPO FINAL DEL EFECTO 
l.layer=1
subs.append(l)
		
--SILABAS ESTATICAS(LINEA DE KARAOKE......las que solo se quedan sin hacer nada)
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..bord(1)..be(5).."}"..sil()
l.start_time = line.start_time
l.end_time = line.end_time
l.layer=1
subs.append(l)

--SILABAS ESTATICAS(LINEA DE KARAOKE......las que solo se quedan sin hacer nada)
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..bord(1)..color(0,'000000',0)..be(2).."}"..sil()
l.start_time = line.start_time
l.end_time = line.end_time
l.layer=2
subs.append(l)

--------------------------------------HASTA AQUI TERMINAN LOS EFECTOS-----------------------------------------------------
--NO LOS QUITES
	end
end
---------------------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("kara", "APLICAR EFECTO", Alki_FX)
aegisub.register_filter("kara", "APLICAR EFECTO", 2000, Alki_FX)
----------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------------