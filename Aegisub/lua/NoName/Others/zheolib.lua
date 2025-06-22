include('utils.lua')
--[[
 Librería creada por David Pineda (Zheo) con Licencia gnu/GPL.
 Cuenta con la ayuda de Nande!, Nickles, Asedark y Alquimista
 en ir fortaleciendo la zheolib con sus funciones.
 
 Toda modificación y/ó rippeo descarado, debe ser con previo
 aviso al autor, o sea, yo xD.

 Esta librería esta en su versión 1.2, aún así, puede contener errores.
 Usarlo con cuidado.
 
 Agradecimientos enormes a Jerónimo Barraco (Nande!),
 por ser mi gran maestro de la programación,
 a mi novia Yumi *3* y a los FXXXmakers Social Club :D
--]]

--#############
--## ASS TAG ##
--#############
function b(valor)
return "\\b" ..math.floor(valor).. ""
end

function i(valor)
return "\\i" ..math.floor(valor).. ""
end

function u(valor)
return "\\u" ..math.floor(valor).. ""
end

function s(valor)
return "\\s" ..math.floor(valor).. ""
end

function bord(valor)
return "\\bord" ..valor.. ""
end

function shad(valor)
sombraZ =  "\\shad" ..valor.. ""
return sombraZ
end

function be(valor)
return "\\be" ..math.floor(valor).. ""
end

function fn(letra)
return "\\fn" ..letra.. ""
end

function fs(valor)
return "\\fs" ..math.floor(valor).. ""
end

function fscx(valor)
return "\\fscx" ..math.floor(valor).. ""
end

function fscy(valor)
return "\\fscy" ..math.floor(valor).. ""
end

function fsp(valor)
return "\\fsp" ..math.floor(valor).. ""
end

function frx(valor)
return "\\frx" ..math.floor(valor).. ""
end

function fry(valor)
return "\\fry" ..math.floor(valor).. ""
end

function frz(valor)
return "\\frz" ..math.floor(valor).. ""
end

function fr(valor)
return "\\fr" ..math.floor(valor).. ""
end

function fe(valor)
return "\\fe" ..math.floor(valor).. ""
end

function color(tipo, valor)
larval = string.len(valor)
if larval <= 6 then 
    return "\\" ..tipo.. "c&H" ..valor.. "&"
    else 
    return "\\" ..tipo.. "c" ..valor.. ""
end
end

function c(tipo, valor) -- lo mismo que Color()
larval = string.len(valor)
if larval <= 6 then 
    return "\\" ..tipo.. "c&H" ..valor.. "&"
    else 
    return "\\" ..tipo.. "c" ..valor.. ""
end
end

function al(valor)
return "\\a" ..math.floor(valor).. ""
end

function an(valor)
return "\\an" ..math.floor(valor).. ""
end

function alfa(tipo, valor)
return "\\" ..tipo.. "a&H" ..valor.. "&"
end

function a(tipo, valor) -- lo mismo que Alfa()
return "\\" ..tipo.. "a&H" ..valor.. "&"
end

function alpha(valor)
return "\\alpha&H" ..valor.. "&"
end

function r()
return "\\r"
end

function t(estilos)
return "\\t(" ..estilos.. ")"
end

function tt(t1,t2,acel)
if not acel then
    return "" ..math.floor(t1).. "," ..math.floor(t2).. ","
    else 
    return "" ..math.floor(t1).. "," ..math.floor(t2).. ","..math.floor(acel)..","
    end
end

function move(valorx1, valory1, valorx2, valory2, ti, tf) 
if not ti and not tf then
    return "\\move(" .. math.floor(valorx1).. "," ..math.floor(valory1).. ",".. math.floor(valorx2)..","..math.floor(valory2)..")"
    else
    return "\\move(" .. math.floor(valorx1).. "," ..math.floor(valory1).. ",".. math.floor(valorx2)..","..math.floor(valory2)..","..math.floor(ti)..","..math.floor(tf)..")"
    end
end

function pos(valorx, valory)
return "\\pos(" ..math.floor(valorx).. "," ..math.floor(valory).. ")"
end

function org(valorx, valory)
return "\\org(" ..math.floor(valorx).. "," ..math.floor(valory).. ")"
end

function fade(ac1,ac2,ac3,t1,t2,t3,t4)
return "\\fade(" ..ac1.. "," ..ac2.. "," ..ac3.. "," ..t1.. "," ..t2.. "," ..t3.. "," ..t4.. ")"
end

