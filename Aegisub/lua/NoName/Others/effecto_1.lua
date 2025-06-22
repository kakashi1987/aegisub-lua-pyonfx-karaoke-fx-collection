include("karaskel.lua")
include("zheolib.lua")
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
				(l.style == "Romaji") then --Ac· 				
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
local x = line.left + syl.center
local y = line.styleref.margin_t + 10
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
l.text = "{"..fad(100,0)..an(5)..move(x,y-35,x,y-10)..bord(0)..fry(100)..color(1,'ffffff')..t(fry(-360)..estilo(1,line.styleref.color1)..bord(1)).."}"..sil()
l.start_time = line.start_time -800
l.end_time = line.start_time
l.layer=0
subs.append(l)

l = table.copy(line)
l.text = "{"..fad(100,0)..an(5)..move(x,y+35,x,y+10)..bord(0)..fry(100)..color(1,'ffffff')..t(fry(-360)..estilo(1,line.styleref.color1)..bord(1)).."}"..sil()
l.start_time = line.start_time -800
l.end_time = line.start_time
l.layer=0
subs.append(l)

l = table.copy(line)
l.text = "{"..fad(100,0)..an(5)..move(x+35,y,x+10,y)..bord(0)..fry(100)..color(1,'ffffff')..t(fry(-360)..estilo(1,line.styleref.color1)..bord(1)).."}"..sil()
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
l.text = "{"..an(5)..pos(x,y)..bord(1)..color(1,"ffffff").."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=1
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..blur(1)..bord(1)..color(2,"ffffff").."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=1
subs.append(l)

l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..blur(0)..bord(1)..color(3,"ffffff").."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=1
subs.append(l)

---- √ÀÌ— Õ—ﬂ… «·ﬂ·„…--------- 
			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..bord(2)..be(3)..fscxy(60)..color(1,line.styleref.color1)..color(3,line.styleref.color1)..alpha('46')..fscxy(100)..t(fscxy(120)..alpha('90')).."}"..sil()
			l.start_time=line.start_time+syl.start_time-200
			l.end_time=line.start_time+syl.end_time
			l.layer=1
			subs.append(l)


--- √ÀÌ— Õ—ﬂ… «·ﬂ·„…-------
l = table.copy(line)
l.text = "{"..an(5)..color(1,"ffffff")..move(x,y,x-9,y+5)..t(fscxy(150)..frz(360)..alpha('ff'))..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time+100
l.end_time=l.start_time+syl.duration+1000
l.layer = 2
subs.append(l)

l = table.copy(line)
l.text = "{"..an(5)..color(1,"ffffff")..move(x,y,x+9,y-5)..t(fscxy(150)..frz(360)..alpha('ff'))..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time+100
l.end_time=l.start_time+syl.duration+1000
l.layer = 2
subs.append(l)

l = table.copy(line)
l.text = "{"..an(5)..color(1,"ffffff")..move(x,y,x+20,y-8)..t(fscxy(150)..frz(760)..alpha('ff'))..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time+100
l.end_time=l.start_time+syl.duration+1000
l.layer = 2
subs.append(l)

l = table.copy(line)
l.text = "{"..an(5)..color(1,"ffffff")..move(x,y,x+20,y-8)..t(fscxy(150)..frz(-760)..alpha('ff'))..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time+100
l.end_time=l.start_time+syl.duration+1000
l.layer = 2
subs.append(l)

l = table.copy(line)
l.text = "{"..an(5)..color(1,"ffffff")..move(x+5,y,x+40,y-18)..t(fscxy(150)..frz(-1760)..alpha('ff'))..blur(5).."}"..sil()
l.start_time=line.start_time+syl.start_time+100
l.end_time=l.start_time+syl.duration+1000
l.layer = 2
subs.append(l)


----«·—”„Â---------


l = table.copy(line)
for j = 1,5 do --serian 6 estrellas
	l.text = "{"..an(5)..color(1,'2fffff1')..move(x,y,x+rand(20),y-rand(130))..frz(-760)..fscxy(5)..bord(2)..t(fscxy(10)..alpha('ff'))..blur(3).."}"..p(3,Formas(3,1))
	l.start_time=line.start_time+syl.start_time
	l.end_time=l.start_time+syl.duration
	l.layer = 2
	subs.append(l)
end

l = table.copy(line)
for j = 1,10 do --serian 6 estrellas
	l.text = "{"..an(5)..color(1,'2fffff1')..move(x,y,x+rand(120),y-rand(130))..frz(-760)..fscxy(5)..bord(2)..t(fscxy(10)..alpha('ff'))..blur(3).."}"..p(1,Formas(3,1))
	l.start_time=line.start_time+syl.start_time
	l.end_time=l.start_time+syl.duration
	l.layer = 2
	subs.append(l)
end



--efeceto shine

local n = 15

local r1, g1, b1 = extract_color(line.styleref.color1)
local r2, g2, b2 = extract_color(line.styleref.color2)

local r12 = (r1 - r2) / n
local g12 = (g1 - g2) / n
local b12 = (b1 - b2) / n

for i = 1, n do

local color = ass_color(r1 - r12 * i, g1 - g12 * i, b1 - b12 * i)

local fscy = 105 + i * 5
local fscx = 100 + i

syl.pre_string = ""

for i = 1, syl.i - 1 do
	
syl.pre_string = syl.pre_string .. line.kara[i].text
	
end

syl.post_string = ""

for i = syl.i + 1, line.kara.n do

syl.post_string = syl.post_string .. line.kara[i].text

end



l = copy_line(line)
l.layer = 0 
l.text = "{"..pos(x,y)..be(2).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time + syl.start_time
subs.append(l)


l = copy_line(line)
l.layer = 0 
l.text = string.format("{\\pos(%d,%d)\\t(\\1c%s)\\be2}%s",x,y,ass_color(extract_color(line.styleref.color2)),syl.text)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.end_time
subs.append(l)


l = copy_line(line)
l.layer = 0 
l.text = string.format("{\\pos(%d,%d)\\1c%s\\be2}%s",x,y,ass_color(extract_color(line.styleref.color2)),syl.text)
l.start_time = line.start_time + syl.end_time
l.end_time = line.end_time
subs.append(l)


l = copy_line(line)
l.layer = i
l.text = string.format("{\\pos(%d,%d)\\blur1\\bord0\\fscx%d\\fscy%d\\1c%s}{\\alpha&HFF&}%s{\\alpha&HE0&\\t(\\alpha&HFF&)}%s{\\alpha&HE0&}%s",line.center,y-i/7.5,fscx,fscy,color,syl.pre_string,syl.text,syl.post_string)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.end_time
subs.append(l)
end



end
end


-------------------------------√‰ ÂÌ  „‰ «· √ÀÌ—------------------------------------
-------------------------------√ „‰Ï √‰ ÌﬂÊ‰ ÃÌœ --------------
aegisub.register_macro("the end", "fx:",fx_alow )
aegisub.register_filter("the end", "fx:", 2000,fx_alow)
-------------------------------≈·Ï «·ﬁ«¡---