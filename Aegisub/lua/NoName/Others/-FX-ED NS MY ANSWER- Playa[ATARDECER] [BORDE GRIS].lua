include("karaskel.lua")
include("zheolib.lua")
-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "FX Playa >3/3<"
script_description = "Kirav751---> Hecho para el Ending de Naruto Shippuden SEAMO -MY ANSWER >3/3<"
script_author = "Kirav751"
script_version = "1.0"

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
--SILABA ESTATICA
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..bord(1)..color(3,"000000")..estilo(1,line.styleref.color2).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=1
subs.append(l)
--FX DE SILABAS
l = table.copy(line)
l.text = "{"..pos(x,y)..an(5)..color(1,"&H000000&")..move(x,y,x+rand(0),y+rand(0))..t(fscxy(250)..alpha('ff'))..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 2
subs.append(l)

end
end

-------------------------------ACÁ TERMINAN LOS EFECTOS------------------------------------
-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------
aegisub.register_macro("-FX-", "kirav751 :P", fx_Kirav751)
aegisub.register_filter("-FX-", "kirav751 :P", 2000, fx_Kirav751)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN---