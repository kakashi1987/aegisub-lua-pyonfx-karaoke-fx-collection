include("karaskel.lua")
include("ezheolib.lua")

script_name = "SOON"
script_description = "KFDS_&_ALOW2_LUA_FX"
script_author = "KFDS & ALOW2"
script_version = "1"


function fx_KFDS(subs)
	aegisub.progress.task("Creando FX")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Applying effect...")
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
	aegisub.progress.task("D: Acabo la wea!")---("Por fin termine D:!")
	aegisub.progress.set(100)
	
end




function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 55
if i == 1 then
tempo=0
end

function sil()
silaba = ""..syl.text_stripped..""
return silaba
end


l = table.copy(line)
l.text = "{"..fad(100,0)..an(5)..pos(x,y)..blur(1)..bord(3)..frx(100)..color(1,'ffffff')..t(frx(360)..estilo(1,line.styleref.color2)..bord(2)).."}"..sil()
l.start_time = line.start_time+tempo-800
l.end_time = line.start_time
l.layer=0
subs.append(l)

l = table.copy(line)
l.text = "{"..fad(100,0)..an(5)..pos(x,y)..blur(1)..bord(3)..frx(100)..color(1,'ffffff')..t(frx(-360)..estilo(1,line.styleref.color2)..bord(2)).."}"..sil()
l.start_time = line.start_time+tempo-800
l.end_time = line.start_time
l.layer=1
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..estilo(1,line.styleref.color2).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=2
subs.append(l)
tempo=tempo+(1000/line.kara.n)


l = table.copy(line)
l.text = "{"..an(5)..org(x,y)..blur(10)..fscxy(100,100)..pos(x,y)..estilo(1,line.styleref.color2)..t(fscxy(50,50)..frx(120)..bord(2)..alpha('ff')).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 3
subs.append(l)

l = table.copy(line)
l.text = "{"..an(5)..org(x,y)..blur(10)..fscxy(100,100)..pos(x,y)..estilo(1,line.styleref.color2)..t(fscxy(50,50)..fry(120)..bord(2)..alpha('ff')).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 4
subs.append(l)

l = table.copy(line)
l.text = "{"..an(5)..org(x,y)..fscxy(100,100)..pos(x,y)..estilo(1,line.styleref.color2)..t(fscxy(50,50)..frz(360)..bord(0)..alpha('ff')).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 5
subs.append(l)


l = table.copy(line)
posy={'-20','-10','10','20','0'}
for i =0,4 do
l.text = string.format("{\\fad(100,0)\\an5\\be1\\move(%d,%d,%d,%d)\\bord0\\1c&HFFFFFF&\\t(\\be0\\1c%s)}%s",x,y+posy[1+i*1],x,y,line.styleref.color2,syl.text_stripped)
l.start_time = line.start_time-800+tempo
l.end_time = line.start_time+tempo
l.layer=6
subs.append(l)
end



l = table.copy(line)
l.text = "{"..fad(100,0)..an(5)..pos(x,y)..blur(1)..bord(3)..frx(100)..color(1,'ffffff')..t(frx(360)..estilo(1,line.styleref.color2)..bord(2)).."}"..sil()
l.start_time = line.start_time+tempo-800
l.end_time = line.start_time
l.layer=7
subs.append(l)


l = table.copy(line)
l.text = "{"..fad(100,0)..an(5)..pos(x,y)..blur(1)..bord(3)..frx(100)..color(1,'ffffff')..t(frx(-360)..estilo(1,line.styleref.color2)..bord(2)).."}"..sil()
l.start_time = line.start_time+tempo-800
l.end_time = line.start_time
l.layer=8
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..estilo(1,line.styleref.color2).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=9
subs.append(l)
tempo=tempo+(1000/line.kara.n)


l = table.copy(line)
l.text = "{"..an(5)..org(x,y)..blur(10)..fscxy(100,100)..pos(x,y)..estilo(1,line.styleref.color2)..t(fscxy(50,50)..frx(120)..bord(2)..alpha('ff')).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=10
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..org(x,y)..blur(10)..fscxy(100,100)..pos(x,y)..estilo(1,line.styleref.color2)..t(fscxy(50,50)..fry(120)..bord(2)..alpha('ff')).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=11
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..org(x,y)..fscxy(100,100)..pos(x,y)..estilo(1,line.styleref.color2)..t(fscxy(50,50)..frz(360)..bord(0)..alpha('ff')).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=12
subs.append(l)

			
l = table.copy(line)
l.text = "{"..an(5)..frz(160)..alpha('ff')..pos(x,y)..estilo(1,line.styleref.color2).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=13
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..frz(-160)..alpha('ff')..pos(x,y)..estilo(1,line.styleref.color2).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=14
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..frx(33)..frz(360)..alpha('ff')..pos(x,y)..estilo(1,line.styleref.color2).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=15
subs.append(l)


l = table.copy(line)

for i = 0,30 do
fsxy=rand(4,20)
l.text = "{"..bord(5)..blur(8)..an(5)..fad(100,200)..move(x+rand(20),y+rand(20),x-rand(35),y-rand(40))..fscxy(fsxy)..color(1,line.styleref.color1).."}"..p(2,'m 23 0 l 15 12 l 0 16 l 10 27 l 9 42 l 23 36 l 37 42 l 36 27 l 46 16 l 31 12 ') 
l.start_time=line.start_time+syl.start_time+rand(200,400)
l.end_time = l.start_time+syl.duration+rand(10,10)
l.layer=16
subs.append(l)
end



