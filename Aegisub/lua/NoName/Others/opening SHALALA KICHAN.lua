include("karaskel.lua") -- ESTE SIEMPRE SE DEBE DE AGREGAR !!!
include("zheolib.lua") --AHORA AGREGAMOS LA LIBRERIA :D !!
include("formaslib.lua") -- AGREGAMOS EL FORMASLIB !!

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Opening Naruto Shippuuden SHA LA LA"
script_description = "FX DEL OPENING SHA LA LA ( OP 9 )"
script_author = "kichanXcrazy"
script_version = "1.0"

-- ## FUNCIÓN GENERADOR FX... NO TOCAR!!!
function fx_kXc(subs)
	aegisub.progress.task("QUE MIRAS !!!")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("SIGUES MIRANDO ¬¬")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("PORQUE CHINGADA MADRE SIGUES MIRANDO !!!!!!!! (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment and
				(l.style == "Karaoke Ending") then
				karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else
			i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("YA DEJA DE MIRAR !!!!")
	aegisub.progress.set(100)
	aegisub.set_undo_point("fx_kXc")
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

function sil()
silaba = ""..syl.text_stripped..""
return silaba
end

-------------------------------TERMINA LA CONFIGURACIÓN BÁSICA-----------------------------
-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

-- FX INICIALES !!!!
---COLOR PRIMARIO SIN BORDE SE MUEVE ARRIBA
l = table.copy(line)
l.text = "{"..an(5)..color(1,"0C0C0D")..alfa(3,"FF")..move(x,y+20,x,y).."}"..sil()
l.start_time = line.start_time -800
l.end_time = line.start_time
l.layer=1
subs.append(l)



--BORDE SOLO SE MUEVE ABAJO
l = table.copy(line)
l.text = "{"..an(5)..alfa(1,"FF")..move(x,y-20,x,y).."}"..sil()
l.start_time = line.start_time -800
l.end_time = line.start_time
l.layer=1
subs.append(l)

--SILABAS ESTATICAS

--SILABA ESTATICA BORDE+PRIMARIO
l = table.copy(line)
l.text = "{"..an(5)..bord(3)..blur(6)..pos(x,y)..estilo(1,line.styleref.color2).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=0
subs.append(l)

--FX DE SILABAS
--SILABA QUE SE DESPRENDE
l = table.copy(line)
l.text = "{"..an(5)..color(1,"FFFFFF")..move(x,y,x,y+rand(10,50))..t(frx(360)..fscxy(150)..alpha('ff'))..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration+math.random(0,800)
l.layer = 3
subs.append(l)

--ESTRELLAS

l = table.copy(line)
for j = 1,10 do --serian 10 estrellas
	l.text = "{"..an(5)..color(1,"000000")..move(x+rand(30),y+rand(30),x-rand(80),y+rand(30))..t(fry(360)..color(1,"1819E0"))..blur(5).."}"..p(1,"m -3 -1 b -5 -1 -8 3 -4 7 b -5 5 -5 4 -4 3 b -1 6 1 -1 -3 -1 m 1 2 b 1 6 8 6 9 2 b 8 3 6 4 5 3 b 7 -1 0 -2 1 2 m 1 -2 b 5 -5 0 -9 -4 -8 b -3 -8 -1 -7 -1 -6 b -4 -3 0 -1 1 -2 ")
	l.start_time=line.start_time+syl.start_time
	l.end_time=l.start_time+syl.duration+math.random(0,500)
	l.layer = 2
	subs.append(l)
end
end
end


-------------------------------ACÁ TERMINAN LOS EFECTOS------------------------------------
-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------
aegisub.register_macro("kXc RULEZ !!!", "Aplica tu FX! D:", fx_kXc)
aegisub.register_filter("kXc RULEZ !!!", "Aplica tu FX! D:", 2000, fx_kXc)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN---