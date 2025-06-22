--[[

]]

include("karaskel.lua")

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "border FX"
script_description = "Script Lua"
script_author = "alquimista"
script_version = "1"

--FUNCIÓN GENERADOR FX
function fx_test(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
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
		local y=line.margin_v + 25
		if i ==1 then
			tiempo=0
		end
		
--FX INICIAL
			

				l = table.copy(line)
		l.text = string.format("{\\fad(500,0)\\an5\\move(%d,%d,%d,%d)\\bord0.5\\be0\\blur2\\fry360\\1c&HFFFFFF&\\\t(\\frx0\\bord0\\blur0\\be0\\fry0\\fscy8\\fscx8\\fad(300,100)\\3a&H8200&)}{\\p1}m 50 -80 l 59 31 l 67 41 l 129 50 l 67 60 l 59 68 l 50 187 l 43 68 l 38 60 l -30 51 l 37 38 l 43 29 {\\p0}",x+10,0,x,y,line.styleref.color1,line.styleref.color3,syl.text_stripped)
		l.start_time = line.start_time -3000+tiempo+(syl.duration/2)
		l.end_time = line.start_time+tiempo
		l.layer=0
		subs.append(l)
		
		
					l = table.copy(line)
		l.text = string.format("{\\fad(500,0)\\an5\\move(%d,%d,%d,%d)\\bord0\\be0\\blur9\\fry360\\1c&HFFFFFF&\\\t(\\frx0\\bord0\\blur9\\be0\\fry0\\fscy14\\fscx14\\fad(300,100)\\3a&H8200&)}{\\p1}m 2 -47 l 11 -43 l 16 -31 l 15 -19 l 14 -13 l 9 -6 l 1 -3 l -7 -5 l -14 -10 l -16 -21 l -16 -35 l -10 -44 {\\p0}",x+10,0,x,y,line.styleref.color1,line.styleref.color3,syl.text_stripped)
		l.start_time = line.start_time -3000+tiempo+(syl.duration/2)
		l.end_time = line.start_time+tiempo
		l.layer=0
		subs.append(l)
		
	l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s}%s",x,y,line.styleref.color1,syl.text_stripped)
		l.start_time = line.start_time+tiempo
		l.end_time = line.start_time+syl.start_time
		l.layer=2
		subs.append(l)
		
		
	l = table.copy(line)
		l.text = string.format("{\\fad(100,0)\\an5\\move(%d,%d,%d,%d)\\bord1\\be0\\fscy20\\fscx20\\t(\\fscy100\\fscx100\\bord2))}%s",x,y-25,x,y,syl.text_stripped)
		l.start_time = line.start_time - 500
		l.end_time = line.start_time
		l.layer=1
		subs.append(l)
		
		
--SILABAS ESTATICAS (2)

	
		
		
	l = table.copy(line)
for j=0,10 do
    star_pos_x = {'5', '10', '15', '20', '25', '-5', '-10', '-15', '-20', '-25', '0'}
    star_pos_y = {'0', '-25', '-20', '-15', '-10', '-5', '25', '20', '15', '10', '5'}
    if syl.duration == 20 then
    rot_z = 360
    else
    rot_z = 360
    end
    l.layer = 20
    l.text = string.format("{\\fad(10,100)\\org(%d,%d)\\bord0\\shad0\\an5\\move(%d,%d,%d,%d)\\1c&HFFFFFF&\\fscx40\\fscy50\\t(\\frz20)}{\\p1}m 0 0 l 0 -13 l 1 0 l 14 -7 l 2 1 l 14 7 l 1 2 l 1 15 l 0 2 l -13 7 l -1 1 l -13 -7 {\\p0}", x,y,x,y,x+math.random(star_pos_x[j*1+1],30),y+star_pos_y[j*1+1], math.random(35,500), math.random(-5,5), rot_z, syl.text_stripped)
    l.start_time=line.start_time+syl.start_time
    l.end_time=l.start_time+(syl.duration*2)+math.random(syl.duration, syl.duration*2)
    subs.append(l)
end
	

--FX DE SILABAS



--FX DE salida
	
		l = table.copy(line)
		for i = 0,2 do
		l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\bord0\\fscy100\\fscx100\\t(\\fscy180\\fscx180\\bord3\\3c&HFFFFFF&\\alpha&HFF&\\blur5\\)}%s", x+(i+2), y,x-15,y, syl.text_stripped)
        l.start_time=line.start_time+syl.start_time+math.random(-100,300)
		l.end_time=line.start_time+syl.start_time+syl.duration+math.random(200,350)
	   l.layer=20
		subs.append(l)
		end
		
			l = table.copy(line)
		for i = 0,2 do
		l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\bord0\\fscy100\\fscx100\\t(\\fscy170\\fscx170\\bord3\\3c&HFFFFFF&\\alpha&HFF&\\blur5\\)}%s", x+(i+2), y,x-30,y, syl.text_stripped)
        l.start_time=line.start_time+syl.start_time+math.random(-100,300)
		l.end_time=line.start_time+syl.start_time+syl.duration+math.random(200,350)
	   l.layer=20
		subs.append(l)
		end
end
end


-------------------------------TERMINA EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("Sadie_FX", "", fx_test)
aegisub.register_filter("Sadie FX", "", 2000, fx_test)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------