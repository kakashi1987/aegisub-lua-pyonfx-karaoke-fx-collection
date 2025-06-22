include("karaskel.lua")
include("zheolib.lua")

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Ending10NS"
script_description = "Fx Chingon Hecho Por KichanXcrazy"
script_author = "kichanXcrazy"
script_version = "1.0"

--FUNCIÓN GENERADOR FX... NO TOCAR!!!
function fx_kichan(subs)
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
				(l.style == "Ending") then
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
	aegisub.set_undo_point(fx_kichan)
end
--TERMINA FUNCION GENERADOR

-------------------------------TERMINA CONFIGURACIONES DE LA MACRO------------------------
	-------------------------------ACÁ COMIENZA LA CONFIGURACIÓN BÁSICA-----------------------
	-- ## CONFIGURACION DE X-Y
	function do_fx(subs, meta, line)
	for i = 1, line.kara.n do
	local syl = line.kara[i]
	local x=syl.center + line.left
	local y=line.margin_v + 25
	if i == 1 then
	tempo=0
	end
	-- ## AGREGAMOS TAMBIEN ESTA FUNCIÓN
	function sil()
	silaba = ""..syl.text_stripped..""
	return silaba
	end

	--VARIABLE DE ACTORES
	local actor=line.actor
	
	-------------------------------TERMINA LA CONFIGURACIÓN BÁSICA-----------------------------
-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------
--FX INICIAL
l = table.copy(line)
l.text = string.format("{\\fad(700,0)\\an5\\pos(%d,%d)\\1c%s}%s",x,y,line.styleref.color1,syl.text_stripped)
l.start_time = line.start_time -700
l.end_time = line.start_time
l.layer=0
subs.append(l)

--SILABAS ESTATICAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..bord(2).."}"..sil()
l.start_time = l.start_time
l.end_time = line.start_time+syl.start_time
l.layer=0
subs.append(l)


-- ACA EMPIEZAN LOS ACTORES :P !Xd 


if actor=='1' then -- PARA EL ACTOR 1
		--SILABA ESTATICA ANARANJADA
		l = table.copy(line)
		l.text = "{"..color(1,"4C8AE6")..an(5)..pos(x,y)..bord(2).."}"..sil()
		l.start_time = l.start_time
		l.end_time = line.start_time+syl.start_time+10
		l.layer=0
		subs.append(l)
		--FX DE LA ACTIVA (LA QUE SE DESPRENDE)
		l = table.copy(line)
		l.text = "{"..an(5)..color(1,"C68D49")..move(x,y,x+rand(80),y+rand(30))..t(fscxy(150)..alpha('ff'))..blur(5).."}"..sil()
		l.start_time=line.start_time+syl.start_time
		l.end_time=l.start_time+syl.duration
		l.layer = 1
		subs.append(l)

