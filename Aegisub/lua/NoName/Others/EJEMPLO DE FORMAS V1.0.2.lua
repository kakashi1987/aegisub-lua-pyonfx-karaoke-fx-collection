include("karaskel.lua")
include("zheolib.lua") --AGREGAMOS LA LIBRERIA ZHEOLIB
include("formaslib.lua") --AGREGAMOS LA LIBRERIA FORMASLIB

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "EJEMPLO DE FORMAS V1.0.1"
script_description = "EFECTOS EN LUA4 USANDO LA zheolib.lua  Y formaslib.lua"
script_author = "ASEDARK"
script_version = "1.0"


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
-- ## TERMINA FUNCION GENERADOR

-------------------------------TERMINA CONFIGURACIONES DE LA MACRO------------------------


-------------------------------ACÁ COMIENZA LA CONFIGURACIÓN BÁSICA-----------------------
-- ## CONFIGURACION DE X-Y
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 30 --AQUI CAMBIAS EL MARGEN DE LA POSICION DE LA LINEA (Que tan abajo estarán de arriba)
if i == 1 then
tempo=0
end
-- ## AGREGAMOS TAMBIEN ESTA FUNCIÓN
function sil()
silaba = ""..syl.text_stripped..""
return silaba
end

-----------------------------------TERMINA LA CONFIGURACIÓN BÁSICA-----------------------------


------------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
--------------------------------------------EFECTO INICIAL--------------------------------------------------
--------------------------(Es como aparece la linea...antes de lo timeado)---------------------------------

l = table.copy(line)--ESTO HARÁ QUE SE COPIEN LAS LINEAS
l.text = "{"..fad(300,0)..an(5)..move(x+rand(300),y+rand(30),x,y)..bord(0)..color(1,'ffffff')..t(frz(10080)..estilo(1,line.styleref.color1)..bord(1)).."}"..sil() --ESTOS SON LOS EFECTOS (Aqui es donde agregarás tus efectos de entrada)
l.start_time = line.start_time -800 --TIEMPO INICIAL DEL EFECTO (-800 = entrará 0.8 segundos antes de lo normal ( del tiempo timeado)
l.end_time = line.start_time ---TIEMPO FINAL DEL EFECTO 
l.layer=0 --NUMERO DE LA CAPA O LAYER..ES DECIR EL NIVEL EN EL QUE ESTARÁ (Por detras o delante de los demas efectos)
subs.append(l) ---HACE QUE TERMINE EL BLOQUE

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--


--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
-------------------------------------------SILABAS ESTATICAS -------------------------------------------------------
---------------------(LINEA DE KARAOKE......las que solo se quedan sin hacer nada)----------------------------------- 

l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..estilo(1,line.styleref.color2).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=0
subs.append(l)

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--


--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
--------------------------------------------EFECTO DE SILABAS---------------------------------------------------------- 
----------------------(Es el efecto de la silaba "ACTIVA" que se canta en el momento)----------------------------------

----------- CHICA
l = table.copy(line) 
l.text = "{"..an(5)..pos(x,y)..estilo(1,line.styleref.color2)..alfa(3,'ff')..t(fscxy(40)..alpha('ff')..fr(rand(720))).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 1
subs.append(l)

----------- GRANDE
POSALEX = x-rand(60,150)
POSALEY = y-rand(30)
GIROZ = rand(100)
l = table.copy(line) 
l.text = "{"..an(5)..fad(0,300)..move(x,y,POSALEX,POSALEY)..fscxy(100)..estilo(3,line.styleref.color3)..alfa(1,'ff')..t(fscxy(100+rand(50,150))..frz(GIROZ)).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 3
subs.append(l)



-----------EFECTO DE FIGURAS 
if syl.text ~=" " then -- NO APLICA EFECTO DE FIGURAS EN ESPACIO EN BLANCO

l = table.copy(line)

for j = 0,20 do

	POSX = x-rand(20,150)
	POSY = y+rand(35)
	
	l.text = "{"..an(5)..fad(100,200)..move(x,y+rand(4),POSX, POSY)..bord(5)..be(13)..fscxy(10)..color(1, RandomColor())..color(3, RandomColor())..t(bord(1)..fscxy(60)).."}"..p(2,Formas(18))--ESTOS SON LOS EFECTOS 

	l.start_time=line.start_time+syl.start_time--CONFIGURACION DEL TIEMPO INICIAL DEL EFECTO
	l.end_time=l.start_time+syl.duration---CONFIGURACION DEL TIEMPO FINAL DEL EFECTO
	l.layer = 2 --NUMERO DE LA CAPA O LAYER..ES DECIR EL NIVEL EN EL QUE ESTARÁ (Por detras o delante de los demas efectos)
	subs.append(l)---HACE QUE TERMINE EL BLOQUE
end
end



--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--

--------------------------------------HASTA AQUI TERMINAN LOS EFECTOS----------------------------------------------------


end
end
---------------------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("EXAMPLE DE FORMAS 01 - ASEDARK", "APLICAR EFECTO", ASEDARK_FX)
aegisub.register_filter("-ASEDARK-", "APLICAR EFECTO", 2000, ASEDARK_FX)
----------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------