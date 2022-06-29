include("karaskel.lua")
include("zheolib.lua")

script_name = "Inoue Joe - CLOSER"
script_description = "Fx lua"
script_author = "ASEDARK to lua KFDS"
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
	aegisub.progress.task("fx_KFDS")
end


function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 25
if i==1 then
end
function sil()
silaba = ""..syl.text_stripped..""
return silaba
end
for char in unicode.chars(sil()) do
if char == ' ' or char == '' then
l.text = "{}"
else


l = table.copy(line)
for i = 0,45 do
l.text = "{"..an(5)..move(x+30,y,x,y,0,400)..fad(400,0)..color(3,'&HFFFFFF&')..bord(0)..fry-(360)..t((0),(400)..fry(0))..RangeColor(1,'&HFFFFFF&','&HD6FF6B&',768).."}"..char
l.start_time=line.start_time -400+i*100
l.end_time=line.start_time+syl.start_time
l.layer=0
subs.append(l)
end


l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\1c&HFFFFFF&\\alpha&HFF&\\3c&HFFFFFF&\\fscx160\\fscy160\\bord2\\blur10\\shad2\\4c&H000000&\\t(\\bord0\\blur0)\\t(\\fscx100\\fscy100\\frz0)}%s",x,y,x+20,y,syl.text_stripped) 
l.start_time=line.start_time+syl.start_time
l.end_time=l.end_time+syl.start_time
l.layer=1
subs.append(l)


l = table.copy(line)
for j = 0,14 do
valpha={'11','22','33','44','55','66','77','88','99','110','121'}
rand_alpha= valpha[math.random(1,11)]
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\1c&HFFFFFF&\\bord0\\shad0\\fscx160\\fscy160\\1a%d\\t(\\fscx100\\fscy100\\frz0)}%s",x,y+j*4,x+j*2,y+j*4,rand_alpha,syl.text_stripped)
l.start_time=line.start_time+syl.start_time+(syl.duration/14)*j
l.end_time=l.end_time+syl.start_time
l.layer=2
subs.append(l)
end


l = table.copy(line)
for i = 0,45 do
l.text = "{"..an(5)..move(x,y,x+20,y)..color(1,'&HF57E66&')..bord(0)..color(3,'&HFFFFFF&')..RangeColor(1,'&HD6FF6B&','&HFFFFFF&',768).."}"..sil() 
l.start_time=line.start_time+syl.end_time
l.end_time=l.end_time+syl.end_time
l.layer=3
subs.append(l)
end


l = table.copy(line)
l.text = "{"..org(x,y)..an(5)..move(x,y,x-200,y)..fad(0,800)..color(1,'&HFFFFFF&')..color(3,'&HFFFFFF&')..bord(1)..blur(5)..t(fry(360)..fscx(0)..fscy(0)).."}"..char
l.start_time=line.start_time+syl.start_time
l.end_time=l.end_time+syl.start_time+300+i*100
l.layer=4
subs.append(l)


end
end

aegisub.register_macro("Inoue Joe - CLOSER", "", fx_KFDS)
aegisub.register_filter("Inoue Joe - CLOSER ", "", 2000, fx_KFDS)