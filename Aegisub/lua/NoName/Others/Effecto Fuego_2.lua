include("karaskel.lua")
include("zheolib.lua")

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Llama"
script_description = "Efecto de llamas de fuego"
script_author = "sami_sonic"
script_version = "1.0"

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
				(l.style == "Romanji") then
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
--	aegisub.set_undo_point("fx_zheo")
end
--TERMINA FUNCION GENERADOR

-------------------------------TERMINA CONFIGURACIONES DE LA MACRO------------------------

-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

--CONFIGURACION DE X-Y
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 25
function sil()
silaba = ""..syl.text_stripped..""
return silaba
end

--DECLARANDO MODIFICADOR DE TIEMPO INICIAL
if i ==1 then
tiempo=0
end
tiempo=tiempo+(1000/line.kara.n)

--FX INICIAL
l = table.copy(line)
l.text = "{"..fad(300,0)..an(5)..pos(x,y)..color(1,"FFFFFF")..bord(2).."}"..sil()
l.start_time = line.start_time - 300 + tiempo
l.end_time = line.start_time + tiempo
l.layer=0
subs.append(l)

--SILABAS ESTATICAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..color(1,"FFFFFF")..color(3,"000000")..bord(2).."}"..sil()
l.start_time = line.start_time + tiempo
l.end_time = line.start_time + syl.start_time
l.layer=0
subs.append(l)

--FX COMBUSTION
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..bord(2)..color(1,"FFFFFF")..color(3,"000000")..t(color(1,"000000")..color(3,"888888")).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=0
subs.append(l)

--FX BORDE LLAMA (GLOW ROJO)
l = table.copy(line)
for i=0,14 do
l.text = "{"..pos(x,y)..an(5)..color(3,"0000FF")..alfa(1,"FF")..alfa(3,"F5")..bord(1+ i*1)..t(bord(0)).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=1
subs.append(l)
end

--FX PARTE SUPERIOR LLAMA (GLOW AMARILLO CON DEGRADO)
l = table.copy(line)
maxfor=8
for i=0,maxfor do
cx1 = 0
cx2 = 640 -- ancho video
if i == 0 then
cy1 = l.top - maxfor -- borde alto de la sílaba - glow
else
cy1 = l.top + (((syl.height - 2)/maxfor) * i) -- parte superior del degrado
end
cy2 = l.top + syl.height - 2
l.text = "{"..pos(x,y)..an(5)..color(3,"00FFFF")..alfa(1,"FF")..bord(1+ i*1)..t(bord(0))..clip(cx1, cy1, cx2, cy2)..RangeAlpha(3, i/syl.height,'FF', '00').."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=2
subs.append(l)
end

--FX PARTE INFERIOR LLAMA (GLOW AMARILLO CON DEGRADO)
l = table.copy(line)
maxfor=8
for i=0,maxfor do
inv = maxfor - i
cx1 = 0
cx2 = 640 -- ancho video
cy1 = l.top + syl.height - 2 -- parte superior del degrado
if i == 0 then -- cy2
cy2 = l.top + syl.height + maxfor -- borde bajo de la sílaba + glow
else
cy2 = l.top + syl.height + ((((syl.height + maxfor) - (syl.height - 2))/maxfor) * inv) -- parte inferior del degrado
end
l.text = "{"..pos(x,y)..an(5)..color(3,"00FFFF")..alfa(1,"FF")..bord(1+ i*1)..t(bord(0))..clip(cx1, cy1, cx2, cy2)..RangeAlpha(3, i/syl.height,'FF', '00').."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=2
subs.append(l)
end

--FX CENIZA
ceny = l.top+syl.height+3
l = table.copy(line)
l.text = "{"..an(2)..pos(x,ceny)..color(1,"000000")..color(3,"888888")..t(tt(0,syl.duration+300)..fscy(5)..alpha("FF")).."}"..sil()
l.start_time=line.start_time+syl.start_time+syl.duration
l.end_time=l.start_time+syl.duration+300
l.layer = 0
subs.append(l)

end
end
-------------------------------ACÁ TERMINAN LOS EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("JR-F FX!", "Aplica tu FX! D:", fx_zheo)
aegisub.register_filter("JR-F FX!", "Aplica tu FX! D:", 2000, fx_zheo)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------