elseif actor=='2' then -- PARA EL ACTOR 2

		--SILABA ESTATICA AZUL
		l = table.copy(line)
		l.text = "{"..color(3,"FFFFFF")..bord(5)..blur(7)..an(5)..pos(x,y).."}"..sil()
		l.start_time = l.start_time
		l.end_time = line.start_time+syl.start_time+10
		l.layer=0
		subs.append(l)

		--SILABA ESTATICA BORDE NEGRO
		l = table.copy(line)
		l.text = "{"..color(1,"C68D49")..color(3,"000000")..shad(2)..an(5)..pos(x,y).."}"..sil()
		l.start_time = l.start_time
		l.end_time = line.start_time+syl.start_time+10
		l.layer=0
		subs.append(l)

		--FX PELOTA DE PLAYA
		l = table.copy(line)
		l.text = "{"..an(7)..move(x+15,y-15,x,y)..bord(1)..color(1,"6641C4")..color(3,"2D2D2D").."}"..p(2,"m -23 20 b -19 31 -9 36 -1 39 b 11 28 16 8 20 -10 b 22 -10 25 -10 27 -10 b 34 -4 39 8 35 22 b 42 10 40 -8 32 -15 b 30 -16 29 -16 27 -17 b 24 -19 22 -20 19 -22 b 19 -23 18 -24 18 -25 b 12 -27 1 -27 -8 -23 b -2 -24 7 -24 13 -21 b 13 -19 13 -17 13 -15 b -8 -9 -24 8 -23 20 m 14 -15 b 14 -17 14 -19 14 -21 b 16 -21 17 -21 19 -21 b 22 -19 24 -18 27 -16 b 27 -14 27 -13 27 -11 b 25 -11 22 -11 20 -11 m -23 20 b -31 3 -18 -19 -8 -23 b -8 -23 -7 -23 -8 -23 b -17 -14 -29 2 -23 20 m 18 -25 b 24 -23 28 -19 32 -15 b 27 -19 23 -23 18 -25 m -1 39 b 12 40 30 36 36 19 b 28 33 13 39 -1 39 m 14 -15 l 14 -21 l 19 -21 l 27 -16 l 27 -11 l 20 -11 l 14 -15 ")
		l.start_time=l.start_time+syl.start_time
		l.end_time=l.start_time+(syl.duration*0.5)
		l.layer = 2
		subs.append(l)

		--FX PELOTA DE PLAYA (PARTE 2)
		l = table.copy(line)
		l.text = "{"..an(7)..move(x,y,x+10,y+15)..bord(1)..color(1,"6641C4")..color(3,"2D2D2D").."}"..p(2,"m -23 20 b -19 31 -9 36 -1 39 b 11 28 16 8 20 -10 b 22 -10 25 -10 27 -10 b 34 -4 39 8 35 22 b 42 10 40 -8 32 -15 b 30 -16 29 -16 27 -17 b 24 -19 22 -20 19 -22 b 19 -23 18 -24 18 -25 b 12 -27 1 -27 -8 -23 b -2 -24 7 -24 13 -21 b 13 -19 13 -17 13 -15 b -8 -9 -24 8 -23 20 m 14 -15 b 14 -17 14 -19 14 -21 b 16 -21 17 -21 19 -21 b 22 -19 24 -18 27 -16 b 27 -14 27 -13 27 -11 b 25 -11 22 -11 20 -11 m -23 20 b -31 3 -18 -19 -8 -23 b -8 -23 -7 -23 -8 -23 b -17 -14 -29 2 -23 20 m 18 -25 b 24 -23 28 -19 32 -15 b 27 -19 23 -23 18 -25 m -1 39 b 12 40 30 36 36 19 b 28 33 13 39 -1 39 m 14 -15 l 14 -21 l 19 -21 l 27 -16 l 27 -11 l 20 -11 l 14 -15 ")
		l.start_time=l.start_time+syl.start_time+(syl.duration*0.4)
		l.end_time=l.start_time+(syl.duration*1)
		l.layer = 2
		subs.append(l)

		--FX SILABAS QUE SE MUEVE A LA ABAJO
		l = table.copy(line)
		l.text = "{"..an(5)..move(x,y, x,y-rand(30,80)).."}"..sil()
		l.start_time=l.start_time+syl.start_time
		l.end_time=l.start_time+syl.duration
		l.layer = 1
		subs.append(l)

		--FX SILABAS QUE SE MUEVE A LA ARRIBA
		l = table.copy(line)
		l.text = "{"..an(5)..move(x,y, x,y+rand(30,80)).."}"..sil()
		l.start_time=l.start_time+syl.start_time
		l.end_time=l.start_time+syl.duration
		l.layer = 1
		subs.append(l)


elseif actor=='voz2' then -- PARA EL ACTOR voz2
		--FX DE LA SILABA QUE GIRA
		l = table.copy(line)
		l.text = "{"..an(6)..move(x-rand(10,20),y+rand(7,12),x,y).."}"..sil()
		l.start_time=l.start_time+syl.start_time
		l.end_time=l.start_time+syl.duration
		l.layer = 1
		subs.append(l)

