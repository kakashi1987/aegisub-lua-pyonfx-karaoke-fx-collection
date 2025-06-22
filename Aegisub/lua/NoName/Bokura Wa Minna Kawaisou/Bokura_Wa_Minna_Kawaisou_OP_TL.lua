--Bokura wa Minna Kawaisou Opening
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	line.infade = 500
	line.outfade = 500
	
	for si,syl in ipairs(line.syls) do

			if syl.text~="" then
				--circle syl fx
				
				l.layer = 2
				
				l.start_time = line.start_time + 100*syl.i - 100
				l.end_time = line.end_time + 250
				
				local x1, y1 = syl.center - 35, syl.middle - 35
				local x2, y2 = syl.center, syl.middle
				
				l.text = string.format("{\\an5\\bord0\\blur5\\shad0\\fad(150,250)\\fscx150\\fscy150\\t(0,250,\\blur0.8\\fscx100\\fscy100)\\1c&H000000&\\3c&H000000&\\move(%.3f, %.3f, %.3f, %.3f, 0, 250)}%s"
				,x1,y1,x2,y2,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--circle fx
				
				l.layer = 1
				
				l.start_time = line.start_time + 100*syl.i - 200
				l.end_time = line.end_time + 250
				
				local r = (syl.width+syl.height)/2
				local circle = shape.ellipse(r+15, r+15)
				
				local x1, y1 = syl.center - 25, syl.middle - 25
				local x2, y2 = syl.center - 3, syl.middle + 3
				
				l.text = string.format("{\\p1\\an5\\bord2.5\\blur1.2\\shad0\\fad(150,250)\\fscx130\\fscy130\\t(0,250,\\fscx100\\fscy100)\\1c&HFFFFFF&\\3c&H000000&\\move(%.3f, %.3f, %.3f, %.3f, 0, 250)}%s"
				,x1,y1,x2,y2,circle)
				
				io.write_line(l)
			end
		
	end
end
for li, line in ipairs(lines) do
	
	kara(line, table.copy(line) )
	
	io.progressbar(li / #lines)
end