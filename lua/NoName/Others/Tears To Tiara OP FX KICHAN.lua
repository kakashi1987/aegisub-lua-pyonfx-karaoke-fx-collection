include("karaskel.lua")
include("zheolib.lua") --AHORA AGREGAMOS LA LIBRERIA :D
include("formaslib.lua")

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Tears To Tiara OP"
script_description = "FX of the opening of Tears To Tiara !!!!"
script_author = "kichanXcrazy"
script_version = "v1"

-- ## FUNCIÓN GENERADOR FX... NO TOCAR!!!
function fx_kichan(subs)
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
	aegisub.set_undo_point(fx_kichan)
end
-- ## TERMINA FUNCION GENERADOR

-------------------------------TERMINA CONFIGURACIONES DE LA MACRO------------------------
-------------------------------ACÁ COMIENZA LA CONFIGURACIÓN BÁSICA-----------------------
-- ## CONFIGURACION DE X-Y
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
	local syl = line.kara[i]
	local x=syl.center + line.left
	local y=line.margin_v + 45
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
			
			
	if i ==1 then
		tiempo=0
	end
	-------------------------------TERMINA LA CONFIGURACIÓN BÁSICA-----------------------------
	-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

	--FX INICIAL
	l = table.copy(line)
	l.text = "{"..fad(800,0)..an(5)..move(-10+rand(10),y,x,y)..org(x,y)..bord(1)..frx(rand(15))..color(3,'HFFFFFF')..be(1)..t(frx(0)).."}"..sil()
	l.start_time = line.start_time -1000+tiempo
	l.end_time = line.start_time+tiempo
	l.layer=0
	subs.append(l)

	--SILABAS ESTATICAS
	--silaba estatica 1 - desenfoque
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..bord(3)..blur(6)..estilo(1,line.styleref.color2).."}"..sil()
l.start_time = line.start_time+tiempo
l.end_time = line.start_time+syl.start_time
l.layer=0
subs.append(l)


-- FX SILABA ACTIVA
			
if actor=='1' then 
------------------------------------------------- FX actor 1 ( petalos y silaba vuela)----------------------------------------

--FX SILABAS QUE SE MUEVE A LA ARRIBA
l = table.copy(line)
l.text = "{"..an(5)..move(x,y,x,y-25)..t(frz(120)..move(x,y,x-10,y)..fad(0,200)).."}"..sil()
l.start_time=l.start_time+syl.start_time
l.end_time=l.start_time+syl.duration+math.random(200,1200)
l.layer = 2
subs.append(l)
-- FX PETALOS
l = table.copy(line)
			for j = 1,13 do --
	colores= {"F1EFE0", "E6C3D0"}
		rand_color= colores[math.random(1,2)]
			fades= {200, 600}
				rand_fad= fades[math.random(1,2)]
l.text = "{"..an(2)..color(1,rand_color)..move(x,y,x-rand(70,120),y+rand(50,80))..bord(0)..color(4,"000000")..shad(1)..t(fscxy(150,150)..frx(360)..move(x,y,x+rand(70,120),y)..fad(0,rand_fad)).."}"..p(1,"m 5 -6 b 0 -2 -6 -6 -8 1 b -7 1 -7 1 -6 1 b -6 2 -8 3 -8 3 b 0 4 2 1 3 -1 b 4 -3 4 -3 5 -6 ")
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration+math.random(200,1000)
l.layer = 2
subs.append(l)
			end

------------------------------------------------------------- ACTOR 2 ------------------------------------------------
elseif actor== '2' then
l = table.copy(line)
	for j = 1 ,3 do
l.text = "{"..an(5)..move(x,y,x-rand(0,70),y-rand(0,40))..color(1,"4CFEFD")..blur(2)..fscxy(150,150)..t(be(10)..color(1,"192CEB")..fad(0,rand_fad)).."}"..p(2,Formas(2,2))
l.start_time= line.start_time+syl.start_time
l.end_time= l.start_time+syl.duration+math.random(200,800)     
l.layer = 5
subs.append(l)

l = table.copy(line)
		for h = 1 ,3 do
l.text = "{"..an(5)..move(x,y,x+rand(0,70),y+rand(0,40))..color(1,"4CFEFD")..blur(2)..fscxy(150,150)..t(be(10)..color(1,"192CEB")..fad(0,rand_fad)).."}"..p(2,Formas(2,2))
l.start_time= line.start_time+syl.start_time
l.end_time= l.start_time+syl.duration+math.random(200,800)     
l.layer = 5
subs.append(l)
	end
		end

---------------------------------------------------------- ACTOR 3 -------------------------------------------------------
elseif actor== '3' then
--FX SILABAS QUE SE MUEVE A LA ARRIBA
l = table.copy(line)
l.text = "{"..an(5)..move(x,y-15,x,y)..t(frz(120)).."}"..sil()
l.start_time=l.start_time+syl.start_time
l.end_time=l.start_time+syl.duration+math.random(200,1200)
l.layer = 5
subs.append(l)
		--FX CIRCULO PARTICULAS
l = table.copy(line)
for r=0,15 do 

   if r==0 then
     p1=0
   end

   angulo=p1
   GenCirculo(3,x,y,p1,15)
	l.text = "{"..an(5)..move(posx+rand(30),posy+rand(30),posx1+rand(20)-100,posy1+rand(20)+10)..color(1,'FFFFFF')..blur(7)..bord(0).."}"..p(2,Formas(2,1))
	l.start_time=line.start_time+syl.start_time
	l.end_time=l.start_time+syl.duration+math.random(200,800)  
	l.layer =4
	subs.append(l)
	   p1=p1+(math.pi/16)
