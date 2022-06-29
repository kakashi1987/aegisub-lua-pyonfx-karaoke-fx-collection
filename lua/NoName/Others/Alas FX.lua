include("karaskel.lua") -- ESTE SIEMPRE SE DEBE DE AGREGAR !!!
include("zheolib.lua") --AHORA AGREGAMOS LA LIBRERIA :D !!
include("formaslib.lua") -- AGREGAMOS EL FORMASLIB !!

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Alas FX"
script_description = "FX by Kirav751"
script_author = "Kirav751"
script_version = "1"

-- ## FUNCIÓN GENERADOR FX... NO TOCAR!!!
function fx_Kirav751(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment then
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
l.text = string.format("{\\fad(100,0)\\an5\\move(%d,%d,%d,%d)\\bord3\\be3\\blur3\\fry360\\1c&HFFFFFF&\\3c&HFFFFFF&\\t(\\frx0\\1c%s\\3c%s\\bord1\\blur0\\be0\\fry0)}%s",x-10,y,x,y,line.styleref.color1,line.styleref.color3,syl.text_stripped)
l.start_time = line.start_time -800
l.end_time = line.start_time
l.layer=0
subs.append(l)

--SILABAS ESTATICAS

--Silaba estatica 2 - 
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..bord(1)..color(3,"000000")..estilo(1,line.styleref.color2).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=1
subs.append(l)

--ALAS--

l = table.copy(line)
if sil() == "" then -- si se karaokea un espacio (suele pasar, sino, no hubiese hecho esto xD)
l.text = " " -- el resultado será un espacio y no una explosión :D
else -- si no es un espacio, hará el FX =D
for j = 1,1 do
	l.text = "{"..pos(x,y)..an(5)..color(1,"&HA9A9AB&")..move(x,y,x+rand(0),y+rand(0))..t(fscxy(250)..alpha('ff'))..blur(5).."}"..p(2,"m 54 26 b 36 33 31 -8 2 50 b 7 42 11 36 18 30 b 11 36 15 36 7 50 b 13 44 17 36 20 30 b 15 36 20 38 12 49 b 19 44 18 33 24 29 b 20 33 21 42 18 47 b 23 44 24 31 26 29 b 25 34 25 42 24 49 b 26 42 26 33 31 30 b 27 36 31 38 26 50 b 32 46 30 33 35 31 b 33 36 35 44 33 46 b 36 47 35 35 42 30 b 41 36 36 42 36 44 b 38 42 42 38 44 33 b 47 31 50 31 53 30 b 53 29 54 27 54 26 m 58 26 b 77 33 83 -9 111 50 b 106 42 102 35 96 29 b 102 36 98 36 107 50 b 99 44 97 36 94 30 b 98 36 94 38 101 49 b 94 44 95 33 90 28 b 94 33 93 42 96 47 b 91 44 90 31 86 28 b 89 33 89 42 90 49 b 88 42 86 33 82 29 b 86 36 82 38 86 50 b 82 46 83 32 77 31 b 81 36 78 44 81 46 b 77 47 78 35 70 30 b 70 36 77 42 77 44 b 74 42 70 38 67 33 b 64 31 62 31 58 30 b 58 29 58 27 58 26  ")
	l.start_time=line.start_time+syl.start_time
	l.end_time=l.start_time+syl.duration
	l.layer = 2
	subs.append(l)

--FX DE SILABAS
--Bordes Resaltan
l = table.copy(line)
l.text = "{"..pos(x,y)..an(5)..color(1,"&H000000&")..move(x,y,x+rand(0),y+rand(0))..t(fscxy(250)..alpha('ff'))..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 2
subs.append(l)


end
end
end
end

-------------------------------ACÁ TERMINAN LOS EFECTOS------------------------------------
-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------
aegisub.register_macro("GxF!", "Aplica tu FX! D:", fx_Kirav751)
aegisub.register_filter("GxF!", "Aplica tu FX! D:", 2000, fx_Kirav751)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN---