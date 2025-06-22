include("karaskel.lua")
include("zheolib.lua")
include("formaslib.lua") -- AGREGAMOS EL FORMASLIB

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Nostalgia"
script_description = "Nostalgia FX"
script_author = "aelmiger"
script_version = "0.8.1 Beta"

--FUNCIÓN GENERADOR FX... NO TOCAR!!!
function fx_zheo(subs)
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
				(l.style == "Default") then
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
end
--TERMINA FUNCION GENERADOR

-------------------------------TERMINA CONFIGURACIONES DE LA MACRO------------------------

-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

--CONFIGURACION DE X-Y
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center+line.left
local y=line.margin_v +27

function sil()
silaba = ""..syl.text_stripped..""
return silaba
end

if i ==1 then
tiempo=0
end

function blurco(valor) --ALPHA POR SORA LAMPAGEROUCH!!
blurC =  "\\blur" ..math.floor(valor).. "\\bord" ..math.floor(valor+valor/2/1).. ""
return blurC
end

--######################## Comienzo de Efectop#################################


--FX INICIAL
l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\alpha&HFF&\\t(\\1a&H00&\\3a&C8&\\4a&64&\\fscy100\\frx360\\frz360\\blur2\\shad0)}%s",x+10,y-15,x,y,syl.text_stripped)
l.start_time = line.start_time - 200
l.end_time = line.start_time+ (syl.duration/2)
l.layer=5
subs.append(l)

l = table.copy(line)
for i=0,50 do
    random_pos = math.random(70,150)
    l.layer=0
    l.text = string.format("{\\fad(0,200)\\move(%d,%d,%d,%d)\\an5\\shad0\\bord0\\be1\\blur0\\1c&HFFFFFF&\\t(\\fscx100\\fscy100\\frx0\\3a&HE6A181&))}{\\p%d}m 0 16 l 5 16 l 2 11 l 3 9 l 8 16 l 16 16 l 12 9 l 3 9 l 4 7 l 11 7 l 8 2 l 10 0 l 13 5 l 16 0 l 19 0 l 14 7 l 19 15 l 24 7 l 19 0 l 22 0 l 25 5 l 28 0 l 30 2 l 27 7 l 34 7 l 35 9 l 26 9 l 22 16 l 30 16 l 35 9 l 36 11 l 33 16 l 38 16 l 38 19 l 33 19 l 36 24 l 35 26 l 30 19 l 22 19 l 26 26 l 35 26 l 34 28 l 27 28 l 30 33 l 28 35 l 25 30 l 22 35 l 19 35 l 24 28 l 19 20 l 14 28 l 19 35 l 16 35 l 13 30 l 10 35 l 8 33 l 8 33 l 11 28 l 4 28 l 3 26 l 12 26 l 16 19 l 8 19 l 3 26 l 2 24 l 5 19 l 0 19{\\p0}",x-math.random(-3,50),y-math.random(-50,50),x+math.random(-3,50),y+math.random(-50,50),random_pos,random_pos,math.random(4,6))
    l.start_time=line.start_time+syl.start_time+ (syl.duration/4)
    l.end_time=l.start_time+syl.duration+math.random(-50,250)
    l.start_time=l.start_time+i
    subs.append(l)
    end
	
	l = table.copy(line)
for i=0,50 do
    random_pos = math.random(70,150)
    l.layer=5
    l.text = string.format("{\\fad(0,200)\\move(%d,%d,%d,%d)\\an5\\1c&HFFFFFF&\\shad0\\bord0\\be1\\blur0\\t(\\fscx100\\fscy100\\frx0\\3a&HE6A181&))}{\\p%d}m 0 16 l 5 16 l 2 11 l 3 9 l 8 16 l 16 16 l 12 9 l 3 9 l 4 7 l 11 7 l 8 2 l 10 0 l 13 5 l 16 0 l 19 0 l 14 7 l 19 15 l 24 7 l 19 0 l 22 0 l 25 5 l 28 0 l 30 2 l 27 7 l 34 7 l 35 9 l 26 9 l 22 16 l 30 16 l 35 9 l 36 11 l 33 16 l 38 16 l 38 19 l 33 19 l 36 24 l 35 26 l 30 19 l 22 19 l 26 26 l 35 26 l 34 28 l 27 28 l 30 33 l 28 35 l 25 30 l 22 35 l 19 35 l 24 28 l 19 20 l 14 28 l 19 35 l 16 35 l 13 30 l 10 35 l 8 33 l 8 33 l 11 28 l 4 28 l 3 26 l 12 26 l 16 19 l 8 19 l 3 26 l 2 24 l 5 19 l 0 19 {\\p0}",x-math.random(-350,50),y-math.random(-50,50),x+math.random(-350,50),y+math.random(-50,50),random_pos,random_pos,math.random(4,6))
    l.start_time=line.start_time+syl.start_time+ (syl.duration/4)
    l.end_time=l.start_time+syl.duration+math.random(-50,250)
    l.start_time=l.start_time+i
    subs.append(l)
    end
	
