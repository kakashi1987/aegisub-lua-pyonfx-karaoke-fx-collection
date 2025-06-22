--Fate/Zero OP2
--Effects by Amberdrake
--VSFilter

function kara(line, l)
	
	line.infade = 250
	line.outfade = 250
	
	for si,syl in ipairs(line.syls) do
		
		if syl.text~="" then
			--text
			
			l.layer = 4
			
			l.start_time = line.start_time-line.infade
			l.end_time = line.end_time+line.outfade
			
			l.text = string.format("{\\an5\\blur1\\bord1\\shad1\\fscx100\\fscy100\\fad(250,250)\\1c&HFFFFFF&\\3c&H000000&\\4c&H000000&\\pos(%.3f, %.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--bezier
			maxj = math.random(3,6)
			for j = 1, maxj, 1 do
				max_frame = 1
				
				local x1, y1 = syl.left, math.random(syl.top, syl.bottom)
				local x2, y2 = math.random(syl.left-40, syl.right+40), math.random(syl.top-35, syl.bottom+40)
				local x3, y3 = syl.center + math.random(-40, 40), syl.middle + math.random(-35, 40)
				local x4, y4 = syl.right, math.random(syl.top, syl.bottom)
				
				local rs = math.randomsteps(line.start_time+syl.start_time, (line.start_time+syl.start_time+line.start_time+syl.end_time)/2, 100)
				local re = math.randomsteps(line.start_time+syl.end_time, line.start_time+syl.end_time+300, 100)
				
				local layer = math.randomsteps(3, 5, 2)
				
				if j%2 == 1 then
					main_color = "&HFFFFFF&"
					bord_color = "&H000000&"
				else
					main_color = "&H000000&"
					bord_color = "&HFFFFFF&"
				end
				
				for s, e, i, n in utils.frames(rs, re, max_frame) do
					
					l.layer = layer
					
					l.start_time=s
					l.end_time=s+250
					
					local step = i / n
					
					local point = math.bezier(step,
					{
					{x1, y1},
					{x2, y2},
					{x3, y3},
					{x4, y4}
					}
					)
					
					local x, y = point[1] , point[2]
					
					l.text=string.format("{\\p1\\an5\\bord0.2\\shad0\\blur2\\fscx100\\fscy100\\t(\\fscx0\\fscy0)\\1c%s\\3c%s\\pos(%.3f,%.3f)}m 0 0 l 1 0 1 1 0 1"
					,main_color,bord_color,x,y)
					
					io.write_line(l)
				end
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	kara(line, table.copy(line) )
	
	io.progressbar(li / #lines)
end