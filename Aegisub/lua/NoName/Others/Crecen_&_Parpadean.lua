include("karaskel.lua")

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Crecen & Parpadean"
script_description = "Script Lua"
script_author = "Kirav751"
script_version = "1.0"

--FUNCIÓN GENERADOR FX
function fx_test(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)
	aegisub.progress.task("Creando Efecto")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Aplicando el Efecto(%d/%d)...", ai, maxai))
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
	aegisub.progress.task("¡Listo!")
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
	randfrz= math.random(-20,20)
		l = table.copy(line)
		l.text = string.format("{\\fad(100,0)\\an5\\move(%d,%d,%d,%d)\\bord3\\be3\\blur3\\frz%d\\1c&HFFFFFF&\\t(\\frx1080\\1c%s\\3c%s\\bord2\\blur0\\be0\\frx360)}%s",x-100,50,x,y,randfrz,line.styleref.color2,line.styleref.color3,syl.text_stripped)
		l.start_time = line.start_time -1000+tiempo
		l.end_time = line.start_time+tiempo
		l.layer=0
		subs.append(l)
		
		l = table.copy(line)


--SILABAS ESTATICAS (2)
		l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s}%s",x,y,line.styleref.color1,syl.text_stripped)
		l.start_time = line.start_time+tiempo
		l.end_time = line.start_time+syl.start_time
		l.layer=2
		subs.append(l)

		
--FX DE SILABAS
	l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\3c%s\\bord2\\be15\\1a&HFFFFFF&\\t(\\3a&H8200&\\fscx200\\fscy200)}%s", x,y, line.styleref.color2, syl.text_stripped)
		l.start_time=line.start_time+syl.start_time
		l.end_time=l.start_time+syl.duration+100
		l.layer = 1
		subs.append(l)
		
			
		
				
		tiempo=tiempo+(1000/line.kara.n)


l = table.copy(line)
for i=0,40 do
l.text = string.format("{\\alpha&HA0B0C0&\\move(%d,%d,%d,%d)\\fad(0,500)}%s",x,y,x-math.random(-60,60),y-math.random(-60,60),syl.text_stripped)
l.start_time = line.start_time+syl.start_time-250
l.end_time = l.start_time+syl.start_time+500
l.layer=3
subs.append(l)
end
	end
	
end
-------------------------------TERMINA EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("-EFECTO-", "", fx_test)
aegisub.register_filter("-EFECTO-", "", 2000, fx_test)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------