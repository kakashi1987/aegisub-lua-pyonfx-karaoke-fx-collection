include("karaskel.lua")
include("zheolib.lua")
--include("formaslib.lua")
-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Vacancy - Kylee"
script_description = "FX Vacancy - Kylee"
script_author = "nickle"
script_version = "1"

--FUNCIÓN GENERADOR FX
function fx_kylee(subs)
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
		if i ==1 then
			tiempo=0
		end
			function sil()
				silaba = ""..syl.text_stripped..""
				return silaba
			end
			actor=line.actor
			inline=syl.inline_fx
function AutoTags(TipoDeLinea,Intervalo,Dato1,Dato2) 
--[[
Copyright (c) 2009, ASEDARK (ASE_DARK_ANGEL@hotmail.com)
All rights reserved®.
AutoTags [Versión 1.0] 
--]]
local RESULTADO = 0 
RESULTADO=""
local SUERTE = 0
local CONTADOR = 0
local ARREGLO = 0

-- ACA SE DEFINEN LOS TIPOS DE LINEA

if TipoDeLinea == TE1 then
DURACION =(line.start_time-800)/Intervalo
end
if TipoDeLinea == TE2 then
DURACION =((line.start_time+(syl.start_time+150))/Intervalo)
end
if TipoDeLinea == TE3 then
DURACION =(line.start_time+syl.start_time)/Intervalo
end
if TipoDeLinea == TE4 then
DURACION =(l.duration)/Intervalo
end

-- FIN DE LOS TIPOS DE LINEA

local count = math.ceil(DURACION) 

-- CONTENEDOR DE TAGS+VALORES [DATOS]

ARREGLO = {Dato1,Dato2}

-- FIN DEL CONTENEDOR

for i = 1, count do -- 01

CONTADOR = i

--|||| 02 DATOS
if Dato1 and Dato2 then 
if CONTADOR%2 ==0 then
SUERTE = ARREGLO[1]
else
SUERTE = ARREGLO[2]
end 
end 

RESULTADO = RESULTADO .."\\t(" ..(i-1)*Intervalo.. "," ..i*Intervalo.. ",\\" ..SUERTE..")".."" 

end -- 01

return RESULTADO 



