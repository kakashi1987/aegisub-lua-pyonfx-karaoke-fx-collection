function romaji(line, l)
--Fate/Zero Ending 01
--Karaoke by Amberdrake

	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=1
				
			l.start_time=line.start_time+25*syl.i-line.infade/8
			l.end_time=line.start_time+syl.start_time
			
			
			l.text=string.format("{\\an5\\blur2\\bord0\\1c&H9FC8E4&\\frx90\\t(0,250,\\blur1\\bord1\\frx0)\\pos(%.3f,%.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end



	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=1
				
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.start_time+syl.end_time
			
			
			l.text=string.format("{\\an5\\blur1\\bord1\\1c&H9FC8E4&\\3c&H000000&\\fscx100\\fscy100\\t(0,%d,\\fscx120\\fscy120)\\t(%d,%d,\\fscx100\\fscy100)\\pos(%.3f,%.3f)}%s"
			,syl.duration/2,syl.duration/2,syl.duration,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end
	
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
		
			l.layer=2
				
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.start_time+syl.end_time+250
			
			
			l.text=string.format("{\\an5\\blur1\\bord1\\1a&HFF&\\3c&H9FC8E4&\\fscx100\\fscy100\\t(\\fscx130\\fscy130\\bord3)\\fad(100,250)\\pos(%.3f,%.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			
			io.write_line(l)
		end
	end	
	

	for ci,char in ipairs(line.chars) do
		if char.text~="" then
		
			l.layer=1
				
			l.start_time=line.start_time+char.end_time
			l.end_time=line.end_time+25*char.i+line.outfade/8
			
			
			l.text=string.format("{\\an5\\blur1\\bord1\\1c&H9FC8E4&\\fad(0,250)\\pos(%.3f,%.3f)}%s"
			,char.center,char.middle,char.text)
			
			
			io.write_line(l)
		end
	end	
	
end
	
for li, line in ipairs(lines) do
	
	romaji( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end