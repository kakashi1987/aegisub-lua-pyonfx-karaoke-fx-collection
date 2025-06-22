include("karaskel.lua")

script_name = "Default"
script_description = "FX en Lua4"
script_author = "Bunshin"
script_version = "0.8.1 Beta"

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
	aegisub.progress.task("Default")
	aegisub.progress.set(100)
	aegisub.set_undo_point("fx_KFDS")
end

function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 60
if i ==1 then
KFDS=0
end

l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s}%s",x,y,line.styleref.color1,syl.text_stripped)
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=0
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s\\t(\\fscx100\\fscy100)}%s",x,y,line.styleref.color1,syl.text_stripped)
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=0
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d))\\t(\\fad(0,300)\\bord5\\blur7\\1c%s\\1a&hff)}%s", x, y, line.styleref.color2, syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer = 2
subs.append(l)

end
end

aegisub.register_macro("Default", "", fx_KFDS)
aegisub.register_filter("Default", "", 2000, fx_KFDS)