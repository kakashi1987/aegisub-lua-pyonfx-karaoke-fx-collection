--[[ Junto con este script debe venir  incluido un virus troyano de no ser asi, contactarme!! XD
kirav751@hotmail.com - kirav_gxf@hotmail.com - 
]]

include("karaskel.lua") ----Siempre Incluimos esto!

-----CONFIGURACIÓN DE LA MACRO-----
script_name = "-GxF- OP NGE -FX-"
script_description = "Kirav751"
script_author = "Kirav751"
script_version = "1.1"
-----FUNCIÓN GENERADOR DEL FX-----
function kirav751_FX(subs)
	aegisub.progress.task("..::Kirav751::..")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Aplicando!!!!!")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Aplicando!!!!! (%d/%d)...", ai, maxai))
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
aegisub.progress.task("TERMINO! XD")
	aegisub.progress.set(100)	
end
------------------------------------------------------------------------------------------------------------------------------------------

-----COMIENZAN LOS FX's-----

---CONFIGUARACIONES DE X - Y-----
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 32
-----ENTRADA-----
l = table.copy(line)
l.text = string.format("{\\fad(200,0)\\an5\\move(%d,%d,%d,%d)\\bord2\\frz720\\frx570\\fry560\\be3\\blur3\\frx0\\t(\\fry0\\1c%s\\3c%s\\bord0.5\\frx0\\blur5\\be0)}%s",x-math.random(-100,100),y-math.random(-30,30),x,y,line.styleref.color2,line.styleref.color3,syl.text_stripped)
l.start_time = line.start_time -800
l.end_time = line.start_time
l.layer=0
subs.append(l)   
 ---ESTATICA ---
l = table.copy(line)
for j = 0,0 do
l.text = string.format("{\\fad(150,0)\\bord1\\fscx90\\fscy110\\an5\\move(%d,%d,%d,%d)\\1c%s}%s",x,y,x-math.random(-0,0),y-math.random(-0,0),line.styleref.color1,syl.text_stripped)
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=2
subs.append(l)			
end	
----FX!!!!---
l = table.copy(line)
 l.text=string.format("{\\fad(0,200)\\an5\\move(%d,%d,%d,%d,100,10)\\1c%s\\3c%s\\frz0\\fscx120\\fscy120\\t(%d,%d)\\t(%d,%d,\\3a&H8200\\blur1\\fscx120\\fscy165\\be2\\bord1)\\t(%d,%d,\\blur0\\be5\\bord2\\fscx100\\fscy110\\1c%s\\3c%s)}%s",x,y+5,x,y,line.styleref.color1,line.styleref.color3,0,syl.duration,0,syl.duration/2,syl.duration/2,syl.duration,line.styleref.color1,line.styleref.color3,syl.text_stripped)
 l.start_time = line.start_time+syl.start_time
 l.layer='3'
 subs.append(l) 
end
end
-----TERMINAN LOS FX's-----

----------REGISTRO DE LA MACRO Y REGISTRO DE EXPORTACIÓN-----
aegisub.register_macro("-FX- -FX-", "Kirav751 ^^", kirav751_FX)
aegisub.register_filter("-FX- -FX-", "Kirav751 ^^", 2000, kirav751_FX)