end
			--Efecto pulso, basado en los scripts de zheo
				if inline=="part" then
					limite=(line.right+20)/2
					l = table.copy(line)
					posix=0
					posiy=y
						for xx=1,limite do
						tem1= line.start_time+syl.start_time -- tiempo 1
						tem2= tem1+xx+line.duration/1.5 -- tiempo 2
						tf= interpolate(xx/limite, tem1, tem2) -- interpolacion para los tiempos
						posix=posix+2
							if posix >= line.right-120 and posix < line.right-100 then
								posiy=posiy-1				
							elseif posix >= line.right-100 and posix<line.right-60 then
								posiy=posiy+1	
							elseif posix >= line.right-60 and posix<line.right-20 then
								posiy=posiy-1	
							elseif posix >= line.right-20 and posix<line.right+20 then
								posiy=posiy+1	
							end
						
						for d=1,30 do
							arreglo_colores={'FB9CFF','E900F3','F8EFF9','CC59D1','CC59D1','C40ACC'}
							l.text = "{"..an(5)..move(posix,posiy,posix+rand(10),posiy+rand(10))..be(rand(1,4))..bord(0)..alpha('32')..color(1,arreglo_colores[math.random(1,6)])..fscxy(rand(100,250))..t(alpha('ff')..fscxy(0)).."}"..p(1, Fpixel())
							l.start_time= tf-limite
							l.end_time= tf+math.random(500,1000)
							l.layer = 0
							subs.append(l)
						end	
						
						l.text = "{"..an(5)..pos(posix,posiy)..be(3)..bord(0)..alpha('32')..color(1,'E900F3')..fscxy(450)..t(alpha('ff')..fscxy(0)..color(1,'D8F4B6')).."}"..p(1, Fpixel())
						l.start_time= tf-limite
						l.end_time= tf+1400
						l.layer = 0
						subs.append(l)

					end
				
				end				
						
			if actor=="1" then	--Coro
			
			--Efectos Entrada
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..fscx(105)..fscy(105)..fad(500,0)..blur(3)..bord(0)..color(1,'0084FF').."}"..sil()
			l.start_time=line.start_time-500
			l.end_time=line.start_time
			l.layer=0
			subs.append(l)
					
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..fad(500,0)..bord(0)..color(1,line.styleref.color1)..t(be(0)).."}"..sil()
			l.start_time=line.start_time-500
			l.end_time=line.start_time
			l.layer=1
			subs.append(l)
				
			--Efectos estaticos
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..bord(0)..fscx(105)..fscy(105)..blur(3)..color(1,'0084FF').."}"..sil()
			l.start_time=line.start_time
			l.end_time=line.start_time+syl.start_time
			l.layer=0
			subs.append(l)
					
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..bord(0)..color(1,line.styleref.color1).."}"..sil()
			l.start_time=line.start_time
			l.end_time=line.start_time+syl.start_time
			l.layer=1
			subs.append(l)		
			
			--Efectos Silabas
		
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..fscx(105)..fscy(105)..bord(0)..blur(3)..color(1,'0084FF')..AutoTags(TE3,200,fscx(105),fscx(125))..t(alpha('FF')).."}"..sil()
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration
			l.layer=3
			subs.append(l)	
			
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..bord(0)..fscx(100)..fscy(100)..alpha('00')..color(1,line.styleref.color1)..AutoTags(TE3,200,fscx(100),fscx(120))..t(alpha('FF')).."}"..sil()
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration
			l.layer=4
			subs.append(l)	
			
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..fscx(100)..fscy(100)..bord(0)..be(3)..alpha('96')..color(1,'0084FF')..AutoTags(TE3,250,fscx(100)..alpha('96'),fscx(120)..alpha('D2'))..t(alpha('FF')).."}"..sil()
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration
			l.layer=5
			subs.append(l)
			
			if sil() == ' ' or sil() == '' then -- si no hay texto
				l.text = "{}"
			else -- si hay texto	
				l = table.copy(line)
				for t=1,50 do
				tam_ale=rand(50,100)
				--Destino
				limite_alt=(syl.height/2) 
				limite_anch=(syl.width/2)+10 
								
				l.text = "{"..an(5)..fad(100,100)..move(x+rand(limite_anch-10),y+rand(limite_alt-10),x+math.random(-(limite_anch+10),limite_anch+10),y+math.random(-(limite_alt),limite_alt))..fscx(tam_ale)..fscy(tam_ale)..bord(0)..be(rand(0,2))..color(1,'0084FF')..AutoTags(TE3,230,fscx(tam_ale)..fscy(tam_ale),fscx(tam_ale+15)..fscy(tam_ale+15)).."}"..p(6,'m -31 -33 b -24 -41 -19 -44 -12 -46 b -8 -119 -3 -194 0 -267 b 3 -194 7 -119 12 -46 b 17 -46 24 -43 31 -36 b 37 -28 38 -24 40 -14 b 105 -11 172 -7 238 -4 b 172 0 104 4 40 11 b 37 18 36 20 32 26 b 26 33 24 36 12 40 b 8 108 4 177 0 245 b -4 178 -9 110 -12 40 b -19 39 -24 36 -31 30 b -34 27 -40 20 -40 11 b -105 7 -172 1 -237 -4 b -171 -7 -104 -11 -40 -14 b -38 -21 -35 -27 -31 -33')
				l.start_time=line.start_time+syl.start_time+math.random(syl.duration/5)
				l.end_time=l.start_time+syl.duration+math.random(300)
				l.layer=2
				subs.append(l)
				
				tam_ale_pix=rand(100,150)
				l.text = "{"..an(5)..fad(100,100)..move(x+rand(limite_anch-10),y+rand(limite_alt-10),x+math.random(-(limite_anch+10),limite_anch+10),y+math.random(-limite_alt,limite_alt))..fscx(tam_ale_pix)..fscy(tam_ale_pix)..bord(0)..be(rand(0,1))..color(1,'0084FF').."}"..p(1, Fpixel())
				l.start_time=line.start_time+syl.start_time+math.random(syl.duration/5)
				l.end_time=l.start_time+syl.duration+math.random(300)
				l.layer=2
				subs.append(l)
				end
			end
			
			elseif actor=="2" or actor=="22" then --Traduccion
				y=453
				if inline~="color" then
					color_blur='FFFFFF'
				else
					color_blur='0084FF'
				end
				
				if actor=="2" then
					strb="{"..an(5)..pos(x,y)..fad(0,400)..bord(0)..blur(3)..color(1,color_blur).."}"..sil()
					str="{"..an(5)..pos(x,y)..fad(0,400)..bord(0)..color(1,line.styleref.color1).."}"..sil()
				else
					y=428
					strb="{"..an(5)..move(x,y,x,453,1830,2630)..fad(0,400)..bord(0)..blur(3)..color(1,color_blur).."}"..sil()
					str="{"..an(5)..move(x,y,x,453,1830,2430)..fad(0,400)..bord(0)..color(1,line.styleref.color1).."}"..sil()
				end
				
				--Efectos Entrada
				l = table.copy(line)
				l.text = "{"..an(5)..pos(x,y)..fad(500,0)..blur(3)..bord(0)..color(1,color_blur)..t(frx(0)..fry(0)).."}"..sil()
				l.start_time=line.start_time-500
				l.end_time=line.start_time
				l.layer=0
				subs.append(l)
						
				l = table.copy(line)
				l.text = "{"..an(5)..pos(x,y)..fad(500,0)..bord(0)..color(1,line.styleref.color1)..t(be(0)..frx(0)..fry(0)).."}"..sil()
				l.start_time=line.start_time-500
				l.end_time=line.start_time
				l.layer=1
				subs.append(l)
				
				--Estaticas
				l = table.copy(line)
				l.text = strb
				l.start_time=line.start_time
				l.layer=0
				subs.append(l)
					
				l = table.copy(line)
				l.text = str
				l.start_time=line.start_time
				l.layer=1
				subs.append(l)
				
			
			else --lo demas
						
			--Efectos Entrada
			l = table.copy(line)
			l.text = "{"..an(5)..move(x-10,0,x,y)..fscx(105)..fscy(105)..fry(35)..frx(90)..alpha('FF')..blur(3)..bord(0)..color(1,line.styleref.color3)..t(alpha('00')..fry(0)..frx(0)).."}"..sil()
			l.start_time=line.start_time-1000+tiempo
			l.end_time=line.start_time+tiempo
			l.layer=0
			subs.append(l)
					
			l = table.copy(line)
			l.text = "{"..an(5)..move(x-10,0,x,y)..be(4)..fry(35)..frx(90)..alpha('FF')..bord(0)..color(1,line.styleref.color1)..t(alpha('00')..fry(0)..frx(0)..be(0)).."}"..sil()
			l.start_time=line.start_time-1000+tiempo
			l.end_time=line.start_time+tiempo
			l.layer=1
			subs.append(l)
				
			--Efectos estaticos
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..fscx(105)..fscy(105)..bord(0)..blur(3)..color(1,line.styleref.color3).."}"..sil()
			l.start_time=line.start_time+tiempo
			l.end_time=line.start_time+syl.start_time
			l.layer=0
			subs.append(l)
					
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..bord(0)..color(1,line.styleref.color1).."}"..sil()
			l.start_time=line.start_time+tiempo
			l.end_time=line.start_time+syl.start_time
			l.layer=1
			subs.append(l)		
			
			--Efectos Silabas
		
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..fscx(105)..fscy(105)..bord(0)..blur(3)..color(1,line.styleref.color1)..t(fscx(135)..fscy(135))..t(fscx(105)..fscy(105)).."}"..sil()
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration
			l.layer=3
			subs.append(l)	
			
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..bord(0)..fscx(100)..fscy(100)..alpha('00')..color(1,line.styleref.color1)..t(fscx(130)..fscy(130))..t(fscx(100)..fscy(100)..alpha('FF')).."}"..sil()
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration
			l.layer=4
			subs.append(l)	
			
			l = table.copy(line)
			tabla_angulos={'20','-20'}
			l.text = "{"..an(5)..pos(x,y)..bord(0)..alpha('32')..fscx(100)..fscy(100)..fr(0)..color(1,line.styleref.color1)..t(fscx(150)..fscy(150)..alpha('FF')..fr(tabla_angulos[math.random(1,2)])).."}"..sil()
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration
			l.layer=5
			subs.append(l)	
			
			end
						
			tiempo=tiempo+(1000/line.kara.n)
	end
	
end
-------------------------------TERMINA EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("FX Vacancy - Kylee", "", fx_kylee)
aegisub.register_filter("FX Vacancy - Kylee", "", 2000, fx_kylee)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------