function fad(valori, valorf)
return "\\fad(" ..valori.. "," ..valorf.. ")"
end

function p(valor, codigo)
return "{\\p" ..valor.. "}" ..codigo.. "{\\p0}"
end

function clip(valorx1, valory1, valorx2, valory2)
return "\\clip(" .. math.floor(valorx1).. "," ..math.floor(valory1).. ",".. math.floor(valorx2)..","..math.floor(valory2)..")"
end

--###################################################
--## ASS TAG ESPECIALES (Version Mod del VSFilter) ##
--###################################################
function fax(valor)
return "\\fax" ..math.floor(valor).. ""
end

function fay(valor)
return "\\fay" ..math.floor(valor).. ""
end

function xbord(valor)
return "\\xbord" ..valor.. ""
end

function ybord(valor)
return "\\ybord" ..valor.. ""
end

function xshad(valor)
return "\\xshad" ..valor.. ""
end

function yshad(valor)
return "\\yshad" ..valor.. ""
end

function blur(valor)
return "\\blur" ..math.floor(valor).. ""
end

function iclip(valorx1, valory1, valorx2, valory2)
return "\\iclip(" .. math.floor(valorx1).. "," ..math.floor(valory1).. ",".. math.floor(valorx2)..","..math.floor(valory2)..")"
end

--##################
--## ASS TAG ZHEO ##
--##################
function fscxy(valorx, valory)
if not valory then
    return "\\fscx" ..math.floor(valorx).. "\\fscy" ..math.floor(valorx)..""
    else
    return "\\fscx" ..math.floor(valorx).. "\\fscy" ..math.floor(valory)..""
end
end

function estilo(tipo, valor) -- ya no sirve desde la v1.1-Rev3
return "\\" ..tipo.. "c" ..valor.. ""
end

--#############
--## DIBUJOS ##
--#############
function Fcirculo(valor)
if not valor or valor >=2 then
    return "m 0 0 m 10 20 b 16 20 20 16 20 10 b 20 4 16 0 10 0 b 2 0 0 6 0 10 b 0 16 4 20 10 20 "
    elseif valor == 1 then
    return "m 0 0 m 10 20 b 16 20 20 16 20 10 b 20 4 16 0 10 0 b 2 0 0 6 0 10 b 0 16 4 20 10 20 m 10 1 b 15 1 19 6 19 10 b 18 17 14 19 10 19 b 7 19 2 18 1 10 b 1 6 4 1 10 1 "
end
end

function Fovalo()
return "m 50 0 b 100 0 100 100 50 100 b 0 100 0 0 50 0 "
end

function Fbrillo(valor)
if not valor or valor >= 2 then
    return "m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c"
    elseif valor == 1 then
    return "m 0 0 l 0 -13 l 1 0 l 14 -7 l 2 1 l 14 7 l 1 2 l 1 15 l 0 2 l -13 7 l -1 1 l -13 -7 "
end    
end

function Festrella(valor)
if not valor or valor >=5 then
    return "m 10 49 l 52 19 l 0 19 l 42 49 l 26 0 "
    elseif valor == 1 then
    return "m 20 0 b 20 10 30 20 40 20 b 30 20 20 30 20 40 b 20 30 10 20 0 20 b 10 20 20 10 20 0 "
        elseif valor ==2 then
        return "m 20 0 b 20 10 30 20 40 20 b 30 20 20 30 20 40 b 20 30 10 20 0 20 b 10 20 20 10 20 0 m 25 20 b 24 17 23 16 20 15 b 17 16 16 17 15 20 b 16 23 17 24 20 25 b 23 24 24 23 25 20 "
            elseif valor ==3 then
            return "m 50 0 l 60 30 l 70 40 l 100 50 l 70 60 l 60 70 l 50 100 l 40 70 l 30 60 l 0 50 l 30 40 l 40 30 "
end
end

function Fcorazon(valor)
return "m 16 30 b 28 22 30 18 30 14 b 32 8 22 -2 16 10 b 10 -2 0 8 2 14 b 2 18 4 22 16 30 "
end

function Fpixel()
return "m 0 0 l 0 1 l 1 1 l 1 0 "
end

