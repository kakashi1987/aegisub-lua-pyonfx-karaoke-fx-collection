include("karaskel.lua")
include("zheolib.lua")
include("formaslib.lua")
-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Denpa Teki Na Kanojo ED"
script_description = "Denpa Teki Na Kanojo ED"
script_author = "nickle"
script_version = "1.5"

--FUNCIÓN GENERADOR FX
function convAlpha(valor)
	if valor < 0 or valor >255 then
		valor=0
	end
	return "\\alpha"..ass_alpha(valor)..""
end
	
function fx_denpa(subs)
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
		local y=line.margin_v + 25
		local actor=line.actor
		
		if i==1 then
			modi_tiempo=0
		end	
		
		function sil()
			silaba = ""..syl.text_stripped..""
			return silaba
		end
		
		if actor=='rom' or actor=='kan' then
		
			if actor=='kan' then
				 y=439
			end
		
			posicion_anterior=0
			longsil=string.len(sil())
			modt=0
			modtend=0
			for char in unicode.chars(sil()) do
				 -- si hay texto
					--Metricas de caracter
					tam_caracter=aegisub.text_extents(line.styleref,char) --obtenemos la longitud del caracter
					x_individual=line.left + syl.left +tam_caracter/2+posicion_anterior --Posicionamos nuestro carácter
					
					l = table.copy(line) 	
					l.start_time=line.start_time-600+modi_tiempo+modtend
					l.end_time=line.start_time+syl.start_time+modt
					duracion=l.end_time-l.start_time
					l.text = "{"..an(5)..fad(600,100)..be(3)..move(x_individual-20,y,x_individual,y,0,600)..bord(1)..fscxy(100)..color(1,line.styleref.color1).."}"..char
					l.layer=1
					subs.append(l)
					
					l = table.copy(line) 	
					l.start_time=line.start_time-600+modi_tiempo+modtend
					l.end_time=line.start_time+syl.start_time+modt
					duracion=l.end_time-l.start_time
					l.text = "{"..an(5)..alpha('46')..fad(600,100)..be(2)..move(x_individual-20,y,x_individual,y,0,600)..bord(0)..fscxy(100)..color(1,line.styleref.color3).."}"..char
					l.layer=1
					subs.append(l)
					
					--enfasis	
					l = table.copy(line)
					ini=line.start_time+syl.start_time-100+modt
					fin=line.start_time+syl.end_time+modt
					l.start_time=ini
					l.end_time=fin
					duracion=fin-ini
					l.text = "{"..an(5)..be(1)..fad(100,0)..pos(x_individual,y)..bord(1)..fscxy(100)..t(tt(0,duracion/2)..fscxy(120)..fr(5))..t(tt(duracion/2,duracion)..fr(0)..fscxy(100)..be(3)..color(1,line.styleref.color3)..color(3,'020D99')).."}"..char
					l.layer=2
					subs.append(l)	
										
					--salida
					l = table.copy(line)
					l.start_time=line.start_time+syl.end_time+modt
					l.end_time=l.end_time-100+modi_tiempo+modtend
					duracion=l.end_time-l.start_time
					tfin=duracion-500
					l.text = "{"..an(5)..fad(0,500)..be(3)..move(x_individual,y,x_individual-20,y,tfin,duracion)..bord(1)..fscxy(100)..color(1,line.styleref.color3)..color(3,'020D99').."}"..char
					l.layer=1
					subs.append(l)
					
					for j=0,2 do --original blur3
				
						l = table.copy(line)
						l.start_time= line.start_time+syl.start_time+rand(-300,500)
						l.end_time= line.end_time-500+modi_tiempo
						l.text = "{"..an(5)..fad(500,500)..pos(x+rand(-15,15),y+rand(-7,7))..blur(3)..convAlpha(rand(70,150))..color(1,'020D99')..bord(0)..fscxy(rand(110,150))..AutoTags(TE3,700,convAlpha(rand(80,140)),convAlpha(rand(140,190))).."}"..p(1,'m 7 0 b 2 0 1 4 1 6 b 1 8 2 12 7 12 b 12 12 13 8 13 6 b 13 4 12 0 7 0 ')
						l.layer=0
						subs.append(l)
					end
					
					--config
					if syl.duration < 900 then
						modt=modt+700/(longsil*2)
					--[[elseif syl.duration >= 900 and syl.duration < 1500 then
							modt=modt+1100/(longsil*2)]]
					else
						modt=modt+1400/(longsil*2)
					end					
					modtend=modtend+((1000/line.kara.n)/longsil)
					posicion_anterior=posicion_anterior+tam_caracter
				
			end	
			
		--[[if sil() == ' ' or sil() == '' then -- si no hay texto
				l.text = "{}"
			else	
				for j=0,2 do --original blur3
					al=string.format("\\alpha(%s)",ass_alpha(math.random(70,150)))
					l = table.copy(line)
					l.start_time= line.start_time+syl.start_time+rand(-300,700)
					l.end_time= line.end_time-500+modi_tiempo
					l.text = "{"..an(5)..fad(500,500)..pos(x+rand(-15,15),y+rand(-8,8))..blur(3)..alpha_al(rand(50,140))..color(1,'020D99')..bord(0)..fscxy(rand(140,180))..AutoTags(TE3,700,alpha_al(rand(10,90)),alpha_al(rand(100,170))).."}"..p(1,'m 7 0 b 2 0 1 4 1 6 b 1 8 2 12 7 12 b 12 12 13 8 13 6 b 13 4 12 0 7 0 ')
					l.layer=0
					subs.append(l)
			end
				
			end]]
				
		elseif actor=='tra'then
			local ytra=462
			
			l = table.copy(line) 	
			l.text = "{"..an(5)..be(3)..fad(200,200)..pos(x,ytra)..bord(1)..fscxy(100)..color(1,line.styleref.color1).."}"..sil()
			l.layer=1
			subs.append(l)
		
		end
		modi_tiempo=modi_tiempo+1000/line.kara.n
	end	
end
-------------------------------TERMINA EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("FX Denpa Teki Na Kanoj ED", "", fx_denpa)
aegisub.register_filter("FX Denpa Teki Na Kanoj ED", "", 2000, fx_denpa)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------