elseif actor=='4' then -- PARA EL ACTOR 4
    
		--FX PELOTA DE PLAYA
		l = table.copy(line)
		for j = 1,1 do
		l.text = "{"..color(1,RandomColor())..an(7)..move(x+15,y-15,x,y)..bord(1)..color(3,"2D2D2D").."}"..p(2,"m -23 20 b -19 31 -9 36 -1 39 b 11 28 16 8 20 -10 b 22 -10 25 -10 27 -10 b 34 -4 39 8 35 22 b 42 10 40 -8 32 -15 b 30 -16 29 -16 27 -17 b 24 -19 22 -20 19 -22 b 19 -23 18 -24 18 -25 b 12 -27 1 -27 -8 -23 b -2 -24 7 -24 13 -21 b 13 -19 13 -17 13 -15 b -8 -9 -24 8 -23 20 m 14 -15 b 14 -17 14 -19 14 -21 b 16 -21 17 -21 19 -21 b 22 -19 24 -18 27 -16 b 27 -14 27 -13 27 -11 b 25 -11 22 -11 20 -11 m -23 20 b -31 3 -18 -19 -8 -23 b -8 -23 -7 -23 -8 -23 b -17 -14 -29 2 -23 20 m 18 -25 b 24 -23 28 -19 32 -15 b 27 -19 23 -23 18 -25 m -1 39 b 12 40 30 36 36 19 b 28 33 13 39 -1 39 m 14 -15 l 14 -21 l 19 -21 l 27 -16 l 27 -11 l 20 -11 l 14 -15 ")
		l.start_time=l.start_time+syl.start_time
		l.end_time=l.start_time+(syl.duration*0.5)
		l.layer = 2
		subs.append(l)
		
		--FX PELOTA DE PLAYA (PARTE 2)
		l = table.copy(line)
		for j = 1,1 do  
		l.text = "{"..color(1,RandomColor())..an(7)..move(x,y,x+10,y+15)..bord(1)..color(3,"2D2D2D").."}"..p(2,"m -23 20 b -19 31 -9 36 -1 39 b 11 28 16 8 20 -10 b 22 -10 25 -10 27 -10 b 34 -4 39 8 35 22 b 42 10 40 -8 32 -15 b 30 -16 29 -16 27 -17 b 24 -19 22 -20 19 -22 b 19 -23 18 -24 18 -25 b 12 -27 1 -27 -8 -23 b -2 -24 7 -24 13 -21 b 13 -19 13 -17 13 -15 b -8 -9 -24 8 -23 20 m 14 -15 b 14 -17 14 -19 14 -21 b 16 -21 17 -21 19 -21 b 22 -19 24 -18 27 -16 b 27 -14 27 -13 27 -11 b 25 -11 22 -11 20 -11 m -23 20 b -31 3 -18 -19 -8 -23 b -8 -23 -7 -23 -8 -23 b -17 -14 -29 2 -23 20 m 18 -25 b 24 -23 28 -19 32 -15 b 27 -19 23 -23 18 -25 m -1 39 b 12 40 30 36 36 19 b 28 33 13 39 -1 39 m 14 -15 l 14 -21 l 19 -21 l 27 -16 l 27 -11 l 20 -11 l 14 -15 ")
		l.start_time=l.start_time+syl.start_time+(syl.duration*0.4)
		l.end_time=l.start_time+(syl.duration*1)
		l.layer = 2
		subs.append(l)
		
		--FX SILABAS QUE SE MUEVE A LA ABAJO
		l = table.copy(line)
		l.text = "{"..an(5)..move(x,y, x,y-rand(30,80)).."}"..sil()
		l.start_time=l.start_time+syl.start_time
		l.end_time=l.start_time+syl.duration
		l.layer = 1
		subs.append(l)

		--FX SILABAS QUE SE MUEVE A LA ARRIBA
		l = table.copy(line)
		l.text = "{"..an(5)..move(x,y, x,y+rand(30,80)).."}"..sil()
		l.start_time=l.start_time+syl.start_time
		l.end_time=l.start_time+syl.duration
		l.layer = 1
		subs.append(l)

	end
	end
	
elseif actor=='3' then --PARA EL ACTOR 3
		for i = 1,50 do
		colores ={'0C1D26', '6BAAC7', ' 295E76', '6BA9C8', 'FFFFFF'}
		rand_color= colores[math.random(1,5)]
		l.text = "{"..alpha(rand(-20,250))..bord(0.1)..color(1,RandomColor())..blur(5)..fad(100,200)..move(x,y,x-rand(26),y+rand(15)).."}"..p(1,"m 0 0 m 0 2 l -4 -14 b 6 1 7 10 2 12 b -8 11 0 3 -4 -14 ")--ESTOS SON LOS EFECTOS 
		l.start_time=line.start_time+syl.start_time
		l.end_time=l.start_time+syl.duration+rand(-200,400)---CONFIGURACION DEL TIEMPO FINAL DEL EFECTO
		l.layer = 1 --NUMERO DE LA CAPA O LAYER..ES DECIR EL NIVEL EN EL QUE ESTARÁ (Por detras o delante de los demas efectos)
		subs.append(l)---HACE QUE TERMINE EL BLOQUE
		end

end
end

end
-------------------------------ACÁ TERMINAN LOS EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("Naruto Shippuuden Ending 10 FX", "FX CHINGON! :P", fx_kichan)
aegisub.register_filter("Naruto Shippuuden Ending 10 FX", "FX CHINGON! :P", 2000, fx_kichan)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------