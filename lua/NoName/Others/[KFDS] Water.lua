include("karaskel.lua")

script_name = "Water FX"
script_description = "FX lua"
script_author = "KFDS"
script_version = "3"


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
				(l.style == "Default1") then
				karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else
			i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("xD")
	aegisub.progress.set(100)
	aegisub.set_undo_point("fx_KFDS")
end

function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 34
if i == 1 then
KFDS=0
end

if  (syl.text_stripped == ".") then elseif (syl.text_stripped == ",") then elseif (syl.text_stripped == "\"") then else


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\be0\\bord2\\1c&HFFEADC&\\1a&HFF&\\3c&H60300E&\\3a&HFF&\\t(\\1a&H00&\\3a&H00&)}%s",x,y-21,x,y,syl.text_stripped)
l.start_time = line.start_time - 20
l.end_time = line.start_time
l.layer = 0
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\be0\\bord2\\fscx100\\fscy100\\1c&HFFEADC&\\1a&H00&\\3c&H60300E&\\3a&H00&}%s",x,y,syl.text_stripped)
l.start_time = line.start_time
l.end_time = line.start_time + syl.start_time + 10
l.layer = 1
subs.append(l)


l = table.copy(line)
if math.mod(i,2)==1 then
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\be0\\bord2\\1c&HFFEADC&\\1a&H00&\\3c&H60300E&\\3a&H00&\\t(\\1c&HE59862&)}%s",x,y-15,x,y,syl.text_stripped)
else
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\be0\\bord2\\1c&HFFEADC&\\1a&H00&\\3c&H60300E&\\3a&H00&\\t(\\1c&HE59862&)}%s",x,y+15,x,y,syl.text_stripped)
end
l.start_time = line.start_time + syl.start_time + 10
l.end_time = l.start_time + syl.duration + 800
l.layer = 2
subs.append(l)
end


l = table.copy(line)
l.text = string.format("{\\1c&HFFFBCF&\\fade(255,128,0,0,90,90,360)\\fad(10,150)\\pos(%d,%d)\\an5\\bord0\\be1\\frx60\\move\\fscx140\\fscy100\\t(\\be1\\1a&H55&\\fscx180\\fscy140)}{\\p1}m 0 0 m 10 20 b 16 20 20 16 20 10 b 20 4 16 0 10 0 b 2 0 0 6 0 10 b 0 16 4 20 10 20 m 10 1 b 15 1 19 6 19 10 b 18 17 14 19 10 19 b 7 19 2 18 1 10 b 1 6 4 1 10 1 {\\p0}",x,y+12+syl.duration/300,syl.text_stripped)
l.start_time=line.start_time + syl.start_time
l.end_time=l.start_time + syl.duration + KFDS + 100
l.layer = 3
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\1c&HFFFBCF&\\fade(255,128,0,0,90,90,360)\\fad(10,150)\\pos(%d,%d)\\an5\\1a&H55&\\bord0\\be0.5\\frx60\\move\\fscx140\\fscy100\\t(\\be1\\1a&H55&\\fscx180\\fscy140)}{\\p1}m 0 0 m 10 20 b 16 20 20 16 20 10 b 20 4 16 0 10 0 b 2 0 0 6 0 10 b 0 16 4 20 10 20 m 10 1 b 15 1 19 6 19 10 b 18 17 14 19 10 19 b 7 19 2 18 1 10 b 1 6 4 1 10 1 {\\p0}",x,y+12+syl.duration/300,syl.text_stripped)
l.start_time=line.start_time + syl.start_time
l.end_time=l.start_time + syl.duration + KFDS + 110
l.layer = 4
subs.append(l)		


l = table.copy(line)
l.text = string.format("{\\1c&HFFFBCF&\\fade(255,128,0,0,90,90,360)\\fad(10,150)\\pos(%d,%d)\\an5\\bord0\\be1\\frx60\\move\\fscx140\\fscy100\\t(\\be1\\1a&H55&\\fscx180\\fscy140)}{\\p1}m 0 0 m 10 20 b 16 20 20 16 20 10 b 20 4 16 0 10 0 b 2 0 0 6 0 10 b 0 16 4 20 10 20 m 10 1 b 15 1 19 6 19 10 b 18 17 14 19 10 19 b 7 19 2 18 1 10 b 1 6 4 1 10 1 {\\p0}",x,y+12+syl.duration/300,syl.text_stripped)
l.start_time=line.start_time + syl.start_time
l.end_time=l.start_time + syl.duration + KFDS + 115
l.layer = 5
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\1c&HFFFBCF&\\fade(255,128,0,0,90,90,360)\\fad(10,150)\\pos(%d,%d)\\an5\\1a&H55&\\bord0\\be0.5\\frx60\\move\\fscx140\\fscy100\\t(\\be1\\1a&H55&\\fscx180\\fscy140)}{\\p1}m 0 0 m 10 20 b 16 20 20 16 20 10 b 20 4 16 0 10 0 b 2 0 0 6 0 10 b 0 16 4 20 10 20 m 10 1 b 15 1 19 6 19 10 b 18 17 14 19 10 19 b 7 19 2 18 1 10 b 1 6 4 1 10 1 {\\p0}",x,y+12+syl.duration/300,syl.text_stripped)
l.start_time=line.start_time + syl.start_time
l.end_time=l.start_time + syl.duration + KFDS + 120
l.layer = 6
subs.append(l)		


