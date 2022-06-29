include("karaskel.lua")

script_name = "Scattering"
script_description = "Script Lua"
script_author = "Kirav751 Edit by KFDS"
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
	aegisub.progress.task("Scttering")
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

		
randfrz= math.random(-20,20)
l = table.copy(line)
l.text = string.format("{\\fad(100,0)\\an5\\move(%d,%d,%d,%d)\\bord3\\be3\\blur3\\frz%d\\1c&HFFFFFF&\\t(\\frx1080\\1c%s\\3c%s\\bord2\\blur0\\be0\\frx360)}%s",x-100,50,x,y,randfrz,line.styleref.color2,line.styleref.color3,syl.text_stripped)
l.start_time = line.start_time -1000+KFDS
l.end_time = line.start_time+KFDS
l.layer=0
subs.append(l)


l = table.copy(line)
--SILABAS ESTATICAS (2)
l.text = string.format("{\\an5\\pos(%d,%d)\\1c%s}%s",x,y,line.styleref.color1,syl.text_stripped)
l.start_time = line.start_time+KFDS
l.end_time = line.start_time+syl.start_time
l.layer=2
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\3c%s\\bord2\\be15\\1a&HFFFFFF&\\t(\\3a&H8200&\\fscx200\\fscy200)}%s", x,y, line.styleref.color2, syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration+100
l.layer = 1
subs.append(l)				
KFDS=KFDS+(1000/line.kara.n)


end	
end

aegisub.register_macro("Scattering", "", fx_KFDS)
aegisub.register_filter("Scattering", "", 2000, fx_KFDS)