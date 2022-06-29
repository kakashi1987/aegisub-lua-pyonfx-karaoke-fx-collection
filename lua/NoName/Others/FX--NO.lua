include("karaskel.lua")
include("zheolib.lua")
include("formaslib.lua")

script_name = "Fx Chingon ! xD"
script_description = "Fx del ending de Naruto Shippuuden llamado Shinkokyuu"
script_author = "kichanXcrazy"
script_version = "v1"

function fx_kXc(subs)
	aegisub.progress.task("QUE QUIERES QUE TE DIGA ??   NO ME METAS TU PUTO FX !!! xD")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Aplicando tu FX D:")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("PLEASE WAIT xD (%d/%d)...", ai, maxai))
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
	aegisub.progress.task("Ya te puedes ir !")
	aegisub.progress.set(100)
	aegisub.set_undo_point("fx_kXc")
end


function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local actor=line.actor
local x=syl.center + line.left
local y=line.margin_v + 25
if i == 1 then
tempo=0
end
function sil()
silaba = ""..syl.text_stripped..""
return silaba
end


l = table.copy(line)
l.text = "{"..fad(800,0)..an(5)..move(-10+rand(10),y,x,y)..org(x,y)..alfa(1,'ff')..bord(1)..frx(rand(15))..color(3,'HFFFFFF')..be(1)..t(frx(0)).."}"..sil()
l.start_time = line.start_time -800
l.end_time = line.start_time
l.layer=0
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..alfa(1,'ff')..color(3,'HFFFFFF').."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=0
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..move(x,y+8,x,y)..color(1,'H726FDE')..blur(5)..t(blur(0)..bord(1)).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer =5
subs.append(l)


if actor==’1’ then
l = table.copy(line)
for i=0,35 do
l.text = "{"..an(5)..move(x,y, x-rand(30,80), y+rand(30,60))..blur(4)..bord(0.3)..be(2)..c(3, 'ffffff')..RangeColor(1, f/35, 'AFCFF0', 'EBBE87').."}"..p(5,Formas(17))
l.start_time = line.start_time+syl.start_time
l.end_time = l.start_time+syl.duration+rand(600)
l.layer=0
subs.append(l)
end


if actor==’2’ then
l = table.copy(line)
for i=0,35 do
l.text = "{"..an(5)..move(x,y, x-rand(30,80), y+rand(30,60))..blur(4)..bord(0.3)..be(2)..c(3, 'ffffff')..RangeColor(1, f/35, '8C2D34', '659F96').."}"..p(5,Formas(17))
l.start_time = line.start_time+syl.start_time
l.end_time = l.start_time+syl.duration+rand(600)
l.layer=0
subs.append(l)
end


if actor==’3’ then
l = table.copy(line)
for i=0,35 do
l.text = "{"..an(5)..move(x,y, x-rand(30,80), y+rand(30,60))..blur(4)..bord(0.3)..be(2)..c(3, 'ffffff')..RangeColor(1, f/35, '1F6AD1', 'A2EFF0').."}"..p(5,Formas(17))
l.start_time = line.start_time+syl.start_time
l.end_time = l.start_time+syl.duration+rand(600)
l.layer=0
subs.append(l)
end


if actor==’4’ then
l = table.copy(line)
for i=0,35 do
l.text = "{"..an(5)..move(x,y, x-rand(30,80), y+rand(30,60))..blur(4)..bord(0.3)..be(2)..c(3, 'ffffff')..RangeColor(1, f/35, 'AFCFF0', 'EBBE87').."}"..p(5,Formas(17))
l.start_time = line.start_time+syl.start_time
l.end_time = l.start_time+syl.duration+rand(600)
l.layer=0
subs.append(l)
end





end
end


aegisub.register_macro("Prueba!", "FX Ending Naruto Shippuuden Shinkokyuu", fx_kXc)
aegisub.register_filter("Prueba!", "FX Ending Naruto Shippuuden Shinkokyuu", 2000, fx_kXc)