include("karaskel.lua")

script_name = "UP & Dawn"
script_description = "FX lua"
script_author = "KFDS"
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

KFDS1=0
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 34
if i == 1 then
end

if  (syl.text_stripped == ".") then elseif (syl.text_stripped == ",") then elseif (syl.text_stripped == "\"") then else


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\be0\\bord2\\1c&HFFEADC&\\1a&HFF&\\3c&H60300E&\\3a&HFF&\\t(\\1a&H00&\\3a&H00&)}%s",x,y-14,x,y,syl.text_stripped)
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
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\be0\\bord2\\1c&HFFEADC&\\1a&H00&\\3c&H60300E&\\3a&H00&\\t(\\1c&HE59862&)}%s",x,y-8,x,y,syl.text_stripped)
else
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\be0\\bord2\\1c&HFFEADC&\\1a&H00&\\3c&H60300E&\\3a&H00&\\t(\\1c&HE59862&)}%s",x,y+8,x,y,syl.text_stripped)
end
l.start_time = line.start_time + syl.start_time + 10
l.end_time = l.start_time + syl.duration
l.layer = 2
subs.append(l)
end


l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\be0\\bord2\\fscx100\\fscy100\\1c&HE59862&\\1a&H00&\\3c&H60300E&\\3a&H00&}%s",x,y,syl.text_stripped)
l.start_time = line.start_time + syl.start_time + 10 + syl.duration
l.end_time = line.end_time
l.layer = 3
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\be0\\bord2\\1c&HE59862&\\1a&H00&\\3c&H60300E&\\3a&H00&\\t(\\1a&HFF&\\3a&HFF&)}%s",x,y,x,y+14,syl.text_stripped)
l.start_time = line.end_time
l.end_time = line.end_time + 20
l.layer = 4
subs.append(l)


end
end


aegisub.register_macro("FX", "", fx_KFDS)
aegisub.register_filter("FX", "", 2000, fx_KFDS)