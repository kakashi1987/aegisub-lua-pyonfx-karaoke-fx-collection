function kara(line, l)
	--Noragami Opening
	--Karaoke by Amberdrake
	
	for si,syl in ipairs(line.syls) do
		
		if line.style == OP_Kanji then
			
			if syl.text~="" then
				
				l.layer=2
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord0\\blur1.5\\1c&HFFFFFF\\fad(250,0)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
		
		if line.style == OP_Romanji then
			
			if syl.text~="" then
				
				l.layer=2
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord0\\blur1.5\\1c&HFFFFFF\\fad(250,0)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
		
		if line.style == OP_Kanji_right then
			
			if syl.text~="" then
				
				l.layer=2
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord0\\blur1.5\\1c&HFFFFFF\\fad(250,0)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
		
		if line.style == OP_Romanji_right then
			
			if syl.text~="" then
				
				l.layer=2
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord0\\blur1.5\\1c&HFFFFFF\\fad(250,0)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
		
		if line.style == Chikutaku_kanji then
			
			if syl.text~="" then
				
				l.layer=2
				
				l.start_time=line.start_time+50*syl.i+line.infade/8
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord0\\blur1.5\\1c&H0000FF\\fad(250,0)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
		
		if line.style == Chikutaku_romanji then
			
			if syl.text~="" then
				
				l.layer=2
				
				l.start_time=line.start_time+50*syl.i+line.infade/8
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord0\\blur1.5\\1c&H0000FF\\fad(250,0)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
		
		if line.style == OP_Hey then
			
			if syl.text~="" then
				
				l.layer=2
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord0\\blur1.5\\1c&HFF0000\\fad(250,0)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
	end
end

for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end