include("karaskel.lua")
include("zheolib.lua") --AHORA AGREGAMOS LA LIBRERIA :D
include("formaslib.lua")

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "FX My Answer"
script_description = "Fx Del PV SEAMO - My Answer"
script_author = "KichanXcrazY"
script_version = "1.0"

-- ## FUNCIÓN GENERADOR FX... NO TOCAR!!!
function kichan_fx(subs)
	aegisub.progress.task("ESPERA MIESTRAS SE HACE EL FX... (Sale a dar una vuelta D:)")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Aplicando tu FX D:")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Esto llevo trabajado (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment and
				(l.style == "op" or l.style == "op2" or l.style == "Default") then --Acá se puede cambiar por el nombre del Estilo que quieras
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
	aegisub.set_undo_point("kichan_fx")
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
-------------------------------TERMINA LA CONFIGURACIÓN BÁSICA-----------------------------
-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

function convAlpha(valor)
if valor < 0 or valor >255 then
valor=0
end
return "\\alpha"..ass_alpha(valor)..""
end
		if i ==1 then
		tiempo=0
		end

--FX INICIAL
l = table.copy(line)
l.text = "{"..fad(100,0)..bord(0)..color(1,'ffffff')..move(x,y-50,x,y)..t(color(1,line.styleref.color2)..bord(1)).."}"..sil()
l.start_time = line.start_time -800+tiempo
l.end_time = line.start_time+tiempo
l.layer=0
subs.append(l)

--SILABAS ESTATICAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..color(1,line.styleref.color2).."}"..sil()
l.start_time = line.start_time+tiempo
l.end_time = line.start_time+syl.start_time
l.layer=0
subs.append(l)


if actor=='1' then 


--FX DE SILABAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..color(1,line.styleref.color1)..t(fscxy(250,250)..alpha(200)).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 50
subs.append(l)
-- SILABA GIRO IZQUIERDA
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..color(1,line.styleref.color1)..t(fscxy(150,150)..frz(360)..alpha(200)).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 2
subs.append(l)
-- SILABA GIRO DERECHA
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..color(1,line.styleref.color1)..t(fscxy(150,150)..frz(-360)..alpha(200)).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 2
subs.append(l)


elseif actor=='2' then
--SILABAS ESTATICAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..color(1,line.styleref.color2).."}"..sil()
l.start_time = line.start_time+tiempo
l.end_time = line.start_time+syl.start_time+500
l.layer=0
subs.append(l)

-- SILABA Vuela hacia arriba con giro 
l = table.copy(line)
l.text = "{"..an(5)..move(x,y,x,y-20)..color(1,line.styleref.color1)..t(fry(360)).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration+200
l.layer = 20
subs.append(l)

-- Silaba baja con giro media opaca
l = table.copy(line)
l.text = "{"..an(5)..move(x,y,x,y+20)..color(1,line.styleref.color1)..alfa(3,"7F")..alfa(1,"7F")..t(fry(-360)).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration+200 
l.layer = 20
subs.append(l)


elseif actor=='3' then


--FX DE SILABAS
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..color(1,line.styleref.color1)..t(fscxy(250,250)..alpha(200)).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 50
subs.append(l)
-- Circulos
l = table.copy(line)
	for j = 1 ,5 do
l.text = "{"..an(5)..move(x,y,x-rand(0,70),y-rand(0,40))..color(3,"FFFFFF")..blur(2)..bord(1)..estilo(1,line.styleref.color2)..fscxy(150,150)..RangeColor(1, j/5, 'CECECE', 'FFFFFF')..t(be(1)..alpha('ff')).."}"..p(2,Formas(2,2))
l.start_time= line.start_time+syl.start_time
l.end_time= l.start_time+syl.duration+math.random(200,800)     
l.layer = 30
subs.append(l)
--Brillo 1
l = table.copy(line)
		for j = 1 ,5 do
l.text = "{"..an(5)..move(x,y,x-rand(50,80),y+rand(40,60))..color(3,"FFFFFF")..blur(0)..bord(0)..estilo(1,line.styleref.color2)..fscxy(150,150)..RangeColor(1, j/5, 'CECECE', 'FFFFFF')..t(be(1)..alpha('ff')).."}"..p(3,Formas(4,2))
l.start_time= line.start_time+syl.start_time
l.end_time= l.start_time+syl.duration+math.random(200,800)     
l.layer = 25
subs.append(l)
--Brillo 2
l = table.copy(line)
		for j = 1 ,5 do
l.text = "{"..an(5)..move(x,y,x+rand(0,70),y+rand(0,40))..color(3,"FFFFFF")..blur(0)..bord(0)..estilo(1,line.styleref.color2)..fscxy(150,150)..RangeColor(1, j/5, 'CECECE', 'FFFFFF')..t(be(1)..alpha('ff')).."}"..p(3,Formas(4,2))
l.start_time= line.start_time+syl.start_time
l.end_time= l.start_time+syl.duration+math.random(200,800)     
l.layer = 20
subs.append(l)
	end
		end
			end
end
tiempo=tiempo+(800/line.kara.n)

end
end
-------------------------------ACÁ TERMINAN LOS EFECTOS------------------------------------
-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------
aegisub.register_macro("KxC FX !", "Aplica tu FX! D:", kichan_fx)
aegisub.register_filter("KxC FX !", "Aplica tu FX! D:", 2000, kichan_fx)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN---