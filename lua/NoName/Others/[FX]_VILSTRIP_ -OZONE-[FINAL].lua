include("karaskel.lua") 

--+InFo
script_name = "-InF- ViLsTriP -OZONE-"
script_description = "Kirav751----> FANSUB: InF=Ichigo no Fansub - PV: Vilstrip -OZONE-"
script_author = "Kirav751"
script_version = "2.2"
-----FUNCIÓN GENERADOR DEL FX
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
				(l.style == "D_1" or l.style == "D_2" or l.style == "D_2_2" or l.style == "D_3" or l.style == "D_4" or l.style == "D_2-") then 
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

---CONFIGUARACIONES DE X - Y-----
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 30
if i ==1 then
tiempo=0
end
-----EFECTO ENTRADA
l = table.copy(line)
l.text = string.format("{\\fad(200,0)\\an5\\be1\\move(%d,%d,%d,%d)\\t(0,90,\\frx30\\alpha&H60&\\blur2\\bord1.2)\\t(90,400,\\frx0\\blur4\\bord0.5)\\1c%s}%s",x+550,y+0,x,y,line.styleref.color1,syl.text_stripped)
l.start_time = line.start_time-500
l.end_time = line.start_time+tiempo
l.layer=0
subs.append(l)  
-------SILABA ESTATICA
l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s}%s",x,y,line.styleref.color1,syl.text_stripped)
l.start_time = line.start_time+tiempo
l.end_time = line.start_time+syl.start_time
subs.append(l)
----EFECTO
l = table.copy(line)
l.text=string.format("{\\fad(0,200)\\an5\\move(%d,%d,%d,%d,100,10)\\1c%s\\3c%s\\frz0\\fscx120\\fscy120\\t(%d,%d)\\t(%d,%d,\\3a&H8200\\blur5\\fry720\\fry360\\be5\\bord0.5)\\t(%d,%d,\\blur0\\be5\\bord2\\fscx100\\fscy110\\1c%s\\3c%s)}%s",x,y+5,x,y,line.styleref.color1,line.styleref.color3,0,syl.duration,0,syl.duration/2,syl.duration/2,syl.duration,line.styleref.color1,line.styleref.color3,syl.text_stripped)
l.start_time = line.start_time+syl.start_time
l.layer=2
subs.append(l)
-----PARTICULAS
end
end 
----DATOS DE EXPORTACIÓN----
aegisub.register_macro("-InF * FX-", "Kirav751 ^^", kirav751_FX)
aegisub.register_filter("-InF * FX-", "Kirav751 ^^", 2000, kirav751_FX)
