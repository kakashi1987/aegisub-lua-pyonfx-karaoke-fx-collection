--[[
     This script is given to the public domain
     You can use and modify the effect freely, also without credit, although I would appreciate some
     This script was made by Gh.s (Ghasan Al-Sakkaf) & modified by KanamiSama (Osama Al-mutawaa)
     Spacial Thanx for Gh.s (Ghasan Al-Sakkaf) for this script & NiCkle (Alex Flechas) for learning me how I make this FX
     Copyright © 2009 || NiCkle (Alex Flechas) || Gh.s (Ghasan Al-Sakkaf) || KanamiSama (Osama Al-mutawaa)
]]--

include("karaskel.lua")

script_name = "Shaking"
script_description = "Shaking"
script_author = "Ghasan Al-Sakkaf"
script_modified = "Kanami Sama"
script_version = "2"

function fx_Shaking(subs)
	local meta, styles = karaskel.collect_head(subs)
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				l.style=="Default" and
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
	aegisub.set_undo_point("")
end

function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x = line.left + syl.center
local y = line.middle
local xini = line.center
local yini = line.middle
local xfin = line.center + math.random(-6,6)
local yfin = line.middle + math.random(-6,6)

l = table.copy(line)
l.start_time=line.start_time
l.end_time=line.start_time+syl.start_time
l.text=string.format("{\\an5\\pos(%d,%d)\\fscx100\\fscy100\\bord1\\be1\\shad0}%s",x,y,syl.text_stripped)
l.layer=0
subs.append(l)


l = table.copy(line)
l.start_time=line.start_time+syl.end_time
l.end_time=line.end_time
l.text=string.format("{\\an5\\pos(%d,%d)\\fscx100\\fscy100\\bord1\\be1\\shad0}%s",x,y,syl.text_stripped)
l.layer=0
subs.append(l)


l=table.copy(line)
for loop=1,math.ceil(syl.duration/50) do
l.text=string.format("{\\3c&HFFFFFF&\\an5\\fscx100\\fscy100\\bord1\\be1\\shad0\\move(%d,%d,%d,%d)}%s",xini,yini,xfin,yfin,l.text_stripped)
l.start_time=line.start_time+syl.start_time+((loop-1)*50)
l.end_time=line.start_time+syl.start_time+((loop-1)*50)+50
l.layer=0
subs.append(l)
end


l=table.copy(line)
for loop=1,math.ceil(syl.duration/50) do
l.text=string.format("{\\an5\\fscx100\\fscy100\\bord1\\be1\\shad0\\move(%d,%d,%d,%d)\\t(\\1c&HFFFFFF&\\3c&HFFFFFF&)}%s",x,y,x+math.random(-6,6),y+math.random(-6,6),syl.text_stripped)
l.start_time=line.start_time+syl.start_time+((loop-1)*50)
l.end_time=line.start_time+syl.start_time+((loop-1)*50)+50
l.layer=3
subs.append(l)
end

end
end

aegisub.register_macro("Shaking","", fx_Shaking)
aegisub.register_filter("Shaking","" ,2010, fx_Shaking)