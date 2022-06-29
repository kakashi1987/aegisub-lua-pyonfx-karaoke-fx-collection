include("karaskel.lua")

script_name = "fire blaze effect"
script_description = "FX_lua"
script_author = "Zheo"
script_version = "1.01"

function fx_Zheo(subs)
	aegisub.progress.task("Creando FX")
	local meta, styles = karaskel.collect_head(subs)	
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Esto llevo trabajado (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment and
				(l.style == "Default" or l.style == "Romaji") then
				karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else
			i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("D: Acabo la wea!")---("Por fin termine D:!")
	aegisub.progress.set(100)
	
end


function do_fx(subs, meta, line)
for i = 1, line.kara.n do
local syl = line.kara[i]
local x=syl.center + line.left
local y=line.margin_v + 15
if i == 1 then
tempo=0
end


-- ÍÑßÉ ÇáÏÎæá
l = table.copy(line)
l.text = string.format("{\\fad(100,0)\\an5\\be1\\move(%d,%d,%d,%d)\\bord0\\1c&HFFFFFF&\\t(\\be0\\1c&H00C6F8&\\3c&H0000FF&\\bord1)}%s",x,y,x,y,syl.text_stripped)
l.start_time = line.start_time-800+tempo
l.end_time = line.start_time+tempo
subs.append(l)


l = table.copy(line)
l.text = string.format("{\\an5\\pos(%d,%d)\\1c&H00C6F8&\\3c&H0000FF&\\bord1.5\\be2\\3a&H22&}%s",x,y,syl.text_stripped)
l.start_time = line.start_time+tempo
l.end_time = line.start_time+syl.start_time
l.layer=2
subs.append(l)
tempo=tempo+(1000/line.kara.n)


for j=0,02 do
colores={'H00C6F8', 'H0000FF'}
rand_color= colores[math.random(2,2)]
l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,200)\\1c%s\\3c%s\\bord0\\t(\\bord0\\frx-70\\be1)\\t(\\be2)\\t(\\be5)\\t(\\fscy160\\be10\\bord0\\3c&H86AEC1&)\\t(\\be60\\fscy240\\fscx240)}%s",x,y,x,y+15,rand_color,rand_color,syl.text_stripped)
l.start_time = l.start_time+syl.start_time
l.end_time = l.start_time+syl.duration+700+math.random(200,400)+math.random(0,syl.duration)
l.layer=4
subs.append(l)
end



for j=0,02 do
colores={'H0000FF', 'H00C6F8'}
rand_color= colores[math.random(2,2)]
l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,200)\\1c%s\\3c%s\\bord0\\t(\\bord0\\frx-70\\be1)\\t(\\be2)\\t(\\be5)\\t(\\fscy110\\be10\\bord0\\3c&H86AEC1&)\\t(\\be80\\fscy220\\fscx220)}%s",x,y,x,y+15,rand_color,rand_color,syl.text_stripped)
l.start_time = l.start_time+syl.start_time
l.end_time = l.start_time+syl.duration+800+math.random(200,200)+math.random(0,syl.duration)+200
l.layer=4
subs.append(l)
end


for j=0,02 do
colores={'H0000FF', 'H00C6F8'}
rand_color= colores[math.random(2,2)]
l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,200)\\1c%s\\3c%s\\bord0\\t(\\bord0\\frx-70\\be1)\\t(\\be2)\\t(\\be5)\\t(\\fscy80\\be10\\bord0\\3c&H86AEC1&)\\t(\\be90\\fscy120\\fscx120)}%s",x,y,x+10,y+15,rand_color,rand_color,syl.text_stripped)
l.start_time = l.start_time+syl.start_time
l.end_time = l.start_time+syl.duration+900+math.random(200,200)+math.random(0,syl.duration)
l.layer=4
subs.append(l)
end


for j=0,02 do
colores={'H0000FF', 'H00C6F8'}
rand_color= colores[math.random(2,2)]
l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,200)\\1c%s\\3c%s\\bord0\\t(\\bord0\\frx-70\\be1)\\t(\\be2)\\t(\\be5)\\t(\\fscy120\\be10\\bord0\\3c&H86AEC1&)\\t(\\frz100\\be100\\fscy200\\fscx200)}%s",x,y,x,y+15,rand_color,rand_color,syl.text_stripped)
l.start_time = l.start_time+syl.start_time
l.end_time = l.start_time+syl.duration+900+math.random(200,200)+math.random(0,syl.duration)+100
l.layer=4
subs.append(l)
end


for j=0,01 do
colores={'H00C6F8', 'H0000FF'}
rand_color= colores[math.random(2,2)]
l = table.copy(line)
l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,200)\\1c%s\\3c%s\\bord0\\alpha&HFF&\\t(\\bord0\\frx-70\\be1)\\t(\\be2)\\t(\\be5)\\t(\\alpha&HAA&\\alpha&HCC&\\fscy160\\be10\\bord0\\3c&H86AEC1&)\\t(\\alpha&H99&\\be60\\fscy170\\fscx160)}%s",x,y,x,y+15,rand_color,rand_color,syl.text_stripped)
l.start_time = l.start_time+syl.start_time
l.end_time = l.start_time+syl.duration+700+math.random(200,400)+math.random(0,syl.duration)
l.layer=5
subs.append(l)
end


end
end



aegisub.register_macro("JR-F FX!", "Aplica tu FX! D:", fx_Zheo)
aegisub.register_filter("JR-F FX!", "Aplica tu FX! D:", 2000, fx_Zheo)