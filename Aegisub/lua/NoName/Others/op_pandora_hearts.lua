include("karaskel.lua")

-------------------------------CONFIGURACIONES DE LA MACRO--------------------------------

script_name = "op pandora"
script_description = "FX"
script_author = "KARAOKE LUA"
script_version = "1.01"

--FUNCIÓN GENERADOR FX... NO TOCAR!!!
function fx_rico(subs)
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
	aegisub.set_undo_point("fx_rico")
end
--TERMINA FUNCION GENERADOR

-------------------------------TERMINA CONFIGURACIONES DE LA MACRO------------------------

-------------------------------ACÁ COMIENZAN LOS EFECTOS-----------------------------------

ttt=0
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 30



local l = table.copy(line)
l.layer=4
l.start_time = l.start_time - 200
 l.end_time = l.start_time+ syl.start_time+200
l.text = string.format("{\\an5\\pos(%d,%d)\\fad(400,0)\\bord1\\3c&H6C849C&}%s",x,y,syl.text_stripped)
subs.append(l)

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

local l = table.copy(line)
local alkoon      
                               
             if math.mod (syl.i,2) ~= 0 then  
             alkoon = -10-20    
             else         
             alkoon = 10

  end
for g=0,00 do
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration + g*500 + 700
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\1c&HFFFFFF&\\3c&HFFFFFF&\\fad(0,300)\\bord1\\blur2\\t(\\frz%d)\\t(\\fs20)}%s",x,y,x-alkoon-15,y+alkoon,syl.duration*1,syl.text_stripped)
l.layer=3
subs.append(l)
end

local l = table.copy(line)
for g=0,05 do
l.start_time= line.start_time+syl.start_time-50-100
l.end_time= l.start_time+syl.duration+ g*550
l.text = string.format("{\\fad(10,200)\\move(%d,%d,%d,%d)\\an5\\shad0\\fscx10\\fscy10\\bord0.5\\3a&HAA&\\blur5\\3c&HFFFFFF&\\1c&HFFFFFF&\\t(\\fscx5\\fscy5\frz360\\alpa&HAA&)}{\\p1}m 26 37 l 38 27 l 45 19 l 52 11 l 57 7 b 66 0 72 9 64 29 l 59 26 l 62 31 b 58 36 52 43 46 47 l 41 44 l 44 48 b 41 52 37 56 33 58 l 28 52 l 30 58 l 27 61 l 24 58 l 24 61 l 21 58 l 17 61 l 17 59 b 11 62 6 64 0 64 l 0 60 b 5 60 12 57 16 54 l 14 51 l 18 51 l 17 47 l 20 50 l 20 42 l 24 38 l 25 45{\\p0}",x-math.random(-6,6),y-math.random(-6,6),x+math.random(-35,25)*syl.duration/600,y+math.random(-35,25),random_pos,random_pos,syl.text_stripped)
 l.layer=1
 subs.append(l)   
end
local l = table.copy(line)
for g=0,05 do
l.start_time= line.start_time+syl.start_time  -50
l.end_time= l.start_time+syl.duration+ g*550
l.text = string.format("{\\fad(10,200)\\move(%d,%d,%d,%d)\\an5\\shad0\\fscx15\\fscy15\\bord0.5\\3a&HAA&\\blur5\\3c&HFFFFFF&\\1c&HFFFFFF&\\t(\\fscx5\\fscy5\frz360\\alpa&HAA&)}{\\p1}m 26 37 l 38 27 l 45 19 l 52 11 l 57 7 b 66 0 72 9 64 29 l 59 26 l 62 31 b 58 36 52 43 46 47 l 41 44 l 44 48 b 41 52 37 56 33 58 l 28 52 l 30 58 l 27 61 l 24 58 l 24 61 l 21 58 l 17 61 l 17 59 b 11 62 6 64 0 64 l 0 60 b 5 60 12 57 16 54 l 14 51 l 18 51 l 17 47 l 20 50 l 20 42 l 24 38 l 25 45{\\p0}",x-math.random(-6,6),y-math.random(-6,6),x+math.random(-15,25),y+math.random(-15,25)*syl.duration/600,random_pos,random_pos,syl.text_stripped)
l.layer=1
subs.append(l)   
end		


                end

end
-------------------------------ACÁ TERMINAN LOS EFECTOS----------------------------------------------------


-------------------------------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-------------------------------
aegisub.register_macro("TNF!", "Aplica tu FX! D:", fx_rico)
aegisub.register_filter("TNF!", "Aplica tu FX! D:", 2000, fx_rico)
-------------------------------TERMINO DE REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--------------------