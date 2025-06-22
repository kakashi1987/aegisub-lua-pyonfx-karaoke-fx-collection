include("karaskel.lua")
include("zheolib.lua") --AGREGAMOS LA LIBRERIA ZHEOLIB
include("formaslib.lua") --AGREGAMOS LA LIBRERIA FORMASLIB

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "un disque karaoke"
script_description = "EFECTOS EN LUA4"
script_author = "Alquimista"
script_version = "1.0"


-- ## FUNCIÓN GENERADOR DE EFECTO... ¡NO MODIFICABLE!
function Alki_FX(subs)
	aegisub.progress.task("ESPERA MIENTRAS SE CREA EL EFECTO")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("APLICANDO EFECTO")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("PROGRESO (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment and
				(l.style == "Default") then  -- <-- en esta linea coloca el nombre del estilo al que afectará el script lua
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
-- ## TERMINA FUNCION GENERADOR

-------------------------------TERMINA CONFIGURACIONES DE LA MACRO------------------------

-------------------------------ACÁ COMIENZA LA CONFIGURACIÓN BÁSICA-----------------------
-- ## CONFIGURACION DE X-Y
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 40 --AQUI CAMBIAS EL MARGEN DE LA POSICION DE LA LINEA (Que tan abajo estarán de arriba)
if i == 1 then
tempo=0
end
-- ## AGREGAMOS TAMBIEN ESTA FUNCIÓN
function sil()
silaba = ""..syl.text_stripped..""
return silaba
end

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--X                                                                                                            X
--X                                              FUNCIONES                                                     X 
--X                       (Aca coloco las funciones que estoy usando en este Script)                           X
--X                                            (¡No mover !)                                                   X
--X                                                                                                            X
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

--FUNCION AUTOTIMER (Versión Beta) creada por ASEDARK y Sora-kun
function AutoTimer(TipoDeLinea,Intervalo,Tag,ValorInicialTag,AumentoTag,MasYMenos) 
local RESULTADO_01 = 0
RESULTADO_01=""
local RESULTADO_02 = 0
RESULTADO_02=""
local DIRECCION =1
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
local count = math.ceil(DURACION) 
if math.random(0,1) == 0 then 
	DIRECCION = -DIRECCION
end 
	for i = 1, count do 
		ValorTagAumento=ValorInicialTag+(i*AumentoTag)
		RESULTADO_01 = RESULTADO_01 .."\\t(" ..(i-1)*Intervalo.. "," ..i*Intervalo.. ",\\" ..Tag..DIRECCION*ValorTagAumento..")"..""
		RESULTADO_02 = RESULTADO_02 .."\\t(" ..(i-1)*Intervalo.. "," ..i*Intervalo.. ",\\" ..Tag..ValorTagAumento..")"..""
		DIRECCION = -DIRECCION
	end
	if MasYMenos == 1 then
		return RESULTADO_01	
	elseif MasYMenos == 0 then
		return RESULTADO_02
	end
end

--FIN DE AUTOTIMER

-----------------------------------TERMINA LA CONFIGURACIÓN BÁSICA-----------------------------

------------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

if syl.inline_fx == "" then -- éste será el Default

--SILABAS ESTATICAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..color(3,'H000000')..color(1,line.styleref.color2)..bord(1)..be(8).."}"..sil()
l.start_time = line.start_time
l.end_time =line.start_time+syl.start_time
l.layer=1
subs.append(l)

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
--------------------------------------------EFECTO INICIAL--------------------------------------------------
--------------------------(Es como aparece la linea...antes de lo timeado)---------------------------------

l = table.copy(line)--ESTO HARÁ QUE SE COPIEN LAS LINEAS
l.text = "{"..fad(300,0)..an(5)..move(x-100+rand(10),y-100+rand(10),x,y)..color(1,'ffffff')..bord(0.5)..color(3,'H000000')..t(fry(10080)..bord(1)).."}"..sil() --ESTOS SON LOS EFECTOS (Aqui es donde agregarás tus efectos de entrada)
l.start_time = line.start_time -800 --TIEMPO INICIAL DEL EFECTO (-800 = entrará 0.8 segundos antes de lo normal ( del tiempo timeado)
l.end_time = line.start_time ---TIEMPO FINAL DEL EFECTO 
l.layer=0 --NUMERO DE LA CAPA O LAYER..ES DECIR EL NIVEL EN EL QUE ESTARÁ (Por detras o delante de los demas efectos)
subs.append(l) ---HACE QUE TERMINE EL BLOQUE

--------------------------------------------------------------------------------------------------------------------

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
-------------------------------------------SILABAS ESTATICAS -------------------------------------------------------
---------------------(LINEA DE KARAOKE......las que solo se quedan sin hacer nada)----------------------------------- 

l = table.copy(line)
for j = 0, syl.height do
cx1 = 0 -- siempre cero
cy1 = l.top+j*1+1 -- comienza desde la cima de linea (tambien puede ser l.top+j*1+1)
cx2 = 1280 -- ancho video
cy2 = l.top+j*1+2 -- es igual a cy1 pero con un nº más (tambien puede ser l.top+j*1+2)
l.text = "{"..fad(100,0)..an(5)..pos(x,y)..clip(cx1, cy1, cx2, cy2)..RangeAlpha(1, j/syl.height,'00', 'ff')..RangeAlpha(3, j/syl.height,'00', 'ff')..color(1, line.styleref.color1)..bord(1).."}"..sil()
l.start_time = line.start_time
l.end_time = l.end_time
l.layer=0
subs.append(l)
end

---------------------------------------------FX DE SILABAS -------------------------------------------------------
-----------------------------------------------(Silaba)----------------------------------------------------------- 

--FX DE SILABAS
l = table.copy(line)
l.text = "{"..fad(0,5)..an(5)..pos(x,y)..t(fscxy(105)..bord(3))..estilo(3,line.styleref.color1)..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer =3
subs.append(l)

--FX DE SILABAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..t(fscxy(105))..color(1,line.styleref.color2)..AutoTimer(TE3,2,'frz',2.5,0,1).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer =4
subs.append(l)

	if syl.text ~=" " then -- NO APLICA EFECTO DE particulas EN ESPACIO EN BLANCO
	l = table.copy(line)

		--Rayos
		for i = 0,53 do		
			--Variables
			fsx=rand(50,160)
			fsy=rand(50,160)
			posx1=x+rand(150)
			posy1=y+rand(5)
			posx2=x+rand(150)
			posy2=y+rand(5)
			frzrand=rand(360)
			
			l.text = "{"..estilo(3,'HF2A369')..estilo(1,line.styleref.color1)..bord(0.5)..blur(5)..an(5)..alpha(rand(0,100))..fad(100,200)..move(posx1,posy1,posx2,posy2)..fscxy(fsx,fsy)..frz(frzrand).."}"..p(1,'m 0 0 l 1 -6 l -6 -13 l -20 -11 b -20 -11 -20 -12 -20 -12 l -25 -27 l -19 -13 l -5 -14 l -5 -14 l 2 -6 l 0 0')--ESTOS SON LOS EFECTOS 
			l.start_time=line.start_time+syl.start_time+rand(200,400)--CONFIGURACION DEL TIEMPO INICIAL DEL EFECTO
			l.end_time=l.start_time+syl.duration+rand(200,400)---CONFIGURACION DEL TIEMPO FINAL DEL EFECTO
			l.layer = 2 --NUMERO DE LA CAPA O LAYER..ES DECIR EL NIVEL EN EL QUE ESTARÁ (Por detras o delante de los demas efectos)
			subs.append(l)---HACE QUE TERMINE EL BLOQUE
		end
		
		for i = 0,53 do
			--Variables
			fsx=rand(50,160)
			fsy=rand(50,160)
			posx1=x+rand(150)
			posy1=y+rand(5)
			posx2=x+rand(150)
			posy2=y+rand(5)
			frzrand=rand(360)
			
			l.text = "{"..color(3,'HF2A369')..color(1,line.styleref.color1)..bord(0.5)..blur(5)..an(5)..alpha(rand(0,100))..fad(100,200)..move(posx1,posy1,posx2,posy2)..fscxy(fsx,fsy)..frz(frzrand).."}"..p(1,'m -18 -18 l -12 -22 l -16 -18 l -18 -11 l -28 -3 l -17 -5 l -20 -1 l -29 5 l -18 -4 l -30 -2 l -19 -12 l -18 -18 ')--ESTOS SON LOS EFECTOS 
			l.start_time=line.start_time+syl.start_time+rand(200,400)--CONFIGURACION DEL TIEMPO INICIAL DEL EFECTO
			l.end_time=l.start_time+syl.duration+rand(200,400)---CONFIGURACION DEL TIEMPO FINAL DEL EFECTO
			l.layer = 2 --NUMERO DE LA CAPA O LAYER..ES DECIR EL NIVEL EN EL QUE ESTARÁ (Por detras o delante de los demas efectos)
			subs.append(l)---HACE QUE TERMINE EL BLOQUE
		end

	end

elseif syl.inline_fx == "hojas" then	--efecto hoja

--SILABAS ESTATICAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..color(3,'H000000')..color(1,line.styleref.color2)..bord(1)..be(8).."}"..sil()
l.start_time = line.start_time
l.end_time =line.start_time+syl.start_time
l.layer=1
subs.append(l)

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
--------------------------------------------EFECTO INICIAL--------------------------------------------------
--------------------------(Es como aparece la linea...antes de lo timeado)---------------------------------

l = table.copy(line)--ESTO HARÁ QUE SE COPIEN LAS LINEAS
l.text = "{"..fad(300,0)..an(5)..move(x-100+rand(10),y-100+rand(10),x,y)..color(1,'ffffff')..bord(0.5)..color(3,'H000000')..t(fry(10080)..bord(1)).."}"..sil() --ESTOS SON LOS EFECTOS (Aqui es donde agregarás tus efectos de entrada)
l.start_time = line.start_time -800 --TIEMPO INICIAL DEL EFECTO (-800 = entrará 0.8 segundos antes de lo normal ( del tiempo timeado)
l.end_time = line.start_time ---TIEMPO FINAL DEL EFECTO 
l.layer=0 --NUMERO DE LA CAPA O LAYER..ES DECIR EL NIVEL EN EL QUE ESTARÁ (Por detras o delante de los demas efectos)
subs.append(l) ---HACE QUE TERMINE EL BLOQUE

--------------------------------------------------------------------------------------------------------------------

l = table.copy(line)
for j = 0, syl.height do
cx1 = 0 -- siempre cero
cy1 = l.top+j*1+1 -- comienza desde la cima de linea (tambien puede ser l.top+j*1+1)
cx2 = 1280 -- ancho video
cy2 = l.top+j*1+2 -- es igual a cy1 pero con un nº más (tambien puede ser l.top+j*1+2)
l.text = "{"..fad(100,0)..an(5)..pos(x,y)..clip(cx1, cy1, cx2, cy2)..RangeAlpha(1, j/syl.height,'00', 'ff')..RangeAlpha(3, j/syl.height,'00', 'ff')..color(1,'H51C78B')..color(3,'H29633E')..bord(1).."}"..sil()
l.start_time = line.start_time
l.end_time = l.end_time
l.layer=0
subs.append(l)
end

---------------------------------------------FX DE SILABAS -------------------------------------------------------
-----------------------------------------------(Silaba)----------------------------------------------------------- 

--FX DE SILABAS
l = table.copy(line)
l.text = "{"..fad(0,5)..an(5)..pos(x,y)..t(fscxy(105)..bord(3))..color(3,'H51C78B')..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer =3
subs.append(l)

--FX DE SILABAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..t(fscxy(105))..color(1,line.styleref.color2)..AutoTimer(TE3,2,'frz',2.5,0,1)..color(3,'H29633E').."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer =4
subs.append(l)

	if syl.text ~=" " then -- NO APLICA EFECTO DE particulas EN ESPACIO EN BLANCO
	l = table.copy(line)
		
		for i = 0,34 do		
			--Variables
			fsx=rand(10,40)
			fsy=rand(10,40)
			posx1=x+rand(80)
			posy1=y+rand(10)
			posx2=x+rand(80)
			posy2=y+rand(10)
			frzrand=rand(360)
			
			l.text = "{"..bord(0)..color(1,'H48AB77')..an(5)..alpha(rand(0,100))..fad(100,200)..move(posx1,posy1,posx2,posy2)..fscxy(fsx,fsy)..frz(frzrand).."}"..p(1,Formas(32))--ESTOS SON LOS EFECTOS 
			l.start_time=line.start_time+syl.start_time+rand(200,400)--CONFIGURACION DEL TIEMPO INICIAL DEL EFECTO
			l.end_time=l.start_time+syl.duration+rand(200,400)---CONFIGURACION DEL TIEMPO FINAL DEL EFECTO
			l.layer = 2 --NUMERO DE LA CAPA O LAYER..ES DECIR EL NIVEL EN EL QUE ESTARÁ (Por detras o delante de los demas efectos)
			subs.append(l)---HACE QUE TERMINE EL BLOQUE			
		end	
	
	end	

elseif syl.inline_fx == "hojas2" then	--efecto hoja	

--SILABAS ESTATICAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..color(3,'H000000')..color(1,line.styleref.color2)..bord(1)..be(8).."}"..sil()
l.start_time = line.start_time
l.end_time =line.start_time+syl.start_time
l.layer=1
subs.append(l)

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
--------------------------------------------EFECTO INICIAL--------------------------------------------------
--------------------------(Es como aparece la linea...antes de lo timeado)---------------------------------

l = table.copy(line)--ESTO HARÁ QUE SE COPIEN LAS LINEAS
l.text = "{"..fad(300,0)..an(5)..move(x-100+rand(10),y-100+rand(10),x,y)..color(1,'ffffff')..bord(0.5)..color(3,'H000000')..t(fry(10080)..bord(1)).."}"..sil() --ESTOS SON LOS EFECTOS (Aqui es donde agregarás tus efectos de entrada)
l.start_time = line.start_time -800 --TIEMPO INICIAL DEL EFECTO (-800 = entrará 0.8 segundos antes de lo normal ( del tiempo timeado)
l.end_time = line.start_time ---TIEMPO FINAL DEL EFECTO 
l.layer=0 --NUMERO DE LA CAPA O LAYER..ES DECIR EL NIVEL EN EL QUE ESTARÁ (Por detras o delante de los demas efectos)
subs.append(l) ---HACE QUE TERMINE EL BLOQUE

--------------------------------------------------------------------------------------------------------------------

l = table.copy(line)
for j = 0, syl.height do
cx1 = 0 -- siempre cero
cy1 = l.top+j*1+1 -- comienza desde la cima de linea (tambien puede ser l.top+j*1+1)
cx2 = 1280 -- ancho video
cy2 = l.top+j*1+2 -- es igual a cy1 pero con un nº más (tambien puede ser l.top+j*1+2)
l.text = "{"..fad(100,0)..an(5)..pos(x,y)..clip(cx1, cy1, cx2, cy2)..RangeAlpha(1, j/syl.height,'00', 'ff')..RangeAlpha(3, j/syl.height,'00', 'ff')..color(1,'HAECBDA')..color(3,'H191B23')..bord(1).."}"..sil()
l.start_time = line.start_time
l.end_time = l.end_time
l.layer=0
subs.append(l)
end

---------------------------------------------FX DE SILABAS -------------------------------------------------------
-----------------------------------------------(Silaba)----------------------------------------------------------- 

--FX DE SILABAS
l = table.copy(line)
l.text = "{"..fad(0,5)..an(5)..pos(x,y)..t(fscxy(105)..bord(3))..color(3,'H5CBFDC')..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer =3
subs.append(l)

--FX DE SILABAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..t(fscxy(105))..color(1,line.styleref.color2)..AutoTimer(TE3,2,'frz',2.5,0,1)..color(3,'H394459').."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer =4
subs.append(l)

if syl.text ~=" " then -- NO APLICA EFECTO DE particulas EN ESPACIO EN BLANCO
	l = table.copy(line)
		
		for i = 0,34 do		
			--Variables
			fsx=rand(10,40)
			fsy=rand(10,40)
			posx1=x+rand(80)
			posy1=y+rand(10)
			posx2=x+rand(80)
			posy2=y+rand(10)
			frzrand=rand(360)
			
			l.text = "{"..color(1,'H476571')..bord(0)..an(5)..alpha(rand(0,50))..fad(0,100)..move(posx1,posy1,posx2,posy2)..fscxy(fsx,fsy)..frz(frzrand).."}"..p(1,Formas(32))--ESTOS SON LOS EFECTOS 
			l.start_time=line.start_time+syl.start_time+rand(200,400)--CONFIGURACION DEL TIEMPO INICIAL DEL EFECTO
			l.end_time=l.start_time+syl.duration+rand(200,400)---CONFIGURACION DEL TIEMPO FINAL DEL EFECTO
			l.layer = 2 --NUMERO DE LA CAPA O LAYER..ES DECIR EL NIVEL EN EL QUE ESTARÁ (Por detras o delante de los demas efectos)
			subs.append(l)---HACE QUE TERMINE EL BLOQUE			
		end	
	
	end	

elseif syl.inline_fx == "rrayos" then -- éste será el Default

--SILABAS ESTATICAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..color(3,'H000000')..color(1,line.styleref.color2)..bord(1)..be(8).."}"..sil()
l.start_time = line.start_time
l.end_time =line.start_time+syl.start_time
l.layer=1
subs.append(l)

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
--------------------------------------------EFECTO INICIAL--------------------------------------------------
--------------------------(Es como aparece la linea...antes de lo timeado)---------------------------------

l = table.copy(line)--ESTO HARÁ QUE SE COPIEN LAS LINEAS
l.text = "{"..fad(300,0)..an(5)..move(x-100+rand(10),y-100+rand(10),x,y)..color(1,'ffffff')..bord(0.5)..color(3,'H000000')..t(fry(10080)..bord(1)).."}"..sil() --ESTOS SON LOS EFECTOS (Aqui es donde agregarás tus efectos de entrada)
l.start_time = line.start_time -800 --TIEMPO INICIAL DEL EFECTO (-800 = entrará 0.8 segundos antes de lo normal ( del tiempo timeado)
l.end_time = line.start_time ---TIEMPO FINAL DEL EFECTO 
l.layer=0 --NUMERO DE LA CAPA O LAYER..ES DECIR EL NIVEL EN EL QUE ESTARÁ (Por detras o delante de los demas efectos)
subs.append(l) ---HACE QUE TERMINE EL BLOQUE


--------------------------------------------------------------------------------------------------------------------

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
-------------------------------------------SILABAS ESTATICAS -------------------------------------------------------
---------------------(LINEA DE KARAOKE......las que solo se quedan sin hacer nada)----------------------------------- 

l = table.copy(line)
for j = 0, syl.height do
cx1 = 0 -- siempre cero
cy1 = l.top+j*1+1 -- comienza desde la cima de linea (tambien puede ser l.top+j*1+1)
cx2 = 1280 -- ancho video
cy2 = l.top+j*1+2 -- es igual a cy1 pero con un nº más (tambien puede ser l.top+j*1+2)
l.text = "{"..fad(100,0)..an(5)..pos(x,y)..clip(cx1, cy1, cx2, cy2)..RangeAlpha(1, j/syl.height,'00', 'ff')..RangeAlpha(3, j/syl.height,'00', 'ff')..color(1,'H86D3FF')..color(3,'H2F40BC')..bord(1).."}"..sil()
l.start_time = line.start_time
l.end_time = l.end_time
l.layer=0
subs.append(l)
end

---------------------------------------------FX DE SILABAS -------------------------------------------------------
-----------------------------------------------(Silaba)----------------------------------------------------------- 

--FX DE SILABAS
l = table.copy(line)
l.text = "{"..fad(0,5)..an(5)..pos(x,y)..t(fscxy(105)..bord(3))..color(3,'H4E86F5')..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer =3
subs.append(l)

--FX DE SILABAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..t(fscxy(105))..estilo(1,line.styleref.color2)..AutoTimer(TE3,2,'frz',2.5,0,1)..color(3,'H08187E').."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer =4
subs.append(l)

--------------------------------------------------------------------------------------------------------------------

	if syl.text ~=" " then -- NO APLICA EFECTO DE particulas EN ESPACIO EN BLANCO
	l = table.copy(line)

		--Rayos Rojos
		for i = 0,33 do		
			--Variables
			fsx=rand(50,160)
			fsy=rand(50,160)
			posx1=x+rand(150)
			posy1=y+rand(10)
			posx2=x+rand(150)
			posy2=y+rand(10)
			frzrand=rand(360)
			
			l.text = "{"..color(3,'H2F40BC')..color(1,'H2F40BC')..bord(0.5)..blur(5)..an(5)..alpha(rand(0,100))..fad(100,200)..move(posx1,posy1,posx2,posy2)..fscxy(fsx,fsy)..frz(frzrand).."}"..p(1,Formas(30))--ESTOS SON LOS EFECTOS 
			l.start_time=line.start_time+syl.start_time+rand(200,400)--CONFIGURACION DEL TIEMPO INICIAL DEL EFECTO
			l.end_time=l.start_time+syl.duration+rand(200,400)---CONFIGURACION DEL TIEMPO FINAL DEL EFECTO
			l.layer = 2 --NUMERO DE LA CAPA O LAYER..ES DECIR EL NIVEL EN EL QUE ESTARÁ (Por detras o delante de los demas efectos)
			subs.append(l)---HACE QUE TERMINE EL BLOQUE
		end
		
		for i = 0,53 do
			--Variables
			fsx=rand(20,130)
			fsy=rand(20,130)
			posx1=x+rand(150)
			posy1=y+rand(10)
			posx2=x+rand(150)
			posy2=y+rand(10)
			frzrand=rand(360)
			
			l.text = "{"..color(3,'H2F40BC')..color(1,'H2F40BC')..bord(0.5)..blur(5)..an(5)..alpha(rand(0,100))..fad(100,200)..move(posx1,posy1,posx2,posy2)..fscxy(fsx,fsy)..frz(frzrand).."}"..p(1,Formas(31))--ESTOS SON LOS EFECTOS 
			l.start_time=line.start_time+syl.start_time+rand(200,400)--CONFIGURACION DEL TIEMPO INICIAL DEL EFECTO
			l.end_time=l.start_time+syl.duration+rand(200,400)---CONFIGURACION DEL TIEMPO FINAL DEL EFECTO
			l.layer = 2 --NUMERO DE LA CAPA O LAYER..ES DECIR EL NIVEL EN EL QUE ESTARÁ (Por detras o delante de los demas efectos)
			subs.append(l)---HACE QUE TERMINE EL BLOQUE
		end

	end

elseif syl.inline_fx == "flores" then	

--SILABAS ESTATICAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..color(3,'H000000')..color(1,line.styleref.color2)..bord(1)..be(8).."}"..sil()
l.start_time = line.start_time
l.end_time =line.start_time+syl.start_time
l.layer=1
subs.append(l)

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
--------------------------------------------EFECTO INICIAL--------------------------------------------------
--------------------------(Es como aparece la linea...antes de lo timeado)---------------------------------

l = table.copy(line)--ESTO HARÁ QUE SE COPIEN LAS LINEAS
l.text = "{"..fad(300,0)..an(5)..move(x-100+rand(10),y-100+rand(10),x,y)..color(1,'ffffff')..bord(0.5)..color(3,'H000000')..t(fry(10080)..bord(1)).."}"..sil() --ESTOS SON LOS EFECTOS (Aqui es donde agregarás tus efectos de entrada)
l.start_time = line.start_time -800 --TIEMPO INICIAL DEL EFECTO (-800 = entrará 0.8 segundos antes de lo normal ( del tiempo timeado)
l.end_time = line.start_time ---TIEMPO FINAL DEL EFECTO 
l.layer=0 --NUMERO DE LA CAPA O LAYER..ES DECIR EL NIVEL EN EL QUE ESTARÁ (Por detras o delante de los demas efectos)
subs.append(l) ---HACE QUE TERMINE EL BLOQUE

--------------------------------------------------------------------------------------------------------------------

l = table.copy(line)
for j = 0, syl.height do
cx1 = 0 -- siempre cero
cy1 = l.top+j*1+1 -- comienza desde la cima de linea (tambien puede ser l.top+j*1+1)
cx2 = 1280 -- ancho video
cy2 = l.top+j*1+2 -- es igual a cy1 pero con un nº más (tambien puede ser l.top+j*1+2)
l.text = "{"..fad(100,0)..an(5)..pos(x,y)..clip(cx1, cy1, cx2, cy2)..RangeAlpha(1, j/syl.height,'00', 'ff')..RangeAlpha(3, j/syl.height,'00', 'ff')..color(1,'H86D3FF')..color(3,'H2F40BC')..bord(1).."}"..sil()
l.start_time = line.start_time
l.end_time = l.end_time
l.layer=0
subs.append(l)
end

---------------------------------------------FX DE SILABAS -------------------------------------------------------
-----------------------------------------------(Silaba)----------------------------------------------------------- 

--FX DE SILABAS
l = table.copy(line)
l.text = "{"..fad(0,5)..an(5)..pos(x,y)..t(fscxy(105)..bord(3))..color(3,'H4E86F5')..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer =3
subs.append(l)

--FX DE SILABAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..t(fscxy(105))..estilo(1,line.styleref.color2)..AutoTimer(TE3,2,'frz',2.5,0,1)..color(3,'H08187E').."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer =4
subs.append(l)

--------------------------------------------------------------------------------------------------------------------


	if syl.text ~=" " then -- NO APLICA EFECTO DE particulas EN ESPACIO EN BLANCO
	l = table.copy(line)
		
		for i = 0,54 do		
			--Variables
			fsx=rand(15,80)
			fsy=rand(15,80)
			posx1=x+rand(80)
			posy1=y+rand(25)
			posx2=x+rand(80)
			posy2=y+rand(25)
			frzrand=rand(360)
			
			l.text = "{"..color(3,'H29297B')..color(1,'H51529F')..bord(0.5)..an(5)..alpha(rand(0,100))..fad(100,200)..move(posx1,posy1,posx2,posy2)..fscxy(fsx,fsy)..frz(frzrand).."}"..p(1,Formas(9,2))--ESTOS SON LOS EFECTOS 
			l.start_time=line.start_time+syl.start_time+rand(200,400)--CONFIGURACION DEL TIEMPO INICIAL DEL EFECTO
			l.end_time=l.start_time+syl.duration+rand(200,400)---CONFIGURACION DEL TIEMPO FINAL DEL EFECTO
			l.layer = 2 --NUMERO DE LA CAPA O LAYER..ES DECIR EL NIVEL EN EL QUE ESTARÁ (Por detras o delante de los demas efectos)
			subs.append(l)---HACE QUE TERMINE EL BLOQUE			
		end	
	
	end	

elseif syl.inline_fx == "white" then	

	frand=rand(10)
	l.text = "{"..fad(0,400)..an(5)..move(x,y+50,x+50,y+55)..estilo(1,'HFFFFFF')..bord(0)..t(fr(frand)..bord(1)..fscxy(150,150)..alpha('ff')..color(3,'HFFFFFF')).."}"..sil()
	l.start_time=l.start_time+syl.start_time
	l.end_time=l.start_time+syl.duration
	l.layer = 0
	subs.append(l)	
	
end

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--

--------------------------------------HASTA AQUI TERMINAN LOS EFECTOS----------------------------------------------------
end
end

---------------------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("karaFX", "APLICAR EFECTO", Alki_FX)
aegisub.register_filter("karaFX", "APLICAR EFECTO", 2000, Alki_FX)
----------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------