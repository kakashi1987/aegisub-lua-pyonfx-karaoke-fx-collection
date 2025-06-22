-------------------------------CARGA DE LUA AUXILIAR-------------------------------------
include("karaskel.lua")

-------------------------------CONFIGURACION DE LA MACRO--------------------------------

script_name = "TONIGH"
script_description = "PLANTILLA PARA HACER EFECTOS EN LUA4"
script_author = "ASEDARK"
script_version = "0.1 PLANTILLA"

--FUNCIÓN GENERADOR DE EFECTO... ¡NO MODIFICABLE!
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
				(l.style == "Default1") then
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
	aegisub.set_undo_point("TONIGH")
end
--TERMINA FUNCION GENERADOR

-------------------------------TERMINA CONFIGURACION DE LA MACRO------------------------

-------------------------------APARTIR DE AQUI COMIENZAN LOS EFECTOS-----------------------------------

--CONFIGURACION DE X-Y
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 122 --AQUI CAMBIAS EL MARGEN DE LA POSICION DE LA LINEA (Que tan abajo estarán)

function sil()
silaba = ""..syl.text_stripped..""
return silaba
end

ESPACIO = 'syl.text_stripped'

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
--------------------------------------------EFECTO INICIAL--------------------------------------------------
--------------------------(Es como aparece la linea...antes de lo timeado)---------------------------------

l = table.copy(line)--ESTO HARA QUE SE COPIEN LAS LINEAS
	COLOR_1C = {'&H00293F&'}
	BORDE_3C = {'&H7AD0F9&'}
l.text = string.format("{\\fad(400,0)\\an5\\move(%d,%d,%d,%d)\\bord2\\fscx50\\fscy50\\1c%s\\3c%s\\t(\\fscx100\\fscy100\\shad0)}%s",x+math.random(-200,500),y-math.random(-30,30),x,y,line.styleref.color1,line.styleref.color3,syl.text_stripped) --ESTOS SON LOS EFECTOS (Aqui es donde agregarás tus efectos de entrada)
l.start_time = line.start_time -600  --TIEMPO INICIAL DEL EFECTO (-400 = entrará 0.6 segundos antes de lo normal ( del tiempo timeado)
l.end_time = line.start_time ---TIEMPO FINAL DEL EFECTO 
l.layer=1 --NUMERO DE LA CAPA O LAYER..ES DECIR EL NIVEL EN EL QUE ESTARÁ (Por detras o delante de los demas efectos)
subs.append(l) ---HACE QUE TERMINE EL BLOQUE

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--


--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
-------------------------------------------SILABAS SIN MOVER -------------------------------------------------------
-------------- --(LINEA DE KARAOKE...las del medio...las ke solo se kedan sin hacer nada)--------------------------- 

l = table.copy(line)
	COLOR_1C = {'&H00293F&'}
	BORDE_3C = {'&H7AD0F9&'}
l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\3c%s\\shad0\\fscy100}%s",x,y,line.styleref.color1,line.styleref.color3,syl.text_stripped)--ESTOS SON LOS EFECTOS (Aqui es donde agregarás tus efectos)
l.start_time = line.start_time --CONFIGURACION DEL TIEMPO INICIAL DEL EFECTO
l.end_time=l.end_time---CONFIGURACION DEL TIEMPO FINAL DEL EFECTO
l.layer=1 --NUMERO DE LA CAPA O LAYER..ES DECIR EL NIVEL EN EL QUE ESTARÁ (Por detras o delante de los demas efectos)
subs.append(l)---HACE QUE TERMINE EL BLOQUE


------- EFECTO DESPUES DE CANTAR
for i=0,1 do
   l = table.copy(line)
   l.text = string.format("{\\an5\\shad0\\bord2\\pos(%d,%d)\\1c%s\\3c%s\\}%s", x, y,line.styleref.color2,line.styleref.color3,syl.text_stripped)
l.start_time=line.start_time+(syl.start_time+150)
l.end_time=l.end_time
l.layer=1
subs.append(l)

end

------- EFECTO POSTLINE
for i=0,0 do
   ROTACION_FR= {'-10080','10080'}
   l = table.copy(line)
   l.text = string.format("{\\an5\\fad(0,600)\\shad0\\bord2\\move(%d,%d,%d,%d)\\1c%s\\3c%s\\t(\\fscx50\\fscx50\\fr%d)}%s", x, y, x+math.random(-250,250), y+math.random(-30,30),line.styleref.color2,line.styleref.color3,ROTACION_FR[math.random(1,2)],syl.text_stripped)
