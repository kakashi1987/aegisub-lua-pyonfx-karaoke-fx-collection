include("karaskel.lua")

script_name = "Moves Shape 09"
script_description = "Moves Shape 09"
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
		l.text = string.format("{\\an5\\pos(%s,%s)\\fad(300,0)}%s",x,y,syl.text_stripped)
		l.start_time = line.start_time + 50*(syl.i-line.kara.n)
		l.end_time = line.start_time + syl.start_time
		l.layer = 1
		subs.append(l)

		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%s,%s)\\fscx120\\fscy120\\3c&HFFFFFF&\\bord2\\blur2\\t(50,%d,\\fscx100\\fscy100\\3c%s\\bord1\\blur0)\\fad(0,%s)}%s",x,y,syl.duration,line.styleref.color3,fad_f,syl.text_stripped)
		l.start_time = line.start_time + syl.start_time
		l.end_time = l.start_time + syl.duration + dur_f
		l.layer=2
		subs.append(l)

		l = table.copy(line)
		l.text = string.format("{\\an5\\pos(%s,%s)\\fad(0,300)}%s",x,y,syl.text_stripped)
		l.start_time = syl.duration + line.start_time + syl.start_time
		l.end_time = line.end_time + 50*(syl.i-line.kara.n)
		l.layer= 1
		subs.append(l)
		
		if syl.i == 1 then
		size = 32
		ratio = 1.4*size
		shape = "m 12 55 b 32 61 68 67 72 55 b 76 43 60 47 60 30 b 60 0 103 0 103 30 b 103 47 88 43 92 55 b 96 67 132 61 152 55 b 158 75 164 111 152 115 b 140 119 144 103 127 103 b 97 103 97 147 127 147 b 144 147 140 131 152 135 b 164 139 158 175 152 195 b 132 191 96 183 92 195 b 88 207 103 203 103 220 b 103 250 60 250 60 220 b 60 203 76 207 72 195 b 68 183 32 189 12 195 b 8 175 0 139 12 135 b 24 131 20 147 37 147 b 67 147 67 103 37 103 b 20 103 24 119 12 115 b 0 111 8 75 12 55"
		n = math.ceil(line.width/ratio)
		l_shape = ratio*n
		x_shape = x + line.width/2 - l_shape/2
			
			for j = 1, n do
			A = line.kara[math.random(line.kara.n)].start_time
			B = A + 500
			l.text = string.format("{\\an5\\move(%s,%s,%s,%s,0,500)\\1a&HFF&\\3a&H60\\bord1.5\\shad0\\3c&HFA8F2B&\\blur1\\fad(200,0)\\fscx%s\\fscy%s\\frx%s\\fry%s\\fr%s\\t(0,500,\\frx0\\fry0\\fr%s)\\p1}%s",x_shape+ratio*(j-1)+math.random(-100,100),y+math.random(-100,100),x_shape+ratio*(j-1),y,size,size,math.random(-360,360),math.random(-360,360),math.random(-360,360),45*(1+(-1)^j),shape)
			l.start_time = line.start_time + 50*(j-n) - 500
			l.end_time = line.start_time
			l.layer = 0
			subs.append(l)

			w = math.random(n)
				if math.mod(w,2) == 1 then
				angle = 0
				else
				angle = 90
				end
			extra_shape = x_shape + ratio*w
			sign = (-1)^math.random(2)
			math.randomseed = 8317
			l.text = string.format("{\\an5\\move(%s,%s,%s,%s,0,500)\\1a&HFF&\\3a&H60\\bord1.5\\shad0\\3c&HFA8F2B&\\blur1\\fad(200,0)\\fscx%s\\fscy%s\\frx%s\\fry%s\\fr%s\\t(0,500,\\frx0\\fry0\\fr%s)\\p1}%s",extra_shape+math.random(-100,100),y+ratio*sign+math.random(-100,100),extra_shape,y+ratio*sign,size,size,math.random(-360,360),math.random(-360,360),math.random(-360,360),angle,shape)
			l.start_time = line.start_time + 50*(j-n) - 500
			l.end_time = line.start_time
			l.layer = 0
			subs.append(l)
			
			l.text = string.format("{\\an5\\move(%s,%s,%s,%s,%s,%s)\\1a&HFF&\\3a&H60\\bord1.5\\shad0\\3c&HFA8F2B&\\blur1\\fad(0,200)\\fscx%s\\fscy%s\\frz%s\\t(%s,%s,\\frx%s\\fry%s\\fr%s)\\p1}%s",extra_shape,y+ratio*sign,extra_shape+math.random(-100,100),y+ratio*sign+math.random(-100,100),A,B,size,size,angle,A,B,math.random(-360,360),math.random(-360,360),math.random(-360,360),shape)
			l.start_time = line.start_time
			l.end_time = line.start_time + B
			l.layer = 0
			subs.append(l)
			
			l.text = string.format("{\\an5\\move(%s,%s,%s,%s,%s,%s)\\1a&HFF&\\3a&H60\\bord1.5\\shad0\\3c&HFA8F2B&\\blur1\\fad(0,200)\\fscx%s\\fscy%s\\frz%s\\t(%s,%s,\\frx%s\\fry%s\\fr%s)\\p1}%s",x_shape+ratio*(j-1),y,x_shape+ratio*(j-1)+math.random(-100,100),y+math.random(-100,100),A,B,size,size,45*(1+(-1)^j),A,B,math.random(-360,360),math.random(-360,360),math.random(-360,360),shape)
			l.start_time = line.start_time
			l.end_time = line.start_time + B
			l.layer = 0
			subs.append(l)
			
			end
		
		end
		
	end
end

aegisub.register_macro("Moves Shape 09", "", generator_lua)