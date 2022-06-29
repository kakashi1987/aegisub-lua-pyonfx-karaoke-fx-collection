include("karaskel.lua") -- ESTE SIEMPRE SE DEBE DE AGREGAR !!!
include("zheolib.lua") --AHORA AGREGAMOS LA LIBRERIA :D !!
include("formaslib.lua") -- AGREGAMOS EL FORMASLIB !!

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Border FX"
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
for j = 1,1 do
	l.text = "{"..pos(x,y)..an(5)..color(1,"&H000000&")..move(x,y,x+rand(0),y+rand(0))..t(fscxy(250)..alpha('ff'))..blur(5).."}"..p(2,"m 77 48 b 50 60 41 -3 -2 85 b 6 74 12 63 22 53 b 12 65 18 64 6 84 b 16 76 20 64 26 54 b 18 64 25 66 13 82 b 24 76 22 60 31 52 b 25 59 27 71 22 81 b 29 76 30 56 35 52 b 32 61 32 71 30 83 b 34 73 35 60 42 53 b 36 63 42 66 35 85 b 44 79 40 58 49 56 b 45 65 48 76 45 79 b 50 81 48 62 58 54 b 57 64 50 72 50 76 b 53 71 58 67 62 58 b 66 56 71 55 76 54 b 76 52 77 50 77 48 m 82 48 b 109 60 118 -4 161 85 b 152 74 147 62 138 52 b 147 64 141 63 153 84 b 143 76 140 63 134 54 b 141 63 134 66 146 82 b 135 76 137 59 129 51 b 134 58 132 71 138 81 b 130 76 129 55 124 51 b 128 60 128 71 129 83 b 126 73 124 59 117 52 b 123 63 117 66 124 85 b 116 79 119 57 110 55 b 115 65 111 76 115 79 b 109 81 111 62 101 54 b 101 64 109 72 109 76 b 106 71 101 67 97 58 b 92 56 88 55 83 54 b 83 52 82 50 82 48 ")
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


-------------------------------ACÁ TERMINAN LOS EFECTOS------------------------------------
-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------
aegisub.register_macro("GxF!", "Aplica tu FX! D:", fx_Kirav751)
aegisub.register_filter("GxF!", "Aplica tu FX! D:", 2000, fx_Kirav751)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN---