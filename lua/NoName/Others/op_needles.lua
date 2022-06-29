include("karaskel.lua") -- ESTE SIEMPRE SE DEBE DE AGREGAR !!!
include("zheolib.lua") --AHORA AGREGAMOS LA LIBRERIA :D !!
include("formaslib.lua") -- AGREGAMOS EL FORMASLIB !!

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "needles"
script_description = "Fx para konohaline"
script_author = "rico19901"
script_version = "2.0"

-- ## FUNCIÓN GENERADOR FX... NO TOCAR!!!
function fx_rico19901(subs)
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
	aegisub.set_undo_point("fx_rico19901")
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

function sil()
silaba = ""..syl.text_stripped..""
return silaba
end

-------------------------------TERMINA LA CONFIGURACIÓN BÁSICA-----------------------------
-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

--FX INICIAL
l = table.copy(line)
l.text = "{"..fad(100,0)..an(5)..move(x,y+30,x,y)..bord(0)..fry(100)..color(1,'ffffff')..t(fry(360)..estilo(1,line.styleref.color1)..bord(1)).."}"..sil()
l.start_time = line.start_time -800
l.end_time = line.start_time
l.layer=0
subs.append(l)

l = table.copy(line)
l.text = "{"..fad(100,0)..an(5)..move(x,y-30,x,y)..bord(0)..fry(100)..color(1,'ffffff')..t(fry(360)..estilo(1,line.styleref.color1)..bord(1)).."}"..sil()
l.start_time = line.start_time -800
l.end_time = line.start_time
l.layer=0
subs.append(l)

--SILABAS ESTATICAS

--Silaba estatica 2 - borde negro
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..bord(1)..color(3,"ffffff").."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=1
subs.append(l)

--SILABAS ESTATICAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..blur(5)..bord(2)..color(3,"ffffff").."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=1
subs.append(l)

--SILABAS ESTATICAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..blur(2)..bord(2)..color(3,"ffffff").."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=1
subs.append(l)


	--FX SILABA ACTIVA
	l = table.copy(line)
	l.text = "{"..an(5)..move(x,y+5,x,y)..color(1,'ffffff')..blur(1)..t(blur(0)..bord(1)).."}"..sil()
	l.start_time=line.start_time+syl.start_time
	l.end_time=l.start_time+syl.duration
	l.layer =5
	subs.append(l)


--FX DE SILABAS
--SILABA QUE SE DESPRENDE
l = table.copy(line)
l.text = "{"..an(5)..color(1,"ffffff")..move(x,y,x-9,y+50)..t(fscxy(150)..frz(360)..alpha('ff'))..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time+100
l.end_time=l.start_time+syl.duration+1000
l.layer = 2
subs.append(l)


--ESTRELLAS

l = table.copy(line)
for j = 1,20 do --serian 5 estrellas
	l.text = string.format("{\\an5\\1c2fffff1\\move(%d,%d,%d,%d)\\frz-160\\fscy10\\fscx10\\bord2\\t(\\alphaff)\\blur3}{\\p1}m 10 49 l 52 19 l 0 19 l 42 49 l 26 0 {\\p0}",x,y,x+math.random(-30,120),y-math.random(-120,30),syl.text_stripped)
	l.start_time=line.start_time+syl.start_time
	l.end_time=l.start_time+syl.duration
	l.layer = 2
	subs.append(l)
end
end
end


-------------------------------ACÁ TERMINAN LOS EFECTOS------------------------------------
-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------
aegisub.register_macro("needles", "Aplica tu FX! D:", fx_rico19901)
aegisub.register_filter("needles", "Aplica tu FX! D:", 2000, fx_rico19901)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN---