include("karaskel.lua")

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "gundam00s2"
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
				(l.style == "Default" or l.style == "4") then
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
local x=syl.center + line.left
local y=line.margin_v + 40
if i == 1 then
tempo=0
end

--FX INICIAL
		l = table.copy(line)
		
function genera_circulo(radio,centrox,centroy,angulo,movimiento)
 posx=centrox + radio*math.cos(angulo)
 posy=centroy + radio*math.sin(angulo)
 
 if not movimiento then
   return posx,posy
 else
   posx1=centrox + (radio+movimiento)*math.cos(angulo)
   posy1=centroy + (radio+movimiento)*math.sin(angulo)
   return posx,posy,posx1,posy1
 end
end

-- Variables Degrado
l = table.copy(line)
ini = 1
pix = ((l.bottom - l.top)/ini) -3 -- Restamos el Fondo de la Linea con la Cima de la Linea, dividimos x 1 y sumamos 1.


color1 = color_from_style(l.styleref.color1) -- Color 1 Obtenido del Color Primario.
color2 = color_from_style(l.styleref.color2) -- Color 2 Obtenido del Color Secundario.

var = 1/(pix/2) -- Variable para el calculo de t
color_inicial = (pix/2)/2 -- Variable para el calculo de t
color_final = (pix/2)+((pix/2)/2) -- Variable para el calculo de t
color = 0

for j = 0 , pix do -- For que va desde cero hasta el resultado de Pix

    x1 = 0
    x2 = 1280
    y1 = l.top + (j * ini) - 4 -- El -5 puede variar dependiendo de la Font (Top)
    y2 = l.top + (j * ini) + 1 -- El -2 puede variar dependiendo de la Font (Bottom)

        if (j >= color_inicial) and (j <= color_final) then -- Hacemos el calculo final para t
        color = color + var
        end
    local color_final = interpolate_color(color, color1, color2) -- Interpolación de colores

l.text = string.format("{\\pos(%d,%d)\\clip(%d,%d,%d,%d)\\an5\\bord2\\1c%s}%s", x, y, x1, y1, x2, y2, color_final, syl.text_stripped)
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer= 3
subs.append(l)
end

--SILABAS ESTATICAS (2)
		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\alpha&H50&}%s",x,y,line.styleref.color1,syl.text_stripped)
		l.start_time = line.start_time+syl.start_time
		l.layer=2
		subs.append(l)

--FX silaba
l = table.copy(line)
l.text = string.format("{\\pos(%d,%d)\\an5\\bord2\\1c%s\\t(\\fscx110\\fscy110\\bord3\\1c%s\\3c%s\\blur3))}%s", x, y, line.styleref.color2, line.styleref.color1, line.styleref.color4, syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 4
subs.append(l)

--FX silaba
--l = table.copy(line)
--l.text = string.format("{\\pos(%d,%d)\\an5\\bord2\\1c%s\\t(\\fry360\\bord0))}%s", x, y, line.styleref.color2, syl.text_stripped)
--l.start_time=line.start_time+syl.start_time
--l.end_time=l.start_time+syl.duration
--l.layer = 4
--subs.append(l)

--FX CIRCULO PARTICULAS
l = table.copy(line)
  for r=0,7 do
   if r==0 then
     p=0
   end

   angulo=p   
   genera_circulo(10,x,y,p,15)
   l.text = string.format("{\\p1\\fscx50\\fscy50\\fad(100,100)\\an5\\blur0\\bord0\\frz0\\org(%d,%d)\\move(%d,%d,%d,%d)\\1c%s\\3c%s\\t(\\1c%s\\frz360\\fscx60\\fscy60\\3c&HEBD796&\\bord2\\blur10)}m 0 -6 l 2 -2 6 -2 2 1 5 5 0 3 -5 5 -2 1 -6 -2 -2 -2{\\p0}",x,y,posx,posy,posx1,posy1,line.styleref.color2,line.styleref.color3,line.styleref.color1)
   l.start_time=line.start_time+syl.start_time
   l.end_time=l.start_time+syl.duration+syl.duration
   l.layer = 2
   subs.append(l)
   p=p+(math.pi/4)
end
	

-- FX GLOW
l = table.copy(line)
for i=0,5 do
    l.layer=5
    l.text = string.format("{\\pos(%d,%d)\\an5\\shad0\\3c&HFFFFFF&\\1a&HF5&\\3a&HF5&\\bord%d\\fscx120\\fscy120\\t(\\bord0\\3c%s\\fscx100\\fscy100)}%s",x,y,1+ i*1,line.styleref.color2, syl.text_stripped)
    l.start_time=line.start_time+syl.start_time
    l.end_time=l.start_time+syl.duration
    subs.append(l)
end	

end
end
-------------------------------ACÁ TERMINAN LOS EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("FX!", "", fx_Zheo)
aegisub.register_filter("FX!", "", 2000, fx_Zheo)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------