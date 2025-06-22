--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	line.infade = 750
	line.outfade = 750
	
	for ci,char in ipairs(line.chars) do
		
		if char.text~="" and char.text~=" " then
			--text fx 1
			
			local max_frame = 25
			local u_in, u_out = 0, 0
			local a, b = 0, 0
			
			l.layer = 5
			
			for s, e, i, n in utils.frames(line.start_time+100*char.i-100-line.infade, line.end_time+25*char.i-25+line.outfade, max_frame) do
				
				l.start_time = s
				l.end_time = e
				
				local step = i / n
				
				local infad, outfad = 700, 1000
				local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
				
				local sx1, sy1 = char.left, char.top
				local sx2, sy2 = char.center - 5, char.middle + 5
				local sx3, sy3 = char.center, char.middle
				
				local ex1, ey1 = char.center, char.middle
				local ex2, ey2 = char.right + 15, char.top
				local ex3, ey3 = char.right, char.bottom
				
				if i < math.ceil(infad/max_frame) then
					alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
					scx, scy = 100, 100
					local spoint = math.bezier(u_in/inmax,
					{
					{sx1, sy1},
					{sx2, sy2},
					{sx3, sy3}
					}
					)
					x, y = spoint[1] , spoint[2]
					u_in = u_in + 1
				elseif s >= (line.start_time+char.start_time) and s <= (line.start_time + char.start_time + char.duration) then
					alpha="&H00&"
					x, y = char.center, char.middle
					sc = utils.interpolate((s - (line.start_time + char.start_time))/char.duration, 130, 100) + 5*math.sin(math.rad(a))
					scx, scy = sc, sc
					a = a + 10
				elseif i > (n-math.ceil(outfad/max_frame)) then
					alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
					scx, scy = 100, 100
					local epoint = math.bezier(u_out/outmax,
					{
					{ex1, ey1},
					{ex2, ey2},
					{ex3, ey3}
					}
					)
					x, y = epoint[1] , epoint[2]
					u_out = u_out + 1
				else
					alpha="&H00&"
					scx, scy = 100, 100 + 6*math.sin(math.rad(15*char.i+b))
					x, y = char.center, char.middle
					b = b + 5
				end
				
				l.text = string.format("{\\an5\\blur3\\bord2\\shad0\\fscx%.3f\\fscy%.3f\\alpha%s\\1c&HFBE79C&\\3c&H9B7036&\\pos(%.3f, %.3f)}%s"
				,scx,scy,alpha,x,y,char.text)
				
				io.write_line(l)
			end
		end
	end
	
	for si,syl in ipairs(line.syls) do
		
		if syl.text~=" " then
			--text fx 2
			
			local max_frame = 25
			
			l.layer = 4
			
			for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
				
				l.start_time = s
				l.end_time = e + 250
				
				local step = i / n
				
				local sc = utils.interpolate(step, 130, 100) + math.randomsteps(-10, 10, 5)
				local blur = 3 + 3*math.sin(math.rad(utils.interpolate(step, 0, 180)))
				local bord = 0.5*math.sin(math.rad(utils.interpolate(step, 1, 180)))
				
				local bzx1, bzy1 = 0, 0
				local bzx2, bzy2 = 15, 0
				local bzx3, bzy3 = -15, 0
				local bzx4, bzy4 = 0, 0
				
				local bzpoint = math.bezier(step,
				{
				{bzx1, bzy1},
				{bzx2, bzy2},
				{bzx3, bzy3},
				{bzx4, bzy4}
				}
				)
				
				local frz = bzpoint[1]
				local x, y = syl.center, syl.middle
				local orgx, orgy = syl.center, syl.bottom
				
				l.text = string.format("{\\an5\\blur0.6\\bord0.5\\shad0\\fscx%.3f\\fscy%.3f\\frz%.3f\\fad(0,250)\\1a&HFF&\\3c&H9B7036&\\pos(%.3f, %.3f)\\org(%.3f, %.3f)}%s"
				,sc,sc,frz,x,y,orgx,orgy,syl.text)
				
				io.write_line(l)
			end
		end
		
		if syl.text~=" " then
			--stars effect
			
			local max_frame = 150
			
			l.layer = math.randomsteps(3, 6, 3)
			
			for s, e, i, n in utils.frames(line.start_time+syl.start_time - 150, line.start_time+syl.end_time, max_frame) do
				
				local star = shape.star(4, 2, 8)
				
				local rs = math.randomsteps(0, 250, 50)
				
				l.start_time = s + rs
				l.end_time = e + rs + 500
				
				local step = i / n
				
				local x, y = math.random(syl.left, syl.right), math.random(syl.top, syl.bottom)
				
				l.text = string.format("{\\an5\\p1\\blur3\\bord0.1\\shad0\\fscx50\\fscy50\\fad(150,150)\\1c&HFFFFFF&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
				,x,y,star)
				
				io.write_line(l)
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	kara(line, table.copy(line) )
	
	io.progressbar(li / #lines)
end