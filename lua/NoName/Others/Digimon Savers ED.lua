include("karaskel.lua")

script_name = "Digimon Savers ED"
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
if time ~= line.start_time then
time=line.start_time
br=-1
end
br=br+1

l = table.copy(line)
l.text = string.format("{\\move(%d,%d,%d,%d)\\bord1\\shad0\\1a&HAA&\\1a&HCC&\\1c&H0992E9&\\3c&HD2ECFD&\\fs30\t(\\fs20))}%s",x+math.random(-30,30),y+math.random(-30,30),x,y,syl.text_stripped)
l.end_time=line.start_time+syl.start_time+10
l.layer=0
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\shad0\\bord3\\blur5\\1c&H0992E9&\\3c&HE8F3FC&}%s",x,y,syl.text_stripped)
l.start_time=line.start_time+syl.start_time+10
l.end_time=line.end_time-20+br*5
l.layer=1
subs.append(l)


end
end

aegisub.register_macro("Digimon Savers ED", "", fx_KFDS)
aegisub.register_filter("Digimon Savers ED", "", 2000, fx_KFDS)