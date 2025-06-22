include("karaskel.lua")
include("zheolib.lua")

script_name = "Inoue Joe - CLOSER"
script_description = "Fx lua"
script_author = "ASEDARK to lua KFDS"
script_version = "1"

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
	aegisub.set_undo_point("fx_KFDS")
end


function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 25
local actor=line.actor
if i==1 then
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

if actor ~= '1' then
l = table.copy(line)
for i = 0,45 do
l.text = "{"..an(5)..move(x+30,y,x,y,0,400)..fad(400,0)..color(3,'&HFFFFFF&')..bord(0)..fry(-360)..t(0,400,fry(0))..RangeColor(1,'&HFFFFFF&','&HD6FF6B&',768).."}"..char
l.start_time=line.start_time -400+tiempo
l.end_time=line.start_time+tiempo
l.layer=0
subs.append(l)
end


l = table.copy(line)
l.text = "{"..an(5)..move(x,y,x+20,y)..color(1,'&HFFFFFF&')..alpha(1,'&HFF&')..color(3,'&HFFFFFF&')..fscx(160)..fscy(160)..bord(2)..blur(10)..shad(2)..color(4,'&H000000&')..t(bord(0)..blur(0))..t(fscx(100)..fscy(100)..frz(0)).."}"..sil() 
l.start_time=line.start_time+syl.start_time
l.end_time=l.end_time+syl.start_time
l.layer=1
subs.append(l)


l = table.copy(line)
for j = 0,14 do
valpha={'11','22','33','44','55','66','77','88','99','110','121'}
rand_alpha= valpha[math.random(1,11)]
l.text = "{"..an(5)..move(x,y+j*4,x+j*2,y+j*4)..color(1,'&HFFFFFF&')..bord(0)..shad(0)..fscx(160)..fscy(160)..alfa(1,rand_alpha)..t(fscx(100)..fscy(100)..frz(0)).."}"..sil()
l.start_time=line.start_time+syl.start_time+(syl.duration/14)*j
l.end_time=l.end_time+syl.start_time
l.layer=2
subs.append(l)
end


l = table.copy(line)
for i = 0,45 do
l.text = "{"..an(5)..move(x,y,x+20,y)..color(1,'&HF57E66&')..bord(0)..color(3,'&HFFFFFF&')..RangeColor(1,'&HD6FF6B&','&HFFFFFF&',768).."}"..sil() 
l.start_time=line.start_time+syl.end_time
l.end_time=l.end_time+syl.end_time
l.layer=3
subs.append(l)
end


l = table.copy(line)
l.text = "{"..org(x,y)..an(5)..move(x,y,x-200,y)..fad(0,800)..color(1,'&HFFFFFF&')..color(3,'&HFFFFFF&')..bord(1)..blur(5)..t(fry(360)..fscx(0)..fscy(0)).."}"..char
l.start_time=line.start_time+syl.start_time
l.end_time=l.end_time+syl.start_time+300+tiempo
l.layer=4
subs.append(l)


elseif actor=='2'then
l = table.copy(line)
for i = 0,45 do
l.text = "{"..an(5)..move(x+30,y,x,y,0,400)..fad(400,0)..color(3,'&HFFFFFF&')..bord(0)..fry(-360)..t(0,400,fry(0))..RangeColor(1,'&HFFFFFF&','&H0000FF&',768).."}"..char
l.start_time=line.start_time -400+tiempo
l.end_time=line.start_time+tiempo
l.layer=0
subs.append(l)
end


l = table.copy(line)
l.text = "{"..an(5)..move(x,y,x+20,y)..color(1,'&HFFFFFF&')..color(3,'&HFFFFFF&')..fscx(100)..fscy(100)..shad(2)..color(4,'&H000000&')..t(fscx(120)..fscy(120))..AutoTags(TE3,50,'frz10','frz-10').."}"..sil() 
l.start_time=line.start_time+syl.start_time
l.end_time=l.end_time+syl.start_time
l.layer=1
subs.append(l)


l = table.copy(line)
for i = 0,2 do
GIRO_RAYO= {'-1420','1420'}
POS_RAYO_X={'-20','20'}
POS_RAYO_Y={'-14','14'}
POS_RAYO_Y1=POS_RAYO_Y[math.random(1,2)]
frz1=math.random(-45,45)
l.text = "{"..an(5)..pos(x-20,y+POS_RAYO_Y1)..color(1,'&HFFFFFF&')..color(3,'&HFFFFFF&')..fscx(100)..fscy(150)..frz(90)+(frz1)..bord(1)..alpha(3,'&HAA&')..blur(3)..t(frx(450)).."}"..p(2, 'm 0 48 l 24 41 l 51 56 l 65 49 l 73 33 l 66 49 l 82 40 l 99 43 l 82 41 l 51 57 l 37 49 l 21 60 l 36 49 l 24 42')
l.start_time=line.start_time+syl.start_time
l.end_time=l.end_time+syl.start_time
l.layer=2
subs.append(l)
end


