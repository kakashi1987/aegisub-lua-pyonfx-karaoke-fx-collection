include("karaskel.lua")
include("zheolib.lua")
include("formaslib.lua")
-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Polyphonica Crimson OP"
script_description = "FX Polyphonica Crimson OP"
script_author = "nickle"
script_version = "1"

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
		local y=line.margin_v + 20
		local actor=line.actor
		local xres=aegisub.video_size()
			
		if i==1 then
			modi_tiempo=0
		end	
		
		function sil()
			silaba = ""..syl.text_stripped..""
			return silaba
		end
		
		if actor=='rom' or actor=='kan' then
			modclipy=0
			if actor=='kan' then
				y=y+30
				modclipy=30
			end
			
			if i==1 then
				tiniclip=line.start_time-700
			end
			
			l = table.copy(line) 	
			l.start_time=tiniclip
			l.end_time=line.end_time
			l.text = "{"..an(5)..alpha('FF')..pos(x,y)..clip((x-syl.width/2)-1,(y-syl.height/2)-1,x-syl.width/2,y+syl.height/2)..bord(1)..be(2)..fscxy(100)..t(tt(0,150)..alpha('00')..clip(x-2-syl.width/2,y-syl.height/2,x+2+syl.width/2,y+syl.height/2)).."}"..sil()
			l.layer=1
			subs.append(l)
				
			posicion_anterior=0
			longsil=string.len(sil())
			modt=0
			modtend=0
			for char in unicode.chars(sil()) do
				--Metricas de caracter
				tam_caracter=aegisub.text_extents(line.styleref,char) --obtenemos la longitud del caracter
				x_individual=line.left + syl.left +tam_caracter/2+posicion_anterior --Posicionamos nuestro carácter
								
				--enfasis
				iniEnf=line.start_time+syl.start_time+modt-150
				finEnf=line.start_time+syl.end_time+modt
				duracion=finEnf-iniEnf
				for j=0, line.height+2 do  
					clip1x=0
					clip2x=xres
					clip1y=line.top+j-4+modclipy
					clip2y=clip1y+1
					col_int=interpolate_color(j/(line.height-5),line.styleref.color3,line.styleref.color2)						
					l = table.copy(line)					
					l.start_time=iniEnf
					l.end_time=finEnf
					l.text = "{"..an(5)..clip(clip1x, clip1y, clip2x, clip2y)..pos(x_individual,y)..bord(1)..fad(100,40)..shad(0)..blur(0)..fscxy(100)..color(1,col_int)..color(3,'EEDBFF')..t(tt(0,duracion/2)..fscxy(110)..bord(1)..blur(3))..t(tt(duracion/2,duracion)..fscxy(100)..bord(0)..blur(0)..be(2)).."}"..char
					l.layer=3
					subs.append(l)
				end	
						

			l = table.copy(line)
			l.start_time=line.end_time
			l.end_time=line.end_time+50+modi_tiempo
			l.text = "{"..an(5)..pos(x_individual,y)..alpha('00')..bord(1)..be(2)..t(alpha('FF')).."}"..char
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
					
			arr_lay={1,4}
			for part=0,60 do  
				l = table.copy(line) 	
				l.start_time=tiniclip+rand(0,500)
				l.end_time=l.start_time+rand(0,500)
				l.text = "{"..an(5)..convAlpha(rand(50,80))..move(x+rand(50,70),y+rand(-syl.height/2,syl.height/2),x-syl.width/2,y+rand(-2,2))..bord(1)..blur(3)..fscxy(rand(30,60))..color(1,'D1BDFF')..color(3,'4E00FF')..t(alpha('FF')).."}"..p(2,Formas(4,2))
				l.layer=arr_lay[rand(1,2)]
				subs.append(l)			
			
			end
		
		elseif actor=='tra' then 
			limite= line.height
			y=455
			for j=0, limite do  
				clip1x=0
				clip2x=xres
				clip1y=line.top+j-1
				clip2y=clip1y+1
				col_int=interpolate_color(j/limite,line.styleref.color1,line.styleref.color2)
				l = table.copy(line)
				l.text = "{"..an(5)..pos(x,y)..clip(clip1x, clip1y, clip2x, clip2y)..color(1,col_int)..bord(1)..be(2)..fscxy(100)..fad(100,100)..fscxy(100).."}"..sil()
				l.layer=1
				subs.append(l)
			end
		
		end
	tiniclip=tiniclip+150		 
	modi_tiempo=modi_tiempo+1000/line.kara.n
	end
end
-------------------------------TERMINA EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("FX Polyphonica Crimson OP", "", fx_crimison)
aegisub.register_filter("FX Polyphonica Crimson OP", "", 2000,fx_crimison)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------