l = table.copy(line)
l.text = string.format("{\\1c&HFFFBCF&\\fade(255,128,0,0,90,90,360)\\fad(10,150)\\pos(%d,%d)\\an5\\bord0\\be1\\frx60\\move\\fscx140\\fscy100\\t(\\be1\\1a&H55&\\fscx180\\fscy140)}{\\p1}m 0 0 m 10 20 b 16 20 20 16 20 10 b 20 4 16 0 10 0 b 2 0 0 6 0 10 b 0 16 4 20 10 20 m 10 1 b 15 1 19 6 19 10 b 18 17 14 19 10 19 b 7 19 2 18 1 10 b 1 6 4 1 10 1 {\\p0}",x,y+12+syl.duration/300,syl.text_stripped)
l.start_time=line.start_time + syl.start_time
l.end_time=l.start_time + syl.duration + KFDS + 125
l.layer = 3
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\1c&HFFFBCF&\\fade(255,128,0,0,90,90,360)\\fad(10,150)\\pos(%d,%d)\\an5\\1a&H55&\\bord0\\be0.5\\frx60\\move\\fscx140\\fscy100\\t(\\be1\\1a&H55&\\fscx180\\fscy140)}{\\p1}m 0 0 m 10 20 b 16 20 20 16 20 10 b 20 4 16 0 10 0 b 2 0 0 6 0 10 b 0 16 4 20 10 20 m 10 1 b 15 1 19 6 19 10 b 18 17 14 19 10 19 b 7 19 2 18 1 10 b 1 6 4 1 10 1 {\\p0}",x,y+12+syl.duration/300,syl.text_stripped)
l.start_time=line.start_time + syl.start_time
l.end_time=l.start_time + syl.duration + KFDS + 130
l.layer = 4
subs.append(l)		


l = table.copy(line)
l.text = string.format("{\\1c&HFFFBCF&\\fade(255,128,0,0,90,90,360)\\fad(10,150)\\pos(%d,%d)\\an5\\bord0\\be1\\frx60\\move\\fscx140\\fscy100\\t(\\be1\\1a&H55&\\fscx180\\fscy140)}{\\p1}m 0 0 m 10 20 b 16 20 20 16 20 10 b 20 4 16 0 10 0 b 2 0 0 6 0 10 b 0 16 4 20 10 20 m 10 1 b 15 1 19 6 19 10 b 18 17 14 19 10 19 b 7 19 2 18 1 10 b 1 6 4 1 10 1 {\\p0}",x,y+12+syl.duration/300,syl.text_stripped)
l.start_time=line.start_time + syl.start_time
l.end_time=l.start_time + syl.duration + KFDS + 135
l.layer = 5
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\1c&HFFFBCF&\\fade(255,128,0,0,90,90,360)\\fad(10,150)\\pos(%d,%d)\\an5\\1a&H55&\\bord0\\be0.5\\frx60\\move\\fscx140\\fscy100\\t(\\be1\\1a&H55&\\fscx180\\fscy140)}{\\p1}m 0 0 m 10 20 b 16 20 20 16 20 10 b 20 4 16 0 10 0 b 2 0 0 6 0 10 b 0 16 4 20 10 20 m 10 1 b 15 1 19 6 19 10 b 18 17 14 19 10 19 b 7 19 2 18 1 10 b 1 6 4 1 10 1 {\\p0}",x,y+12+syl.duration/300,syl.text_stripped)
l.start_time=line.start_time + syl.start_time
l.end_time=l.start_time + syl.duration + KFDS + 140
l.layer = 6
subs.append(l)		


l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\be0\\bord2\\fscx100\\fscy100\\1c&HE59862&\\1a&H00&\\3c&H60300E&\\3a&H00&}%s",x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time + 800 + syl.duration
l.end_time = line.end_time
l.layer = 7
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\be0\\bord2\\1c&HE59862&\\1a&H00&\\3c&H60300E&\\3a&H00&\\t(\\1a&HFF&\\3a&HFF&)}%s",x,y,x,y+21,syl.text_stripped)
l.start_time = line.end_time
l.end_time = line.end_time + 20
l.layer = 8
subs.append(l)

end
end


aegisub.register_macro("Water FX", "", fx_KFDS)
aegisub.register_filter("Water FX", "", 2000, fx_KFDS)