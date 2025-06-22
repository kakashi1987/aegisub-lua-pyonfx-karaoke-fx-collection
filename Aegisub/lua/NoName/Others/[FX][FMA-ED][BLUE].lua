include("karaskel.lua") ---> ESTO SIEMPRE LO AGREGAMOS
include("zheolib.lua") -----> LA ZHEOLIB :D
---------------------------------------------------------------------------------------------------------------
script_name = "Full Metal Alchemist FX"               --| 
script_description = "By Kirav751---> 1/2"            --| 
script_author = "Kirav751"                            --| 
script_version = "1.0"                                --| 
---------------------------------------------------------------------------------------------------------------
----------GENERADOR FX----------
function fx_kirav751(subs)
	aegisub.progress.task("..::Kirav751::..")
	local meta, styles = karaskel.collect_head(subs)
	aegisub.progress.task("..::Kirav751::..")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("..::APLICANDO::.. (%d/%d)...", ai, maxai))
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
	aegisub.progress.task("..::COMPLETADO::..")
	aegisub.progress.set(100)
end

----------CONFIGURACION DE X & Y----------
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v +30
if i ==1 then
tiempo=0
end
---FUNCIÓN ALPHA---------------------------------------------    POR SORA LAMPAGEROUCH    -----------------------------------------------------------
function blurco(valor)                                                                --| 
blurC =  "\\blur" ..math.floor(valor).. "\\bord" ..math.floor(valor+valor/2/1).. ""   --| 
return blurC                                                                          --| 
end                                                                                   --| 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---FUNCIÓN Syl---
function sil()
silaba = ""..syl.text_stripped..""
return silaba
end

--FX INICIAL
l = table.copy(line)
l.text = "{"..fad(300,0)..an(5)..move(x+rand(90),y+rand(180),x,y)..bord(3)..blur(5)..color(1,'ffffff')..t(frz(720)..estilo(1,line.styleref.color1)..bord(1)).."}"..sil()
l.start_time = line.start_time -800 
l.end_time = line.start_time 
l.layer=2
subs.append(l) 
 ---ESTATICA ---
l = table.copy(line)
for j = 0,0 do
l.text = string.format("{\\fad(150,0)\\bord2\\be5\\fscx90\\fscy110\\an5\\move(%d,%d,%d,%d)\\1c%s}%s",x,y,x-math.random(-3,3),y-math.random(-3,3),line.styleref.color1,syl.text_stripped)
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=3
subs.append(l)			
end	
----FX!!!!---
l = table.copy(line)
 l.text=string.format("{\\fad(0,200)\\an5\\move(%d,%d,%d,%d,100,10)\\1c%s\\3c%s\\frz0\\fscx120\\fscy120\\t(%d,%d)\\t(%d,%d,\\3a&H8200\\blur5\\fscx100\\fscy180\\be5\\bord0.5)\\t(%d,%d,\\blur0\\be5\\bord2\\fscx100\\fscy110\\1c%s\\3c%s)}%s",x,y+5,x,y,line.styleref.color1,line.styleref.color3,0,syl.duration,0,syl.duration/2,syl.duration/2,syl.duration,line.styleref.color1,line.styleref.color3,syl.text_stripped)
 l.start_time = line.start_time+syl.start_time
 l.layer=4
 subs.append(l)
subs.append(l)
---PARTICULAS 1 ---
-------DERECHA
l = table.copy(line)
for i = 0,12 do
l.text = "{"..an(5)..move(x+rand(50),y+rand(50),x+rand(25)+500+(i*2),y+rand(30)/2)..color(3,"&HC30B1E&")..t(fscxy(90,90)..color(1,"&HD0BCA0&")..frz(0))..blur(0)..be(5)..bord(1).."}"..p(1,"m 10 1 l 7 2 l -1 -2 l -4 0 l -6 3 l -4 0 l -9 2 l -14 1 l -9 2 l -1 -2 l 3 0 l 4 -2 l 3 0 l 7 2 ")
l.start_time=line.start_time+syl.start_time+math.random(-50,50)
l.end_time=l.start_time+rand(600,900)
l.layer = 1
subs.append(l)
end
--------IZQUIERDA
l = table.copy(line)
for i = 0,12 do
l.text = "{"..an(5)..move(x+rand(10),y+rand(50),x+rand(25)-500+(i*2),y+rand(30)/2)..color(3,"&HC30B1E&")..t(fscxy(90,90)..color(1,"&HD0BCA0&")..frz(0))..blur(1)..be(5)..bord(1).."}"..p(1,"m 10 1 l 7 2 l -1 -2 l -4 0 l -6 3 l -4 0 l -9 2 l -14 1 l -9 2 l -1 -2 l 3 0 l 4 -2 l 3 0 l 7 2 ")
l.start_time=line.start_time+syl.start_time+math.random(-50,50)
l.end_time=l.start_time+rand(600,900)
l.layer = 1
subs.append(l)


---PARTICULAS 2(BRILLOS)---
-------DERECHA
l = table.copy(line)
for i = 0,5 do
l.text = "{"..an(5)..move(x+rand(50),y+rand(10),x+rand(25)+500+(i*2),y+rand(30)/2)..color(3,"&HFFFFFF&")..t(fscxy(90,90)..color(1,"&HFFFFFF&")..frz(90))..blur(0)..be(0.5)..bord(0).."}"..p(1,"m -1 -1 l 0 -5 l 0 -1 l 4 -2 l 0 0 l 4 3 l 0 1 l -1 4 l -1 1 l -5 2 l -2 0 l -6 -4 ")
l.start_time=line.start_time+syl.start_time+math.random(-50,50)
l.end_time=l.start_time+rand(600,900)
l.layer = 2
subs.append(l)
end
--------IZQUIERDA
l = table.copy(line)
for i = 0,5 do
l.text = "{"..an(5)..move(x+rand(10),y+rand(10),x+rand(25)-500+(i*2),y+rand(30)/2)..color(3,"&HFFFFFF&")..t(fscxy(90,90)..color(1,"&HFFFFFF&")..frz(-90))..blur(0)..be(0.5)..bord(0).."}"..p(1,"m -1 -1 l 0 -5 l 0 -1 l 4 -2 l 0 0 l 4 3 l 0 1 l -1 4 l -1 1 l -5 2 l -2 0 l -6 -4 ")
l.start_time=line.start_time+syl.start_time+math.random(-50,50)
l.end_time=l.start_time+rand(600,900)
l.layer = 2
subs.append(l)
end
end
end
end

--REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN--
aegisub.register_macro("-ERES MUY FEO-", "..::Kirav751::..", fx_kirav751)
aegisub.register_filter("-FX-FMA OP2-", "..::Kirav751::..", 2000, fx_kirav751)
