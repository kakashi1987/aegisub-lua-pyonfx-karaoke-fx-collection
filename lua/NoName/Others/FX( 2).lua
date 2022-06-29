include("karaskel.lua")

script_name = "FX"
script_description = "FX lua"
script_author = "KFDS"
script_version = "1"


function fx_lua(subs)
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
				(l.style == "Default2") then
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
	aegisub.set_undo_point("fx_lua")
end

KFDS1=0
function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 34
if i == 1 then
KFDS=0
end


l = table.copy(line)
l.text = string.format("{\\fad(100,0)\\an5\\move(%d,%d,%d,%d)\\bord3\\be3\\blur3\\fry360\\1c&HFFFFFF&\\3c&HFFFFFF&\\t(\\frx360\\1c%s\\3c%s\\bord1\\blur0\\be0\\fry0)}%s",x-10,0,x,y,line.styleref.color1,line.styleref.color3,syl.text_stripped)
l.start_time = line.start_time -1000+KFDS
l.end_time = line.start_time+KFDS
l.layer=0
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)}%s",x,y,syl.text_stripped)
l.layer=0
subs.append(l)
KFDS=KFDS+(1000/line.kara.n)


if syl.duration > 0 then
l = table.copy(line)
KFDS2=1
l.start_time = line.start_time + syl.start_time
l.end_time = line.start_time + syl.end_time
l.layer = KFDS1
for g=0, 9 do
l.text = string.format("{\\1a&H%d&\\be1\\an5\\shad0\\bord0\\1c&H008A9F&\\pos(%d,%d)\\t(0.1\\fscx%d\\fscy%d\\alpha&HFF&)}%s",KFDS1*9,x,y-2,150+(g*15), 150+(g*15), syl.text_stripped)
KFDS2=KFDS2+1
subs.append(l)
end
end
KFDS1=KFDS1+1


for j=0,5 do
star_pos_x = {'5', '10', '15', '20', '25', '-5', '-10', '-15', '-20', '-25', '0'}
star_pos_y = {'0', '-25', '-20', '-15', '-10', '-5', '25', '20', '15', '10', '5'}
if syl.duration == 20 then
rot_z = 360
else
rot_z = 360
end
l.text = string.format("{\\fad(10,100)\\org(%d,%d)\\bord0\\shad0\\an5\\move(%d,%d,%d,%d)\\1c&H10282B&\\fscx50\\fscy60\\t(\\frz20)}{\\p1}m -8 0 b -8 0 0 6 8 0 b 8 0 0 -6 -8 0 {\\p0}",x,y,x,y,x+math.random(star_pos_x[j*1+1],30),y+star_pos_y[j*1+1],math.random(-30,100),math.random(50,100),rot_z,syl.text_stripped)
l.start_time=line.start_time+syl.start_time
l.end_time=l.start_time+(syl.duration*2)+math.random(syl.duration, syl.duration*2)
l.layer = 4
subs.append(l)
end


end
end


aegisub.register_macro("FX", "", fx_lua)
aegisub.register_filter("FX", "", 2000, fx_lua)