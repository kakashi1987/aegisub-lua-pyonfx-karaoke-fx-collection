include("karaskel.lua")

---------------------------------------------------------
--# ÊÃËíÑ ÈÓíØ ÈÌÚá ÇáÍÑİ ÊÖíÁ ÈÇáÚÑÖ  #--
--# åĞå ÇáÊÃËíÑ ÇáÈÓíØ ÚãáÊåÇ ãäĞ ÈÏÃÊ ÈÏÎæá ÚÇáã ÇááæÇ_4 #--
-----------------------------------------------------------
script_name = "FX_LUA.4"
script_description = "the light"
script_author = "Bakura_('FX_alkoon)"


function FX_8(subs)
	local meta, styles = karaskel.collect_head(subs)	
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue"  then karaskel.preproc_line(subs, meta, styles, l)
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
local y=line.margin_v + 30
if i == 1 then uae =0
end
    
	local l = table.copy(line)
	l.start_time=l.start_time-40 + uae
	l.end_time = l.end_time + 100 
	l.text = string.format("{\\an5\\pos(%d,%d)\\fad(100,200)\\bord1\\shad0\\blur3\\1c&FFFFFF&\\3c&HBA7921&}%s",x,y,syl.text_stripped)
	l.layer=2
	subs.append(l)
	local l = table.copy(line)
	l.start_time=line.start_time+syl.start_time
	l.end_time=l.start_time+syl.duration
	l.text = string.format("{\\an5\\pos(%d,%d)\\fad(100,200)\\bord1\\shad0\\blur3\\1c&FFFFFF&\\3c&HBA7921&\\t(\\fscx110\\fscy110)}%s",x,y,syl.text_stripped)
	l.layer=2
	subs.append(l)
	local l = table.copy(line)
	l.start_time=line.start_time+syl.start_time
	l.end_time=l.start_time+syl.duration
	l.text = string.format("{\\an5\\pos(%d,%d)\\fad(450,450)\\bord1\\shad0\\blur2\\3c&HBA7921&\\t(\\xbord2)}%s",x,y,syl.text_stripped)
	l.layer=2
	subs.append(l)


                end	
end

aegisub.register_filter("FX_8", "~ALKOON~", 2008, FX_8)