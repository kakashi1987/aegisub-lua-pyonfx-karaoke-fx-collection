include("karaskel.lua")

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "Cortar Letras"
script_description = "FX"
script_author = "Gen Mishima and Zheo"
script_version = "1.01"

--FUNCIÓN GENERADOR FX... NO TOCAR!!!
function fx_Zheo(subs)
	aegisub.progress.task("Creando FX")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Aplicando FX")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Esto llevo trabajado (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment and
				(l.style == "Default" or l.style == "Romaji") then
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
	aegisub.set_undo_point("fx_Zheo")
end
--TERMINA FUNCION GENERADOR

-------------------------------TERMINA CONFIGURACIONES DE LA MACRO------------------------

-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

--CONFIGURACION DE X-Y
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 25
if i == 1 then
tempo=0
end

--## COLORES ALEATOREOS PARA EL \CLIP y \MOVE
colores ={'393AD9', '6363C2', '2A2ABB', '0C0D7D'}
rand_color= colores[math.random(1,4)]

--## CONFIGURACIÓN DEL \CLIP
valor = 2
genera_pos_neg = math.random(-1,1)
if genera_pos_neg == 0 then
    genera_pos_neg = 1
    end
dire = math.random(500,900) * genera_pos_neg
col1 = x+syl.width+syl.width*valor+dire
col2 = y-syl.height/2-syl.height*valor
col3 = x-syl.width*valor-dire
col4 = y+syl.height/2+syl.height*valor

--## CONFIGURACIÓN DEL \MOVE
col = x-col3
lin = y-col4
val_mov = 40
val_col = col/val_mov
val_lin = lin/val_mov
col_fin = x-val_col
lin_fin = y-val_lin


--FX INICIAL
l = table.copy(line)
posy={'-20','-10','10','20','0'}
for i =0,4 do
    l.text = string.format("{\\fad(100,0)\\an5\\be1\\move(%d,%d,%d,%d)\\bord0\\1c&HFFFFFF&\\t(\\be0\\1c%s)}%s",x,y+posy[1+i*1],x,y,line.styleref.color2,syl.text_stripped)
    l.start_time = line.start_time-800+tempo
    l.end_time = line.start_time+tempo
    l.layer=3
    subs.append(l)
    end


--SILABAS ESTATICAS
l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\bord0\\t(\\bord1)}%s",x,y,line.styleref.color2,syl.text_stripped)
l.start_time = line.start_time+tempo
l.end_time = line.start_time+syl.start_time
l.layer=3
subs.append(l)
tempo=tempo+(1000/line.kara.n)


--FX DE SILABAS CLIP
l = table.copy(line)
l.text = string.format("{\\fad(0,100)\\an5\\pos(%d,%d)\\1c%s\\fscx150\\fscy150\\clip(m %d %d l %d %d %d %d)\\t(\\fscx100\\fscy100\\1c&H%s\\bord0)}%s",x,y,line.styleref.color2,col1,col2,col1,col4,col3,col4, rand_color,syl.text_stripped)
l.start_time = line.start_time+syl.start_time
l.end_time = l.start_time+syl.duration+100
l.layer=4
subs.append(l)

--FX DE SILABAS MOVE
l = table.copy(line)   
l.text = string.format("{\\fad(0,100)\\an5\\move(%d,%d,%d,%d)\\1c%s\\fscx150\\fscy150\\clip(m %d %d l %d %d %d %d)\\t(\\fscx100\\fscy100\\1c&H%s\\bord0)}%s",x,y,col_fin,lin_fin,line.styleref.color2,col3,col2,col1,col2,col3,col4,rand_color,syl.text_stripped)
l.start_time = line.start_time+syl.start_time
l.end_time = l.start_time+syl.duration+100
l.layer=4
subs.append(l)

-- FX SANGRE
l = table.copy(line)
for i=0,50 do
    random_pos = math.random(100,500)
    l.layer=0
    l.text = string.format("{\\fad(0,200)\\move(%d,%d,%d,%d)\\an5\\shad0\\bord0\\be1\\1c&H191AA9&\\t(\\fscx%d\\fscy%d))}{\\p%d}m 0 0 m 10 20 b 16 20 20 16 20 10 b 20 4 16 0 10 0 b 2 0 0 6 0 10 b 0 16 4 20 10 20 {\\p0}",x-math.random(-20,20),y-math.random(-20,20),x+math.random(-35,25),y+math.random(-35,25),random_pos,random_pos,math.random(4,6))
    l.start_time=line.start_time+syl.start_time
    l.end_time=l.start_time+syl.duration+math.random(200,400)
    l.start_time=l.start_time+i
    subs.append(l)
    end

l = table.copy(line)
for i=0,5 do
    random_pos = math.random(100,500)
    l.layer=5
    l.text = string.format("{\\fad(0,200)\\move(%d,%d,%d,%d)\\an5\\shad0\\bord0\\be1\\1c&H191AA9&\\t(\\fscx%d\\fscy%d))}{\\p%d}m 0 0 m 10 20 b 16 20 20 16 20 10 b 20 4 16 0 10 0 b 2 0 0 6 0 10 b 0 16 4 20 10 20 {\\p0}",x-math.random(-10,10),y-math.random(-10,10),x+math.random(-15,15),y+math.random(-15,15),random_pos,random_pos,math.random(4,6))
    l.start_time=line.start_time+syl.start_time
    l.end_time=l.start_time+syl.duration+math.random(200,400)
    l.end_time=l.end_time+i
    subs.append(l)
    end


-- FX GLOW
l = table.copy(line)
for i=0,15 do
    l.layer=0
    l.text = string.format("{\\pos(%d,%d)\\an5\\shad0\\3c&HFFFFFF&\\1a&HF5&\\3a&HF5&\\bord%d\\fscx150\\fscy150\\t(\\bord0\\3c%s\\fscx100\\fscy100)}%s",x,y,1+ i*1,line.styleref.color2, syl.text_stripped)
    l.start_time=line.start_time+syl.start_time
    l.end_time=l.start_time+syl.duration
    subs.append(l)
    end


end
end
-------------------------------ACÁ TERMINAN LOS EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("JR-F FX!", "Aplica tu FX! D:", fx_Zheo)
aegisub.register_filter("JR-F FX!", "Aplica tu FX! D:", 2000, fx_Zheo)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------