-- SCRIPT MODIFICADO Y COMENTADO POR ALQUIMISTA
-- GRACIAS A ZHEO, NICKLE, ASEDARK Y A TODO EL SOCIAL CLUB DE FXMAKERS
-- SON LIBRES DE MODIFICARLO A SU ANTOJO
-- USEN NOTEPAD++ PARA QUE VEAN TODO ACOMODADITO Y CON COLORES xD

--INCLUIR LIBRERIAS
include("karaskel.lua") --SIEMPRE HAY QUE AGREGARLA
include("zheolib.lua") --AGREGAMOS LA LIBRERIA ZHEOLIB
include("formaslib.lua") --AGREGAMOS LA LIBRERIA FORMASLIB

--\\-----------------------------CONFIGURACIONES DE LA MACRO------------------------------\\--

--[[-------------------------------------------/
                                               /
	script_name = "Grafica de coseno"          /
	script_description = "EFECTOS EN LUA4"     /
	script_author = "Alquimista"               /
	script_version = "0.1 beta"                /
											   /				
--------------------------------------------]]--

-- FUNCIÓN GENERADOR DE EFECTO... ¡NO MODIFICABLE! 
function Alki_FX(subs)
	aegisub.progress.task("ESPERA MIENTRAS SE CREA EL EFECTO") --los mensajes entre comillas y parentesis se pueden modificar
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("APLICANDO EFECTO")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("YA CASI (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment and
				(l.style == "Default" or l.style == "Traduccion" or l.style == "Kanji") then  -- en esta linea coloca el nombre del estilo al que afectará el script lua
				karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else
			i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("¡PROCESO FINALIZADO!")
	aegisub.progress.set(100)
end
-- TERMINA FUNCION GENERADOR


--\\-----------------------------TERMINA CONFIGURACIONES DE LA MACRO----------------------\\--

--////////////////FUNCIONES//////////////////////////////////////////////////////////////////////////////////////////////

-- CONFIGURACION DE LA POSICION DEL SUBTITULO
function do_fx(subs, meta, line)
	for i = 1, line.kara.n do
	
		local syl = line.kara[i]
		
		local sstart=0
		local send=syl.end_time
		local smid=syl.duration / 2	
		
		local actor=line.actor

		if i == 1 then
			tempo=0
		end
		
		-- AGREGAMOS TAMBIEN ESTA FUNCIÓN
		function sil()
			silaba = ""..syl.text_stripped..""
			return silaba
		end		
		
--////////////////EMPIEZAN LOS FX'S//////////////////////////////////////////////////////////////////////////////////////////

		if actor=='yui' then
		
		local x=syl.left + line.left
		local y=line.margin_v + 8--AQUI CAMBIAS EL MARGEN DE LA POSICION DE LA LINEA (Que tan abajo estarán de arriba)

			if syl.inline_fx == "" then	
				px=x
				cr='ffffff'
				fsc=100
				A=7
				PY1=y
				br=0
			elseif syl.inline_fx == "fx2" then	
				px=x+650    
				cr='48CFE4'
				fsc=120
				A=5
				PY1=y+10
				br=5
				
				--FX SILABA
				l = table.copy(line)
				fr={'45', '-45'}
				rand_frz= fr[math.random(1,2)]

				l.text = "{"..an(A)..pos(px,PY1)..bord(0)..color(1,'ffffff')..t(frz(rand_frz)..alpha('ff'))..t(bord(1)..be(10)).."}"..sil()
				l.start_time = line.start_time+syl.start_time
				l.end_time = l.start_time+syl.duration
				l.layer=5
				subs.append(l)
			end
		
			--FX DE ENTRADA
			for k=0, 2 do
				if k==0 then
					py=10
				elseif k==1 then
					py=0
				else
					py=-10
				end	
				l = table.copy(line)--E2BDF6
				l.text = "{"..an(A)..fad(400,0)..move(px,PY1+py,px,PY1)..color(1,'ffffff')..t(color(1,'C1E9E5'))..alpha('c0')..bord(0).."}"..sil()
				l.start_time = line.start_time-400+ tempo
				l.end_time=line.start_time
				l.layer=2+k
				subs.append(l)			
			end	


			--SILABAS ESTATICAS2
			l = table.copy(line)
			l.text = "{"..an(A)..fad(50,100)..an(5)..pos(px,PY1)..bord(2)..color(1, 'C1E9E5')..blur(0.2)..bord(0)..alpha('c0').."}"..sil()
			l.start_time = line.start_time
			l.end_time = l.end_time
			l.layer=0
			subs.append(l)	

			--SILABAS ESTATICAS
			l = table.copy(line)
			l.text = "{"..an(A)..fad(50,100)..an(5)..pos(px,PY1)..bord(0.3)..be(1)..color(1, 'C1E9E5').."}"..sil()
			l.start_time = line.start_time
			l.end_time = line.start_time+syl.start_time+50
			l.layer=1
			subs.append(l)	

			--SILABAS ESTATICAS
			l = table.copy(line)--E2BDF6--C1E9E5--8E8DDD--5C5CD9
			l.text = "{"..fad(50,1000)..an(A)..pos(px,PY1)..color(1,'6EB6AB')..bord(0)..t(bord(1)..color(1,'B1FFF8')).."}"..sil()
			l.start_time = line.start_time
			l.end_time = line.start_time+syl.start_time+50
			l.layer=2
			subs.append(l)

			--FX PARTICULAS
			for n=0, 9 do
				c ={'C1E9E5', '7AE4FF'}----7AE4FF--E2BDF6
				SC= c[math.random(1,2)]
				movx=px+rand(10,20)
				l = table.copy(line)--C3C3F4----DBDBFF--B6FFFE
				l.text = "{"..an(A)..bord(0)..move(movx,PY1+rand(5,30),movx,PY1-20)..bord(0.1)..blur(5)..color(1,SC)..fscxy(50,50)..color(3,cr).."}"..p(4,Formas(5,4))
				l.start_time=line.start_time+syl.start_time+100+rand(100)
				l.end_time=l.start_time+1300-rand(100,500)
				l.layer = 5
				subs.append(l)
			end
			
			--FX PARTICULAS
			l = table.copy(line)--C3C3F4----DBDBFF--B6FFFE			
			for n=0, 14 do
				l.text = "{"..an(A)..bord(0)..move(px+rand(10)+5,PY1+rand(10)+15,px+rand(10)+5,PY1+rand(10)+15)..color(1,'ffffff').."}"..p(1,Formas(1))
				l.start_time=line.start_time+syl.start_time-100
				l.end_time=l.start_time+syl.duration
				l.layer = 6
				subs.append(l)
			end

			--EFECTO DE SILABA
			l = table.copy(line)--E2BDF6--1F29AB--999ADB--1F29AB
			l.text = "{"..an(A)..pos(px,PY1)..bord(1)..color(1,'A8D8D0')..color(3,'0CA397')..blur(br)..t(tt(sstart,smid)..fscxy(fsc)..bord(0.5)..blur(5))..t(tt(smid,send)..color(1,'C1E9E5')..a(1,'ff')..bord(0)).."}"..sil()
			l.start_time=line.start_time+syl.start_time--09D2C2
			l.end_time=l.start_time+syl.duration
			l.layer =4
			subs.append(l)
			
		elseif actor=='esp' then
	
			if syl.inline_fx == "" then
			x=line.right-5	
			y=line.margin_v + 475--AQUI CAMBIAS EL MARGEN DE LA POSICION DE LA LINEA (Que tan abajo estarán de arriba)
			c='14204E'
            fscXY=100
            FAD=0
			elseif syl.inline_fx == "fx2" then
			x=line.right-620
			y=line.margin_v + 475
			c='A8D8D0'
            fscXY=120
            FAD=800
			end
		
        	--SILABAS ESTATICAS2
			l = table.copy(line)
			l.text = "{"..fad(0,FAD)..an(3)..pos(x,y)..bord(1)..color(3,c)..t(fscxy(fscXY)).."}"..sil()
			l.start_time = line.start_time
			l.end_time = line.end_time
			l.layer=1
            
			subs.append(l)
            
			--SILABAS ESTATICAS
			l = table.copy(line)
			l.text = "{"..fad(0,FAD)..an(3)..pos(x,y)..bord(2)..xbord(0)..be(2)..color(3,c)..t(bord(1)..xbord(2)..blur(3)..fscxy(fscXY)).."}"..sil()
			l.start_time = line.start_time
			l.end_time = line.end_time
			l.layer=0
			subs.append(l)
			--]]
		elseif actor=='jap' then
		
		local x=syl.left + line.left
		local y=line.margin_v + 50--AQUI CAMBIAS EL MARGEN DE LA POSICION DE LA LINEA (Que tan abajo estarán de arriba)
		
			--SILABAS ESTATICAS
			l = table.copy(line)
			l.text = "{"..an(7)..an(5)..pos(x,y)..bord(1).."}"..sil()
			l.start_time =line.start_time+syl.start_time+syl.duration
			l.end_time = l.end_time
			l.layer=0
			subs.append(l)
			
			--GLOW
			l = table.copy(line)
			for i=0,5 do
			l.layer=3
			l.text = string.format("{\\pos(%d,%d)\\an7\\shad0\\3c&HFFFFFF&\\1a&HFF&\\3a&HF5&\\bord%d\\t(\\bord0\\3c%s\\blur2)}%s",x,y,1+ i*1,line.styleref.color2,syl.text_stripped)
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration+syl.duration/2
			subs.append(l)
			end
		
			--FX SILABA
			l = table.copy(line)
			l.text = "{"..an(7)..pos(x,y)..bord(0.5)..color(1,'ffffff')..xbord(0)..be(1)..t(bord(1)..be(10)).."}"..sil()
			l.start_time = line.start_time+syl.start_time
			l.end_time = l.start_time+syl.duration
			l.layer=2
			subs.append(l)

			--SILABAS ESTATICAS
			l = table.copy(line)
			l.text = "{"..an(7)..an(5)..pos(x,y)..bord(1).."}"..sil()
			l.start_time = line.start_time
			l.end_time = line.start_time+syl.start_time
			l.layer=0
			subs.append(l)
			
		end
	
				
--------------------------------------HASTA AQUI TERMINAN LOS EFECTOS-----------------------------------------------------
--NO LOS QUITES
	end
end
---------------------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("yuifx", "APLICAR EFECTO", Alki_FX)
aegisub.register_filter("yuifx", "APLICAR EFECTO", 2000, Alki_FX)
----------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------------