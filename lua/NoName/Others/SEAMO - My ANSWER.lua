include("karaskel.lua")

script_name = "SEAMO - My ANSWER"
script_description = "FX lua"
script_author = "KFDS"
script_made = "02:20-P.M_02-08-2009"
script_version = "1"

function fx_KFDS(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do

                   aegisub.progress.task(string.format("Applying effect... (%d\%d)", ai, maxai))		
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
if i == 1 then
KFDS=0
end


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\alpha&HFF&\\frx%d\\t(\\alpha&H00&\\frx0)}%s",x-30,y-20,x,y,math.random(360,1080),syl.text_stripped)
l.start_time=line.start_time-28+i*1
l.end_time=line.start_time+i*10-15
l.layer=0
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)}%s",x,y,syl.text_stripped)
l.start_time=line.start_time+i*10-15
l.end_time=line.start_time+syl.start_time
l.layer=1
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\t(\\fry360)}%s",x,y,syl.text_stripped)
l.start_time=line.start_time+syl.start_time+i*2
l.end_time=line.start_time+syl.duration+5+math.random(15,50)
l.layer=2
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx30\\fscy30\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=3
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-5\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx30\\fscy30\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=4
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-10\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx40\\fscy40\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=5
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-15\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx50\\fscy50\\t(\\frz%d)\\t(\\fscx30\\fscy30\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=6
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-20\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx50\\fscy50\\t(\\frz%d)\\t(\\fscx40\\fscy40\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=7
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr10\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx30\\fscy30\\alpha&HFF&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=8
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr20\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx40\\fscy40\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=9
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr30\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx30\\fscy30\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=10
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr40\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx40\\fscy40\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=11
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr50\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx30\\fscy30\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=12
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr60\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx40\\fscy40\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=13
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr70\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx30\\fscy30\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=14
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr80\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx40\\fscy40\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=15
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr90\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx40\\fscy40\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=16
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr100\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx30\\fscy30\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=18
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-30\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx50\\fscy50\\t(\\frz%d)\\t(\\fscx40\\fscy40\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=19
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-35\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx50\\fscy50\\t(\\frz%d)\\t(\\fscx30\\fscy30\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=20
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-40\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx50\\fscy50\\t(\\frz%d)\\t(\\fscx40\\fscy40\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=21
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-45\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx50\\fscy50\\t(\\frz%d)\\t(\\fscx30\\fscy30\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=22
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-50\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx50\\fscy50\\t(\\frz%d)\\t(\\fscx40\\fscy40\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=23
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-55\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx30\\fscy30\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=24
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-60\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx40\\fscy40\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=25
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-65\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx30\\fscy30\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=26
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-70\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx40\\fscy40\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=27
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-75\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx30\\fscy30\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=28
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-80\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx50\\fscy50\\t(\\frz%d)\\t(\\fscx40\\fscy40\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=29
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-85\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx50\\fscy50\\t(\\frz%d)\\t(\\fscx30\\fscy30\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=30
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-90\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx50\\fscy50\\t(\\frz%d)\\t(\\fscx40\\fscy40\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=31
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-95\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx50\\fscy50\\t(\\frz%d)\\t(\\fscx30\\fscy30\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=32
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-100\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx50\\fscy50\\t(\\frz%d)\\t(\\fscx40\\fscy40\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=33
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr110\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx30\\fscy30\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=34
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr130\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx40\\fscy40\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=35
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr140\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx30\\fscy30\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=36
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr150\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx40\\fscy40\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=37
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr160\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx30\\fscy30\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=38
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr170\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx40\\fscy40\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=39
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr180\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx30\\fscy30\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=40
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-130\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx40\\fscy40\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=41
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-150\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx30\\fscy30\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=42
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-170\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx40\\fscy40\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=43
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-190\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx30\\fscy30\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=44
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\fscx40\\fscy40\\an5\\fr-200\\1a&H77&\\pos(%d,%d)\\fad(10,10)\\shad0\\bord0\\1c&HFFFFFF&\\fscx70\\fscy70\\t(\\frz%d)\\t(\\fscx40\\fscy40\\alpha&HFA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c {\\p0}",x,y,syl.duration*3,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=45
subs.append(l)


l = table.copy(line)
for j=0,30 do
random_pos = math.random(200,500)
l.text = string.format("{\\fad(10,200)\\move(%d,%d,%d,%d)\\an5\\shad0\\fscx10\\fscy10\\bord0.5\\3a&HAA&\\blur5\\3c&HFFFFFF&\\1c&HFFFFFF&\\t(\\fscx5\\fscy5\\alpa&HAA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c{\\p0}",x-math.random(-6,6),y-math.random(-6,6),x+math.random(-35,25)*syl.duration/600,y+math.random(-35,25),random_pos,random_pos,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration+math.random(200,400)+300
l.layer=46
subs.append(l)
end


l = table.copy(line)
for j=0,20 do
random_pos = math.random(200,500)
l.text = string.format("{\\fad(10,200)\\move(%d,%d,%d,%d)\\an5\\shad0\\fscx15\\fscy15\\bord0.5\\3a&HAA&\\blur5\\3c&HFFFFFF&\\1c&HFFFFFF&\\t(\\fscx5\\fscy5\\alpa&HAA&)}{\\p1}m 0 0 l 50 49 100 0 51 50 100 100 50 51 0 100 49 50 0 0 m 45 45 s 55 45 55 55 45 55 c{\\p0}",x-math.random(-6,6),y-math.random(-6,6),x+math.random(-15,25),y+math.random(-15,25)*syl.duration/600,random_pos,random_pos,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration+math.random(200,400)+300
l.layer=47
subs.append(l)
end


l = table.copy(line)
l.text = string.format("{\\an5\\bord0\\1c&HFFFFFF\\3c&H000000&\\alpha&c0&\\move(%d,%d,%d,%d)\\fscx100\\fscy100\\bord0\\t(\\fscx115\\fscy115\\blur1)}%s",x,y,x-2,y,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=48
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\bord0\\1c&HFFFFFF\\3c&H000000&\\alpha&c0&\\move(%d,%d,%d,%d)\\fscx100\\fscy100\\bord0\\t(\\fscx125\\fscy125\\blur1)}%s",x,y,x-3,y,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=49
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\bord0\\1c&HFFFFFF\\3c&H000000&\\alpha&c0&\\move(%d,%d,%d,%d)\\fscx100\\fscy100\\bord0\\t(\\fscx135\\fscy135\\blur2)}%s",x,y,x-4,y,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=50
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\org(%d,%d)\\pos(%d,%d)\\bord1\\1c&HFFFFFF\\3c&H000000&\\t(\\blur5\\bord1.5)}%s",x,y,x,y,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+syl.duration
l.layer=51
subs.append(l)


for i=0,70 do
l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\3a&HFF&\\4a&HFF&\\fscx100\\fscy100\\t(\\1a&HBF&\\fscy%d\fscx%d)}%s",x,y,150+math.random(-50,100),math.random(-50,100)+150,syl.text_stripped)
l.start_time=line.start_time+syl.start_time+i*2
l.end_time=line.start_time+syl.duration+5+math.random(15,50)
l.layer=52
subs.append(l)
end


for i=0,80 do
l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\3a&HFF&\\4a&HFF&\\fscx100\\fscy100\\t(\\1a&HBF&\\fscy%d\fscx%d)}%s",x,y,150+math.random(-50,100),math.random(-50,100)+150,syl.text_stripped)
l.start_time=line.start_time+syl.start_time+i*2
l.end_time=line.start_time+syl.duration+5+math.random(15,50)
l.layer=53
subs.append(l)
end


for i=0,40 do
l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\alpha&H80&\\1c&H00FFFF&\\shad1\\bord1\\3c&HFFFFFF&\\fscx100\\fscy100\\t(\\alpha&HD0&)}{\\p2} m 0 0 l 0 1 1 1 1 0 {\\p0}", x+math.random(-10,10), y+math.random(-10,10), x+math.random(-100,100), y+math.random(-100,100),math.random(0,255),math.random(0,255),math.random(0,255),syl.text_stripped)
l.start_time=line.start_time+syl.start_time+i*2
l.end_time=line.start_time+syl.start_time+syl.duration+i*5
l.layer=54
subs.append(l)
end


for i=0,40 do
l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\alpha&H80&\\1c&H0090FF&\\shad1\\bord1\\3c&HFFFFFF&\\fscx100\\fscy100\\t(\\alpha&HD0&)}{\\p3} m 0 0 l 0 1 1 1 1 0 {\\p0}", x+math.random(-10,10), y+math.random(-10,10), x+math.random(-100,100), y+math.random(-100,100),math.random(0,255),math.random(0,255),math.random(0,255),syl.text_stripped)
l.start_time=line.start_time+syl.start_time+i*2
l.end_time=line.start_time+syl.start_time+syl.duration+i*5
l.layer=55
subs.append(l)
end


for i=0,40 do
l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\alpha&H80&\\1c&H00C0FF&\\shad1\\bord1\\3c&HFFFFFF&\\fscx100\\fscy100\\t(\\alpha&HD0&)}{\\p4} m 0 0 l 0 1 1 1 1 0 {\\p0}", x+math.random(-10,10), y+math.random(-10,10), x+math.random(-100,100), y+math.random(-100,100),math.random(0,255),math.random(0,255),math.random(0,255),syl.text_stripped)
l.start_time=line.start_time+syl.start_time+i*2
l.end_time=line.start_time+syl.start_time+syl.duration+i*5
l.layer=56
subs.append(l)
end


end
end


aegisub.register_macro("SEAMO - My ANSWER", "NS ED10", fx_KFDS)
aegisub.register_filter("SEAMO - My ANSWER", "NS ED10", 2000, fx_KFDS)