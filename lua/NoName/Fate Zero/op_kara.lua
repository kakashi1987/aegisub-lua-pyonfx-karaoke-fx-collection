function romaji(line, l)
--Fate/Zero Opening 01
--Karaoke by Amberdrake

	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=1
				
			l.start_time=(line.start_time+25*syl.i)-750
			l.end_time=line.start_time
			
			
			l.text=string.format("{\\an5\\blur5\\1c&H0000FF&\\fad(%d,0)\\frz45\\t(\\blur3\\frz0)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
			,syl.duration,syl.center-25,syl.middle-25,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end
	
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=1
				
			l.start_time=line.start_time
			l.end_time=line.start_time+syl.start_time
			
			
			l.text=string.format("{\\an5\\blur3\\1c&H0000FF&\\t(0,250,\\blur0.4)\\pos(%.3f,%.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end
	
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=2
				
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.start_time+syl.end_time
			
			
			l.text=string.format("{\\an5\\blur0.4\\1c&H0000FF&\\t(0,%d,\\1c&HFFFFFF&)\\pos(%.3f,%.3f)}%s"
			,syl.duration/4,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end
	
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=1
				
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.start_time+syl.end_time+600
			
			
			l.text=string.format("{\\an5\\blur1\\bord1\\1a&HFF&\\1c&HFFFFFF&\\3c&HFFFFFF&\\t(\\fscx110\\fscy110)\\fad(0,500)\\pos(%.3f,%.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end
	
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=1
				
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.start_time+syl.end_time+600
			
			
			l.text=string.format("{\\an5\\blur1\\bord1\\1a&HFF&\\1c&HFFFFFF&\\3c&HFFFFFF&\\t(\\fscx120\\fscy120)\\fad(0,500)\\pos(%.3f,%.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end
	
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=1
				
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.start_time+syl.end_time+600
			
			
			l.text=string.format("{\\an5\\blur1\\bord1\\1a&HFF&\\1c&HFFFFFF&\\3c&HFFFFFF&\\t(\\fscx130\\fscy130)\\fad(0,500)\\pos(%.3f,%.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end	
	
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=1
				
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.start_time+syl.end_time+600
			
			
			l.text=string.format("{\\an5\\blur1\\bord1\\1a&HFF&\\1c&HFFFFFF&\\3c&HFFFFFF&\\t(\\fscx140\\fscy140)\\fad(0,500)\\pos(%.3f,%.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end
	
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=1
				
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.start_time+syl.end_time+600
			
			
			l.text=string.format("{\\an5\\blur1\\bord1\\1a&HFF&\\1c&HFFFFFF&\\3c&HFFFFFF&\\t(\\fscx150\\fscy150)\\fad(0,500)\\pos(%.3f,%.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end	
	
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=1
				
			l.start_time=line.start_time+syl.end_time
			l.end_time=line.end_time-250
			
			l.text=string.format("{\\an5\\blur0.4\\1c&HFFFFFF&\\t(0,350,\\1c&H0000FF&)\\pos(%.3f,%.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end
	
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=1
				
			l.start_time=line.end_time-250
			l.end_time=line.end_time
			
			l.text=string.format("{\\an5\\blur0.4\\1c&H0000FF&\\t(0,250,\\blur3)\\pos(%.3f,%.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end	
	
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=1
				
			l.start_time=line.end_time
			l.end_time=(line.end_time-25*syl.i)+750
			
			
			l.text=string.format("{\\an5\\blur3\\1c&H0000FF&\\fad(0,%d)\\frz0\\t(\\blur5\\frz-45)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
			,syl.duration,syl.center,syl.middle,syl.center+25,syl.middle+25,syl.text)
			
			
			io.write_line(l)
		end
	end
end

for li, line in ipairs(lines) do
	
	romaji( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end