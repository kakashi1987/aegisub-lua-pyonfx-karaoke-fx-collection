function kara(line, l)
	--Noragami Ending
	--Karaoke by Amberdrake
	
	for si, syl in pairs(line.syls) do
		
		local l = table.copy(line)
		
		for pi, pixel in ipairs( convert.text_to_pixels(syl.text, line.styleref) ) do
			
			x = syl.left + pixel.x
			y = syl.top + pixel.y
			
			l.start_time=line.start_time-750
			l.end_time=line.start_time+1500
			
			random_pos = math.random(-10,10)
			random_layer = math.random(3,6)
			
			alpha_array = {"&HFF&" , "&HFF&" , "&HFF&" , "&HFF&" ,"&HFF&" , "&HFF&" , "&H00&" }
			random_alpha=alpha_array[math.random(1,table.getn(alpha_array))]
			
			l.text = string.format("{\\an7\\bord0\\blur1.2\\1c&HFFFFFF&\\1a%s\\fscx30\\fscy30\\move(%.3f,%.3f,%.3f,%.3f)\\fad(0,%d)\\p1}m 0 0 l 1 1 l 2 1 l 4 1 l 5 0 l 5 -1 l 6 -2 l 5 -3 l 5 -3 l 4 -4 l 2 -4 l 1 -4 l 1 -4 l 0 -3 l 0 -2 "
			,random_alpha,x+random_pos,y-30+random_pos,x+random_pos,y+20+random_pos,syl.duration)
			l.layer=random_layer
			io.write_line(l)
		end
		
	end
	
	for si, syl in pairs(line.syls) do
		
		local l = table.copy(line)
		
		for pi, pixel in ipairs( convert.text_to_pixels(syl.text, line.styleref) ) do
			
			x = syl.left + pixel.x
			y = syl.top + pixel.y
			
			l.start_time=line.start_time
			l.end_time=line.start_time+syl.start_time
			
			random_pos = math.random(-1,1)
			random_layer = math.random(3,6)
			random_fad_mult = math.random(1,3)
			random_fad = random_fad_mult*400
			
			alpha_array = {"&HFF&" , "&HFF&" , "&HFF&" , "&HFF&" ,"&HFF&" , "&HFF&" , "&H00&" }
			random_alpha=alpha_array[math.random(1,table.getn(alpha_array))]
			
			l.text = string.format("{\\an7\\bord0\\blur1.2\\1c&HFFFFFF&\\1a%s\\fscx30\\fscy30\\fad(%d,0)\\pos(%.3f,%.3f)\\p1}m 0 0 l 1 1 l 2 1 l 4 1 l 5 0 l 5 -1 l 6 -2 l 5 -3 l 5 -3 l 4 -4 l 2 -4 l 1 -4 l 1 -4 l 0 -3 l 0 -2 "
			,random_alpha,random_fad,x+random_pos,y+random_pos)
			l.layer=random_layer
			io.write_line(l)
		end
		
	end
	
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
			
			l.layer=2
			
			l.start_time=line.start_time
			l.end_time=line.start_time+syl.start_time
			
			l.text=string.format("{\\an5\\bord0\\blur1.5\\1c&HFFFFFF\\fad(500,0)\\pos(%.3f,%.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
			
		end
		
	end
	
	for ci,char in ipairs(line.chars) do
		if char.text~="" then
			
			l.layer=1
			
			l.start_time=line.start_time+char.start_time
			l.end_time=line.start_time+char.end_time
			
			l.text=string.format("{\\an5\\blur3\\be2\\bord1\\1c&HFFFFFF&\\3c&HFFFFFF&\\1a&HFF&\\3a&H4B&\\fscx100\\fscy100\\t(\\fscy130\\bord3)\\fad(%d,%d)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
			,char.duration/4,char.duration/2,char.center,char.middle,char.center,char.middle-3,char.text)
			
			io.write_line(l)
			
		end
		
	end
	
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
			
			l.layer=2
			
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.end_time
			
			l.text=string.format("{\\an5\\blur1\\1c&HFFFFFF&\\alpha&H32&\\fad(0,500)\\pos(%.3f,%.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
			
		end
		
	end
	
	for si, syl in pairs(line.syls) do
		
		local l = table.copy(line)
		
		for pi, pixel in ipairs( convert.text_to_pixels(syl.text, line.styleref) ) do
			
			x = syl.left + pixel.x
			y = syl.top + pixel.y
			
			random_xmove = math.random(-10,10)
			random_ymove = math.random(20,50)
			
			x_move = syl.left + 2*pixel.x + random_xmove
			y_move = syl.top + pixel.y + random_ymove
			
			random_fad = math.random(0,30)
			random_pos = math.random(-1,1)
			random_layer = math.random(3,6)
			
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.start_time+syl.end_time+1000
			
			alpha_array = {"&HFF&" , "&HFF&" , "&HFF&" , "&HFF&" ,"&HFF&" , "&HFF&" , "&H00&" }
			random_alpha=alpha_array[math.random(1,table.getn(alpha_array))]
			
			l.text = string.format("{\\an7\\bord0\\blur1.2\\1c&HFFFFFF&\\1a%s\\fscx30\\fscy30\\fad(0,%d)\\move(%.3f,%.3f,%.3f,%.3f)\\p1}m 0 0 l 1 1 l 2 1 l 4 1 l 5 0 l 5 -1 l 6 -2 l 5 -3 l 5 -3 l 4 -4 l 2 -4 l 1 -4 l 1 -4 l 0 -3 l 0 -2 "
			,random_alpha,3*syl.duration/4-random_fad,x+random_pos,y+random_pos,x_move,y_move)
			l.layer=random_layer
			io.write_line(l)
		end
		
	end
	
end

for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end