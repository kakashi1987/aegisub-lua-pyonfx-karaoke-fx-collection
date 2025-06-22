--Seirei Tsukai no Blade Dance ED
--Karaoke by Amberdrake
--VSFilter

function romanji(line, l)
	
	if line.infade > 500 then
		line.infade = 250
	end
	if line.outfade > 500 then
		line.outfade = 250
	end
	
	if line.style == "ED_high" then
		
		for si,syl in ipairs(line.syls) do
			
			local x, y = 1160 ,38
			
			if syl.text~="" then
				--infade
				
				l.layer = 5
				
				l.start_time = line.start_time+syl.start_time
				l.end_time = line.start_time+syl.end_time
				
				l.text = string.format("{\\an5\\blur0.4\\bord0\\shad0\\fscx100\\fscy100\\fsp0\\t(\\fscx135\\fscy130\\blur1.2\\fsp4)\\fad(0,%d)\\1c&H923E27&\\pos(%.3f, %.3f)}%s"
				,syl.duration/4,x,y,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--infade outline 1
				
				l.layer = 4
				
				l.start_time = line.start_time+syl.start_time
				l.end_time = line.start_time+syl.end_time
				
				l.text = string.format("{\\an5\\blur0.6\\bord3\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&HFFFFFF&\\t(\\fscx140\\fscy140\\blur2)\\fad(0,%d)\\pos(%.3f, %.3f)}%s"
				,syl.duration/3,x,y,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--infade outline 2
				
				l.layer = 3
				
				l.start_time = line.start_time+syl.start_time
				l.end_time = line.start_time+syl.end_time
				
				l.text = string.format("{\\an5\\blur1\\bord7\\shad4\\fscx100\\fscy100\\1c&H762907&\\3c&H762907&\\4c&HC0DAA1&\\4a&H32&\\t(\\fscx150\\fscy150\\blur3)\\fad(0,%d)\\pos(%.3f, %.3f)}%s"
				,syl.duration/2,x,y,syl.text)
				
				io.write_line(l)
			end
		end
	end
end

for li, line in ipairs(lines) do
	
	romanji( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end