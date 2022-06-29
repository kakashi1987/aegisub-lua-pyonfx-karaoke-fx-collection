include("karaskel.lua")

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "OP Kemeko"
script_description = "Fx Kemeko OP"
script_author = "nickle"
script_version = "0.5"

--FUNCIÓN GENERADOR FX
function fx_kemekop(subs)
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
	for i = 1, line.kara.n do
		local syl = line.kara[i]
		local x=syl.center + line.left
		local y=line.margin_v + 30
		--CIRCULOS
		l = table.copy(line)
		for h=0,14 do
			posicion={-10,0,10}
			tiempo={0,25,50,100}
			--posi=posicion[math.random(1,7)]
			if h<4 then
				tiempoe=line.start_time+syl.start_time
				tiempos=tiempoe+syl.duration+300
				px=x+posicion[math.random(1,3)]
				py=y+posicion[math.random(1,3)]
				radio=25
			else						
				tiempoe=line.start_time+syl.start_time+syl.duration/3+300+tiempo[math.random(1,4)]
				if syl.duration<300 then
				tiempos=tiempoe+syl.duration+math.random(500,900)
				elseif syl.duration>800 then
				tiempos=tiempoe+syl.duration/2+math.random(300,700)
				else
				tiempos=tiempoe+syl.duration+math.random(300,700)
				end
				px=x+math.random(-30,30)
				py=y+math.random(-30,30)					
				radio=15
			end
			for r=0,19 do
					if r==0 then
						p=0
					end
				angulo=math.rad(p)
				l.text = string.format("{\\p1\\fad(150,100)\\be0\\an5\\alpha&H96&\\move(%d,%d,%d,%d,)\\1c%s\\3c&HFFFFFF&\\fscx200\\fscy200\\bord0\\t(\\b3)}m 0 0 l 0 1 1 1 1 0{\\p0}",circulox(0,px,angulo),circuloy(0,py,angulo),circulox(radio,px,angulo),circuloy(radio,py,angulo),line.styleref.color3)
				l.start_time=tiempoe
				l.end_time=tiempos
				l.layer = 0
				subs.append(l)
				p=p+18	
			end
		end
		--"Mecha"
		l = table.copy(line)
		for rr=0,15 do
			if rr==0 then
				tiempo=600
			end
				l.text = string.format("{\\p1\\fad(100,50)\\be2\\bord1\\blur2\\alpha&h96&\\an5\\bord0\\shad0\\1c%s\\move(%d,%d,%d,%d)\\fscx100\\fscy100}m 3 5 b 4 5 5 4 5 2 b 5 1 4 0 3 0 b 1 0 0 1 0 2 b 0 4 1 5 3 5{\\p0}",line.styleref.color3,x,y+70,x,y)
				l.start_time=line.start_time+syl.start_time-tiempo
				l.end_time=line.start_time+syl.start_time
				tiempo=tiempo-10
				l.layer = 1
				subs.append(l)
		end
		--Efecto entrada
		if i ==1 then
			tie=0
		end
		l = table.copy(line)
		l.text=string.format("{\\an5\\move(%d,%d,%d,%d)\\fr360\\fad(170,0)\\be3\\blur3\\1c&HFFFFFF&\\3c&HFFFFFF&\\t(\\be0\\blur0\\1c%s\\3c%s\\fr0)}%s",x,y-20,x,y,line.styleref.color2,line.styleref.color3,syl.text_stripped)
		l.start_time=line.start_time-500+tie
		l.end_time=line.start_time+tie
		subs.append(l)
		--SILABAS ESTATICAS
		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s}%s",x,y,line.styleref.color2,syl.text_stripped)
		l.start_time = line.start_time+tie
		l.end_time = line.start_time+syl.start_time
		l.layer=4
		subs.append(l)
		--Efecto
		l = table.copy(line)
		for g=0, 7 do
			l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\fsp0\\be0\\blur0\\t(\\blur3\\bord3\\be3\\fscx%d\\fscy%d\\alpha&HFF&\\1c&HFFFFFF&\\3c&HFFFFFF&)}%s",x,y+3,line.styleref.color2,140+(g*15),140+(g*15),syl.text_stripped)
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration
			l.layer=3
			subs.append(l)
		end
		tie=tie+(1000/line.kara.n)
	end
	
end
-------------------------------TERMINA EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("FX Kemeko OP", "", fx_kemekop)
aegisub.register_filter("FX Kemeko OP", "", 2000, fx_kemekop)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------