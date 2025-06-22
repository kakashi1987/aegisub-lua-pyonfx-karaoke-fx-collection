-- Aegisub Automation script by Zheo ¬¬!!!
-- NO COPIAR!!!!!



name = "[ZHEO]Lua FXs"
description = "Hikari no Machi"
configuration = {}
version, kind = 3, 'basic_ass'



-->--INCLUDE VARIABLES GLOBALES
include("karaskel-adv.lua")
br=0
time=1
--<--FIN INCLUDE



-->>FUNCIONES DE RESULTADOS Y WEAS XD>>--
function do_syllable(meta, styles, config, line, syl)
local result = {n=0}
function result.add() local l = copy_line(line); table.insert(result, l); return l end
--<<FIN FUNCIONES<<--



-->--REVISA TIEMPOS MUERTOS
  if syl.text == "" then
   return { n=0 }
  end
  if syl.text == " " then
   return { n=0 }
  end
--<--FIN REVISION



-->-- POSICION DE X - Y
  local x=syl.center + line.centerleft
  local y=line.styleref.margin_v + 18
--<-- FIN POSICION



-->--REVISA EL TIEMPO EN LAS LINEAS
if time ~= line.start_time then
  time=line.start_time
  br=-1
end
br=br+1
--<--FIN REVISION



--REVISA LAS LINEAS POR SI HAY ERRORES DE SINTAXIS
if  (syl.text_stripped == ".") then elseif (syl.text_stripped == ",") then elseif (syl.text_stripped == "\"") then else
end



--EFECTO DE INICIO
l=result.add()
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\bord0\\fscx5\\fscy5\\frx10\\1c&HFFFFFF&\\t(\\frx-360\\1c&H704053&\\fscx100\\fscy100\\bord2)}%s",x,y+30,x,y,syl.text_stripped)
l.start_time = line.start_time -28 +br*1
l.end_time = line.start_time + br*10 -15

--SILABAS ESTATICAS
l=result.add()
l.layer=2
l.text = string.format("{\\an5\\pos(%d,%d)\\1c&H704053&}%s",x,y,syl.text_stripped)
l.start_time = line.start_time +br*10 -15
l.end_time = line.start_time + syl.start_time/10

--EFECTO 01
l=result.add()
l.layer=30
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\t(0,30,\\bord1\\1c&H261F23&)\\t(30,%d,\\frx90\\fscx0\\fscy180\\bord0\\1a&H000000&\\3c&H000000&\\alpha&HFF&)}%s",x,y,x,y-15,syl.duration*10+200,syl.text_stripped)
l.start_time = line.start_time + syl.start_time/10
l.end_time = line.start_time + syl.start_time/10 + syl.duration + 20



--EFECTO 02
local numdebris = math.floor(syl.width * syl.height / 6)
	                for i = 1, numdebris do

		local dx = math.sqrt(math.random(syl.width*syl.width)) - syl.width/2
		local dy = math.sqrt(math.random(syl.height*syl.height)) - syl.height/2

		local sx = line.centerleft + syl.center + dx
		local sy = 40 + dy

		local speed = math.random(-10,10)/6

		local ex = line.centerleft + syl.center + dx*speed
		local ey = 40 + dy + math.random(-80,0)
		
		local l = copy_line(line)
		l.start_time = l.start_time + syl.start_time/10 - 5
		l.end_time = l.start_time + math.random(20,40) + syl.duration
		
local color = "38A5E3"
if math.random() > 0.5 then
color = "12F2F0"
end
local color2 = "3869E3"
if math.random() > 0.5 then
color2 = "12C0F2"

		end
l.layer=50
   l.text = string.format("{\\move(%d,%d,%d,%d)\\alpha&HC8&\\1c&H%s&\\bord0\\shad0\\fscx110\\fscy100\\t(\\1c&H%s&\\fscx20\\fscy20\\alpha&H00&}{\\p3}m 16 32 b 22 18 25 15 30 14 b 25 12 17 2 16 -10 b 15 2 4 12 -1 14 b 4 15 8 18 16 32 {\\p0}", x+math.random(-15,15), y+math.random(-20,20),ex, ey-5, color, color2)
		table.insert(result, l)
	end

--FX03

for i=0,20 do
l=result.add()
l.layer=1
l.text = string.format("{\\pos(%d,%d)\\an5\\shad0\\3c&HFFFFFF&\\1a&HFF&\\3a&HFD&\\bord%d\\t(\\bord0)}%s",x,y,1+ i*1,syl.text_stripped)
l.start_time = line.start_time + syl.start_time/10
l.end_time = line.start_time + syl.start_time/10 + syl.duration + 60
end 

  return result
end