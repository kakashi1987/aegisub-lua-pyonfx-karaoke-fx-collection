include("karaskel.lua")  --->Siempre debemos añadir esto                                                                                     
include("zheolib.lua")   --->Podremos programar mas comodamente

-----CONFIGURACIÓN DE LA MACRO-----
script_name = "-FX- One ok Rock - Keep It Real -FX-"
script_description = "Lua FX ---> Hecho por Kirav751 para el PV One ok Rock - Keep It Real"
script_author = "Kirav751"
script_version = "1"

-----FUNCIÓN GENERADOR DEL FX-----
function fxs_kirav751(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("-APLICANDO-(%d/%d)...", ai, maxai))
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
	aegisub.progress.task("Terminado!")
	aegisub.progress.set(100)
end
-----TERMINA LA FUNCIÓN GENERADOR DE FX-----
	
-----CONFIGUARACIONES DE X - Y-----
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 40 
if i == 1 then
tempo=0
end

-----FUNCIÓN SIL-----		
function sil()
silaba = ""..syl.text_stripped..""
return silaba
end
if syl.inline_fx == "" then

-----COMEIENZO DE LOS EFECTOS-----
-----ENTRADA-----
l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d,0,600)\\fad(500,0)\\1c&H000000&\\fry90\\frz90\\fscx120\\t(50,100,\\frx0\\fscy100\\frz0\\fry0\\fscx100)\\t(150,250,\\fscy100\\fscx100)}%s",x-50,y-math.random(-30,30),x,y,syl.text_stripped)
l.start_time = line.start_time-650
l.end_time = line.start_time+syl.start_time
l.layer=0
subs.append(l) 
-----ESTATICA-----
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..estilo(1,line.styleref.color2).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=0
subs.append(l)
-----LETRA HACIA ARRIBA-----
l = table.copy(line)
l.text = "{"..an(5)..move(x+10,y,x,y+30)..color(2,'HFDF3B8')..blur(5)..t(frx(360)..frz(360)..blur(3)..bord(1)).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer =3
subs.append(l)			
-----LETRA HACIA ABAJO-----		
l = table.copy(line)
l.text = "{"..an(5)..move(x+10,y,x,y-30)..color(2,'HFDF3B8')..blur(5)..t(frx(360)..frz(360)..blur(3)..bord(1)).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer =3
subs.append(l)

end
end
end
-----FIN DE LOS EFECTOS----


aegisub.register_macro("FX", "Kirav751", fxs_kirav751)
aegisub.register_filter("FX", "Kirav751", 2000, fxs_kirav751)
