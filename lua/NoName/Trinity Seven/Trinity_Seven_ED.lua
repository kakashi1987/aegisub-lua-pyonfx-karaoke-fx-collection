--Trinity Seven ED
--Effects by Amberdrake
--VSFilter

function kara(line, l)
	
	if line.infade > 500 then
		line.infade = 500
	end
	if line.outfade > 500 then
		line.outfade = 500
	end
	
	for si,syl in ipairs(line.syls) do
		
		if syl.text~="" then
			
			if syl.text~="" and syl.text~=" " then
				--infade
				
				l.layer = 5
				
				l.start_time = line.start_time+syl.start_time-300+15*syl.i-15
				l.end_time = line.start_time+syl.start_time
				
				local sx1, sy1 = syl.left - math.randomsteps(15, 30, 5)-100, math.random(syl.top - 5, syl.bottom + 5)
				local sx2, sy2 = math.random(syl.left-40, syl.right+40), syl.top-math.random(25,50)
				local sx3, sy3 = syl.center + math.random(-40, 40), syl.middle + math.random(-35, 40)
				local sx4, sy4 = syl.center, syl.bottom+math.random(30,60)
				
				local ex1, ey1 = syl.center, syl.middle-math.randomsteps(25,50,0.5)
				local ex2, ey2 = math.random(syl.left-40, syl.right+40), math.random(syl.top-35, syl.bottom+40)
				local ex3, ey3 = syl.center + math.random(-40, 40), syl.middle + math.random(-35, 40)
				local ex4, ey4 = syl.right + math.randomsteps(15, 30, 5)+100, syl.middle + math.randomsteps(30,55,0.5)
				
				for pi, pixel in ipairs( convert.text_to_pixels(syl.text, line.styleref) ) do
					
					local rd1 = math.randomsteps(0, 1, 0.05)
					local spoint = math.bezier(rd1,
					{
					{sx1, sy1},
					{sx2, sy2},
					{sx3, sy3},
					{sx4, sy4}
					}
					)
					local x1, y1 = spoint[1], spoint[2]
					
					local rd2 = math.randomsteps(0, 1, 0.1)
					local epoint = math.bezier(rd2,
					{
					{ex1, ey1},
					{ex2, ey2},
					{ex3, ey3},
					{ex4, ey4}
					}
					)
					local x2, y2 = epoint[1], epoint[2]
					
					local rd3 = math.randomsteps(0, 1, 0.01)
					local rd4 = math.randomsteps(0, 1, 0.02)
					local x3, y3 = utils.interpolate(rd3, x1, x2), utils.interpolate(rd4, y1, y2)
					local x4, y4 = syl.left + pixel.x, syl.top + pixel.y
					
					local rf = math.randomsteps(100, 250, 25)
					
					l.text=string.format("{\\p1\\an5\\blur3\\t(\\blur0.6)\\bord0\\shad0\\fscx100\\fscy100\\1c&H6FDBF6&\\3c&H000000&\\fad(%d,0)\\move(%.3f, %.3f, %.3f, %.3f)}m 0 0 l 1 0 1 1 0 1"
					,rf,x3,y3,x4,y4)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" and syl.text~=" " then
				--text placeholder
				
				local max_frame = 24
				local a = 0
				local u_in, u_out = 0, 0
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.end_time-line.outfade+50*syl.i, max_frame) do
					l.layer = 5
					
					l.start_time = s
					l.end_time = e
					
					if syl.i%2 == 1 then
						xe = syl.middle - 20
					else
						xe = syl.middle + 20
					end
					
					local infad, outfad = 100, 250
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					if i<math.ceil(infad/max_frame) then
						x, y = syl.center, syl.middle
						alpha = "&H00&"
						u_in=u_in+1
					elseif i>(n-math.ceil(outfad/max_frame)) then
						alpha = "&H00&"
						x, y = syl.center, syl.middle
						u_out=u_out+1
					elseif s >= (line.start_time+syl.start_time) and s <= (line.start_time + syl.start_time + syl.duration) then
						alpha = "&H00&"
						x, y = syl.center, syl.middle
					else
						alpha = "&H00&"
						x, y = syl.center, syl.middle
					end
					
					l.text=string.format("{\\an5\\blur2\\bord2\\shad0\\fscx100\\fscy100\\alpha%s\\1c&H6FDBF6&\\3c&H000000&\\pos(%.3f, %.3f)}%s"
					,alpha,x,y,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" and syl.text~=" " then
				--outfade
				
				l.layer = 5
				
				l.start_time = line.end_time-line.outfade+50*syl.i
				l.end_time = line.end_time-line.outfade+50*syl.i+250
				
				for pi, pixel in ipairs( convert.text_to_pixels(syl.text, line.styleref) ) do
					
					local sx1, sy1 = syl.left - math.randomsteps(25, 35, 5)-50, math.random(syl.top - 25, syl.bottom + 25)
					local sx2, sy2 = math.random(syl.left-20, syl.right+20), math.random(syl.top-15, syl.bottom+20)
					local sx3, sy3 = syl.center + math.random(-20, 20), syl.middle + math.random(-25, 20)
					local sx4, sy4 = syl.center + math.random(-5, 5), syl.middle + math.random(-15, 10)
					
					local ex1, ey1 = syl.center + math.random(-10, 10), syl.middle + math.random(-5, 5)
					local ex2, ey2 = math.random(syl.left-40, syl.right+40), math.random(syl.top-35, syl.bottom+40)
					local ex3, ey3 = syl.center + math.random(-40, 40), syl.middle + math.random(-35, 40)
					local ex4, ey4 = syl.right + math.randomsteps(15, 30, 5)-75, syl.middle + math.randomsteps(-15, 15, 5)
					
					local rd1 = math.randomsteps(0, 1, 0.05)
					local spoint = math.bezier(rd1,
					{
					{sx1, sy1},
					{sx2, sy2},
					{sx3, sy3},
					{sx4, sy4}
					}
					)
					local x1, y1 = spoint[1], spoint[2]
					
					local rd2 = math.randomsteps(0, 1, 0.1)
					local epoint = math.bezier(rd2,
					{
					{ex1, ey1},
					{ex2, ey2},
					{ex3, ey3},
					{ex4, ey4}
					}
					)
					local x2, y2 = epoint[1], epoint[2]
					
					local rd3 = math.randomsteps(0.5, 1, 0.1)
					local rd4 = math.randomsteps(0.5, 1, 0.1)
					local x3, y3 = utils.interpolate(rd3, x1, x2), utils.interpolate(rd4, y1, y2)
					local x4, y4 = syl.left + pixel.x, syl.top + pixel.y
					
					local rf = math.randomsteps(50, 150, 25)
					
					l.text=string.format("{\\p1\\an5\\blur0.6\\t(\\blur3)\\bord0\\shad0\\fscx100\\fscy100\\1c&H6FDBF6&\\3c&H000000&\\fad(0,%d)\\move(%.3f, %.3f, %.3f, %.3f)}m 0 0 l 1 0 1 1 0 1"
					,rf,x4,y4,x3,y3)
					
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