for i = 0,20 do
fsxy=rand(2,8)
l.text = "{"..bord(5)..blur(8)..alpha(rand(100,255))..an(5)..fad(100,200)..move(x-rand(30),y-rand(30),x-rand(35),y-rand(40))..fscxy(fsxy)..color(1,line.styleref.color2).."}"..p(2,'m 23 0 l 15 12 l 0 16 l 10 27 l 9 42 l 23 36 l 37 42 l 36 27 l 46 16 l 31 12 ') 
l.start_time = line.start_time+syl.start_time+rand(200,400)
l.end_time = l.start_time+syl.duration+rand(10,10)
l.layer=17
subs.append(l)
end

for i = 0,20 do
fsxy=rand(4,10)
l.text = "{"..bord(5)..blur(8)..alpha(rand(100,255))..an(5)..fad(100,200)..move(x-rand(30),y-rand(30),x-rand(35),y-rand(40))..fscxy(fsxy)..color(1,'HFFFFFF').."}"..p(2,'m 23 0 l 15 12 l 0 16 l 10 27 l 9 42 l 23 36 l 37 42 l 36 27 l 46 16 l 31 12 ') 
l.start_time=line.start_time+syl.start_time+rand(200,400)
l.end_time=l.start_time+syl.duration+rand(10,10)
l.layer=18
subs.append(l)
end



for i = 0,30 do
fsxy=rand(4,20)
l.text = "{"..bord(5)..blur(8)..an(5)..fad(100,200)..move(x+rand(20),y+rand(20),x-rand(35),y-rand(40))..fscxy(fsxy)..color(1,line.styleref.color1).."}"..p(2,'m 23 0 l 15 12 l 0 16 l 10 27 l 9 42 l 23 36 l 37 42 l 36 27 l 46 16 l 31 12 ') 
l.start_time=line.start_time+syl.start_time+rand(200,400)
l.end_time = l.start_time+syl.duration+rand(10,10)
l.layer=19
subs.append(l)
end


for i = 0,20 do
fsxy=rand(2,8)
l.text = "{"..bord(5)..blur(8)..alpha(rand(100,255))..an(5)..fad(100,200)..move(x-rand(30),y-rand(30),x-rand(35),y-rand(40))..fscxy(fsxy)..color(1,line.styleref.color2).."}"..p(2,'m 23 0 l 15 12 l 0 16 l 10 27 l 9 42 l 23 36 l 37 42 l 36 27 l 46 16 l 31 12 ') 
l.start_time = line.start_time+syl.start_time+rand(200,400)
l.end_time = l.start_time+syl.duration+rand(10,10)
l.layer=20
subs.append(l)
end


for i = 0,20 do
fsxy=rand(4,10)
l.text = "{"..bord(5)..blur(8)..alpha(rand(100,255))..an(5)..fad(100,200)..move(x-rand(30),y-rand(30),x-rand(35),y-rand(40))..fscxy(fsxy)..color(1,'HFFFFFF').."}"..p(2,'m 23 0 l 15 12 l 0 16 l 10 27 l 9 42 l 23 36 l 37 42 l 36 27 l 46 16 l 31 12 ') 
l.start_time=line.start_time+syl.start_time+rand(200,400)
l.end_time=l.start_time+syl.duration+rand(10,10)
l.layer=21
subs.append(l)
end
			

for i = 0,1 do
colores ={'HFFFFFF', 'HD3CFCF'}
rand_color= colores[math.random(1,1)]
l.text = "{"..estilo(3,line.styleref.color1)..alpha(rand(20,250))..bord(1)..blur(3)..color(1,'H767575')..bord(0.1)..an(5)..fad(100,200)..move(x+rand(23),y+rand(38),x-rand(16),y-rand(25))..fscx(200,100)..fscy(200,100)..t(color(1,rand_color)).."}"..p(2,'m 0 150 l 5 130 l 4 10 l 5 0 l 10 0 l 25 5 l 26 0 l 4 -10 l 2 -45 l 3 -50 l 0 -55 l -3 -50 l -2 -45 l -4 -10 l -26 0 l -25 5 l -10 0 l -5 0 l -4 10 l -5 130  ')
l.end_time=l.start_time+syl.duration+rand(10,250)
l.layer=22
subs.append(l)
end


for i = 0,1 do
colores ={'HFFFFFF', 'HD3CFCF'}
rand_color= colores[math.random(1,1)]
l.text = "{"..estilo(3,line.styleref.color1)..alpha(rand(20,250))..bord(1)..blur(3)..color(1,'H767575')..bord(0.1)..an(5)..fad(100,200)..move(x+rand(23),y+rand(38),x-rand(16),y-rand(25))..fscx(200,100)..fscy(200,100)..t(color(1,rand_color)).."}"..p(2,'m 0 150 l 5 130 l 4 10 l 5 0 l 10 0 l 25 5 l 26 0 l 4 -10 l 2 -45 l 3 -50 l 0 -55 l -3 -50 l -2 -45 l -4 -10 l -26 0 l -25 5 l -10 0 l -5 0 l -4 10 l -5 130  ')
l.end_time=l.start_time+syl.duration+rand(10,250)
l.layer=23
subs.append(l)
end


end
end



aegisub.register_macro("SOON KARAOKE", "KFDS", fx_KFDS)
aegisub.register_filter("SOON KARAOKE", "KFDS", 2000, fx_KFDS)