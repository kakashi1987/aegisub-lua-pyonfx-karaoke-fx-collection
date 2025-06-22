include("karaskel.lua")
include("zheolib.lua")
include("formaslib.lua")

script_name = "SHINE"
script_description = "SHINE FX"
script_author = "JAMPY1990 (FIX('KFDS'))"
script_version = "0.8.1 Beta"


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
				(l.style == "1") then --Acá se puede cambiar por el nombre del Estilo que quieras
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
	aegisub.set_undo_point("fx_kXc")
end


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

			
         l = copy_line(line)
         l.layer = 0 
         l.text = string.format("{\\pos(%d,%d)\\be2}%s",x,y,syl.text)
         l.start_time = line.start_time
         l.end_time = line.start_time + syl.start_time
         subs.append(l)

         l = copy_line(line)
         l.layer = 0 
         l.text = string.format("{\\pos(%d,%d)\\t(\\1c%s)\\be2}%s",x,y,ass_color(extract_color(line.styleref.color2)),syl.text)
         l.start_time = line.start_time + syl.start_time
         l.end_time = line.start_time + syl.end_time
         subs.append(l)

         l = copy_line(line)
         l.layer = 0 
         l.text = string.format("{\\pos(%d,%d)\\1c%s\\be2}%s",x,y,ass_color(extract_color(line.styleref.color2)),syl.text)
         l.start_time = line.start_time + syl.end_time
         l.end_time = line.end_time
         subs.append(l)
	
	local n = 15

	local r1, g1, b1 = extract_color(line.styleref.color1)
	local r2, g2, b2 = extract_color(line.styleref.color2)
		
	local r12 = (r1 - r2) / n
	local g12 = (g1 - g2) / n
	local b12 = (b1 - b2) / n

	for i = 1, n do
			
		local color = ass_color(r1 - r12 * i, g1 - g12 * i, b1 - b12 * i)
		
		local fscy = 105 + i * 5
		local fscx = 100 + i

                syl.pre_string = ""

                for i = 1, syl.i - 1 do
	
	        syl.pre_string = syl.pre_string .. line.kara[i].text
	
              end

                syl.post_string = ""

                for i = syl.i + 1, line.kara.n do
	
	        syl.post_string = syl.post_string .. line.kara[i].text
	
           end
		
		l = copy_line(line)
                l.layer = i
                l.text = string.format("{\\pos(%d,%d)\\blur1\\bord0\\fscx%d\\fscy%d\\1c%s}{\\alpha&HFF&}%s{\\alpha&HE0&\\t(\\alpha&HFF&)}%s{\\alpha&HE0&}%s",line.center,y-i/7.5,fscx,fscy,color,syl.pre_string,syl.text,syl.post_string)
                l.start_time = line.start_time + syl.start_time
                l.end_time = line.start_time + syl.end_time
                subs.append(l)
			
	end


end
end

-------------------------------ACÁ TERMINAN LOS EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("SHINE - Prueba", "Exportando con Exito", fx_zheo)
aegisub.register_filter("SHINE - Prueba", "Exportando con Exito", 2000, fx_zheo)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------