l.start_time=line.end_time
l.end_time=(l.end_time+600)
l.layer=2
subs.append(l)

end
--------------------------------------------------------------------------------------------------------------------
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--


--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--
--------------------------------------------EFECTO DE SILABAS---------------------------------------------------------- 
-------------------------------(Es el efecto de la silaba que se canta en el momento)----------------------------------

-----------EFECTO LETRA 01
l = table.copy(line)
for j = 0,1 do
	ASEDARK_1C = {'&HDBF1FA&', '&HDBF1FA&' }
	ASEDARK_3C = {'&HDBF1FA&', '&HDBF1FA&'}
	l.text = string.format("{\\fad(100,200)\\bord3\\be13\\an5\\move(%d,%d,%d,%d)\\1c%s\\3c%s\\fscx130\\fscy130\\shad0\\t(\\bord5\\blur15\\fscx50\\fscy50)}%s", x,y,x,y,ASEDARK_1C[math.random(1,2)],ASEDARK_3C[math.random(1,2)], syl.text_stripped)--ESTOS SON LOS EFECTOS (Aqui es donde agregarás tus efectos de silabas)
	l.start_time=line.start_time+syl.start_time--CONFIGURACION DEL TIEMPO INICIAL DEL EFECTO
	l.end_time=l.start_time+syl.duration---CONFIGURACION DEL TIEMPO FINAL DEL EFECTO
	l.layer = 3 --NUMERO DE LA CAPA O LAYER..ES DECIR EL NIVEL EN EL QUE ESTARÁ (Por detras o delante de los demas efectos)
	subs.append(l)---HACE QUE TERMINE EL BLOQUE
end
-------------------------------
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--------------------------------------------EFECTO DE FIGURAS---------------------------------------------------------- 
-------------------------------(Es el efecto de las figuras)----------------------------------


-----------EFECTO DE FIGURAS 01

--[[
if syl.text ==" " then 
l = table.copy(line)
l.text = " " 
else ]]

l = table.copy(line)
if sil() == " " then 
l.text = " " 
else 
for j = 0,30 do
	ASEDARK_1C = {'&HDBF1FA&', '&HB2E5FB&','&H94DBFC&','&H70CAF0&'}
	ASEDARK_3C = {'&HDBF1FA&', '&HB2E5FB&','&H94DBFC&','&H70CAF0&'}
	ROTACION_Z= math.random(-359,359)
	ROTACION_X= math.random(-140,140)
	ROTACION_Y= math.random(-359,359)
	l.text = string.format("{\\fad(100,200)\\bord3\\be13\\an5\\move(%d,%d,%d,%d)\\1c%s\\3c%s\\fscx10\\fscy10\\shad0\\fr10080\\t(\\bord0.2\\fscx100\\fscy100\\frz%d\\fry%d\\frx%d)}{\\p3}m -43 -1 b -35 -4 -28 -6 -20 -9 b -13 -2 -7 5 0 12 b 9 6 19 0 28 -6 b 35 3 42 11 49 20 b 42 14 36 9 29 3 b 19 10 10 16 0 23 b -7 14 -14 6 -21 -3 b -32 4 -44 10 -55 17 b -51 11 -47 5 -43 -1 {\\p0}", x,y+2,x-math.random(-15,15),y+math.random(-15,15),ASEDARK_1C[math.random(1,4)],ASEDARK_3C[math.random(1,4)],ROTACION_Z, ROTACION_Y, ROTACION_X,syl.text_stripped)--ESTOS SON LOS EFECTOS (Aqui es donde agregarás tus efectos de silabas)
	l.start_time=line.start_time+syl.start_time--CONFIGURACION DEL TIEMPO INICIAL DEL EFECTO
	l.end_time=l.start_time+syl.duration---CONFIGURACION DEL TIEMPO FINAL DEL EFECTO
	l.layer = 2	--NUMERO DE LA CAPA O LAYER..ES DECIR EL NIVEL EN EL QUE ESTARÁ (Por detras o delante de los demas efectos)
	subs.append(l)---HACE QUE TERMINE EL BLOQUE
end
--------------------------------
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


end



end
end

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--

--------------------------------------HASTA AQUI TERMINAN LOS EFECTOS----------------------------------------------------


---------------------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("TONIGH", "APLICAR EFECTO", ASEDARK_FX)
aegisub.register_filter("TONIGH", "APLICAR EFECTO", 2000, ASEDARK_FX)
----------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------