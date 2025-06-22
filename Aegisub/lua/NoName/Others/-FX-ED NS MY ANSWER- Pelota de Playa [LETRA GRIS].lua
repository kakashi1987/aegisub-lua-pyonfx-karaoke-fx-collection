include("karaskel.lua")

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "FX Playa >2/3<"
script_description = "Kirav751---> Hecho para el Ending de Naruto Shippuden SEAMO -MY ANSWER >2/3<"
script_author = "Kirav75"
script_version = "1.0"

--FUNCIÓN GENERADOR FX
function fx_kirav751(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment and 
				(l.style == "ED_2")then
			karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else
			i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("Finished!")
	aegisub.progress.set(100)
end

--TERMINA FUNCION GENERADOR

-------------------------------TERMINA CONFIGURACIONES DE LA MACRO------------------------

-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

--CONFIGURACION DE POSICION
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y
local alineamiento
local inicio=syl.start_time
local fin=syl.end_time
local medio=syl.start_time + syl.duration / 2
if i ==1 then
tiempo=0
end
if actor=='1' then
y=line.margin_v + 45
else
y=line.margin_v + 30

--FX INICIAL
l = table.copy(line)
l.text = string.format("{\\fad(100,0)\\an5\\be3\\pos(%d,%d)\\frx360\\bord0\\1c&HFFFFFF&\\t(\\frx360\\be0\\1c%s\\bord1)}%s",x,y,line.styleref.color1, syl.text_stripped)
l.start_time=line.start_time-800+tiempo
l.end_time=line.start_time
l.layer=0
subs.append(l)
	
		
--Pelota parte 1			
l.text = string.format("{\\p1\\1c&H0000C5&\\an5\\be6\\bord0\\shad0\\1a&H64&\\move(%d,%d,%d,%d)\\fscx100\\fscy100\\t(\\fscx270\\fscy270)\\t(\\fscx100\\fscy100)}m 14 27 b 22 26 28 21 28 13 b 28 5 22 0 14 0 b 3 0 0 8 0 13 b 0 21 6 27 14 27 m 14 1 b 30 0 32 24 14 26 b -2 26 -5 2 14 1 m 14 1 b 21 2 26 26 14 26 b 2 28 6 1 14 1   {\\p0}",x-syl.width/2,y,x+syl.width/2,y,syl.text_stripped)
l.start_time=line.start_time+syl.start_time+tiempo
l.end_time=l.start_time+syl.duration+tiempo
subs.append(l)
--Tiempos de salida de los circulos
if syl.duration<170 then
tiempoi=tiempo+60
elseif syl.duration<230 then
tiempoi=tiempoi+70
elseif syl.duration<300 then
tiempoi=tiempoi+syl.duration/4
else
tiempoi=tiempoi+80
end
end
--SILABAS ESTATICAS+efecto+salida
l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\blur0\\be5\\1c%s\\fad(0,200)\\fscx100\\fscy100\\t(%d,%d,\\1c%s\\fscx200\\fscy200\\blur5\\be5\\bord3)\\t(%d,%d,\\1c%s\\fscx100\\fscy100\\blur0\\be0\\bord1)}%s",x,y,line.styleref.color1,inicio,medio,line.styleref.color2,medio,fin,line.styleref.color1,syl.text_stripped)
l.end_time=line.end_time-300+tiempo
l.layer='1'
subs.append(l)
end
end

-------------------------------TERMINA EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("-FX-", "Kirav751 :P", fx_kirav751)
aegisub.register_filter("-FX-", "Kirav751 :P", 2000, fx_kirav751)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------