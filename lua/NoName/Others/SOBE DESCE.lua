include("karaskel.lua")
include("zheolib.lua")
include("formaslib.lua")

script_name = "SOBE DESCE"
script_description = "lua Fx Fansub ANIME FORISET"
script_author = "Mdslino" 
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
	aegisub.set_undo_point(fx_KFDS)
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


if syl.inline_fx == "" then
l = table.copy(line)
l.text = "{"..fad(800,0)..an(5)..move(x+rand(300),y+rand(30),x,y)..fscx(50)..fscy(50)..bord(0)..color(1,'ffffff')..t(fscx(100)..fscy(100)..estilo(1,line.styleref.color1)..bord(1)).."}"..sil()
l.start_time = line.start_time -800
l.end_time = line.start_time
l.layer=0
subs.append(l)


l = table.copy(line)
l.text = "{"..an(5)..pos(x,y)..estilo(1,line.styleref.color2)..AutoTimer(TE2,500,'frz',20,0.5,1).."}"..sil()
l.start_time = line.start_time
l.end_time = line.start_time+syl.start_time
l.layer=0
subs.append(l)


if(syl.i%2) == 0 then
my = 30 
else
my = -30
end
		
l = table.copy(line)
l.text = "{"..an(5)..move(x,y,x,y+my)..bord(0)..color(1,'FFFFFF')..t(fry(360)..frx(360)..frz(360)..estilo(1,line.styleref.color1)..bord(1)).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=0
subs.append(l)


l = table.copy(line)
l.text = "{"..fad(300,0)..an(5)..move(x,y,x+rand(300),y+rand(30))..bord(0)..color(1,'ffffff')..t(fscx(50)..fscy(50)..estilo(1,line.styleref.color1)..bord(1)).."}"..sil()
l.start_time = line.start_time +800
l.end_time = line.start_time
l.layer=0
subs.append(l)	

end
end
end

aegisub.register_macro("SOBE DESCE", "", fx_KFDS)
aegisub.register_filter("SOBE DESCE", "", 2000, fx_KFDS)