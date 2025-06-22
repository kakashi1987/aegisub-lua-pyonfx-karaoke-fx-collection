-- SCRIPT MODIFICADO Y COMENTADO POR ALQUIMISTA
-- GRACIAS A ZHEO, NICKLE, ASEDARK (ROBE ALGUNOS COMENTARIOS DE TUS EJEMPLOS) Y A TODO EL SOCIAL CLUB DE FXMAKERS
-- SON LIBRES DE MODIFICARLO A SU ANTOJO
-- USEN NOTEPAD++ PARA QUE VEN TODO ACOMODADITO Y CON COLORES xD

--INCLUIR LIBRERIAS
include("karaskel.lua") --SIEMPRE HAY QUE AGREGARLA
include("zheolib.lua") --AGREGAMOS LA LIBRERIA ZHEOLIB
include("formaslib.lua") --AGREGAMOS LA LIBRERIA FORMASLIB

--\\-----------------------------CONFIGURACIONES DE LA MACRO------------------------------\\--

--[[-------------------------------------------/
                                               /
	script_name = "un disque karaoke"          /
	script_description = "EFECTOS EN LUA4"     /
	script_author = "Alquimista"               /
	script_version = "1.0"                     /
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
				(l.style == "Default") then  -- en esta linea coloca el nombre del estilo al que afectará el script lua
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

-- CONFIGURACION DE LA POSICION DEL SUBTITULO
function do_fx(subs, meta, line)
	for i = 1, line.kara.n do
		local syl = line.kara[i]
		local x=syl.center + line.left
		local y=line.margin_v + 23 --AQUI CAMBIAS EL MARGEN DE LA POSICION DE LA LINEA (Que tan abajo estarán de arriba)
		if i == 1 then
			tempo=0
		end
		
		-- AGREGAMOS TAMBIEN ESTA FUNCIÓN
		function sil()
			silaba = ""..syl.text_stripped..""
			return silaba
		end
			
		--FX CIRCULO PARTICULAS
l = table.copy(line)
for r=0,10 do 

   if r==0 then
     p1=0
   end

   angulo=p1
   GenCirculo(3,x,y,p1,15)
   l.text = "{"..fad(100,100)..an(5)..bord(0)..org(x,y)..move(posx+rand(30),posy+rand(30),posx1+rand(20)-100,posy1+rand(20)+10)..color(1,'HD4D3CE')..fscx(200,200)..frz(0).."}"..p(3,Formas(36,1))--'HD7D6D2'--HD4D3CE--HD3EAFF
   l.start_time=line.start_time+syl.start_time
   l.end_time=l.start_time+syl.duration+syl.duration+rand(300)
   l.layer = 2
   subs.append(l)
   p1=p1+(math.pi/16)
end

fr ={'360', '720'}
randfr= fr[math.random(1,2)]

			l = table.copy(line)--ESTO HARÁ QUE SE COPIEN LAS LINEAS
			l.text = "{"..fad(800,0)..an(5)..move(-10+rand(10),y,x,y)..org(x,y)..alfa(1,'ff')..bord(1)..frx(randfr+rand(15))..color(3,'HFFFFFF')..be(1)..t(frx(0)).."}"..sil() --ESTOS SON LOS EFECTOS (Aqui es donde agregarás tus efectos de entrada)
			l.start_time = line.start_time -1000 --TIEMPO INICIAL DEL EFECTO (-800 = entrará 0.8 segundos antes de lo normal ( del tiempo timeado)
			l.end_time = line.start_time ---TIEMPO FINAL DEL EFECTO 
			l.layer=0 --NUMERO DE LA CAPA O LAYER..ES DECIR EL NIVEL EN EL QUE ESTARÁ (Por detras o delante de los demas efectos)
			subs.append(l) ---HACE QUE TERMINE EL BLOQUE

			--SILABAS ESTATICAS(LINEA DE KARAOKE......las que solo se quedan sin hacer nada)
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..color(1,line.styleref.color2).."}"..sil()
			l.start_time = line.start_time
			l.end_time = line.start_time+syl.start_time
			l.layer=1
			subs.append(l)

			--EFECTO DE SILABAS(Es el efecto de la silaba "ACTIVA" que se canta en el momento)

				l = table.copy(line)
				l.text = "{"..an(5)..pos(x,y)..bord(1)..alfa(1,'ff')..fscxy(150,200)..color(2,'HAEDFFF').."}"..sil()
				l.start_time=line.start_time+syl.start_time
				l.end_time=l.start_time+syl.duration
				l.layer =1
				subs.append(l)
				
				l = table.copy(line)
				l.text = "{"..an(5)..pos(x,y)..color(1,'HAEDFFF')..bord(1)..fscxy(100,200)..t(fscxy(100,100))..t(syl.start_time + syl.duration / 2, syl.end_time, color(1,'HFFFFFF')..color(3,'HFFFFFF')..bord(2))..color(2,'HFFFFFF')..frx(360).."}"..sil()
				l.start_time=line.start_time+syl.start_time
				l.end_time=l.start_time+syl.duration
				l.layer =1
				subs.append(l)
		
			--FX DE SILABA DESPUES DE CANTADA
			l = table.copy(line)
			frand=rand(10)
			l.text = "{"..fad(100,200)..an(5)..pos(x,y)..bord(0)..color(1,'HFFFFFF')..t(alfa(1,'ff')).."}"..sil()
			l.start_time=l.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration+1000			
			l.layer = 0
			subs.append(l)

--------------------------------------HASTA AQUI TERMINAN LOS EFECTOS-----------------------------------------------------
--NO LOS QUITES
	end
end
---------------------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("kara", "APLICAR EFECTO", Alki_FX)
aegisub.register_filter("kara", "APLICAR EFECTO", 2000, Alki_FX)
----------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------------