end
----------------------------------------------------------- ACTOR 4 -------------------------------------------------------
elseif actor== '4' then
---FX move abajo

l = table.copy(line)
l.text = "{"..an(5)..fad(0,500)..color(1,rand_color)..color(3,'&HFFFFFF&')..blur(1)..clip(x-(syl.width/2),y,x+(syl.width/2),y+(syl.height/2))..t(clip(x-(syl.width/2)-5,y+25,x+(syl.width/2)+5,y+(syl.height/2)+25)..move(x,y,x,y+25))..alfa(1,255).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration+300
l.layer = 2
subs.append(l)



--FX clip arriba

l = table.copy(line)
l.text = "{"..an(5)..fad(0,500)..color(1,rand_color)..color(3,'&HFFFFFF&')..blur(1)..clip(x-(syl.width/2),y-(syl.height/2),x+(syl.width/2),y)..t(clip(x-(syl.width/2)-5,y-(syl.height/2)-25,x+(syl.width/2)+5,y-25)..move(x,y,x,y-25))..alfa(1,255).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration+300
l.layer = 2
subs.append(l)
--- Flecha

l = table.copy(line)
l.text = "{"..an(5)..move(x-20,y,x,y)..frz(0)..fscxy(150)..color(1,'&H787878&')..t(frx(140))..blur(2).."}"..p(2,'m 64 0 b 59 -2 52 -4 46 -4 b 45 -1 43 -3 40 -4 b 41 -2 39 -1 37 -1 b 37 -1 37 0 37 0 b 20 1 -15 2 -15 2 b -16 1 -17 1 -18 0 b -18 0 -27 -1 -27 -1 b -25 1 -27 -1 -25 1 b -25 1 -28 1 -28 1 b -28 1 -30 -2 -30 -2 b -30 -2 -32 -2 -32 -2 b -32 -2 -32 1 -32 1 b -32 1 -32 -2 -33 -2 b -33 -2 -38 -2 -38 -2 b -37 -1 -36 1 -37 2 b -38 1 -39 1 -41 1 b -39 2 -39 3 -39 3 b -39 3 -39 4 -41 5 b -39 5 -37 4 -37 4 b -37 5 -37 6 -39 8 b -37 8 -35 8 -34 8 b -33 8 -32 5 -32 4 b -32 5 -32 6 -32 7 b -31 6 -29 6 -28 6 b -27 5 -28 5 -26 4 b -26 5 -26 5 -26 6 b -23 6 -20 5 -17 6 b -16 5 -16 5 -15 4 b -15 4 20 3 37 3 b 37 3 37 4 37 4 b 39 4 41 5 41 7 b 43 6 45 3 47 6 b 54 5 60 2 64 0 m 54 1 b 51 3 47 4 46 3 b 47 2 48 1 46 0 b 47 -1 51 0 54 1 m 42 1 b 42 0 43 0 44 0 b 45 0 46 0 46 1 b 46 2 45 2 44 2 b 43 2 42 2 42 1 ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 4
subs.append(l)
--------------------------------------------------------- ACTOR 5 --------------------------------------------------------
elseif actor =='5' then 
---FX move abajo

l = table.copy(line)
l.text = "{"..an(5)..fad(0,500)..color(1,rand_color)..color(3,'&HFFFFFF&')..blur(1)..clip(x-(syl.width/2),y,x+(syl.width/2),y+(syl.height/2))..t(clip(x-(syl.width/2)-5,y+25,x+(syl.width/2)+5,y+(syl.height/2)+25)..move(x,y,x,y+25))..alfa(1,255).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration+300
l.layer = 2
subs.append(l)



--FX clip arriba

l = table.copy(line)
l.text = "{"..an(5)..fad(0,500)..color(1,rand_color)..color(3,'&HFFFFFF&')..blur(1)..clip(x-(syl.width/2),y-(syl.height/2),x+(syl.width/2),y)..t(clip(x-(syl.width/2)-5,y-(syl.height/2)-25,x+(syl.width/2)+5,y-25)..move(x,y,x,y-25))..alfa(1,255).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration+300
l.layer = 2
subs.append(l)
--- Espada

l = table.copy(line)
l.text = "{"..an(5)..move(x-20,y,x,y)..frz(0)..fscxy(150)..color(1,'&H787878&')..t(frx(140))..blur(2).."}"..p(2,'m 94 16 l 77 10 l -17 16 l -24 14 l -24 10 l -20 -4 l -23 -4 l -32 16 l -60 18 l -63 18 l -68 19 l -65 22 l -60 22 l -32 22 l -25 42 l -21 42 l -25 28 l -24 23 l -18 22 l 78 22 ')
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 4
subs.append(l)
end
------------------------------ NO LOS QUITES !! -------------------------------------------
tiempo=tiempo+(500/line.kara.n)
end
end
-------------------------------ACÁ TERMINAN LOS EFECTOS------------------------------------
-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------
aegisub.register_macro("kXc RULEZ !!", "Tears To Tiara OP", fx_kichan)
aegisub.register_filter("kXc RULEZ !!", "Tears To Tiara OP", 2000, fx_kichan)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN---