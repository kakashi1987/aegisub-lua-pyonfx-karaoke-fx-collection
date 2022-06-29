include("karaskel.lua")
include("azheolib.lua")
include("formaslib.lua")

-------------------------------»œ«Ì… «·√”ﬂ—» --------------------------------

script_name = "the end"
script_description = "Fx 1"
script_author = "alow"
script_version = "2.0"

function fx_alow(subs)
	aegisub.progress.task("«· √ÀÌ— FX... (:)")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Aplicando tu FX D:")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Esto llevo trabajado (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment and
				(l.style == "Default") then --Ac· 				
karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else
			i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("Por fin termine D:!")
	aegisub.progress.set(100)
	aegisub.set_undo_point("fx_alow")
end

-------------------------------·‰ﬂ„·------------------------
-------------------------------·‰ «»⁄-----------------------
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 25
if i == 1 then
tempo=0
end

function sil()
silaba = ""..syl.text_stripped..""
return silaba
end

-------------------------------«· √ÀÌ—« -----------------------------
-------------------------------·‰ «»⁄ -----------------------------------

-- √ÀÌ— «·œŒÊ·----
l = table.copy(line)
l.text = "{"..fad(100,0)..an(5)..move(x,y+35,x,y)..bord(0)..fry(100)..color(1,'ffffff')..t(fry(-360)..estilo(1,line.styleref.color1)..bord(1)).."}"..sil()
l.start_time = line.start_time -800
l.end_time = line.start_time
l.layer=0
subs.append(l)

l = table.copy(line)
l.text = "{"..fad(100,0)..an(5)..move(x,y-35,x,y)..bord(0)..fry(100)..color(1,'ffffff')..t(fry(360)..estilo(1,line.styleref.color1)..bord(1)).."}"..sil()
l.start_time = line.start_time -800
l.end_time = line.start_time
l.layer=0
subs.append(l)

-- √ÀÌ— ·Ê‰ «·ﬂ·„… ÊÊ÷⁄Â« ----------

--Silaba estatica 2 - borde negro
l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..bord(1)..color(3,"ffffff").."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=1
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..blur(5)..bord(2)..color(3,"ffffff").."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=1
subs.append(l)

l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..blur(2)..bord(2)..color(3,"ffffff").."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=1
subs.append(l)

---- √ÀÌ— Õ—ﬂ… «·ﬂ·„…--------- 
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..bord(2)..be(3)..fscxy(60)..color(1,line.styleref.color1)..color(3,line.styleref.color1)..alpha('46')..fscxy(100)..t(fscxy(150)..alpha('ff')).."}"..sil()
			l.start_time=line.start_time+syl.start_time-100
			l.end_time=line.start_time+syl.end_time
			l.layer=1
			subs.append(l)


--- √ÀÌ— Õ—ﬂ… «·ﬂ·„…-------
l = table.copy(line)
l.text = "{"..an(5)..color(1,"ffffff")..move(x,y,x-9,y+50)..t(fscxy(150)..frz(360)..alpha('ff'))..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time+100
l.end_time=l.start_time+syl.duration+1000
l.layer = 2
subs.append(l)

l = table.copy(line)
l.text = "{"..an(5)..color(1,"ffffff")..move(x,y,x+9,y-50)..t(fscxy(150)..frz(360)..alpha('ff'))..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time+100
l.end_time=l.start_time+syl.duration+1000
l.layer = 2
subs.append(l)


----«·—”„Â---------
l = table.copy(line)
for f=1,8 do
l.text = "{"..an(5)..move(x,y, x-rand(20,80), y+rand(30,60))..blur(4)..bord(0.3)..be(2)..c(3, 'ffffff')..RangeColor(1, f/35, 'AFCFF0', 'EBBE87').."}"..p(5,Formas(17))
l.start_time = line.start_time+syl.start_time
l.end_time = l.start_time+syl.duration+rand(600)
l.layer=0
subs.append(l)
end



l = table.copy(line)
for j = 1,5 do --serian 6 estrellas
	l.text = "{"..an(5)..color(1,'2fffff1')..move(x,y,x+rand(20),y-rand(30))..frz(-160)..fscxy(10)..bord(2)..t(fscxy(50)..alpha('ff'))..blur(3).."}"..p(3,Formas(1,1))
	l.start_time=line.start_time+syl.start_time
	l.end_time=l.start_time+syl.duration
	l.layer = 2
	subs.append(l)
end

l = table.copy(line)
for j = 1,10 do --serian 6 estrellas
	l.text = "{"..an(5)..color(1,'2fffff1')..move(x,y,x+rand(120),y-rand(30))..frz(-160)..fscxy(10)..bord(2)..t(fscxy(50)..alpha('ff'))..blur(3).."}"..p(3,Formas(1,1))
	l.start_time=line.start_time+syl.start_time
	l.end_time=l.start_time+syl.duration
	l.layer = 2
	subs.append(l)
end
end
end


-------------------------------√‰ ÂÌ  „‰ «· √ÀÌ—------------------------------------
-------------------------------√ „‰Ï √‰ ÌﬂÊ‰ ÃÌœ --------------
aegisub.register_macro("the end", "fx:",fx_alow )
aegisub.register_filter("the end", "fx:", 2000,fx_alow)
-------------------------------≈·Ï «·ﬁ«¡---