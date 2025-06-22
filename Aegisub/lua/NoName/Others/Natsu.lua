include("karaskel.lua")

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Natsu ED"
script_description = "FX Natsu no Sora"
script_author = "nickle"
script_version = "1.1 rev2"

--FUNCIÓN GENERADOR FX
function fx_natsu(subs)
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
				(l.style == "Natsu-furigana" or l.style == "Natsu-Kanji" or l.style == "Natsu-Traducción" or l.style == "Default") then
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
	aegisub.set_undo_point("fx")
end

--TERMINA FUNCION GENERADOR

-------------------------------TERMINA CONFIGURACIONES DE LA MACRO------------------------

-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------
--Funcion Circulos
function circulox(radio,centrox,angulo)
	posx=centrox + radio*math.cos(angulo)
	return posx
end
function circuloy(radio,centroy,angulo)
	posy=centroy + radio*math.sin(angulo)
return posy
end

--CONFIGURACION DE POSICION
function do_fx(subs, meta, line)
	lineas={ }
	posiciones={ }
	--obtenemos el tiempo de inicio de las silabas para guardarlas en un arreglo
		for k = 1, line.kara.n do
		local syl = line.kara[k]
			times=syl.start_time
			posis=syl.width/2
			posiciones[k]=posis
			lineas[k]=times
		end
	
	local sum=1
	for i = 1, line.kara.n do
		local syl = line.kara[i]
		local x=syl.center + line.left
		local y
		actor=line.actor
		if actor=="1" then
			y=line.margin_v + 60
		else
			y=line.margin_v + 30
		end
		if i ==1 then
		tiempo=0
		end
		--FX INICIAL
		l = table.copy(line)
		l.text = string.format("{\\fad(100,0)\\an5\\move(%d,%d,%d,%d)\\bord3\\be3\\blur3\\frx360\\1c&HFFFFFF&\\3c&HFFFFFF&\\t(\\frx360\\1c%s\\3c%s\\bord1\\blur0\\be0\\frx0)}%s",0,y,x,y,line.styleref.color2,line.styleref.color3,syl.text_stripped)
		l.start_time = line.start_time -1000+tiempo
		l.end_time = line.start_time+tiempo
		l.layer=0
		subs.append(l)
		--FX Particulas
		j=i+1
		duracion=syl.duration
		if duracion > 0 and actor~="1" then 
			l = table.copy(line)
			if math.mod(sum,2)==0 then
				mult=-1
			else
				mult=1
			end
			angulo=180
			tstart=0
			tend=lineas[j] --tiempo de la siguente silaba
			spos=posiciones[j] --posiscion de la siguiente silaba
			if tend == nil then
			 tend=syl.duration
			 end
			 if spos==nil then
				spos=syl.width/2
			 end
		    controlx=0
			controly=0
			for r=0,50 do
				if r>25 then
					radio=spos
				else
					radio=syl.width/2
				end
				radangulo=math.rad(angulo)
				posx=circulox(radio,x,radangulo)
				posy=circuloy(radio,y,radangulo)
				l.start_time=line.start_time+syl.start_time+tstart
				l.end_time=line.start_time+tend+tiempo
				if posx~=controlx and controly~=posy then 
					for t=0,2 do
				--3c&HFF7600&
					l.text = string.format("{\\p1\\3a&H64&\\3c&HFFFFFF&\\1a&HFF&\\fad(0,70)\\move(%d,%d,%d,%d)\\an5\\blur3\\bord0.2\\shad0\\fscx150\\fscy150}m 0 0 l 1 0 1 1 0 1{\\p0}",posx,posy,posx+math.random(-10,10),posy+math.random(-10,10))
					subs.append(l)
				--1c&HFF7600&	
					l.text = string.format("{\\p1\\3a&HFF&\\1c&HFFFFFF&\\fad(0,70)\\move(%d,%d,%d,%d)\\an5\\be3\\bord0\\shad0\\fscx150\\fscy150}m 0 0 l 1 0 1 1 0 1{\\p0}",posx,posy,posx+math.random(-10,10),posy+math.random(-10,10))
					subs.append(l)
					end
				end
				angulo=angulo+(mult*3.6)
				tstart=tstart+syl.duration/50
				tend=tend+10
				controlx=posx
				controly=posy
			end
			sum=sum+1
		end	
		--SILABAS ESTATICAS
		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s}%s",x,y,line.styleref.color2,syl.text_stripped)
		l.start_time = line.start_time+tiempo
		l.end_time = line.start_time+syl.start_time
		l.layer=0
		subs.append(l)

		--FX DE SILABAS
		l = table.copy(line)
		for j=1,3 do
			l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\t(\\fscx%d\\fscy%d\\alpha&HFF&\\blur3\\3c&HFFFFFF&))}%s", x, y,line.styleref.color2,135+(j*5),135+(j*5), syl.text_stripped)
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration
			l.layer = 2
			subs.append(l)
		end
		
		tiempo=tiempo+(1000/line.kara.n)
	end
	
end
-------------------------------TERMINA EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("FX Natsu no Sora", "", fx_natsu)
aegisub.register_filter("FX Natsu no Sora", "", 2000, fx_natsu)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------