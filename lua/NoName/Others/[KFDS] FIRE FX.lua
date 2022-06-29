include("karaskel.lua")
include("zheolib.lua")

script_name = "FIRE FX"
script_description = "FX lua"
script_author = "KFDS"
script_version = "6"

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
local y=line.margin_v + 25
if i ==1 then
end
function sil()
silaba = ""..syl.text_stripped..""
return silaba
end


l = table.copy(line)
l.text = "{"..an(5)..move(x+100,y,x,y,0,400)..fad(200,0)..color(1,'&H9CC890&')..bord(1)..RangeColor(1,'&H00FFF7&','&H0000FF&',768).."}"..sil()
l.start_time = line.start_time -400+i*100
l.end_time = line.start_time
l.layer=0
subs.append(l)


l = table.copy(line)
for i=0,150 do
COLOR ={'&H0000FF&','&H00F6FF&','&H00A8FF&'}
rand_COLOR =COLOR[math.random(1,3)]
l.text = "{"..an(5)..move(x+rand(-15,15),y+rand(-20,20),x-rand(0,80),(syl.top)+rand(1,syl.height))..bord(0)..alfa(1,'&H00&')..t(alpha('&HAA&'))..color(1,rand_COLOR)..t(clip((syl.right)+(syl.width),(syl.top)-(syl.height),(syl.right)+(syl.width),(syl.bottom)+(syl.height))).."}"..p(2,'m 0 0 l 0 1 l 1 1 l 1 0 ')
l.start_time=l.start_time+math.random(0,syl.duration)
l.end_time=l.start_time+syl.start_time
l.layer=1
subs.append(l)
end


l = table.copy(line)
for i=0,25 do
l.text = "{"..be(1)..be(1)..an(5)..move(x,y,x,y)..bord(1)..alfa(1,'&Hff&')..RangeColor(2,'&H00FFF7&','&H0000FF&',768)..K(syl.duration*10).."}"..sil()
l.start_time=line.start_time+syl.start_time
l.end_time=line.start_time+syl.start_time
l.layer=2
subs.append(l)
end


end
end

aegisub.register_macro("FIRE FX", "^^", fx_KFDS)
aegisub.register_filter("FIRE FX", "^^", 2000, fx_KFDS)