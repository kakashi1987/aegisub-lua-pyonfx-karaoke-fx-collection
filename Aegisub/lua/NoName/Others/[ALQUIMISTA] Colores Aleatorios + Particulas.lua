-- (Derivado de [[LUA4 FX BASE]] por Zheo~Kami --> http://my.opera.com/zheox/blog/ <-- )
include("karaskel.lua")
-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Colores Aleatorios + Particulas"
script_description = "Script Lua4"
script_author = "Alquimista"
script_version = "1"

--FUNCIÓN GENERADOR FX... NO TOCAR!!!
function fx_zheo(subs)
	aegisub.progress.task("ESPERA MIESTRAS SE HACE EL FX... (Sale a dar una vuelta D:)")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Aplicando tu Cagá de FX D:")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Esto llevo trabajado (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment and
				(l.style == "Default") then
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
--TERMINA FUNCION GENERADOR

-------------------------------TERMINA CONFIGURACIONES DE LA MACRO------------------------

-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

--CONFIGURACION DE X-Y
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 60
if i == 1 then
tempo=0
end

--## COLORES ALEATOREOS
colores ={'F8CDF5', 'E39ECA', 'AD75A9', 'F2E7D9', 'CFAA99'} --'D9E7F2', '99AACF'
rand_color= colores[math.random(1,5)]

--FX INICIAL

--SILABAS ESTATICAS
l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\bord1}%s",x,y,line.styleref.color2,syl.text_stripped)
l.start_time = line.start_time
l.end_time = l.end_time
l.layer=4
subs.append(l)

--blur
l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\bord1\\blur3}%s",x,y,line.styleref.color2,syl.text_stripped)
l.start_time = line.start_time
l.end_time = l.end_time
l.layer=3
subs.append(l)


--FX silaba
l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\t(\\fscx150\\fscy150\\alpha&HFF&\\frz15))}%s", x, y,rand_color, syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 5
subs.append(l)

--FX ya cantada
l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s}%s", x, y, rand_color, syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.end_time
l.layer = 4
subs.append(l)

--FX GLOW
l = table.copy(line)
for i=0,14 do
l.layer=1
l.text = string.format("{\\pos(%d,%d)\\an5\\shad0\\3c&HFFFFFF&\\2c&H56C7E8&\\1a&HFF&\\3a&HF5&\\bord%d\\t(\\bord0\\3c%s)}%s",x,y,1+ i*1,line.styleref.color2,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
subs.append(l)
end


end
end
-------------------------------ACÁ TERMINAN LOS EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("Coloresfx", "", fx_zheo)
aegisub.register_filter("Coloresfx", "", 2000, fx_zheo)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------