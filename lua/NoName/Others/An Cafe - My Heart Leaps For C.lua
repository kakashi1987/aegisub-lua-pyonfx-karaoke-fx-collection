include("karaskel.lua")
include("zheolib.lua")
include("formaslib.lua") -- AGREGAMOS EL FORMASLIB

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Being"
script_description = "Being FX"
script_author = "Aoi.Alternative"
script_version = "User.Beta.2009"

--FUNCIÓN GENERADOR FX... NO TOCAR!!!
function fx_zheo(subs)
	aegisub.progress.task("ESPERA MIESTRAS SE HACE EL FX... (Sale a dar una vuelta D:)")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Aplicando tu Cagá de FX D:")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Esto llevo trabajado (%d/%d)...", ai, maxai))
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
	aegisub.progress.task("Por fin termine D:!")
	aegisub.progress.set(100)
end
--TERMINA FUNCION GENERADOR

-------------------------------TERMINA CONFIGURACIONES DE LA MACRO------------------------

-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

--CONFIGURACION DE X-Y
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v +40
if i ==1 then
tiempo=0
end

function blurco(valor) --ALPHA POR SORA LAMPAGEROUCH!!
blurC =  "\\blur" ..math.floor(valor).. "\\bord" ..math.floor(valor+valor/2/1).. ""
return blurC
end

-- ## AGREGAMOS TAMBIEN ESTA FUNCIÓN
function sil()
silaba = ""..syl.text_stripped..""
return silaba
end

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

--####### FUNCION AUTOTIMER (Versión Beta) creada por ASEDARK y Sora-kun
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

--####### FIN DE AUTOTIMER###########################----------------------------------------

--###################FUNCION AUTOTAG####################--

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

--###################FIN AUTOTAG####################--

--######################################Comienzo de Efectos#######################--

--FX INICIAL
	l = table.copy(line)
	l.text = string.format("{\\fad(100,0)\\an5\\move(%d,%d,%d,%d)\\bord0\\fry100\\t(\\fry360\\bord2)}%s",x-20,y-10,x,y,syl.text_stripped)
	l.start_time = line.start_time-500
	l.end_time = line.start_time
	l.layer=3
	subs.append(l)



		
		--SILABAS ESTATICAS
l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\bord1\\blur4\\1c%s}%s",x,y,line.styleref.color1,syl.text_stripped)
l.start_time = line.start_time+tiempo
l.end_time = line.start_time+syl.start_time+syl.duration
l.layer=1
subs.append(l)

		l = table.copy(line)
			frand=rand(10)
			l.text = "{"..fad(100,200)..an(5)..pos(x,y)..bord(0)..blur(7)..color(1,'HFFFFFF')..t(alfa(1,'ff')).."}"..sil()
			l.start_time=l.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration+1000			
			l.layer = 90
			subs.append(l)
		
	l = table.copy(line)
				l.text = "{"..an(5)..pos(x,y)..color(1,'&HBDFCFF&')..bord(0)..fscxy(100,200)..t(fscxy(125,125))..t(syl.start_time + syl.duration / 2, syl.end_time, color(1,'HFFFFFF')..color(3,'HFFFFFF')..bord(2))..color(2,'HFFFFFF')..frx(360).."}"..sil()
				l.start_time=line.start_time+syl.start_time
				l.end_time=l.start_time+syl.duration
				l.layer =1
				subs.append(l)
				
				
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..estilo(1,line.styleref.color1)..t(fscxy(150,150)..alpha('ff')).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=line.start_time+syl.start_time + (syl.duration/2)
l.layer=2
subs.append(l)

	--SILABAS ESTATICAS (1)
		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s}%s",x,y,line.styleref.color1,syl.text_stripped)
		l.start_time = line.start_time+tiempo
		l.end_time = line.start_time+syl.start_time
		l.layer=2
		subs.append(l)
		
		--SILABAS ESTATICAS (2)
		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\alpha&H96&\\blur1}%s",x,y,line.styleref.color1,syl.text_stripped)
		l.start_time = line.start_time+syl.start_time
		l.layer=3
		subs.append(l)
		
		l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..estilo(1,line.styleref.color1)..t(fscxy(180,180)..alpha('ff')).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=line.start_time+syl.start_time + (syl.duration/2)
l.layer=99
subs.append(l)

-- FX GLOW
l = table.copy(line)
for i=0,15 do
    l.layer=100
    l.text = string.format("{\\pos(%d,%d)\\an5\\shad0\\3c&HFFFFFF&\\1a&HF5&\\3a&HF5&\\bord%d\\fscx100\\fscy100\\t(\\bord0\\3c%s\\fscx100\\fscy100)}%s",x,y,1+ i*1,line.styleref.color2, syl.text_stripped)
    l.start_time=line.start_time+syl.start_time
    l.end_time=l.start_time+syl.duration
    subs.append(l)
    end

		--Humo
l = table.copy(line)
for i = 0,50 do
l.text = "{"..an(5)..move(x+rand(30),y+rand(30),x+rand(20)-100+(i*2),y+rand(30)/2)..t(fscxy(100,100)..color(3,"&H2985F6&")..frz(300))..blur(5).."}"..p(3,Formas(5,5))--'HD7D6D2'--HD4D3CE--HD3EAFF
l.start_time=line.start_time+syl.start_time+math.random(-50,50)
l.end_time=l.start_time+rand(600,900)
l.layer = 40
subs.append(l)
end

end
end
-------------------------------ACÁ TERMINAN LOS EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("BEING_KOTOKO", "Aplica tu FX! D:", fx_zheo)
aegisub.register_filter("BEING_KOTOKO", "Aplica tu FX! D:", 2000, fx_zheo)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------