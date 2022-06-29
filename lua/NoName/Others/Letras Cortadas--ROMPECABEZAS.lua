***************************************************************************************************
* DErechos de Autor: ninguno por que no cobro!! XDDD
*Autores : Jampy1990 y el super Zheo
*requisitos haber comentado!!(fundamental)
*y tener mi msn !!! XDDDD jajaja
*._.
*._.
****************************************************************************************************


include("karaskel.lua")
include("zheolib.lua") --AHORA AGREGAMOS LA LIBRERIA :D

script_name = "Cherish"
script_description = "Script Lua4 con Zheolib.lua"
script_author = "Zheo"
script_version = "1.9.0 Rev2"

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------
-- ## FUNCIÓN GENERADOR FX  NO TOCAR !
function fx_zheo(subs)
	aegisub.progress.task("ESPERA MIESTRAS SE HACE EL FX... (Sale a dar una vuelta D:)")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Aplicando tu FX D:")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Esto llevo trabajado (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment and
				(l.style == "karaoke sha la la") then --Acá se puede cambiar por el nombre del Estilo que quieras
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
-- ## CONFIGURACION DE X-Y
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 25

-- ## AGREGAMOS TAMBIEN ESTA FUNCIÓN
function sil()
silaba = ""..syl.text_stripped..""
return silaba
end

-------------------------------TERMINA LA CONFIGURACIÓN BÁSICA-----------------------------
-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

direction = 1

l = table.copy(line)
l.layer = 0 
l.text = "{"..pos(x,y)..be(2).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time + syl.start_time
subs.append(l)

if unicode.len(sil()) == 1 then
	
	k = 2
	
else 
	
	k = 3
	
end

syl.clip_width = (syl.width + k*2)/k
syl.clip_top = y - line.height/2
syl.clip_bottom = y + line.height/2

for i = 1, k do
	
	syl.clip_left = line.left + syl.left + syl.clip_width*(i-1) - 2
	syl.clip_right = syl.clip_left + syl.clip_width
	
	if direction == 1 then
		
		l = table.copy(line)
		l.layer = 0 
		l.text = "{"..pos(x,y)..be(2)..clip(syl.clip_left,syl.clip_top,syl.clip_right,syl.clip_bottom)..t(clip(syl.clip_left,syl.clip_bottom,syl.clip_right,syl.clip_bottom)..color(1,line.styleref.color2)).."}"..sil()
		l.start_time = line.start_time + syl.start_time
		l.end_time = line.start_time + syl.end_time
		subs.append(l)
		
		l = table.copy(line)
		l.layer = 0 
		l.text = "{"..pos(x,y)..be(2)..clip(syl.clip_left,syl.clip_top,syl.clip_right-2,syl.clip_top)..t(clip(syl.clip_left,syl.clip_top,syl.clip_right-2,syl.clip_bottom)..color(1,line.styleref.color2)).."}"..sil()	
		l.start_time = line.start_time + syl.start_time
		l.end_time = line.start_time + syl.end_time
		subs.append(l)
		
	else
		
		l = table.copy(line)
		l.layer = 0 
		l.text = "{"..pos(x,y)..be(2)..clip(syl.clip_left,syl.clip_top,syl.clip_right,syl.clip_bottom)..t(clip(syl.clip_left,syl.clip_top,syl.clip_right,syl.clip_top,syl.cilp_bottom)..color(1,line.styleref.color2)).."}"..sil()
		l.start_time = line.start_time + syl.start_time
		l.end_time = line.start_time + syl.end_time
		subs.append(l)
		
		l = table.copy(line)
		l.layer = 0 
		l.text = "{"..pos(x,y)..be(2)..clip(syl.clip_left,syl.clip_bottom,syl.clip_right-2,syl.clip_bottom)..t(clip(syl.clip_left,syl.clip_top,syl.clip_right-2,syl.clip_bottom)..color(1,line.styleref.color2)).."}"..sil()
		l.start_time = line.start_time + syl.start_time
		l.end_time = line.start_time + syl.end_time
		subs.append(l)
				
	end
	
	direction = 1 - direction
	
	if syl.i ~= line.kara.n then
		
		syl.clip_direction = (-1)^math.random(0,1)
		syl.clip_y = y+syl.clip_direction*math.random(7,13)
		syl.clip_end_time = line.start_time + line.kara[syl.i+1].end_time
		
		if line.kara[syl.i+1].text == " " or line.kara[syl.i+1].text == "" then
			
			syl.clip_end_time = syl.clip_end_time + line.kara[syl.i+2].duration
			
		end
		
		l = table.copy(line)
		l.layer = 0 
		l.text = "{"..move(x,y,x,syl.clip_y)..color(1,line.styleref.color2)..be(2)..clip(syl.clip_left,0,syl.clip_right-2,meta.res_y).."}"..sil()
		l.start_time = line.start_time + syl.end_time
		l.end_time = syl.clip_end_time
		subs.append(l)
		
		l = table.copy(line)
		l.layer = 0 
		l.text = "{"..pos(x,y)..be(2)..t(clip(syl.clip_left,0,syl.clip_right-2,meta.res_y,syl)..color(1,line.styleref.color2)).."}"..sil()
		l.start_time = syl.clip_end_time
		l.end_time = line.end_time
		subs.append(l)
		
	end
			
end

-------------------------------ACÁ TERMINAN LOS EFECTOS------------------------------------
end
end
-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------
aegisub.register_macro("JR-F FX!", "Aplica tu FX! D:", fx_zheo)
aegisub.register_filter("JR-F FX!", "Aplica tu FX! D:", 2000, fx_zheo)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN---
