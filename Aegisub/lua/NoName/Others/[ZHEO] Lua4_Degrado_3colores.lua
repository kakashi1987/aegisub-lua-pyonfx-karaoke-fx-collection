include("karaskel.lua")
include("zheolib.lua") --AHORA AGREGAMOS LA LIBRERIA :D

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Degrado 3 Colores"
script_description = "Script Lua4 con Zheolib.lua"
script_author = "Zheo"
script_version = "V1"

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
				(l.style == "Default") then --Acá se puede cambiar por el nombre del Estilo que quieras
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
for j = 0, syl.height do
l.text = "{"..fad(100,0)..an(5)..pos(x,y)..bord(0)..frx(100)..DegradoV(j, syl.height-17, 12, 640, line.styleref.color1, '70FC7B', line.styleref.color2)..t(frx(360)..bord(1)).."}"..sil()
l.start_time = line.start_time -800
l.end_time = line.start_time
l.layer=0
subs.append(l)
end

--SILABAS ESTATICAS
l = table.copy(line)
for j = 0, syl.height do
l.text = "{"..an(5)..pos(x,y)..DegradoV(j, syl.height-17, 12, 640, line.styleref.color1, '70FC7B', line.styleref.color2).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=0
subs.append(l)
end

--FX DE SILABAS
l = table.copy(line)
for j = 0, syl.height+20 do
l.text = "{"..an(5)..pos(x,y)..DegradoV(j, syl.height-17, 0, 640, line.styleref.color1, 'ff00cc', line.styleref.color2)..color(3, 'ffffff')..t(fscxy(200)..xbord(10)..blur(5)..bord(3)..alpha('ff')).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=0
subs.append(l)
end


-------------------------------ACÁ TERMINAN LOS EFECTOS------------------------------------
end
end
-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------
aegisub.register_macro("JR-F FX!", "Aplica tu FX! D:", fx_zheo)
aegisub.register_filter("JR-F FX!", "Aplica tu FX! D:", 2000, fx_zheo)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN---