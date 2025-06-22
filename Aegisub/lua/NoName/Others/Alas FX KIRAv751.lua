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
l.text = string.format("{\\fad(100,0)\\an5\\move(%d,%d,%d,%d)\\bord3\\be3\\blur3\\fry360\\frz360\\1c&HFFFFFF&\\3c&HFFFFFF&\\t(\\frx360\\1c%s\\3c%s\\bord1\\blur0\\be0\\fry0)}%s",x-10,0,x,y,line.styleref.color1,line.styleref.color3,syl.text_stripped)
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
	l.text = "{"..pos(x,y)..an(5)..color(1,"&HA9A9AB&")..move(x,y,x+rand(0),y+rand(0))..t(fscxy(250)..alpha('ff'))..blur(5).."}"..p(2,"m 54 30 b 36 37 31 -4 2 55 b 7 47 11 40 18 34 b 11 41 15 41 7 54 b 13 48 17 41 20 34 b 15 41 20 42 12 53 b 19 48 18 37 24 33 b 20 37 21 46 18 52 b 23 48 24 35 26 33 b 25 38 25 46 24 53 b 26 47 26 37 31 34 b 27 40 31 42 26 55 b 32 50 30 37 35 35 b 33 41 35 48 33 50 b 36 52 35 39 42 34 b 41 41 36 47 36 48 b 38 46 42 42 44 37 b 47 35 50 35 53 34 b 53 33 54 31 54 30 m 58 30 b 77 37 83 -5 111 55 b 106 47 102 39 96 33 b 102 41 98 40 107 54 b 99 48 97 40 94 34 b 98 40 94 42 101 53 b 94 48 95 37 90 32 b 94 37 93 46 96 52 b 91 48 90 35 86 32 b 89 37 89 46 90 53 b 88 47 86 37 82 33 b 86 40 82 42 86 55 b 82 50 83 36 77 35 b 81 41 78 48 81 50 b 77 52 78 39 70 34 b 70 41 77 47 77 48 b 74 46 70 42 67 37 b 64 35 62 35 58 34 b 58 33 58 31 58 30 ")
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