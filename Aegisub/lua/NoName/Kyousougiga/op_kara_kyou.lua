function romaji(line, l)

	
	math.randomseed(8317)

	

	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=1
			
			
			l.start_time=line.start_time+50*syl.i-line.infade/4
			l.end_time=line.start_time+syl.start_time
			
			
			l.text=string.format("{\\an5\\bord0\\shad2\\blur20\\1a&HFF\\3a&HFF&\\4c&H000000&\\fscx0\\fscy100\\pos(%.3f,%.3f)\\fad(10,0)\\t(1,25,\\fscx100\\blur0)}%s"
			,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=2
			
			
			l.start_time=line.start_time+50*syl.i-line.infade/4
			l.end_time=line.start_time+syl.start_time
			
			
			l.text=string.format("{\\an5\\bord2\\shad0\\blur20\\1a&HFF&\\4&HFF&\\3c&H000000&\\fscx0\\fscy100\\pos(%.3f,%.3f)\\fad(10,0)\\t(1,25,\\fscx100\\blur0)}%s"
			,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=2
			
			
			l.start_time=line.start_time+50*syl.i-line.infade/4
			l.end_time=line.start_time+syl.start_time
			
			
			l.text=string.format("{\\an5\\bord0\\shad0\\blur20\\3a&HFF&\\4a&HFF&\\1c&HFFFFFF&\\fscx0\\fscy100\\pos(%.3f,%.3f)\\fad(10,0)\\t(1,25,\\fscx100\\blur0)}%s"
			,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end
	

	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
			
			l.layer=3
			
			
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.start_time+syl.end_time
			
			
			l.text=string.format("{\\an5\\bord2\\shad2\\blur0.4\\1c&HFFFFFF&\\3c&H000000&\\4c&H000000&\\fscx100\\fscy100\\pos(%.3f,%.3f)\\t(\\fscy200)\\t(\\fscy100)}%s"
			,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end
	
	
		for si,syl in ipairs(line.syls) do
		if syl.text~="" then
			
			l.layer=1
			
			
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.start_time+syl.end_time
			
			
			l.text=string.format("{\\an5\\bord1\\shad0\\blur3\\1c&H28C2D8&\\3c&H28C2D8&\\fscx100\\fscy100\\pos(%.3f,%.3f)\\t(\\fscx150\\fscy250)\\fad(0,%d)}%s"
			,syl.center,syl.middle,syl.duration,syl.text)
			
			
			io.write_line(l)
		end
	end

	

	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
			
			l.layer=1
			
			
			l.start_time=line.start_time+syl.end_time
			l.end_time=line.end_time+20*syl.i+line.outfade/3
			
			
			l.text=string.format("{\\an5\\bord2\\shad2\\blur0.4\\1c&HFFFFFF&\\3c&H000000&\\4c&H000000&\\fscx100\\fscy100\\pos(%.3f,%.3f)\\fad(0,50)\\fry0\\t(%d,100,\\fry0)}%s"
			,syl.center,syl.middle,syl.duration,syl.text)
			
			
			io.write_line(l)
		end
	end
end


for li, line in ipairs(lines) do
	
	romaji( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end