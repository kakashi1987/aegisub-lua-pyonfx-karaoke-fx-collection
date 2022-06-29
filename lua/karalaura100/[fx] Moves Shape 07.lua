include("karaskel.lua")

script_name = "Moves Shape 07"
script_description = "Moves Shape 07"
script_author = "KaraLaura"
script_version = "1.0"

function generator_lua(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and not l.comment then
			karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("Finished!")
	aegisub.progress.set(100)
	aegisub.set_undo_point("KaraLaura")
end

function do_fx(subs, meta, line)
	for i = 1, line.kara.n do
		local syl = line.kara[i]
		local x = syl.center + line.left
		local y = line.middle

			if syl.i == line.kara.n then
			fad_f = 300
			dur_f = 300
			else
			fad_f = 0
			dur_f = 0
			end

		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%d,%d)\\fad(300,0)}%s",x,y,syl.text_stripped)
		l.start_time = line.start_time + 50*(syl.i-line.kara.n)
		l.end_time = line.start_time + syl.start_time
		l.layer = 0
		subs.append(l)

		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%s,%s)\\t(0,50,\\fscx120\\fscy120\\3c&HFFFFFF&\\blur2)\\t(50,%d,\\fscx100\\fscy100\\1c&HFFFFFF&\\3c%s\\blur0)\\fad(0,%s)}%s",x,y,syl.duration,line.styleref.color3,fad_f,syl.text_stripped)
		l.start_time = line.start_time + syl.start_time
		l.end_time = l.start_time + syl.duration + dur_f
		l.layer=2
		subs.append(l)
						
		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%s,%s)\\1a&HFF&\\3c&HFFFFFF&\\t(\\fscx150\\fscy150\\blur5)\\fad(0,300)}%s",x,y,syl.text_stripped)
		l.start_time = line.start_time + syl.start_time
		l.end_time = l.start_time + 800
		l.layer=4
		subs.append(l)

		set_temp("color",_G.interpolate_color(math.random(0,100)/100,"&H8AA7B7&","&H1E709B&"))
		set_temp("size",math.random(70,90))
		set_temp("z_i",math.random(150,270)*(-1)^math.random(2))
		set_temp("x_i",math.random(-70,70))
		set_temp("y_i",math.random(-80,80)*(-1)^math.random(2))
		shape = "m 3 21 b 5 23 7 24 8 26 b 6 28 4 29 2 31 b 3 34 0 36 1 39 b 4 40 7 37 10 38 b 12 36 14 35 16 33 b 15 36 14 39 13 42 b 16 45 15 48 18 50 b 21 48 21 45 24 44 b 24 41 24 37 24 34 b 26 36 28 38 30 40 b 33 39 34 42 38 41 b 39 38 37 36 38 33 b 36 31 33 30 31 28 b 33 26 35 26 37 25 b 32 22 27 21 22 24 b 23 16 25 9 29 1 l 28 0 b 24 8 22 15 21 24 b 15 20 11 18 3 21 m 21 26 b 26 26 30 25 34 25 b 30 26 27 26 22 27 b 28 31 32 35 37 39 b 32 35 27 31 21 27 b 21 34 19 42 18 49 b 19 42 20 34 20 27 b 15 31 8 34 2 38 b 8 34 14 30 20 26 b 15 25 10 23 5 22 b 10 23 16 24 21 26"
		
		l = table.copy(line)
		l.text = string.format("{\\an5\\move(%s,%s,%s,%s)\\bord0\\fscx%s\\fscy%s\\1c%s\\fr%s\\frx%s\\fry%s\\t(\\fr%s\\frx%s\\fry%s)\\p1}%s",x,y,x+syl.height,y+2*syl.height,temp.size,temp.size,temp.color,temp.z_i,temp.x_i,temp.y_i,2*temp.z_i,2.5*temp.x_i,2.5*temp.y_i,shape)
		l.start_time = line.start_time + syl.start_time
		l.end_time = l.start_time + 1000
		l.layer=3
		subs.append(l)
		
		l = table.copy(line)
		l.text = string.format("{\\an5\\move(%s,%s,%s,%s)\\bord0\\fscx%s\\fscy%s\\1c%s\\fr%s\\frx%s\\fry%s\\t(\\fr%s\\frx%s\\fry%s)\\fad(0,300)\\p1}%s",x+syl.height,y+2*syl.height,x-2*syl.height,y+1.5*syl.height,temp.size,temp.size,temp.color,2*temp.z_i,2.5*temp.x_i,2.5*temp.y_i,3*temp.z_i,0*temp.x_i,0*temp.y_i,shape)
		l.start_time = line.start_time + syl.start_time + 1000
		l.end_time = l.start_time + 600
		l.layer=3
		subs.append(l)
		
		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%s,%s)\\1c&HFFFFFF&\\fad(0,300)}%s",x,y,syl.text_stripped)
		l.start_time = syl.duration + line.start_time + syl.start_time
		l.end_time = line.end_time + 50*(syl.i-line.kara.n)
		l.layer=0
		subs.append(l)
		
	end
end

temp = {}
function set_temp(ref,val)
		temp[ref] = val
		return val
end

aegisub.register_macro("Moves Shape 07", "", generator_lua)