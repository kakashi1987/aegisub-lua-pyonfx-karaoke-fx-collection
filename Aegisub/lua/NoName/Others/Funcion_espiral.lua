include("karaskel.lua")
include("zheolib.lua") --AHORA AGREGAMOS LA LIBRERIA :D

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "espiral"
script_description = "Script Lua4 con Zheolib.lua"
script_author = "Alquimista"
script_version = "0.1 Beta"

-- ## FUNCI�N GENERADOR FX... NO TOCAR!!!
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
				(l.style == "Default") then --Ac� se puede cambiar por el nombre del Estilo que quieras
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
-------------------------------AC� COMIENZA LA CONFIGURACI�N B�SICA-----------------------
-- ## CONFIGURACION DE X-Y
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 25
if i == 1 then
tempo=0
end
-- ## AGREGAMOS TAMBIEN ESTA FUNCI�N
function sil()
silaba = ""..syl.text_stripped..""
return silaba
end

-------------------------------TERMINA LA CONFIGURACI�N B�SICA-----------------------------
-------------------------------AC� COMIENZAN LOS EFECTOS-----------------------------------
function genespiral(radio,x,y,a,b,angulo)

--[[En coordenadas polares (r, ?) la espiral de Arqu�medes puede ser descrita por la ecuaci�n siguiente:
   radio=a + b*(angulo)
  siendo a y b n�meros reales. Cuando el par�metro a cambia, la espiral gira, mientras que b controla la distancia en giros sucesivos]]--

 radio=a + b*(angulo)

 --convertir de polar a rectangular
 
 posx=x+radio*math.cos(angulo)
 posy=y+radio*math.sin(angulo)
 
 return posx,posy
end
--------------------------------------------------------------------------------------------------------------------

--FX INICIAL
l = table.copy(line)
l.text = "{"..fad(100,0)..an(5)..pos(x,y)..bord(0)..frx(100)..color(1,'ffffff')..t(frx(360)..estilo(1,line.styleref.color1)..bord(1)).."}"..sil()
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

--FX DE SILABAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..estilo(1,line.styleref.color1)..t(fscxy(150,150)..alpha('ff')).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 2
subs.append(l)

--espiral

l=table.copy(line)
nparticulas=360*2
for z=0,nparticulas do
 angulo=math.rad(z)
 genespiral(radio,x,y,0.005,1,angulo) -- genespiral(radio,x,y,a,b,angulo)
 l.start_time=line.start_time+syl.start_time
 l.end_time=l.start_time+syl.duration
 l.text="{"..an(5)..pos(posx,posy)..color(1,line.styleref.color2)..bord(0).."}"..p(1,'m 0 0 l 1 0 1 1 0 1')
 subs.append(l)
end

end
end
-------------------------------AC� TERMINAN LOS EFECTOS------------------------------------
-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACI�N--------------
aegisub.register_macro("FX!", "Aplica tu FX! D:", fx_zheo)
aegisub.register_filter("FX!", "Aplica tu FX! D:", 2000, fx_zheo)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACI�N---