--Fate/kaleid liner PRISMA ILLYA Zwei! OP TL
--Karaoke by Amberdrake
--VSFilter

function romanji(line, l)
	
		line.infade = 50
		line.outfade = 50

	if line.style == "OP_TL" then

			if line.text~="" then
				--infade
				l.layer = 8
				
				l.start_time = line.start_time
				l.end_time = line.end_time
				
				l.text = string.format("{\\an5\\blur0.6\\bord0\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\fad(50,50)\\pos(%.3f, %.3f)}%s"
				,line.center,line.middle,line.text)
				
				io.write_line(l)
			end
			
			if line.text~="" then
				--infade outline 1
				l.layer = 6
				
				l.start_time = line.start_time
				l.end_time = line.end_time
				
				l.text = string.format("{\\an5\\blur1\\bord2.5\\shad0\\fscx100\\fscy100\\fscy100\\1c&H9F0A83&\\3c&H9F0A83&\\fad(50,50)\\pos(%.3f, %.3f)}%s"
				,line.center,line.middle,line.text)
				
				io.write_line(l)
			end
			
			if line.text~="" then
				--infade outline 1
				l.layer = 5
				
				l.start_time = line.start_time
				l.end_time = line.end_time
				
				l.text = string.format("{\\an5\\blur1.5\\bord3\\shad0\\fscx100\\fscy100\\1c&HFF9CFF&\\3c&HFF9CFF&\\fad(50,50)\\pos(%.3f, %.3f)}%s"
				,line.center,line.middle,line.text)
				
				io.write_line(l)
			end
		end
end

for li, line in ipairs(lines) do
	
	romanji( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end