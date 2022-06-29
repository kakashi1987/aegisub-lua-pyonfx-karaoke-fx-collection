
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--X                                                                                                            X
--X                                            EXPORTACION DE LIBRERIAS                                        X 
--X                              (¡No mover a menos de agregar una nueva libreria!)                            X
--X        (Sino tienes una libreria colocala aca:  "C:\Archivos de programa\Aegisub\automation\include)"      X
--X                                                                                                            X
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
include("karaskel.lua")                                                                                      
include("zheolib.lua")  -- version 1.1 -Revisión 2(22-mar-2009)                    
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--X                                                                                                            X
--X                                        TERMINAN EXPORTACION DE LIBRERIAS                                   X
--X                                                                                                            X
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--X                                                                                                            
--X    Copyright (c) 2009, ASEDARK  (ASE_DARK_ANGEL@hotmail.com)
--X    All rights reserved®.                                                                   
--X        
--X    Avisar de cualquier error, duda o sugerencia en cualquiera de las siguientes direcciones:
--X	
--X	          http://my.opera.com/ASEDARK/blog/
--X           http://my.opera.com/zheox/blog/
--X	          http://my.opera.com/nicklechama/blog/
--X	          
--X  
--X     
--X                                                                                                               
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx



--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--X                                                                                                            X
--X                                          CONFIGURACIONES DE LA MACRO                                       X 
--X                                                 (¡No mover!)                                               X
--X                                                                                                            X
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

script_name = "EJEMPLO DE AUTOTIMER (Version 1.0)"
script_description = "PLANTILLA ASEDARK"
script_author = "ASEDARK"
script_version = "2.0"

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--X                                                                                                            X
--X                                          FUNCIÓN GENERADOR DE EFECTO                                       X 
--X                                       (¡No mover a lo que no se indique!)                                  X
--X                                                                                                            X
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

-- ## FUNCIÓN GENERADOR DE EFECTO... ¡NO MODIFICABLE!
function ASEDARK_FX(subs)
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
	aegisub.set_undo_point("ASEDARK_FX")
end

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--X                                                                                                            X
--X                                          TERMINAN FUNCION GENERADOR                                        X
--X                                                                                                            X
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--X                                                                                                            X
--X                                      TERMINAN CONFIGURACIONES DE LA MACRO                                  X
--X                                                                                                            X
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--X                                                                                                            X
--X                                              CONFIGURACIÓN BÁSICA                                          X 
--X                                       (¡No mover a lo que no se indique!)                                  X
--X                                                                                                            X
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- ## CONFIGURACION DE X-Y
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 25 --AQUI CAMBIAS EL MARGEN DE LA POSICION DE LA LINEA (Que tan abajo estarán de arriba..XD)
if i == 1 then
tempo=0
end
-- ## FUNCIÓN DE LA ZHEOLIB
function sil()
silaba = ""..syl.text_stripped..""
return silaba
end

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--X                                                                                                            X
--X                                      TERMINA LA CONFIGURACIÓN BÁSICA                                       X
--X                                                                                                            X
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

function genespiral(radio,x,y,a,b,angulo)

radio=a + b*(angulo)
--pasar de polar  a rectangular
posx=x+radio*math.cos(angulo)
posy=y+radio*math.sin(angulo)
 
return posx,posy
end

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--X                                                                                                            X
--X                                              FUNCIONES                                                     X 
--X                       (Aca coloco las funciones que estoy usando en este Script)                           X
--X                                            (¡No mover !)                                                   X
--X                                                                                                            X
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

--####### FIN DE AUTOTIMER

			--FX INICIAL
		randomy ={15+rand(5),-15+rand(5)} 
        rand_y=y+randomy[math.random(1,2)]
		l = table.copy(line)
		l.text = "{"..fad(100,0)..an(5)..move(x,rand_y,x,y)..bord(0)..be(8)..color(1,'FFFFFF')..t(color(1,line.styleref.color2)..color(3,line.styleref.color3)..bord(1)..frx(0)).."}"..sil()
		l.start_time = line.start_time+syl.start_time-800+tempo
		l.end_time =line.start_time+syl.start_time
		l.layer=1
		subs.append(l)

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--X                                   EFECTO DE SILABAS ACTIVAS (TE3)                                          X 
--X                  ( Es el efecto de la silaba "ACTIVA" que se canta en el momento)                          X
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

--espiral
l=table.copy(line)
nparticulas=360*2
for z=0,nparticulas do
 angulo=math.rad(z)
 genespiral(radio,x,y,0.005,1,angulo) -- genespiral(radio,x,y,a,b,angulo)
 l.start_time=line.start_time+syl.start_time+z*1+1-800
 l.end_time=l.start_time+syl.duration
 l.text="{"..an(5)..pos(posx+rand(5),posy+rand(5))..color(1,line.styleref.color2)..bord(0).."}"..p(1,'m 0 0 l 0 1 l 1 1 l 1 0')
 subs.append(l)
end

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--X                                                                                                            X
--X                                            FIN DE LOS EFECTOS                                              X
--X                                                                                                            X
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


end
end

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--X                                REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN                              X
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
aegisub.register_macro("EXAMPLE DE AUTOTIMER (Version 1.0) - ASEDARK", "APLICAR EFECTO", ASEDARK_FX)                --X
aegisub.register_filter("-ASEDARK-", "APLICAR EFECTO", 2000, ASEDARK_FX)                                     --X
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--X                             TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN                      X
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

