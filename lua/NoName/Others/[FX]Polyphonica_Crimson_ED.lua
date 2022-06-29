include("karaskel.lua")
include("zheolib.lua")
-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Polyphonica Crimson ED"
script_description = "FX Polyphonica Crimson ED"
script_author = "nickle"
script_version = "1.2"

--FUNCIÓN GENERADOR FX

	
function fx_crimison(subs)
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

--CONFIGURACION DE POSICION
function do_fx(subs, meta, line)
	for i = 1, line.kara.n do
		local syl = line.kara[i]
		local x=syl.center + line.left
		local y=line.margin_v + 12
		local actor=line.actor
			
		if i==1 then
			modi_tiempo=0
		end	
		
		function sil()
			silaba = ""..syl.text_stripped..""
			return silaba
		end
		--color(3,'5496CF')
		if actor=='rom' or actor=='kan' then
		
			if actor=='kan' then
				y=y+29
			end			
					
			posicion_anterior=0
			longsil=string.len(sil())
			modt=0
			modtend=0
			for char in unicode.chars(sil()) do
				--Metricas de caracter
				tam_caracter=aegisub.text_extents(line.styleref,char) --obtenemos la longitud del caracter
				x_individual=line.left + syl.left +tam_caracter/2+posicion_anterior --Posicionamos nuestro carácter
									
				l = table.copy(line) 	
				l.start_time=line.start_time-1000+modi_tiempo+modt
				l.end_time=line.start_time+modi_tiempo+modtend-130
				l.text = "{"..an(5)..alpha('FF')..move(x+5,y+10,x_individual,y,0,500)..org(x+30,y+20)..frxyz(150,50,200)..bord(0)..shad(1)..fscxy(100)..color(1,line.styleref.color2)..t(alpha('00')..frxyz(0,0,0)).."}"..char
				l.layer=1
				subs.append(l)
														
				--enfasis
										
				l = table.copy(line)
				iniEnf=line.start_time+syl.start_time+modt-130
				finEnf=line.start_time+syl.end_time+modt
				l.start_time=iniEnf
				l.end_time=finEnf
				duracion=finEnf-iniEnf			
				l.text = "{"..an(5)..pos(x_individual,y)..bord(0)..shad(1)..fscxy(100)..color(1,line.styleref.color2)..color(3,'E3C7FF')..t(tt(0,duracion/2)..fscxy(110)..bord(1)..blur(3))..t(tt(duracion/2,duracion)..fscxy(100)..bord(0)..blur(0)).."}"..char
				l.layer=3
				subs.append(l)
												
				--salida
										
				l = table.copy(line)
				l.start_time=line.start_time+modi_tiempo+modtend-130
				l.end_time=line.end_time+modi_tiempo+600+modtend
				diferencia=l.end_time-l.start_time
				l.text = "{"..an(5)..move(x_individual,y,x_individual-5,y+10,diferencia-400,diferencia)..org(x-30,y+20)..alpha('00')..frxyz(0,0,0)..bord(0)..shad(1)..fscxy(100)..color(1,line.styleref.color2)..t(tt(diferencia-600,diferencia)..alpha('FF')..frxyz(150,50,200)).."}"..char
				l.layer=2
				subs.append(l)
				
				--config
				if syl.duration < 150 then
					modt=modt+300/(longsil*2)
				elseif syl.duration < 500 then
					modt=modt+700/(longsil*2)
				elseif syl.duration >= 500 and syl.duration < 900 then
					modt=modt+1000/(longsil*2)
				elseif syl.duration >= 3000 then
					modt=modt+1600/(longsil*2)
				else
					modt=modt+1400/(longsil*2)
				end					
					modtend=modtend+((1000/line.kara.n)/longsil)
					posicion_anterior=posicion_anterior+tam_caracter
			end	
		
		elseif actor=='tra' then
		
			l = table.copy(line)
			y=455
			l.text = "{"..an(5)..pos(x,y)..bord(0)..shad(1)..fscxy(100)..color(1,line.styleref.color2)..fad(100,100)..fscxy(100).."}"..sil()
			l.layer=1
			subs.append(l)
		
		end
			 
	modi_tiempo=modi_tiempo+1000/line.kara.n
	end
end
-------------------------------TERMINA EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("FX Polyphonica Crimson ED", "", fx_crimison)
aegisub.register_filter("FX Polyphonica Crimson ED", "", 2000,fx_crimison)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------