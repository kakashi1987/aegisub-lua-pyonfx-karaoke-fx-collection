include("zheolib1.lua")
include("karaskel.lua")

script_name = "Oblivious"
script_description = "FX"
script_author = "KFDS"
script_version = "1.0"

function fx_Oblivious(subs)
	aegisub.progress.task("ESPERA MIENTRAS SE APLICA EL EFECTO")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Creando FX")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("wait please...(%d/%d)", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment and
				(l.style == "Default" or "Default2") then
				karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else
			i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("Oblivious")
	aegisub.progress.set(100)
	aegisub.set_undo_point("fx_Oblivious")
	end
	
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 25
if i ==1 then
tiempo=0
end
function sil()
silaba = ""..syl.text_stripped..""
return silaba
end
for char in unicode.chars(sil()) do
if char == ' ' or char == '' then
l.text = "{}"
else


l = table.copy(line)
l.text ="{"..an(5)..move(x+30,y+20,x,y)..blur(5)..alpha(255)..shad(0)..color(1,line.styleref.color1)..fr(-180)..fscxy(150)..t(fscxy(150)..fr(0)..alpha(0)..color(1,line.styleref.color2)..shad(2)).."}"..char
l.start_time=line.start_time-800+tiempo
l.end_time=line.end_time+tiempo
l.layer=0
subs.append(l)


l = table.copy(line)
l.text ="{"..an(5)..pos(x,y)..blur(5)..color(1,line.styleref.color1).."}"..sil()
l.start_time=line.start_time
l.end_time=line.start_time+syl.start_time
l.layer=1
subs.append(l)


l = table.copy(line)
l.text ="{"..an(5)..pos(x,y)..blur(5)..color(1,line.styleref.color1)..fscxy(120)..t(fscxy(100)..color(1,line.styleref.color1)).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=line.end_time+syl.start_time
l.layer=2
subs.append(l)


if syl.duration > 10 then
l = table.copy(line)
luz=0
l.layer = 3
for i=0,6 do
colores = {'&HF68CA4&', '&HFFC0C1&', '&HF68CA4&', '&HFFB37A&', '&HFFB6FF&', '&HFFB37A&'}
rand_colores = colores[math.random(1,6)]
x1 = rand(x-y,x+y)
y1 = rand(y-syl.height,x+syl.height)+10
x2 = rand(x-syl.width,x+syl.width)
y2 = rand(y-syl.height,y+syl.height)+10
l.text ="{"..org(x,y)..move(x1,y1,x2,y2)..blur(5)..fr(rand(45,90))..shad(0)..bord(0.5)..color(1,'FFFFFF')..color(3,'rand_colores')..fscxy(70)..blur(2)..xbord(1)..be(2)..fad(100,0)..t(alpha(255)).."}"..p(2,'m 0 0 l 0 -13 l 1 0 l 14 -7 l 2 1 l 14 7 l 1 2 l 1 15 l 0 2 l -13 7 l -1 1 l -13 -7 ')
l.start_time=line.start_time
l.end_time=line.end_time+syl.start_time+rand(100,200)+50+syl.duration
luz=luz+1
subs.append(l)
end
end


l = table.copy(line)
l.text ="{"..an(5)..move(x,y,x-rand(-50,1),y+rand(10,50))..blur(5)..color(1,line.styleref.color1)..fr(0)..frx(0)..fry(0)..t(fr(rand(0,360))..frx(rand(180))..fry(rand(0,360))..color(1,line.styleref.color1)..shad(0)..alpha(255)).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=line.end_time+syl.start_time+syl.duration
l.layer=4
subs.append(l)
	

l = table.copy(line)
l.text ="{"..an(5)..pos(x,y)..blur(5)..fad(150,150)..bord(0)..fscxy(90)..color(1,line.styleref.color1).."}"..sil()
l.start_time=line.start_time
l.end_time=line.end_time
l.layer=5
subs.append(l)

end
end
end
end
		
aegisub.register_macro("Oblivious", "", fx_Oblivious)
aegisub.register_filter("Oblivious", "", 2000, fx_Oblivious)