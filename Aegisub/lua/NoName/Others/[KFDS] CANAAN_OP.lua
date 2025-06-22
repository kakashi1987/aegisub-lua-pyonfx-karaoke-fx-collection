include("karaskel.lua")

script_name = "CANAAN"
script_description = "to you"
script_author = "KFDS"
script_version = "1.02"

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
	aegisub.progress.task("CANAAN_OP")
	aegisub.progress.set(100)
	aegisub.set_undo_point("fx_KFDS")
end


function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 40
if i == 1 then
KFDS=0
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
posy={'-20','-10','10','20','0'}
for i =0,4 do
l.text = string.format("{\\fad(100,0)\\an5\\be1\\move(%d,%d,%d,%d)\\bord0\\1c&HFFFFFF&\\t(\\be0\\1c%s)}%s",x,y+posy[1+i*1],x,y,line.styleref.color2,syl.text_stripped)
l.start_time = line.start_time -800 + KFDS
l.end_time = line.start_time + KFDS
l.layer=1
subs.append(l)
end


l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\bord0\\t(\\bord1)}%s",x,y,line.styleref.color2,syl.text_stripped)
l.start_time = line.start_time + KFDS
l.end_time = line.start_time + syl.start_time
l.layer=2
subs.append(l)
KFDS=KFDS+(1000/line.kara.n)


l = table.copy(line)
for i=0,30 do
l.text = "{"..an(5)..alpha("&HA0B0C0&")..move(x-rand(60.5),y-rand(60.5),x,y)..fad(0,500)..t(blur(1+ i*1)).."}"..char
l.start_time = line.start_time + syl.start_time - 250
l.end_time = l.start_time + syl.start_time + 800
l.layer=3
subs.append(l)
end


l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\blur2.5\\1c&HFFFFFF&\\3c&HFFFFFF&\\fs50\\t(\\fs40\\3c&H578494&\\1c&HA2A29B&)}%s",x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time=line.start_time + syl.end_time
l.layer = 3
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\blur2.5\\1c&HFFFFFF&\\3c&HFFFFFF&\\fs50\\t(\\fs40\\3c&H578494&\\1c&HA2A29B&)}%s",x,y,syl.text_stripped) 
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.end_time
l.layer = 4
subs.append(l)


l = table.copy(line)
for i=0,24 do
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HF5&}%s",x,y-1+i*24,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 5
subs.append(l)
end


l = table.copy(line)
for i=0,24 do
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HF5&}%s",x,y+1+i*24,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 6
subs.append(l)
end


l = table.copy(line)
for i=0,24 do
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HF5&}%s",x-1+i*24,y,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 7
subs.append(l)
end


l = table.copy(line)
for i=0,24 do
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HF5&}%s",x-1+i*24,y-1+i*24,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 8
subs.append(l)
end


l = table.copy(line)
for i=0,24 do
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HF5&}%s",x+1+i*24,y+1+i*24,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 9
subs.append(l)
end


l = table.copy(line)
for i=0,24 do
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HF5&}%s",x-1+i*24,y+1+i*24,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 10
subs.append(l)
end


l = table.copy(line)
for i=0,21 do
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\blur3.5\\3c&H578494&\\1c&HA2A29B&\\fs50\\t(\\fs40)\\alpha&HED&}%s",x+1+i*1,y-1+i*1,x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.start_time + syl.duration 
l.layer = 10
subs.append(l)
end


l = table.copy(line)
for i=0,85 do
l.text = string.format("{\\an5\\shad0\\alpha&80&\\move(%d,%d,%d,%d)\\3c&H5152FF&\\1c&H1B1C7F&\\blur8\\fscx15\\fscy15\\3c&H0000B1&\\1c&H000068&\\t(\\alpha&HF8&)}{\\p1}m 9 -5 b 15 2 15 13 9 19 b 9 19 9 19 9 19 b 3 13 3 2 9 -5 {\\p0}", x+math.random(-3.5,3.5), y, x+math.random(-8,8), y+55,  syl.text)
l.start_time=line.start_time+syl.start_time
l.end_time=line.start_time+syl.start_time+syl.duration+i*2
l.layer = 11
subs.append(l)
end


end
end


aegisub.register_macro("CANAAN_OP", "By KFDS", fx_KFDS)
aegisub.register_filter("CANAAN_OP", "By KFDS", 2000, fx_KFDS)