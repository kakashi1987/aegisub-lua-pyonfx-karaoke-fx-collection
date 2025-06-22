include("karaskel.lua")

script_name = "NS OP5"
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
local x=syl.center - line.left + 120 - 90
local y=line.margin_v + 40
if i==1 then
end


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\alpha&HFF&\\frx%d\\t(\\alpha&H00&\\frx0)}%s",y-20,x-30,y,x,math.random(360,1080),syl.text_stripped)
l.start_time=line.start_time-28+i*1
l.end_time=line.start_time+i*10-15
l.layer=0
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)}%s",y,x,syl.text_stripped)
l.start_time=line.start_time+i*10-15
l.end_time=line.start_time+syl.start_time
l.layer=0
subs.append(l)


l = table.copy(line)
for i=0,10 do
l.text = string.format("{\\an5\\pos(%d,%d)\\bord0\\shad0\\3a&HFF&\\4a&HFF&\\1c&HDD907B&\\fscx100\\fscy100\\t(0.12,\\fscx%d\\fscy%d\\1a&HBF&\\fry360\\frx360\\frz360\\fry-360\\frx-360\\frz-360\\fry180\\frx180\\frz180\\fry-180\\frx-180\\frz-180\\fry90\\frx90\\frz90\\fry-90\\frx-90\\frz-90)}%s",y,x,120+math.random(-40,40),120+math.random(-50,50),syl.text_stripped)
l.start_time=line.start_time+syl.start_time+10
l.end_time=l.start_time+syl.duration+5+math.random(35)
l.layer=1
subs.append(l)
end


l = table.copy(line)
for i=0,12 do
l.text = string.format("{\\an5\\pos(%d,%d)\\bord0\\shad2\\3a&HFF&\\4a&HFF&\\1c&HFFFFFF&\\blur10\\be10\\fscx110\\fscy125\\t(0.25,\\fscx%d\\fscy%d\\1a&HBF&\\fry360\\frx360\\frz360\\fry-360\\frx-360\\frz-360\\fry180\\frx180\\frz180\\fry-180\\frx-180\\frz-180\\fry90\\frx90\\frz90\\fry-90\\frx-90\\frz-90)}%s",y,x,120+math.random(-60,60),150+math.random(-80,80),syl.text_stripped)
l.start_time=line.start_time+syl.start_time+10
l.end_time=l.start_time+syl.duration+5+math.random(35)
l.layer=2
subs.append(l)
end


l = table.copy(line)
for i=0,10 do
l.text = string.format("{\\an5\\pos(%d,%d)\\bord0\\shad0\\3a&HFF&\\4a&HFF&\\1c&HDD907B&\\fscx100\\fscy100\\t(0.12,\\fscx%d\\fscy%d\\1a&HBF&\\fry360\\frx360\\frz360\\fry-360\\frx-360\\frz-360\\fry180\\frx180\\frz180\\fry-180\\frx-180\\frz-180\\fry90\\frx90\\frz90\\fry-90\\frx-90\\frz-90)}%s",y,x,120+math.random(-40,40),120+math.random(-50,50),syl.text_stripped)
l.start_time=line.start_time+syl.start_time+10
l.end_time=l.start_time+syl.duration+5+math.random(35)
l.layer=3
subs.append(l)
end


l = table.copy(line)
for i=0,12 do
l.text = string.format("{\\an5\\pos(%d,%d)\\bord0\\shad2\\3a&HFF&\\4a&HFF&\\1c&HFFFFFF&\\fscx110\\fscy125\\t(0.25,\\fscx%d\\fscy%d\\1a&HBF&\\fry360\\frx360\\frz360\\fry-360\\frx-360\\frz-360\\fry180\\frx180\\frz180\\fry-180\\frx-180\\frz-180\\fry90\\frx90\\frz90\\fry-90\\frx-90\\frz-90)}%s",y,x,120+math.random(-60,60),150+math.random(-80,80),syl.text_stripped)
l.start_time=line.start_time+syl.start_time+10
l.end_time=l.start_time+syl.duration+5+math.random(35)
l.layer=4
subs.append(l)
end


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\frx360\\fad(100,600)}%s",y,x+20,y+20,x,syl.text_stripped)
l.start_time=line.start_time+syl.start_time+10
l.end_time=line.start_time+syl.start_time+10
l.layer=5
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\frx360\\fad(100,600)}%s",y,x+30,y+30,x,syl.text_stripped)
l.start_time=line.start_time+syl.start_time+10
l.end_time=line.start_time+syl.start_time+9
l.layer=6
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\frx360\\fad(100,600)}%s",y,x+40,y+40,x,syl.text_stripped)
l.start_time=line.start_time+syl.start_time+10
l.end_time=line.start_time+syl.start_time+9
l.layer=7
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\frx360\\fad(100,600)}%s",y,x+50,y+50,x,syl.text_stripped)
l.start_time=line.start_time+syl.start_time+10
l.end_time=line.start_time+syl.start_time+8
l.layer=8
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\frx360\\fad(100,600)}%s",y,x+60,y+60,x,syl.text_stripped)
l.start_time=line.start_time+syl.start_time+10
l.end_time=line.start_time+syl.start_time+8
l.layer=9
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\frx360\\fad(100,600)}%s",y,x+70,y+70,x,syl.text_stripped)
l.start_time=line.start_time+syl.start_time+10
l.end_time=line.start_time+syl.start_time+7
l.layer=10
subs.append(l)


l = table.copy(line)
for i=0,12 do
l.text = string.format("{\\an5\\pos(%d,%d)\\bord0\\shad2\\3a&HFF&\\4a&HFF&\\1c&HFFFFFF&\\fscx110\\fscy125\\t(0.25,\\fscx%d\\fscy%d\\1a&HBF&)}%s",y,x,120+math.random(-60,60),150+math.random(-80,80),syl.text_stripped)
l.start_time=line.start_time+syl.start_time+10
l.end_time=l.start_time+syl.duration+5+math.random(35)
l.layer=2
subs.append(l)
end


l = table.copy(line)
for i=0,10 do
l.text = string.format("{\\an5\\pos(%d,%d)\\bord0\\shad0\\3a&HFF&\\4a&HFF&\\1c&HDD907B&\\fscx100\\fscy100\\t(0.12,\\fscx%d\\fscy%d\\1a&HBF&)}%s",y,x,120+math.random(-40,40),120+math.random(-50,50),syl.text_stripped)
l.start_time=line.start_time+syl.start_time+10
l.end_time=l.start_time+syl.duration+5+math.random(35)
l.layer=3
subs.append(l)
end


end
end


aegisub.register_macro("NS OP5", "", fx_KFDS)
aegisub.register_filter("NS OP5", "", 2000, fx_KFDS)