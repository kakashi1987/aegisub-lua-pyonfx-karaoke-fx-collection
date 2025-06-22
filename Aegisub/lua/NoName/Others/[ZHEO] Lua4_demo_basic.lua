include("karaskel.lua")
include("zheolib.lua") --AHORA AGREGAMOS LA LIBRERIA :D

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "LUA4 FX Base"
script_description = "Script Lua4 con Zheolib.lua"
script_author = "Zheo"
script_version = "1.9.0 Rev2"

-- ## FUNCIÓN GENERADOR FX... NO TOCAR!!!
function fx_zheo(subs)
	aegisub.progress.task("ESPERA MIESTRAS SE HACE EL FX... (Sale a dar una vuelta D:)")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Aplicando tu FX D:")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Esto llevo trabajado (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment and
				(l.style == "1") then --Acá se puede cambiar por el nombre del Estilo que quieras
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
	aegisub.set_undo_point("fx_zheo")
end
-- ## TERMINA FUNCION GENERADOR

-------------------------------TERMINA CONFIGURACIONES DE LA MACRO------------------------
-------------------------------ACÁ COMIENZA LA CONFIGURACIÓN BÁSICA-----------------------
-- ## CONFIGURACION DE X-Y
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 25
if i == 1 then
tempo=0
end
-- ## AGREGAMOS TAMBIEN ESTA FUNCIÓN
function sil()
silaba = ""..syl.text_stripped..""
return silaba
end

-------------------------------TERMINA LA CONFIGURACIÓN BÁSICA-----------------------------
-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

--FX INICIAL
l = table.copy(line)
l.text = "{"..fad(100,0)..an(5)..pos(x,y)..frx(100)..color(1,'ffffff')..t(frx(360)..estilo(1,line.styleref.color1)..bord(1)).."}"..sil()..sil()..sil()
l.start_time = line.start_time -800
l.end_time = line.start_time
l.layer=0
subs.append(l)

--SILABAS ESTATICAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..estilo(1,line.styleref.color2).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=0
subs.append(l)

if syl.inline_fx=="salto" then
--FX DE SILABAS
l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\t(\\fscx250\\fscy250\\bord2\\blur6\\fscy100\\fscx100)}%s", x, y, line.styleref.color2, syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 2
subs.append(L)

--FX DE SILABAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..estilo(1,line.styleref.color1)..t(fscxy(150,150)..alpha('ff')).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 2
subs.append(l)

end
end
end
-------------------------------ACÁ TERMINAN LOS EFECTOS------------------------------------
-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------
aegisub.register_macro("JR-F FX!", "Aplica tu FX! D:", fx_zheo)
aegisub.register_filter("JR-F FX!", "Aplica tu FX! D:", 2000, fx_zheo)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN---