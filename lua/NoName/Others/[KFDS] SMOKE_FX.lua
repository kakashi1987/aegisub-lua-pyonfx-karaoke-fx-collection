include("karaskel.lua")

script_name = "SMOKE"
script_description = "Lua FX"
script_author = "KFDS"
script_version = "1.0"

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
				not l.comment and
				(l.style == "Default" or l.style == "Romaji" or l.style == "4") then
				karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else
			i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("SMOKE")
	aegisub.progress.set(100)
	aegisub.set_undo_point("fx_KFDS")
end

function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 250
if i ==1 then
KFDS=0
end


l = table.copy(line)
randfrz= math.random(-20,20)
l.text = string.format("{\\fad(100,0)\\an5\\move(%d,%d,%d,%d)\\bord3\\be3\\blur3\\frz%d\\1c&HFFFFFF&\\t(\\frx1080\\1c%s\\3c%s\\bord2\\blur0\\be0\\frx360)}%s",x-100,50,x,y,randfrz,line.styleref.color2,line.styleref.color3,syl.text_stripped)
l.start_time = line.start_time -1000+KFDS
l.end_time = line.start_time+KFDS
l.layer=0
subs.append(l)
KFDS=KFDS+(1000/line.kara.n)

l = table.copy(line)
l.text=string.format("{\\blur3\\pos(%d,%d)\\an5\\be1\\bord1\\shad1\\2c&H000000&\\3a&HFF&}%s",x,y,syl.text_stripped)
l.layer=1
subs.append(l)


l = table.copy(line)
l.text=string.format("{\\blur3\\pos(%d,%d)\\an5\\be1\\bord1\\shad1\\1c&H000000&\\1a&HFF&}%s",x,y,syl.text_stripped)
l.layer=2
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\blur10\\bord10.5\\fad(150,0)\\1c&HA68F76&\\3c&H796753&\\an5\\pos(%d,%d)}%s",x,y,syl.text_stripped)
l.start_time = line.start_time -28 +i*1
l.end_time = line.start_time + i*10 
l.layer=3
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\blur10\\bord10.5\\fad(150,0)\\1c&HA68F76&\\3c&H796753&\\an5\\pos(%d,%d)}%s",x,y,syl.text_stripped)
l.start_time = line.start_time -28 
l.end_time = line.start_time
l.layer=4
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\blur10\\bord2.5\\fad(150,0)\\1c&HA68F76&\\3c&H796753&\\an5\\pos(%d,%d)}%s",x,y,syl.text_stripped)
l.start_time = line.start_time -28 +i*9
l.end_time = line.start_time + i*5
l.layer=5
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\blur10\\bord10.5\\fad(150,0)\\1c&HA68F76&\\3c&H796753&\\an5\\pos(%d,%d)}%s",x,y,syl.text_stripped)
l.start_time = line.start_time -28 
l.end_time = line.start_time
l.layer=6
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\blur10\\bord10.5\\fad(150,0)\\1c&HA68F76&\\3c&H796753&\\an5\\pos(%d,%d)}%s",x,y,syl.text_stripped)
l.start_time = line.start_time -68
l.end_time = line.start_time+17
l.layer=7
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\blur10\\bord10.5\\fad(150,0)\\1c&HA68F76&\\3c&H796753&\\an5\\pos(%d,%d)}%s",x,y,syl.text_stripped)
l.start_time = line.start_time -60
l.end_time = line.start_time+17
l.layer=8
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\t(0,30,\\fscx110\\fscy120\\1c&HFDF0EE&\\3c&HFFFFFF&)\\t(30,%d,\\3c&H000000&\\fscx100\\fscy100\\alpha&HFF&)}%s",x,y,syl.duration*10+200,syl.text_stripped)
l.start_time = line.start_time + syl.start_time + 10
l.end_time = line.start_time + syl.start_time + 10 + syl.duration + 20
l.layer=9
subs.append(l)


l = table.copy(line)
for i=0,120 do
l.text = string.format("{\\blur10\\an5\\move(%d,%d,%d,%d)\\alpha&H80&\\1c&H00FFFF&\\shad1\\bord8\\3c&HFFFFFF&\\fscx90\\fscy90\\t(\\alpha&HD0&){\\p4} m 0 0 l 0 1 1 1 1 0 {\\p0}", x+math.random(-10,10), y+math.random(-10,10), x+math.random(-50,50), y+math.random(-50,50),math.random(0,255),math.random)
l.start_time = line.start_time + syl.start_time + 10 + i
l.end_time = line.start_time + syl.start_time + 10 + syl.duration + i*1
l.layer=10
subs.append(l)
end


l = table.copy(line)
for i=0,20 do
l.text = string.format("{\\blur10\\an5\\move(%d,%d,%d,%d)\\alpha&H80&\\1c&H00FFFF&\\shad1\\bord8\\3c&HFFFFFF&\\fscx90\\fscy90\\t(\\alpha&HD0&){\\p4} m 0 0 l 0 1 1 1 1 0 {\\p0}", x+math.random(-10,10), y+math.random(-10,10), x+math.random(-10,40), y+math.random(-10,40),math.random(0,255),math.random)
l.start_time = line.start_time + syl.start_time + 10 + i
l.end_time = line.start_time + syl.start_time + 10 + syl.duration + i*1
l.layer=11
subs.append(l)
end



l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\3c%s\\bord2\\be15\\1a&HFFFFFF&\\t(\\3a&H8200&\\fscx200\\fscy200)}%s", x,y, line.styleref.color2, syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration+100
l.layer=12
subs.append(l)


end	
end

aegisub.register_macro("SMOKE", "", fx_KFDS)

aegisub.register_filter("SMOKE", "", 2000, fx_KFDS)