l = table.copy(line)
for i = 0,2 do
GIRO_RAYO= {'-1420','1420'}
POS_RAYO_X={'-20','20'}
POS_RAYO_Y={'-14','14'}
POS_RAYO_X1=POS_RAYO_X[math.random(1,2)]
frz1=math.rand(-45,45)
l.text = "{"..an(5)..pos(x+POS_RAYO_X1,y-20)..color(1,'&HFFFFFF&')..color(3,'&HFFFFFF&')..fscx(150)..fscy(150)..frz(frz1)..bord(1)..alpha(3,'&HAA&')..blur(3)..t(fry(450)).."}"..p(2, 'm 0 48 l 24 41 l 51 56 l 65 49 l 73 33 l 66 49 l 82 40 l 99 43 l 82 41 l 51 57 l 37 49 l 21 60 l 36 49 l 24 42')
l.start_time=line.start_time+syl.start_time
l.end_time=l.end_time+syl.start_time
l.layer=3
subs.append(l)
end


l = table.copy(line)
for i = 0,45 do
l.text = "{"..an(5)..move(x,y,x,y)..color(1,'&HF57E66&')..bord(0)..color(3,'&HFFFFFF&')..RangeColor(1,'&HFFFFFF&','&H0000FF&',768).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.end_time+syl.start_time
l.layer=4
subs.append(l)
end

l = table.copy(line)
l.text = "{"..org(x,y)..an(5)..move(x,y,x-200,y)..fad(0,800)..color(1,'&HFFFFFF&')..color(3,'&HFFFFFF&')..bord(1)..blur(5)..t(fry(360)..fscx(0)..fscy(0)).."}"..char
l.start_time=line.start_time+syl.start_time
l.end_time=l.end_time+syl.start_time+300+tiempo
l.layer=5
subs.append(l)


elseif actor=='3'then
l = table.copy(line)
for i = 0,45 do
l.text = "{"..an(5)..move(x+30,y,x,y,0,400)..fad(400,0)..color(3,'&HFFFFFF&')..bord(0)..fry(-360)..t(0,400,fry(0))..RangeColor(1,'&HFFFFFF&','&H9318FC&',768).."}"..char
l.start_time=line.start_time -400+tiempo
l.end_time=line.start_time+tiempo
l.layer=0
subs.append(l)
end


l = table.copy(line)
for j = 0,15 do
COLORES= {'&H0000FF&','&H000000&'}
COLORE= COLORES[math.random(1,2)]
COLORES1= {'&H0000FF&','&H000000&'}
COLORE1= COLORES1[math.random(1,2)]
l.text = string.format("{\\an5\\fad(0,200)\\blur%d\\move(%d,%d,%d,%d)\\1c%d\\3c%d\\alpha&HAA&\\fscx%d\\fscy%d\\frz%d\\bord0\\t(\\fscx%d\\fscy%d\\fr-720)}%s",1+j*2,x,y,x-20-j*2,y,COLORE,COLORE1,100,100,1+j*30,100+j*5,100+j*6,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.end_time+syl.start_time+400
l.layer=1
subs.append(l)
end

l = table.copy(line)
for j = 0,20 do
COLORES= {'&H0000FF&','&H000000&'}
COLORE= COLORES[math.random(1,2)]
l.text = string.format("{\\an5\\fad(0,200)\\be%d\\move(%d,%d,%d,%d)\\1c%d\\alpha&HAA&\\fscx%d\\fscy%d\\frz%d\\bord0\\t(\\fscx%d\\fscy%d\\fr720)}%s",1+j*2,x,y,x-20-j*2,y,COLORE,100,100,1+j*30,100+j*5,100+j*6,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.end_time+syl.start_time+400
l.layer=2
subs.append(l)
end


l = table.copy(line)
ASE_GIRO=15
ASE_GIRO=-15
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\1c&HFFFFFF&\\3c&HFFFFFF&\\fscx160\\fscy160\\bord2\\blur10\\shad2\\4c&H000000&\\frz%d}{\\t(\\bord0\\blur0)}{\\t(\\fscx100\\fscy100\\frz0)}%s",x,y,x,y,ASE_GIRO,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.end_time+syl.start_time
l.layer=3
subs.append(l)


l = table.copy(line)
ASE_GIRO=15
ASE_GIRO=-15
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\1c&HFFFFFF&\\3c&HFFFFFF&\\fscx160\\fscy160\\shad2\\4c&H000000&\\frz%d}{\\t(\\fscx100\\fscy100\\frz0)}%s",x,y,x,y,ASE_GIRO,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.end_time+syl.start_time
l.layer=4
subs.append(l)


l = table.copy(line)
POS_Y = {'-12','12'}
POS_Y_FINAL = POS_Y[math.random(1,2)]
POS_AVION= {'15','30','45'}
POS_AVION_FIN = POS_AVION [math.random(1,3)]
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\1c&HFFFFFF&\\3c&HFFFFFF&\\bord0\\fry180\\fscx60\\fscy60}{\\p1}m -15 -4 l -13 -4 l -3 3 l 22 3 l 35 8 l 32 9 l 15 9 l 9 22 l 3 25 l 7 9 l -9 9 l -11 5 l -13 5 l -12 3 l -15 -4 m 15 3 l 9 -8 l 3 -13 l 7 3 {\\p0}",x+100,y+POS_Y_FINAL,15+POS_AVION_FIN,y+POS_Y_FINAL,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.end_time+syl.start_time
l.layer=5
subs.append(l)


l = table.copy(line)
for i = 0,5 do
POS_AVION= {'15','30','45'}
POS_AVION_FIN = POS_AVION [math.random(1,3)]
POS_Y = {'-12','12'}
POS_Y_FINAL = POS_Y[math.random(1,2)]
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\1c&HFFFFFF&\\3c&HFFFFFF&\\bord1\\fry180\\fscx20\\fscy20}{\\t(\\fscx60\\fscy60\\blur8)}{\\p1}m 4 0 l -9 -22 l 8 0 l 8 -19 l 10 -1 l 23 -27 l 14 2 l 37 -8 l 19 5 l 43 0 l 20 9 l 35 23 l 17 12 l 25 37 l 13 14 l 6 36 l 7 15 l -1 32 l 1 14 l -14 29 l -2 9 l -29 5 l -2 6 l -2 6 l -27 -8 l 0 4 l -23 -18 l 4 0 {\\p0}",15+POS_AVION_FIN+5+math.random(-10,10),POS_Y_FINAL+y+math.random(-10,10),15+POS_AVION_FIN+math.random(-10,10),POS_Y_FINAL+y+math.random(-10,10),syl.text_stripped)
l.start_time=line.start_time-15
l.end_time=l.end_time+100
l.layer=6
subs.append(l)

l = table.copy(line)
POS_AVION= {'15','30','45'}
POS_AVION_FIN = POS_AVION [math.random(1,3)]
POS_Y = {'-12','12'}
POS_Y_FINAL = POS_Y[math.random(1,2)]
SK_GIRO = {'0','180'};
SKULL_GIRO = SK_GIRO[math.random(1,2)]
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\1c&HFFFFFF&\\bord0\\shad0\\fry%d\\fscx100\\fscy100}{\\fn HollowWeenie Bats}t",15+POS_AVION_FIN+5+math.random(-10,10),POS_Y_FINAL+y+math.random(-10,10),15+POS_AVION_FIN+math.random(-10,10),POS_Y_FINAL+y+math.random(-10,10),SKULL_GIRO,syl.text_stripped)
l.start_time=line.start_time-15
l.end_time=l.end_time-17
l.layer=7
subs.append(l)


l = table.copy(line)
for i = 0,45 do
l.text = "{"..an(5)..move(x,y,x,y)..color(1,'&HF57E66&')..bord(0)..color(3,'&HFFFFFF&')..RangeColor(1,'&HFFFFFF&','&H9318FC&',768).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.end_time+syl.start_time
l.layer=8
subs.append(l)


l = table.copy(line)
l.text = "{"..org(x,y)..an(5)..move(x,y,x-200,y)..fad(0,800)..color(1,'&HFFFFFF&')..color(3,'&HFFFFFF&')..bord(1)..blur(5)..t(fry(360)..fscx(0)..fscy(0)).."}"..char
l.start_time=line.start_time+syl.start_time
l.end_time=l.end_time+syl.start_time+300+tiempo
l.layer=9
subs.append(l)

end
end
end
end
end
end
end

aegisub.register_macro("Inoue Joe - CLOSER", "", fx_KFDS)
aegisub.register_filter("Inoue Joe - CLOSER ", "", 2000, fx_KFDS)