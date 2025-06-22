include("karaskel.lua") -- ESTE SIEMPRE SE DEBE DE AGREGAR !!!
include("zheolib.lua") --AHORA AGREGAMOS LA LIBRERIA :D !!

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "ending9"
script_description = "ending9"
script_author = "bunshin"
script_version = "2.0"

-- ## FUNCIÓN GENERADOR FX... NO TOCAR!!!
function fx_kXc(subs)
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
l.text = "{"..fad(100,0)..an(5)..pos(x,y)..bord(2)..color(1,'ffffff')..estilo(1,line.styleref.color1)..bord(1).."}"..sil()
l.start_time = line.start_time -400
l.end_time = line.start_time
l.layer=0
subs.append(l)


--Silaba estatica 1 - borde negro
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..bord(1)..color(3,"&H747482&")..estilo(1,line.styleref.color2).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=1
subs.append(l)



--FX DE SILABAS(ESTE SE AGRANDA LA SILABA)
l = table.copy(line)
for j= 0,1 do 
l.text = "{"..move(x+20,y-20,x-20,y+20)..an(5)..pos(x,y)..fscxy(900)..color(1,RandomColor())..t(color(1,RandomColor())).."}"..p(4,"m 0 0 m 10 20 b 16 20 20 16 20 10 b 20 4 16 0 10 0 b 2 0 0 6 0 10 b 0 16 4 20 10 20 ")
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 1
subs.append(l)

--FX DE SILABAS(ESTE SE AGRANDA LA SILABA)
l = table.copy(line)
l.text = "{"..move(x,y,x-20,y+20)..an(5)..pos(x,y)..color(1,RandomColor())..bord(1)..t(fscxy(100)..color(1,RandomColor())..alpha('ff')).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration+500
l.layer = 2
subs.append(l)
end
end
end

-------------------------------ACÁ TERMINAN LOS EFECTOS------------------------------------
-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACION--------------
aegisub.register_macro("ending9", "Aplica tu FX! D:", fx_kXc)
aegisub.register_filter("ending9", "Aplica tu FX! D:", 2000, fx_kXc)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN---