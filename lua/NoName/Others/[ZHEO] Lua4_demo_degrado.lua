include("karaskel.lua")
include("zheolib.lua") --AHORA AGREGAMOS LA LIBRERIA :D

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "LUA4 FX Base"
script_description = "Script Lua4 con Zheolib.lua"
script_author = "Zheo"
script_version = "2.0"

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
cx1 = 0 -- siempre cero
cy1 = 5+j*1+1 -- comienza desde la cima de linea (tambien puede ser l.top+j*1+1)
cx2 = 640 -- ancho video
cy2 = 5+j*1+2 -- es igual a cy1 pero con un nº más (tambien puede ser l.top+j*1+2)
l.text = "{"..fad(100,0)..an(5)..pos(x,y)..clip(cx1, cy1, cx2, cy2)..RangeColor(1, j/syl.height,line.styleref.color1, line.styleref.color2)..bord(0)..t(bord(1)).."}"..sil()
l.start_time = line.start_time -1000
l.end_time = line.start_time
l.layer=0
subs.append(l)
end

--SILABAS ESTATICAS
l = table.copy(line)
for j = 0, syl.height do
cx1 = 0 -- siempre cero
cy1 = 5+j*1+1 -- comienza desde la cima de linea (tambien puede ser l.top+j*1+1)
cx2 = 640 -- ancho video
cy2 = 5+j*1+2 -- es igual a cy1 pero con un nº más (tambien puede ser l.top+j*1+2)
l.text = "{"..an(5)..pos(x,y)..clip(cx1, cy1, cx2, cy2)..RangeColor(1, j/syl.height,line.styleref.color1, line.styleref.color2)..bord(1).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=0
subs.append(l)
end

--FX DE SILABAS
l = table.copy(line) -- sin borde
for j = 0, syl.height do
cx1 = 0 -- siempre cero
cy1 = 5+j*1+1 -- comienza desde la cima de linea (tambien puede ser l.top+j*1+1)
cx2 = 640 -- ancho video
cy2 = 5+j*1+2 -- es igual a cy1 pero con un nº más (tambien puede ser l.top+j*1+2)
l.text = "{"..an(5)..pos(x,y)..bord(1)..clip(cx1, cy1, cx2, cy2)..RangeColor(1, j/syl.height,line.styleref.color1, line.styleref.color2)..alfa(3,'ff')..t(fscxy(50,50)..alpha('ff')).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 1
subs.append(l)
end

l = table.copy(line) -- sólo borde
l.text = "{"..an(5)..pos(x,y)..bord(1.5)..estilo(1,line.styleref.color2)..alfa(1,'ff')..t(fscxy(150,150)..alpha('ff')).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 2
subs.append(l)

-- Ciculos
if sil() == " " then
l.text = " "
else
l = table.copy(line)
for j = 0 ,5 do
    randx = x-rand(40,0)
    randy = y-rand(40,40)
l.text = "{"..an(5)..move(x,y,randx, randy)..bord(0)..estilo(1,line.styleref.color2)..fscxy(150,150)..color(1, RandomColor())..t(be(1)..alpha('ff')).."}"..p(1,Fcirculo(1))
l.start_time= line.start_time+syl.start_time
l.end_time= l.start_time+syl.duration+700       
l.layer = 0
subs.append(l)
end
end




-------------------------------ACÁ TERMINAN LOS EFECTOS------------------------------------
end
end
-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------
aegisub.register_macro("Degrado V2!", "Aplica tu FX! D:", fx_zheo)
aegisub.register_filter("Degrado V2!", "Aplica tu FX! D:", 2000, fx_zheo)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN---