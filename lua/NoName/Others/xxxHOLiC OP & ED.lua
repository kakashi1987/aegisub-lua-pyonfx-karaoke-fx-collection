include("karaskel.lua")
include("zheolib.lua")

script_name = "xxxHOLiC OP & ED"
script_description = "FX lua"
script_Special_Thanks_for_OP = "Thank you nickle for FX (Natsu no Sora) & thanx Aoi for FX (Snow Angel) & I make this FX ^^"
script_Special_Thanks_for_ED = "Thank you Riuuzaki for FX (este) & I make this FX ^^"
script_author = "KFDS & Riuuzaki & nickle & Aoi"
script_version = "1.2"

function fx_xxxHOLiC(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
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
	aegisub.progress.task("Finished!")
	aegisub.progress.set(100)
	aegisub.set_undo_point("fx_xxxHOLiC")
end


function circulox(radio,centrox,angulo)
posx=centrox + radio*math.cos(angulo)
return posx
end
function circuloy(radio,centroy,angulo)
posy=centroy + radio*math.sin(angulo)
return posy
end
function do_fx(subs, meta, line)
lineas={ }
posiciones={ }
for k = 1, line.kara.n do
local syl = line.kara[k]
times=syl.start_time
posis=syl.width/2
posiciones[k]=posis
lineas[k]=times
end
local sum=1
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y
actor=line.actor
if actor=="1" then
y=line.margin_v + 60
else
y=line.margin_v + 30
end
if i ==1 then
tiempo=0
end
function sil()
silaba = ""..syl.text_stripped..""
return silaba
end

if line.actor == 'OP' then
l = table.copy(line)
l.text = string.format("{\\fad(100,0)\\an5\\move(%d,%d,%d,%d)\\bord3\\be3\\blur3\\frx360\\1c&HFFFFFF&\\3c&HFFFFFF&\\t(\\frx360\\1c%s\\3c%s\\bord1\\blur0\\be0\\frx0)}%s",0,y,x,y,line.styleref.color2,line.styleref.color3,syl.text_stripped)
l.start_time = line.start_time -1000+tiempo
l.end_time = line.start_time+tiempo
l.layer=0
subs.append(l)


j=i+1
duracion=syl.duration
if duracion > 0 and actor~="1" then 
l = table.copy(line)
if math.mod(sum,2)==0 then
mult=-1
else
mult=1
end
angulo=180
tstart=0
tend=lineas[j]
spos=posiciones[j]
if tend == nil then
tend=syl.duration
end

if spos==nil then
spos=syl.width/2
end
controlx=0
controly=0
for r=0,50 do
if r>25 then
radio=spos
else
radio=syl.width/2
end

radangulo=math.rad(angulo)
posx=circulox(radio,x,radangulo)
posy=circuloy(radio,y,radangulo)
l.start_time=line.start_time+syl.start_time+tstart
l.end_time=line.start_time+tend+tiempo
if posx~=controlx and controly~=posy then 

for t=0,2 do
--3c&HFF7600&
l.text = string.format("{\\p1\\3a&H64&\\3c&HFFFFFF&\\1a&HFF&\\fad(0,70)\\move(%d,%d,%d,%d)\\an5\\blur3\\bord0.2\\shad0\\fscx%d\\fscy%d}m 0 0 l 1 0 1 1 0 1{\\p0}",posx,posy,posx+math.random(-10,10),posy+math.random(-10,10),150+(t*5),150+(t*5))
subs.append(l)
--1c&HFF7600&	
l.text = string.format("{\\p1\\3a&HFF&\\1c&HFFFFFF&\\fad(0,70)\\move(%d,%d,%d,%d)\\an5\\be3\\bord0\\shad0\\fscx%d\\fscy%d}m 0 0 l 1 0 1 1 0 1{\\p0}",posx,posy,posx+math.random(-10,10),posy+math.random(-10,10),150+(t*5),150+(t*5))
subs.append(l)
end
end

angulo=angulo+(mult*3.6)
tstart=tstart+syl.duration/50
tend=tend+10
controlx=posx
controly=posy
end
sum=sum+1
end


l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s}%s",x,y,line.styleref.color2,syl.text_stripped)
l.start_time = line.start_time+tiempo
l.end_time = line.start_time+syl.start_time
l.layer=2
subs.append(l)


l = table.copy(line)
for j=1,3 do
l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\t(\\fscx%d\\fscy%d\\alpha&HFF&\\blur3\\3c%s))}%s",x,y,line.styleref.color2,135+(j*5),135+(j*5),line.styleref.color2,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=3
subs.append(l)
end


l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\3c%s\\bord0\\blur0\\fs28\\fry0\\t(\\fs55\\fry45\\3c&HFFFFFF&\\bord3\\blur10)}%s",x,y,line.styleref.color3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time+tiempo
l.end_time=line.start_time+syl.start_time+(syl.duration/2)
l.layer=5
subs.append(l)



l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\3c%s\\bord1.5\\fs28\\fry0\\t(\\fs55\\fry45)}%s",x,y,line.styleref.color3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time+tiempo
l.end_time=line.start_time+syl.start_time+(syl.duration/2)
l.layer=6
subs.append(l)
				

l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\3c%s\\bord3\\blur10\\fs55\\fry45\\t(\\fs28\\fry90\\3c%s\\bord0\\blur0)}%s",x,y,line.styleref.color3,line.styleref.color3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time+(syl.duration/2)
l.end_time=line.start_time+syl.start_time+syl.duration+tiempo
l.layer=7
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\3c%s\\bord1.5\\\\fs55\\fry45\\t(\\fs28\\fry90)}%s",x,y,line.styleref.color3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time+(syl.duration/2)
l.end_time=line.start_time+syl.start_time+syl.duration+tiempo
l.layer=8
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\t(\\blur0\\fscx100\\fscy100\\fsp0\\alpha&H00&\\fscx800\\fscy250\\alpha&HFF&\\blur10\\fsp-30))}%s",x,y,line.styleref.color2,syl.text_stripped)
l.start_time=line.end_time
l.end_time=l.end_time+250
l.layer=9
subs.append(l)
tiempo=tiempo+(1000/line.kara.n)
else

if line.actor == 'ED' then
l = table.copy(line)
l.text ="{"..an(5)..pos(x,y+10)..xbord(3)..blur(5)..shad(2)..color(3,'&HFFFFFF&')..color(1,'&HFFFFFF&')..color(4,'&HFFFFFF&')..alfa(1,20)..alfa(3,50)..t(fscy(180)..fscx(120)).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=0
subs.append(l)


l = table.copy(line)
l.text ="{"..an(5)..pos(x,y+10)..ybord(5)..be(1)..blur(2).."}"..sil()
l.start_time=line.start_time
l.end_time=line.start_time+syl.start_time
l.layer=1
subs.append(l)


l = table.copy(line)
l.text ="{"..an(5)..move(x+800,y+10,x,y+10)..xbord(5)..be(1)..blur(2).."}"..sil()
l.start_time=line.start_time-400
l.end_time=line.start_time
l.layer=2
subs.append(l)


l = table.copy(line)
l.text ="{"..an(5)..move(x,y+10,x-100,y+10)..ybord(5)..be(1)..blur(2)..fad(0,500).."}"..sil()
l.start_time=line.start_time+syl.duration+syl.start_time
l.end_time=l.start_time+500
l.layer=3
subs.append(l)


l = table.copy(line)
l.text ="{"..an(5)..shad(0)..blur(0)..xbord(0)..move(x,y+10,x-(syl.width/2),y-46)..fad(0,200).."}"..sil()
l.start_time=line.start_time+syl.start_time+(syl.duration/2)
l.end_time=l.start_time+syl.duration
l.layer=5
subs.append(l)


l = table.copy(line)
l.text ="{"..an(5)..shad(0)..blur(0)..ybord(0)..move(x,y+10,x+(syl.width/2),y-46)..fad(0,200).."}"..sil()
l.start_time=line.start_time+syl.start_time+(syl.duration/2)
l.end_time=l.start_time+syl.duration
l.layer=6
subs.append(l)

end
end
end
end


aegisub.register_macro("BNT FX!", "", fx_xxxHOLiC)
aegisub.register_filter("BNT FX!", "", 2000, fx_xxxHOLiC)