--###################################
--## FUNCIONES ESPECIALES POR ZHEO ##
--###################################
function rand(valorn, valorp)
if not valorn and not valorp then 
    return math.random(999)
elseif not valorp then
return math.random(-valorn, valorn)
    end
return math.random(valorn, valorp)    
end

function RangeColor(tipo, tr, varc1, varc2)
lc1 = string.len(varc1)
lc2 = string.len(varc2)
    if lc1 <= 6 or lc2 <= 6 then
        c1m = "&H"..varc1.."&"
        c2m = "&H"..varc2.."&"
    else
        c1m = varc1
        c2m = varc2
    end
return "\\"..tipo.."c"..interpolate_color(tr, c1m, c2m)..""
end

function RangeAlpha(tipo, tr, varc1, varc2)
lc1 = string.len(varc1)
lc2 = string.len(varc2)
    if lc1 <= 2 or lc2 <= 2 then
        c1m = "&H"..varc1.."&"
        c2m = "&H"..varc2.."&"
    else
        c1m = varc1
        c2m = varc2
    end
return "\\"..tipo.."a"..interpolate_alpha(tr, c1m, c2m)..""
end

function GenPosNeg()
genera_pos_neg = math.random(-1,1)
    if genera_pos_neg == 0 then
    genera_pos_neg = 1
    end
return genera_pos_neg
end

function DegradoV(letra, maxletra, altovideo, anchovideo, color1, color2, color3)
lcr1 = string.len(color1)
lcr2 = string.len(color2)
lcr3 = string.len(color3)
    if lcr1 <= 6 or lcr2 <= 6 or lcr3 <= 6 then
        c1m = "&H"..color1.."&"
        c2m = "&H"..color2.."&"
        c3m = "&H"..color3.."&"
    else
        c1m = color1
        c2m = color2
        c3m = color3
    end    
cv1 = 0
cv2 = altovideo+letra*1+1
cv3 = anchovideo
cv4 = altovideo+letra*1+2
colint1 = interpolate_color(letra/maxletra, c1m, c2m)
colint2 = interpolate_color(letra/maxletra, colint1, c3m)
return clip(cv1 , cv2, cv3, cv4)..c(1, colint2)
end


function Curve(intpol, x_ini, y_ini,  x_int1, y_int1, x_int2, y_int2, x_fin, y_fin)
curvx1 = interpolate(intpol, x_ini, x_int1)
curvx2 = interpolate(intpol, curvx1, x_int2)
curvx3 = interpolate(intpol, curvx2, x_fin)
curvy1 = interpolate(intpol, y_ini, y_int1)
curvy2 = interpolate(intpol, curvy1, y_int2)
curvy3 = interpolate(intpol, curvy2, y_fin)
cur_x, cur_y = curvx3, curvy3
return cur_x, cur_y
end

--#####################################
--## FUNCIONES ESPECIALES POR NANDE! ##
--#####################################
function RandomColor()
colores = {'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'}
rand_color= ""
	for j = 0,5 do
		rand_color = rand_color .. colores[math.random(1,15)]
		end
	return rand_color
end

--######################################
--## FUNCIONES ESPECIALES POR NICKLES ##
--######################################
function GenCirculo(radio,centrox,centroy,angulo,movimiento)
 posx=centrox + radio*math.cos(angulo)
 posy=centroy + radio*math.sin(angulo)
 
 if not movimiento then
   return posx,posy
 else
   posx1=centrox + (radio+movimiento)*math.cos(angulo)
   posy1=centroy + (radio+movimiento)*math.sin(angulo)
   return posx,posy,posx1,posy1
 end
end

function GenBucle(base,altura)
  area=(math.ceil(base)*math.ceil(altura))/4
  return area
end

function GenElipse(x,y,a,b,angulo)
 posx=x+a*math.cos(angulo)
 posy=y+b*math.sin(angulo)
 return posx,posy
end

function GenParabola(x,y,p,angulo,tipo) 
 if not tipo or tipo==1 then
 --parabola Horizontal
  posx=x+(p/2)*((1/math.tan(angulo))^2)
  posy=y+p*(1/math.tan(angulo))
 elseif tipo==2 then
 --parabola vertical
  posx=x+p*(1/math.tan(angulo))
  posy=y+(p/2)*((1/math.tan(angulo))^2)
 end
 return posx,posy
end

function GenHiperbola(x,y,a,b,angulo)
 posx=x+a*(1/math.cos(angulo)) 
 posy=y+b*math.tan(angulo)
