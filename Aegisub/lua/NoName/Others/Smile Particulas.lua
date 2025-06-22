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
local y=line.margin_v + 17
if i ==1 then
tiempo=0
end
--FX INICIAL
	l = table.copy(line)
		l.text = string.format("{\\fad(100,0)\\an5\\move(%d,%d,%d,%d)\\bord3\\be3\\blur3\\fry360\\1c&HFFFFFF&\\3c&HFFFFFF&\\t(\\frx360\\1c%s\\3c%s\\bord1\\blur0\\be0\\fry0)}%s",x-10,0,x,y,line.styleref.color1,line.styleref.color3,syl.text_stripped)
		l.start_time = line.start_time -1000+tiempo
		l.end_time = line.start_time+tiempo
		l.layer=0
		subs.append(l)

l = table.copy(line)
			for i=0, 3 do
				if i==0 then
					tiempoi=0
				end
		--Rayos Electricos			
			l.text = string.format("{\\p1\\an5\\be6\\bord0\\shad2\\1c&HFFFFFF&\\move(%d,%d,%d,%d)\\fscx180\\fscy180\\t(\\fscx185\\fscy185)\\t(\\fscx35\\fscy45\\frx45\\fry35)}m 29 23 l -40 -38 l 60 52 m -40 -27 l 9 19 l 32 39 m -6 -19 l -6 -18 l 54 34 {\\p0}",x-syl.width/2,y,x+syl.width/2,y,syl.text_stripped)
			l.start_time=line.start_time+syl.start_time+tiempoi
			l.end_time=l.start_time+syl.duration+tiempoi
			subs.append(l)
				--Tiempos de salida de los circulos
				if syl.duration<170 then
				tiempoi=tiempoi+60
				elseif syl.duration<230 then
				tiempoi=tiempoi+70
				elseif syl.duration<300 then
				tiempoi=tiempoi+syl.duration/4
				else
				tiempoi=tiempoi+80
				end
			
			end
		
--SILABAS ESTATICAS
l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s}%s",x,y,line.styleref.color1,syl.text_stripped)
		l.start_time = line.start_time+tiempo
		l.end_time = line.start_time+syl.start_time
		l.layer=2
		subs.append(l)
		
color={"&HFFFFFF&","&HFFFFFF&","&HFFFFFF&","&HFFFFFF&","&HFFFFFF&", "&HFFFFFF&", "&HFFFFFF&"}
			inicio={0,0.4,0.5,0.6,0.7,0.8,0.9,1} --no sirve para nada...
			l = table.copy(line)
			for r=0,35 do
			local pcolor=color[math.random(1,7)]
			local pos=inicio[math.random(1,8)]
			l.text = string.format("{\\p2\\org(%d,%d)\\fad(50,70)\\1c%s\\3c%s\\1a&HFFFFFF&\\an5\\be1\\blur2\\bord1\\fscx50\\fscy50\\move(%d,%d,%d,%d)}}m 0 0 l 0 1 1 1 1 0{\\p0}", x,y,pcolor,pcolor,x+((syl.width/2)/2)+pos,y+((syl.height/2)/2)+pos,x+math.random(-50,50),y+math.random(-50,50))
			l.start_time=line.start_time+syl.start_time+(syl.duration/2)
			l.end_time=l.start_time+syl.duration+650
			subs.append(l)
			end
			
--FX DE SILABAS
l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\fad(100,4000)\\&HFFFCA4&\\bord0\shad0\\t(\\fscx75\\fscy75))}%s", x, y, line.styleref.color2, syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 2
subs.append(l)

l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\&HFFFCA4&\\bord1\shad0\\t(\\fscx380\\fscy380\\fscx75\\fscy75\\alpha&HFF&))}%s", x, y, line.styleref.color2, syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 2
subs.append(l)

l = table.copy(line)
for i=0,14 do
l.layer=0
l.text = string.format("{\\pos(%d,%d)\\an5\\shad0\\3c&HFFFFFF&\\1a&HFF&\\3a&HF5&\\bord%d\\t(\\bord5\\3c%s)}%s",x,y,1+ i*1,line.styleref.color2,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
subs.append(l)
end

end
end
-------------------------------ACÁ TERMINAN LOS EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("Smile Particulas Rayos FX!", "Aplica tu FX! D:", fx_zheo)
aegisub.register_filter("Smile Particulas Rayos FX!", "Aplica tu FX! D:", 2000, fx_zheo)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------