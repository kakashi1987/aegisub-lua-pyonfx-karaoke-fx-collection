include("karaskel.lua")
include("zheolib.lua") --AHORA AGREGAMOS LA LIBRERIA :D
include("formaslib.lua")

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Oasis - Stop Crying Your Heart Out"
script_description = "Oasis - Stop Crying Your Heart Out"
script_author = "kichanXcrazy"
script_version = "v1"

-- ## FUNCIÓN GENERADOR FX... NO TOCAR!!!
function fx_kXc(subs)
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
end
-- ## TERMINA FUNCION GENERADOR

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
	
	-- VARIABLE TIEMPO
	if i ==1 then
	tiempo=500
	end 
	
	-------------------------------TERMINA LA CONFIGURACIÓN BÁSICA-----------------------------
	-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------
	--FX INICIAL
	l = table.copy(line)
	l.text = "{"..fad(800,0)..an(5)..move(x,-10+rand(10),x,y)..org(x,y)..alfa(1,'ff')..bord(1)..frx(rand(15))..color(3,'HFFFFFF')..be(1)..t(frx(0)).."}"..sil()
	l.start_time = line.start_time -1000+tiempo
	l.end_time = line.start_time
	l.layer=0
	subs.append(l)

	--SILABAS ESTATICAS
	l = table.copy(line)
	l.text = "{"..an(5)..pos(x,y)..estilo(1,line.styleref.color2).."}"..sil()
	l.start_time = line.start_time
	l.end_time = line.start_time+syl.start_time
	l.layer=2
	subs.append(l)

	--FX DE ACTIVAS
	--SILABA QUE SE MUEVE LEVEBENTE A LA IZQUIERDA
	l = table.copy(line)
	l.text = "{"..an(5)..move(x-10,y,x,y)..blur(5)..t(blur(0)..bord(1)).."}"..sil()
	l.start_time=line.start_time+syl.start_time
	l.end_time=l.start_time+syl.duration
	l.layer =3
	subs.append(l)
	
	-- SILABA SIN BRILLO 
		l = table.copy(line)
			frand=rand(10)
			l.text = "{"..fad(100,200)..an(5)..pos(x,y)..bord(0)..blur(1)..color(1,'HFFFFFF')..t(alfa(1,'ff')).."}"..sil()
			l.start_time=l.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration+1500			
			l.layer = 3
			subs.append(l)
	
	--POLVO
	l = table.copy(line)
	for k= 0,1 do
	l.text = "{"..an(5)..move(x,y,x-rand(10,50),y-rand(20,50))..color(1,'FFFFFF')..blur(7)..bord(0).."}"..sil()
	l.start_time=line.start_time+syl.start_time
	l.end_time=l.start_time+syl.duration
	l.layer =4
	subs.append(l)
	end
    
	--ESTRELLAS
	l = table.copy(line)
	for f= 0,20 do
	l.text = "{"..an(8)..move(x,y,x-rand(10,50),y+rand(0,20))..blur(5).."}"..p(4,Formas(5,5))
	l.start_time = line.start_time+syl.start_time
	l.end_time = l.start_time+syl.duration+rand(600)
	l.layer=4
	subs.append(l)
	end
	end
end
-------------------------------ACÁ TERMINAN LOS EFECTOS------------------------------------
-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------
aegisub.register_macro("kXc RULEZ !!", "Oasis Rulez !", fx_kXc)
aegisub.register_filter("kXc RULEZ !!", "Oasis Rulez !", 2000, fx_kXc)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN---