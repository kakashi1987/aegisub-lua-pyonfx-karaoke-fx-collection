include("karaskel.lua")

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "gundam00s2kanji"
script_description = "FX"
script_author = ""
script_version = ""

--FUNCIÓN GENERADOR FX... NO TOCAR!!!
function fx_Zheo(subs)
	aegisub.progress.task("Creando FX")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Aplicando FX")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Esto llevo trabajado (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment and
				(l.style == "kanji" or l.style == "Romaji") then
				karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else
			i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("Por fin termine D:!")
	aegisub.progress.set(100)
	aegisub.set_undo_point("fx_Zheo")
end
--TERMINA FUNCION GENERADOR

-------------------------------TERMINA CONFIGURACIONES DE LA MACRO------------------------

-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

--CONFIGURACION DE X-Y
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=line.left + line.width + 0.5
local y=line.bottom + 0.5
if i == 1 then
tempo=0
end
	
--SILABAS ESTATICAS (1)
		l = table.copy(line)
		l.text = string.format("{\\an3\\fad(1000,1000)\\pos(%d,%d)\\1c%s}%s",x,y,line.styleref.color1,syl.text_stripped)
		l.start_time = line.start_time
		l.end_time = l.end_time
		l.layer=2
		subs.append(l)		
		
end
end
-------------------------------ACÁ TERMINAN LOS EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("FXkanji!", "", fx_Zheo)
aegisub.register_filter("FXkanji", "", 2000, fx_Zheo)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------