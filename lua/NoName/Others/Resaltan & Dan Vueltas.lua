include("karaskel.lua")

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Resaltan & Dan Vueltas"
script_description = "Kirav FX"
script_author = "Kirav751"
script_version = "0.1"

--FUNCIÓN GENERADOR FX... NO TOCAR!!!
function fx_zheo(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Creando Efecto")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Wait (%d/%d)...", ai, maxai))
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
	aegisub.progress.task("D: Acabo la wea!")
	aegisub.progress.set(100)
	aegisub.set_undo_point("fx_Aoi")
end
--TERMINA FUNCION GENERADOR

-------------------------------TERMINA CONFIGURACIONES DE LA MACRO------------------------

-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

--CONFIGURACION DE X-Y
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 40
if i ==1 then
tiempo=0
end
--FX INICIAL
	l = table.copy(line)
		l.text = string.format("{\\fad(100,0)\\an5\\move(%d,%d,%d,%d)\\bord2\\be3\\blur3\\fry90\\1c&HFFFFFF&\\3c&HFFFFFF&\\t(\\frx360\\1c%s\\3c%s\\bord1\\blur0\\be2\\fry5)}%s",x-10,0,x,y,line.styleref.color1,line.styleref.color3,syl.text_stripped)
		l.start_time = line.start_time -1000+tiempo
		l.end_time = line.start_time+tiempo
		l.layer=0
		subs.append(l)

l = table.copy(line)
			for i=0, 2 do
				if i==0 then
					tiempoi=0
				end
	--Rayos Electricos			
			l.text = string.format("{\\p1\\an5\\be6\\bord0\\shad0\\1c&HCFA837&\\move(%d,%d,%d,%d)\\fscx100\\fscy100\\t(\\fscx25\\fscy25)\\t(\\fscx25\\fscy25\\frx25)}m 0 0  {\\p0}",x-syl.width/2,y,x+syl.width/2,y,syl.text_stripped)
			l.start_time=line.start_time+syl.start_time+tiempoi
			l.end_time=l.start_time+syl.duration+tiempoi
			subs.append(l)
				--Tiempos de salida de los circulos
				if syl.duration<170 then
				tiempoi=tiempoi+60
				elseif syl.duration<230 then
				tiempoi=tiempoi+70
				elseif syl.duration<300 then
				tiempoi=tiempoi+syl.duration/4
				else
				tiempoi=tiempoi+80
				end
			
			end
		
--SILABAS ESTATICAS
l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s}%s",x,y,line.styleref.color1,syl.text_stripped)
		l.start_time = line.start_time+tiempo
		l.end_time = line.start_time+syl.start_time
		l.layer=2
		subs.append(l)
		
		l = table.copy(line)
for j=0,10 do
    star_pos_x = {'5', '10', '15', '20', '25', '-5', '-10', '-15', '-20', '-25', '0'}
    star_pos_y = {'0', '-25', '-20', '-15', '-10', '-5', '25', '20', '15', '10', '5'}
    if syl.duration == 20 then
    rot_z = 360
    else
    rot_z = 360
    end
    l.layer = 4
    l.text = string.format("{\\fad(10,100)\\org(%d,%d)\\bord0\\shad0\\an5\\move(%d,%d,%d,%d)\\1c&HBC65DD&\\fscx40\\fscy50\\t(\\frz20)}{\\p1}m -7 7 m -10 7 b -10 3 -4 3 -4 7 b -4 12 -10 12 -10 7  {\\p0}", x,y,x,y,x+math.random(star_pos_x[j*1+1],30),y+star_pos_y[j*1+1], math.random(-30,100), math.random(50,100), rot_z, syl.text_stripped)
    l.start_time=line.start_time+syl.start_time
    l.end_time=l.start_time+(syl.duration*2)+math.random(syl.duration, syl.duration*2)
    subs.append(l)
end
			
--FX DE SILABAS
l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\&HFFFCA4&\\bord0\shad0\\t(\\fscx30\\fscy120))}%s", x, y, line.styleref.color2, syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 2
subs.append(l)

l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\&HFFFCA4&\\bord3\shad0\\t(\\fscx150\\fscy380\\\\fscx75\\fscy75\\alpha&HFF&\\frz360))}%s", x, y, line.styleref.color2, syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 2
subs.append(l)

l = table.copy(line)
for i=0,14 do
l.layer=0
l.text = string.format("{\\pos(%d,%d)\\an5\\shad0\\3c&HFFFFFF&\\1a&HFF&\\3a&HF5&\\bord%d\\t(\\bord5\\3c%s)}%s",x,y,1+ i*1,line.styleref.color2,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
subs.append(l)
end

end
end
-------------------------------ACÁ TERMINAN LOS EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("GxF FX!", "Aplica el FX!", fx_zheo)
aegisub.register_filter("GxF FX!", "Aplica el FX!", 2000, fx_zheo)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------