return posx,posy
end

function GenMariposa(x,y,a,b,c,d,angulo) -- beta
 posx=x+(a*math.sin(angulo))*(math.exp(math.cos(angulo))-(c*math.cos(4*angulo))-(math.sin(angulo/12))^5)
 posy=y+(b*math.cos(angulo))*(math.exp(math.cos(angulo))-(d*math.cos(4*angulo))-(math.sin(angulo/12))^5)
 return posx,posy
end

function convAlpha(valor)
	if valor < 0 or valor >255 then
		valor=0
	end
	return "\\alpha"..ass_alpha(valor)..""
end

--#########################################
--## FUNCIONES ESPECIALES POR ALQUIMISTA ##
--#########################################
function GenEspiral(radio,x,y,a,b,angulo)
radio=a + b*(angulo)
posx=x+radio*math.cos(angulo)
posy=y+radio*math.sin(angulo)
return posx,posy
end

function GenCoseno(x,y,angulo,ancho,altura,margenleft)
     posx=margenleft+((angulo)*ancho)
     posy=y+(math.cos(angulo)*altura)
     return posx,posy
end

function GenSencos(funcion,angulo,ancho,altura)
if funcion==1 then --seno
posy=y-(altura*math.sin(angulo)) 
elseif funcion==2 then --coseno
posy=y-(altura*math.cos(angulo))
end
posx=line.left+(ancho*(angulo))
return string.format("\\pos(%d,%d)",posx,posy)
end


--######################################
--## FUNCIONES ESPECIALES POR ASEDARK ##
--######################################
function AutoTimer(TipoDeLinea,Intervalo,Tag,ValorInicialTag,AumentoTag,MasYMenos)
local RESULTADO_01 = 0
RESULTADO_01=""
local RESULTADO_02 = 0
RESULTADO_02=""
local DIRECCION =1
-- ACA SE DEFINEN LOS TIPOS DE LINEA
for i = 1, l.kara.n do

	local SILABA = l.kara[i];
	local LINEA = l;
	local LINEA_INICIO = LINEA.start_time;
	local SILABA_INICIO = SILABA.start_time;
	local LINEA_DURACION = LINEA.duration;
		
	if TipoDeLinea == TE1 then -- EFECTO DE ENTRADA
	DURACION =(LINEA_INICIO-800)/Intervalo
	end
	
	if TipoDeLinea == TE2 then -- EFECTO DE SILABA ESTATICA 01
	DURACION =((LINEA_INICIO)/Intervalo)
	end

	if TipoDeLinea == TE3 then -- EFECTO DE SILABA ACTIVA
	DURACION =(LINEA_INICIO+SILABA_INICIO)/Intervalo
	end
	
	if TipoDeLinea == TE4 then -- EFECTO DE SALIDA
	DURACION =(LINEA_DURACION)/Intervalo
	end	
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

function AutoTags(TipoDeLinea,Intervalo,Dato1,Dato2)   
 local RESULTADO = 0 
 RESULTADO=""
 local SUERTE = 0
 local CONTADOR = 0
 local ARREGLO = 0
-- ACA SE DEFINEN LOS TIPOS DE LINEA
for i = 1, l.kara.n do

	local SILABA = l.kara[i];
	local LINEA = l;
	local LINEA_INICIO = LINEA.start_time;
	local SILABA_INICIO = SILABA.start_time;
	local LINEA_DURACION = LINEA.duration;
	
	if TipoDeLinea == TE1 then -- EFECTO DE ENTRADA
	DURACION =(LINEA_INICIO-800)/Intervalo
	end
	
	if TipoDeLinea == TE2 then -- EFECTO DE SILABA ESTATICA 01
	DURACION =((LINEA_INICIO)/Intervalo)
	end

	if TipoDeLinea == TE3 then -- EFECTO DE SILABA ACTIVA
	DURACION =(LINEA_INICIO+SILABA_INICIO)/Intervalo
	end
	
	if TipoDeLinea == TE4 then -- EFECTO DE SALIDA
	DURACION =(LINEA_DURACION)/Intervalo
	end
end
 -->>>>>>>>>>>>>> FIN DE LOS TIPOS DE LINEA
 local count = math.ceil(DURACION) 
 -->>>>>>>>>>>>>> CONTENEDOR DE TAGS+VALORES [DATOS]
