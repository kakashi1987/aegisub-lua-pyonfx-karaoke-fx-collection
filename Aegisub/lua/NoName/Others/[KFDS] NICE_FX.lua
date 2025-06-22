include("karaskel.lua")
include("azheolib.lua")

script_name = "NeW_SmOkE_FX"
script_description = "FX lua to ANIME-VOICE & ADC-ARAB & ANIME KING & BNT"
script_author = "KFDS"
script_version = "2"


function fx_KFDS(subs)

	aegisub.progress.task("Getting header data...") 
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and  not l.comment  then  
			karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else
		i = i + 1
		end
		ai = ai + 1
	end
end

function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 40
if i == 1 then
tempo=0
end

function sil()
silaba = ""..syl.text_stripped..""
return silaba
end

randfrz= math.random(-20,20)
l = table.copy(line)
l.text = string.format("{\\fad(100,0)\\an5\\move(%d,%d,%d,%d)\\bord3\\be3\\blur3\\frz%d\\1c&HFFFFFF&\\t(\\frx1080\\1c%s\\3c%s\\bord2\\blur0\\be0\\frx360)}%s",x-100,50,x,y,randfrz,line.styleref.color2,line.styleref.color3,syl.text_stripped)
l.start_time = line.start_time -1000+tempo
l.end_time = line.start_time+tempo
l.layer=0
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


end
end

aegisub.register_macro("NeW_SmOkE_FX", "BY KFDS", fx_KFDS)
aegisub.register_filter("NeW_SmOkE_FX", "BY KFDS", 2000, fx_KFDS)