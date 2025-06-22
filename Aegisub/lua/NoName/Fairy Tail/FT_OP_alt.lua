function kara (line, l)
	if line.infade > 500 then
		line.infade = 250
	end
	if line.outfade > 500 then
		line.outfade = 250
	end
	
	if line.style == "OP_romanji_alt" then
		
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" then
				--alt infade
				l.start_time = line.start_time-line.infade+25*char.i-25
				l.end_time = line.start_time+char.start_time
				
				l.layer = 3
				
				l.text = string.format("{\\an5\\blur2\\bord3\\shad0\\fscx0\\fscy100\\t(0,250,\\fscx100)\\fad(100,0)\\1c&HFFFFF7&\\3c&HA6794B&\\pos(%.3f, %.3f)}%s"
				,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--alt outfade
				l.start_time = line.start_time+char.end_time
				l.end_time = line.end_time+25*char.i-25
				
				l.layer = 3
				
				of_start = l.end_time-l.start_time-250
				of_end = l.end_time-l.start_time
				
				l.text = string.format("{\\an5\\blur2\\bord3\\shad0\\fscx100\\fscy100\\fad(0,100)\\t(%d,%d,\\fscx0)\\1c&HFFFFF7&\\3c&HA6794B&\\pos(%.3f, %.3f)}%s"
				,of_start,of_end,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
		end
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--alt effect
				l.start_time = line.start_time+syl.start_time
				l.end_time = line.start_time+syl.end_time
				
				l.layer = 4
				
				l.text = string.format("{\\an5\\blur2\\bord6\\shad0\\fscx120\\fscy120\\1c&HFFFFF7&\\3c&HFFFFFF&\\t(\\bord3\\fscx100\\fscy100\\3c&HA6794B&)\\move(%.3f, %.3f, %.3f, %.3f)}%s"
				,syl.center,syl.middle-15,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
		end
	end
end

for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end