ARREGLO = {Dato1,Dato2}
-->>>>>>>>>>>>>> FIN DEL CONTENEDOR
 for i = 1, count do  
    CONTADOR = i
	--|||| 02 DATOS
		if Dato1 and Dato2 then 
					if  CONTADOR%2 ==0 then
								SUERTE = ARREGLO[1]
					else
								SUERTE = ARREGLO[2]
					end	
		end 
	RESULTADO = RESULTADO .."\\t(" ..(i-1)*Intervalo.. "," ..i*Intervalo.. ",\\" ..SUERTE..")".."" 
end   		
return RESULTADO	  		 
end 

function frxyz(valorx,valory,valorz)
	local VACIO = 0

		if  valorx and valory and valorz and valorx ~=VACIO and valory ~=VACIO and valorz ~=VACIO then --..frxyz(50,60,70)|..frxyz(~=0,~=0,~=0)
			giroXYZ = "\\frx" ..math.floor(valorx).. "\\fry" ..math.floor(valory).. "\\frz" ..math.floor(valorz)..""
			return giroXYZ		
		else
			if not valorz and valorx and valory and valorx ~=VACIO and valory ~=VACIO then  --..frxyz(50,60)
				giroXY_1 = "\\frx" ..math.floor(valorx).. "\\fry" ..math.floor(valory).. ""
				return giroXY_1
			end	
			if valorx and valorx ~= 0  and not valory and not valorz then --..frxyz(50)|--..frxyz(~=0)
				giroXYZall = "\\frx" ..math.floor(valorx).. "\\fry" ..math.floor(valorx).. "\\frz" ..math.floor(valorx)..""
				return giroXYZall
			end
			if valorx and valory and valorz and valorx ~=VACIO and valory ~=VACIO and valorz == 0 then --..frxyz(50,60,0)
				giroXY = "\\frx" ..math.floor(valorx).. "\\fry" ..math.floor(valory)..""
				return giroXY
			end	
			if valorx and valory and valorz and valorx~=VACIO and valory == 0 and valorz==0 then --..frxyz(50,0,0)
				giroX = "\\frx" ..math.floor(valorx)..""
				return giroX
			end	
			if valorx and valory and not valorz and valorx~=VACIO and valory == 0  then --..frxyz(50,0)
				giroX = "\\frx" ..math.floor(valorx)..""
				return giroX
			end	
			if valorx and valory and valorz and valorx ~=VACIO and valory == 0 and valorz ~=VACIO then  --..frxyz(50,0,70)
				giroXZ = "\\frx" ..math.floor(valorx).. "\\frz" ..math.floor(valorz)..""
				return giroXZ
			end		
			if valorx and valory and valorz and valorx == 0 and valory ~=VACIO and valorz ~=VACIO then --..frxyz(0,60,70)
				giroYZ = "\\fry" ..math.floor(valory).. "\\frz" ..math.floor(valorz)..""
				return giroYZ
			end	
			if valorx and valory and valorz and valorx == 0 and valory ~=VACIO and valorz == 0 then --..frxyz(0,60,0)
				giroYZ = "\\fry" ..math.floor(valory)..""
				return giroYZ
			end
			if valorx and valory and valorz and valorx == 0 and valory == 0 and valorz ~=VACIO then --..frxyz(0,0,70)
				giroYZ = "\\frz" ..math.floor(valorz)..""
				return giroYZ
			end							
			if valorx and valory and valorz and valorx == 0  and valory == 0 and valorz == 0 then --..frxyz(0,0,0) --DESACTIVA TODOS LOS TAGS
				giroNotXYZ = "\\frx" ..math.floor(valorx).. "\\fry" ..math.floor(valory).. "\\frz" ..math.floor(valorz)..""
				return giroNotXYZ 
			end
			if valorx and valory and valorx == 0  and valory ==0 and not valorz  then --..frxyz(0,0)
				giroNotXYZ_2 = ""
				return giroNotXYZ_2
			end
			if valorx and valorx == 0  and not valory and not valorz  then --..frxyz(0) --DESACTIVA TODOS LOS TAGS
				giroNotXYZ_3 = "\\frx" ..math.floor(valorx).. "\\fry" ..math.floor(valory).. "\\frz" ..math.floor(valorz)..""
				return giroNotXYZ_3
			end		

		end			
end  
