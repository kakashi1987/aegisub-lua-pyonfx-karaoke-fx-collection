include("karaskel.lua")
include("zheolib.lua")

script_name = "SNOW FX"
script_description = "FX lua to you ^^"
script_author = "KFDS"
script_version = "6.2"

function fx_KFDS(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
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
	aegisub.progress.task("Finished!")
	aegisub.progress.set(100)
	aegisub.set_undo_point(fx_KFDS)
end


function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 40
if i ==1 then
KFDS=0
end
function sil()
silaba = ""..syl.text_stripped..""
return silaba
end


l = table.copy(line)
l.text = "{"..fad(800,0)..an(5)..move(-10+rand(10),y,x,y)..org(x,y)..bord(1)..frx(rand(15))..color(3,'HFFFFFF')..be(1)..t(frx(0)).."}"..sil()
l.start_time = line.start_time -1000+KFDS
l.end_time = line.start_time+KFDS
l.layer=0
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..bord(3)..blur(6)..estilo(1,line.styleref.color2).."}"..sil()
l.start_time = line.start_time+KFDS
l.end_time = line.start_time+KFDS
l.layer=1
subs.append(l)
KFDS=KFDS+(1000/line.kara.n)


l = table.copy(line)
l.text = "{"..an(5)..move(x,y,x,y-25)..t(frz(120)..move(x,y,x-10,y)..fad(0,200)).."}"..sil()
l.start_time=l.start_time+syl.start_time
l.end_time=l.start_time+syl.duration+math.random(200,1200)
l.layer=2
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..alfa(1,'ff')..estilo(1,line.styleref.color1).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=3
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..move(x,y+8,x,y)..frxyz(5,7,10)..estilo(1,line.styleref.color1)..blur(5)..t(blur(0)..bord(1)).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=4
subs.append(l)


l = table.copy(line)
for i=0,20 do
rand_frx=rand(-60,50)
rand_frz=rand(-50,60)
rand_fry=rand(-60,50)
l.text = "{"..an(5)..move(x+rand(-20,20),y+rand(-20,20),x+rand(-40,40),y+rand(300),0,3000)..color(1,'&HFFFFFF&')..shad(0)..bord(0)..t((0),(100)..fscx(250)..fscy(250))..t(fscx(60)..fscy(60)..frx(rand_frx)..frz(rand_frz)..fry(rand_fry)).."}"..p(3,'m 0 16 l 5 16 l 2 11 l 3 9 l 8 16 l 16 16 l 12 9 l 3 9 l 4 7 l 11 7 l 8 2 l 10 0 l 13 5 l 16 0 l 19 0 l 14 7 l 19 15 l 24 7 l 19 0 l 22 0 l 25 5 l 28 0 l 30 2 l 27 7 l 34 7 l 35 9 l 26 9 l 22 16 l 30 16 l 35 9 l 36 11 l 33 16 l 38 16 l 38 19 l 33 19 l 36 24 l 35 26 l 30 19 l 22 19 l 26 26 l 35 26 l 34 28 l 27 28 l 30 33 l 28 35 l 25 30 l 22 35 l 19 35 l 24 28 l 19 20 l 14 28 l 19 35 l 16 35 l 13 30 l 10 35 l 8 33 l 8 33 l 11 28 l 4 28 l 3 26 l 12 26 l 16 19 l 8 19 l 3 26 l 2 24 l 5 19 l 0 19 ')
l.start_time=line.start_time+syl.start_time+10
l.end_time=line.start_time+syl.start_time+10+syl.duration+KFDS*20
l.layer=5
subs.append(l)
end


l = table.copy(line)
l.text = "{"..an(5)..move(x,y+5,x,y)..estilo(1,line.styleref.color1)..blur(1)..t(blur(0)..bord(1)).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=6
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..estilo(1,line.styleref.color1)..move(x,y,x-9,y+50)..t(fscxy(150)..frz(360)..alpha('ff'))..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time+100
l.end_time=l.start_time+syl.duration+1000
l.layer=7
subs.append(l)
KFDS=KFDS+(1000/line.kara.n)

end
end

aegisub.register_macro("Snow", "Enjoy", fx_KFDS)
aegisub.register_filter("Snow", "To you ^^", 2000, fx_KFDS)