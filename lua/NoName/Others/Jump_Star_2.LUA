include("karaskel.lua")

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "LUA4 FX Base"
script_description = "Template para hacer FX en Lua4"
script_author = "Kuro~Aoi"
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
	aegisub.set_undo_point("fx_aoi")
end
--TERMINA FUNCION GENERADOR

-------------------------------TERMINA CONFIGURACIONES DE LA MACRO------------------------

-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

--CONFIGURACION DE X-Y
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 30
if i ==1 then
tiempo=0
end
--FX INICIAL
l = table.copy(line)
		l.text = string.format("{\\fad(100,0)\\an5\\move(%d,%d,%d,%d)\\bord3\\be3\\blur3\\fry360\\1c&HFFFFFF&\\3c&HFFFFFF&\\t(\\frx360\\1c%s\\3c%s\\bord1\\blur0\\be0\\fry0)}%s",x+105,2,x+10,y,line.styleref.color1,line.styleref.color3,syl.text_stripped)
		l.start_time = line.start_time -1000+tiempo
		l.end_time = line.start_time+tiempo
		l.layer=0
		subs.append(l)
		
--SILABAS ESTATICAS
		
	l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s}%s",x,y,line.styleref.color1,syl.text_stripped)
		l.start_time = line.start_time+tiempo
		l.end_time = line.start_time+syl.start_time
		l.layer=2
		subs.append(l)
		
		--SILABAS ESTATICAS (2)
			
l = table.copy(line)
for i=0,50 do
    random_pos = math.random(20,25)
    l.layer=0
    l.text = string.format("{\\fad(0,200)\\move(%d,%d,%d,%d)\\an5\\shad0\\bord0\\be1\\1c&HE6A181&\\t(\\fscx%d\\fscy%d\\frx0\\3a&HE6A181&))}{\\p%d}m 1 1 l 50 37 l 100 1 l 65 49 l 100 98 l 50 64 l 1 98 l 37 50 l 1 1 {\\p0}",x-math.random(-3,50),y-math.random(-50,50),x+math.random(-3,50),y+math.random(-50,50),random_pos,random_pos,math.random(4,6))
    l.start_time=line.start_time+syl.start_time
    l.end_time=l.start_time+syl.duration+math.random(-50,2)
    l.start_time=l.start_time+i
    subs.append(l)
    end
	
	l = table.copy(line)
for i=0,50 do
    random_pos = math.random(70,150)
    l.layer=5
    l.text = string.format("{\\fad(0,200)\\move(%d,%d,%d,%d)\\an5\\1c&HFFFFFF&\\shad0\\bord0.5\\be6\\blur10\\t(\\fscx%d\\fscy%d\\frx0\\3a&HE6A181&))}{\\p%d}m 1 1 l 50 37 l 100 1 l 65 49 l 100 98 l 50 64 l 1 98 l 37 50 l 1 1 {\\p0}",x-math.random(-350,50),y-math.random(-50,50),x+math.random(-350,50),y+math.random(-50,50),random_pos,random_pos,math.random(4,6))
    l.start_time=line.start_time+syl.start_time
    l.end_time=l.start_time+syl.duration+math.random(-50,250)
    l.start_time=l.start_time+i
    subs.append(l)
    end
	
  l = table.copy(line)
			l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\t(\\fscx180\\fscy180\\alpha&HFF&)}%s", x, y, line.styleref.color2, syl.text_stripped)
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration+130
			l.layer = 0
			subs.append(l)
			
			    l = table.copy(line)
			l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\t(\\fscx170\\fscy170\\alpha&HFF&\\fscx70\\fscy70\\blur4)}%s", x, y, line.styleref.color2, syl.text_stripped)
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration+150
			l.layer = 1
			subs.append(l)
			
				    l = table.copy(line)
			l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\t(\\fscx160\\fscy160\\alpha&HFF&\\fscx70\\fscy70\\blur5)}%s", x+0.5, y, line.styleref.color2, syl.text_stripped)
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration+180
			l.layer = 8
			subs.append(l)
			
					    l = table.copy(line)
			l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\t(\\fscx200\\fscy200\\alpha&HFF&\\bord4\\fry150\\fscy100)}%s", x-0.5, y, line.styleref.color2, syl.text_stripped)
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration+180
			l.layer = 10
			subs.append(l)
			
					    l = table.copy(line)
			l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\t(\\fscx250\\fscy250\\alpha&HFF&\\bord2\\fscx130\\fscy100\\blur2)}%s", x-1, y, line.styleref.color2, syl.text_stripped)
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration+180
			l.layer = 5
			subs.append(l)
			
							    l = table.copy(line)
			l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\t(\\fscx300\\fscy350\\alpha&HFF&\\bord2\\fscx90\\fry170)}%s", x+1, y, line.styleref.color2, syl.text_stripped)
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration+180
			l.layer = 12
			subs.append(l)
			
l = table.copy(line)
oki = syl.start_time + math.floor(syl.duration*8,5) --variable tiempo move1 end
okis = syl.start_time + math.floor(syl.duration*2,5) --variable tiempo move2 start
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\t(%d,%d,\\fscx140\\fscy140\\bord4\\3c&HFFFFFF&\\1c&H%s&)\\t(%d,%d,\\fscx100\\fscy100\\bord5\\3c&H%s&)}{\\p1}",x-105,y-1, x-math.random(-6,5),y, 0,okis, line.styleref.color2, oki, syl.end_time+200, line.styleref.color3, syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 2
subs.append(l)
	
		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\3c%s\\bord0.5\\1a&HFFFFFF&\\frx0\\fry0\\t(\\fscx150\\fscy150\\fscx50\\fscy50)}%s", x,y, line.styleref.color2, syl.text_stripped)
		l.start_time=line.start_time+syl.start_time
		l.end_time=l.start_time+syl.duration+100
		l.layer = 4
		subs.append(l)
		
l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\&HFFFCA4&\\bord3\shad0\\t(\\fscx10\\fscy10\\\\fscy150\\fscy150\fry90))}%s", x, y, line.styleref.color2, syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 2
subs.append(l)

end
end 


-------------------------------ACÁ TERMINAN LOS EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("JUMP STAR FX!", "Aplica tu FX! D:", fx_zheo)
aegisub.register_filter("JUMP STAR FX!", "Aplica tu FX! D:", 2000, fx_zheo)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------