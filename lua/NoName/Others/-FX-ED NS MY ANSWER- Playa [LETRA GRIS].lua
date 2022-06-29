include("karaskel.lua")

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "FX Playa >1/3<"
script_description = "Kirav751---> Hecho para el Ending de Naruto Shippuden SEAMO -MY ANSWER >1/3<"
script_author = "Kirav75"
script_version = "1.0"

--FUNCIÓN GENERADOR FX
function fx_kirav751(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Aplicando (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment and 
				(l.style == "ED_1" or l.style == "ED_3")then
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
local inicio=syl.start_time
local fin=syl.end_time
local medio=syl.start_time + syl.duration / 2
if i ==1 then
tiempo=0
else
y=line.margin_v + 35
		
--FX INICIAL
l = table.copy(line)
l.text = string.format("{\\fad(100,0)\\an5\\be3\\pos(%d,%d)\\frx360\\bord0\\1c&HFFFFFF&\\t(\\frx360\\be0\\1c%s\\bord1)}%s",x,y,line.styleref.color1, syl.text_stripped)
l.start_time=line.start_time-800+tiempo
l.end_time=line.start_time
l.layer=0
subs.append(l)
		
		
--SILABAS ESTATICAS+efecto+salida
l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\blur0\\be5\\1c%s\\fad(0,200)\\fscx100\\fscy100\\t(%d,%d,\\1c%s\\fscx200\\fscy200\\blur5\\be5\\bord3)\\t(%d,%d,\\1c%s\\fscx100\\fscy100\\blur0\\be0\\bord1)}%s",x,y,line.styleref.color1,inicio,medio,line.styleref.color2,medio,fin,line.styleref.color1,syl.text_stripped)
l.end_time=line.end_time-300+tiempo
l.layer='1'
subs.append(l)

end
end	
end
-------------------------------TERMINA EFECTOS----------------------------------------------------

-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("-FX-", "Kirav751 :P", fx_kirav751)
aegisub.register_filter("-FX-", "Kirav751 :P", 2000, fx_kirav751)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------