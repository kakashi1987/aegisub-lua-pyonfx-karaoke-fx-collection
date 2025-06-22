include("karaskel.lua")


script_name = "Toriko Opening"
script_description = "Jecht is into Carbon"
script_author = "FloriaN"
script_version = "1"

function toriko(subs)
	local meta, styles = karaskel.collect_head(subs)
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
end


function do_fx(subs, meta, line)
	chari = 0
	
for i = 1, line.kara.n do
local l=table.copy(line)
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 35

	pox = 0
	
	for char in unicode.chars(syl.text_stripped) do
		cx,cy = aegisub.text_extents(line.styleref,char)
		local charx = line.left + syl.left + (cx/2) + pox
		local chary = y
		pox = pox + cx
		chari = 1+chari
		l.text = string.format("{\\an5\\bord0.2\\be10\\3c%s\\1c%s\\fad(%d,%d)\\move(%d,%d,%d,%d,%d,%d)\\fscy100\\fry360\\fscx100\\t(%d,%d,\\fscx120\\frz0\\fry0\\frx0\\fscy170)\\t(%d,%d,\\fscx100\\fscy100\\be0\\bord1.5\\3c&H000000&)}%s",line.styleref.color3,line.styleref.color1,200,0,charx+math.random(-40,40),chary+math.random(-20,20),charx,chary,0,400,0,400,400,800,char)
		l.start_time = line.start_time - 400 + (chari-1)*10
		l.end_time = line.start_time + syl.start_time
		subs.append(l)
	end
	

for j=0,02 do
colors={'H00C6F8', 'H0000FF'}
rand_color= colors[math.random(2,2)]
l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,200)\\1c%s\\3c%s\\bord0\\t(\\bord0\\frx-70\\be1)\\t(\\be2)\\t(\\be5)\\t(\\fscy160\\be10\\bord0\\3c&H86AEC1&)\\t(\\be60\\fscy240\\fscx240)}%s",x,y,x,y+15,rand_color,rand_color,syl.text_stripped)
l.start_time = l.start_time+syl.start_time
l.end_time = l.start_time+syl.duration+700+math.random(200,400)+math.random(0,syl.duration)
l.layer=4
subs.append(l)
end

for j=0,02 do
colors={'H0000FF', 'H00C6F8'}
rand_color= colors[math.random(2,2)]
l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,200)\\1c%s\\3c%s\\bord0\\t(\\bord0\\frx-70\\be1)\\t(\\be2)\\t(\\be5)\\t(\\fscy110\\be10\\bord0\\3c&H86AEC1&)\\t(\\be80\\fscy220\\fscx220)}%s",x,y,x,y+15,rand_color,rand_color,syl.text_stripped)
l.start_time = l.start_time+syl.start_time
l.end_time = l.start_time+syl.duration+800+math.random(200,200)+math.random(0,syl.duration)+200
l.layer=4
subs.append(l)
end

for j=0,02 do
colors={'H0000FF', 'H00C6F8'}
rand_color= colors[math.random(2,2)]
l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,200)\\1c%s\\3c%s\\bord0\\t(\\bord0\\frx-70\\be1)\\t(\\be2)\\t(\\be5)\\t(\\fscy80\\be10\\bord0\\3c&H86AEC1&)\\t(\\be90\\fscy120\\fscx120)}%s",x,y,x+10,y+15,rand_color,rand_color,syl.text_stripped)
l.start_time = l.start_time+syl.start_time
l.end_time = l.start_time+syl.duration+900+math.random(200,200)+math.random(0,syl.duration)
l.layer=4
subs.append(l)
end

for j=0,02 do
colors={'H0000FF', 'H00C6F8'}
rand_color= colors[math.random(2,2)]
l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,200)\\1c%s\\3c%s\\bord0\\t(\\bord0\\frx-70\\be1)\\t(\\be2)\\t(\\be5)\\t(\\fscy120\\be10\\bord0\\3c&H86AEC1&)\\t(\\frz100\\be100\\fscy200\\fscx200)}%s",x,y,x,y+15,rand_color,rand_color,syl.text_stripped)
l.start_time = l.start_time+syl.start_time
l.end_time = l.start_time+syl.duration+900+math.random(200,200)+math.random(0,syl.duration)+100
l.layer=4
subs.append(l)
end

for j=0,01 do
colors={'H00C6F8', 'H0000FF'}
rand_color= colors[math.random(2,2)]
l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,200)\\1c%s\\3c%s\\bord0\\alpha&HFF&\\t(\\bord0\\frx-70\\be1)\\t(\\be2)\\t(\\be5)\\t(\\alpha&HAA&\\alpha&HCC&\\fscy160\\be10\\bord0\\3c&H86AEC1&)\\t(\\alpha&H99&\\be60\\fscy170\\fscx160)}%s",x,y,x,y+15,rand_color,rand_color,syl.text_stripped)
l.start_time = l.start_time+syl.start_time
l.end_time = l.start_time+syl.duration+700+math.random(200,400)+math.random(0,syl.duration)
l.layer=5
subs.append(l)
end

end
end

aegisub.register_macro("Toriko Opening","", toriko)
aegisub.register_filter("Toriko Opening","",2000,toriko)