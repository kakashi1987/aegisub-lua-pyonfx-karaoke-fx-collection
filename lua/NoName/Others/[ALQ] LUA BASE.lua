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
				(l.style == "Default" or l.style == "Traduccion" or l.style == "Kanji"  or l.style == "OPR") then  -- en esta linea coloca el nombre del estilo al que afectará el script lua
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

if syl.inline_fx == "" then

x=syl.center + line.left
y=line.margin_v + 25

--FX DE SILABAS
l = table.copy(line)
l.text = "{"..an(5)..org(x,y)..pos(x,y)..estilo(1,line.styleref.color1)..t(tt(sstart,smid)..bord(0)..shad(0))..t(alpha('ff'))..t(tt(smid,send)..fscxy(100,230)..color(1,'ffffff')..color(3,'CBCBCB')).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration+500
l.layer = 2
subs.append(l)

-- ## FX INICIAL
l = table.copy(line)
for j = 0, syl.height do
l.text = "{"..fad(100,0)..an(5)..pos(x,y)..bord(0)..frx(100)..color(1,'ffffff')..t(frx(360)..bord(2)).."}"..sil()
l.start_time = line.start_time+tempo-800
l.end_time = line.start_time
l.layer=0
subs.append(l)
end

--## SILABAS ESTATICAS
l = table.copy(line)
for j = 0, syl.height do
l.text = "{"..an(5)..pos(x,y)..DegradoV(j, syl.height-17, 12, 840, 'ffffff' , line.styleref.color1, line.styleref.color2 ).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=1
subs.append(l)
end
tempo=tempo+(1000/line.kara.n)

--## PIXEL PARTICULAS

	l = table.copy(line)
for n=0, 300 do
	l.text = "{"..an(5)..bord(0)..move(x+rand(50),y+rand(10),x+rand(5)-rand(20,50),y+rand(10))..bord(0)..color(1,'CCDCCC')..fscxy(100,100).."}"..p(1,Formas(1))
	l.start_time=line.start_time+syl.start_time+rand(100)
	l.end_time=l.start_time+syl.duration+rand(100,500)
	l.layer = 3
	subs.append(l)
end


--[[## FX CIRCLE
l = table.copy(line)
if sil() == " " then -- si se karaokea un espacio (suele pasar, siegino, no hubiese hecho esto xD)
l.text = " " -- el resultado será un espacio y no una explosión :D
else -- si no es un espacio, hará el FX =D
for r=1,16 do
if r==1 then
	suma=2
end
angulo=math.rad(suma)
GenCirculo(0,x,y,suma,30)

l.text = "{"..fad(100,100)..an(5)..org(x,y)..move(posx,posy,posx1,posy1)..color(1,'ffffff')..fscxy(200,200)..bord(0)..frz(0)..t(estilo(1,line.styleref.color2)..frz(360)).."}"..p(4,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c')
l.start_time=line.start_time+syl.start_time
l.end_time= l.start_time+(syl.duration/2)
l.layer = 0
subs.append(l)
suma=suma+15
end
end

--## FX CIRCLE DE REGRESO
l = table.copy(line)
if sil() == " " then -- si se karaokea un espacio (suele pasar, sino, no hubiese hecho esto xD)
l.text = " " -- el resultado será un espacio y no una explosión :D
else -- si no es un espacio, hará el FX =D
for r=1,16 do
if r==1 then
	suma=3
end
angulo=math.rad(suma)
GenCirculo(30,x,y,suma,-30)

l.text = "{"..fad(100,100)..an(5)..org(x,y)..move(posx,posy,posx1,posy1)..color(1,'ffffff')..fscxy(200,200)..bord(0)..frz(0)..t(estilo(1,line.styleref.color2)..frz(360)).."}"..p(4,'m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c')
l.start_time=line.start_time+syl.start_time+(syl.duration/2)
l.end_time= l.start_time+syl.duration
l.layer = 0
subs.append(l)
suma=suma+15
end
end--]]

else

x=syl.center + line.left
y=line.margin_v + 50

--FX DE SILABAS
l = table.copy(line)
l.text = "{"..an(5)..org(x,y)..pos(x,y)..estilo(1,line.styleref.color1)..t(tt(sstart,smid)..bord(0)..shad(0))..t(alpha('ff'))..t(tt(smid,send)..fscxy(100,230)..color(1,'ffffff')..color(3,'CBCBCB')).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration+500
l.layer = 2
subs.append(l)

-- ## FX INICIAL
l = table.copy(line)
for j = 0, syl.height do
l.text = "{"..fad(100,0)..an(5)..pos(x,y)..bord(0)..frx(100)..color(1,'ffffff')..t(frx(360)..bord(2)).."}"..sil()
l.start_time = line.start_time+tempo-800
l.end_time = line.start_time
l.layer=0
subs.append(l)
end

--## SILABAS ESTATICAS
l = table.copy(line)
for j = 0, syl.height do
l.text = "{"..an(5)..pos(x,y)..color(1,line.styleref.color2).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=1
subs.append(l)
end
tempo=tempo+(1000/line.kara.n)

--## PIXEL PARTICULAS
	l = table.copy(line)
for n=0, 300 do
	l.text = "{"..an(5)..bord(0)..move(x+rand(50),y+rand(10),x+rand(5)-rand(20,50),y+rand(10))..bord(0)..color(1,'CCDCCC')..fscxy(100,100).."}"..p(1,Formas(1))
	l.start_time=line.start_time+syl.start_time+rand(100)
	l.end_time=l.start_time+syl.duration+rand(100,500)
	l.layer = 2
	subs.append(l)
end

end

--------------------------------------HASTA AQUI TERMINAN LOS EFECTOS-----------------------------------------------------
--NO LOS QUITES
	end
end
---------------------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("fx", "APLICAR EFECTO", Alki_FX)
aegisub.register_filter("fx", "APLICAR EFECTO", 2000, Alki_FX)
----------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------------