--SILABAS ESTATICAS
l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\bord0\\blur0\\1c%s}%s",x,y,line.styleref.color1,syl.text_stripped)
l.start_time = line.start_time
l.end_time = line.end_time
l.layer=1
subs.append(l)

--Silaba Estatica 2 - Degradado
l = table.copy(line)
for j = 0, syl.height do
cx1 = 0 -- siempre cero
cy1 = 1+j*1+1 -- comienza desde la cima de linea (tambien puede ser l.top+j*1+1)
cx2 = 640 -- ancho video
cy2 = 8+j*1+2 -- es igual a cy1 pero con un nº más (tambien puede ser l.top+j*1+2)
l.text = "{"..fad(100,0)..an(5)..pos(x,y)..clip(cx1, cy1, cx2, cy2)..RangeAlpha(1, j/syl.height,'00', 'ff')..RangeAlpha(3, j/syl.height,'00', 'ff')..color(1, line.styleref.color2)..bord(0)..color(3,'000000').."}"..sil()
    l.start_time=line.start_time
    l.end_time=line.end_time
    l.layer= 2
    subs.append(l)
    end

		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\3c&H000000&\\bord0\\blur0\\fs28\\fry0\\t(\\fs55\\fry45\\3c&HFFFFFF&\\bord3\\blur10)}%s", x, y, syl.text_stripped)
        l.start_time=line.start_time+syl.start_time+tiempo
		l.end_time=line.start_time+syl.start_time + (syl.duration/2)
	    l.layer=3
		subs.append(l)
					
	--FX DE SILABAS

--FX LETRA CANTADA - Auymento del FSCy - Bode Negro
		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\3c&HF2BC44&\\bord1.5\\fs28\\fry0\\t(\\fs55\\fry45)}%s", x, y, syl.text_stripped)
        l.start_time=line.start_time+syl.start_time+tiempo
		l.end_time=line.start_time+syl.start_time + (syl.duration/2)
	    l.layer=4
		subs.append(l)
				
		--FX LETRA CANTADA - Regreso del FSCY
		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\3c&HFFFFFF&\\bord3\\blur10\\fs55\\fry45\\t(\\fs28\\fry90\\3c&H000000&\\bord0\\blur0)}%s", x, y, syl.text_stripped)
        l.start_time=line.start_time+syl.start_time+ (syl.duration/2)
		l.end_time=line.start_time+syl.start_time +syl.duration+tiempo
	    l.layer=3
		subs.append(l)
		
		--FX LETRA CANTADA - Regreso del FSCY - Borde Negro
		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\3c&HF2BC44&\\bord1.5\\\\fs55\\fry45\\t(\\fs28\\fry90)}%s", x, y, syl.text_stripped)
        l.start_time=line.start_time+syl.start_time+ (syl.duration/2)
		l.end_time=line.start_time+syl.start_time +syl.duration+tiempo
	    l.layer=4
		subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\t(\\blur0\\fscx100\\fscy100\\fsp0\\alpha&H00&\\fscx800\\fscy250\\alpha&HFF&\\blur10\\fsp-30))}%s", x, y, line.styleref.color2, syl.text_stripped)
l.start_time=line.end_time
l.end_time=l.end_time+250
l.layer = 2
subs.append(l)
end
end
-------------------------------ACÁ TERMINAN LOS EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("REDFRACTION", "Exportando con Exito", fx_zheo)
aegisub.register_filter("REDFRACTION", "Exportando con Exito", 2000, fx_zheo)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------