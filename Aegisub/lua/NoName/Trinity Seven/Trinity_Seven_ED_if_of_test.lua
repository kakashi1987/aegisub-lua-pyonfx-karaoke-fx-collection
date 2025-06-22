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
				--if test
				
				l.layer = 5
				
				l.start_time = line.start_time+syl.start_time-500
				l.end_time = line.start_time+syl.start_time
				
				for pi, pixel in ipairs( convert.text_to_pixels(syl.text, line.styleref) ) do
					
					local sx1, sy1 = syl.left - math.randomsteps(15, 30, 5)-100, math.random(syl.top - 5, syl.bottom + 5)
					local sx2, sy2 = math.random(syl.left-40, syl.right+40), math.random(syl.top-35, syl.bottom+40)
					local sx3, sy3 = syl.center + math.random(-40, 40), syl.middle + math.random(-35, 40)
					local sx4, sy4 = syl.center, syl.middle
					
					local ex1, ey1 = syl.center, syl.middle
					local ex2, ey2 = math.random(syl.left-40, syl.right+40), math.random(syl.top-35, syl.bottom+40)
					local ex3, ey3 = syl.center + math.random(-40, 40), syl.middle + math.random(-35, 40)
					local ex4, ey4 = syl.right + math.randomsteps(15, 30, 5)+100, syl.middle + math.randomsteps(-15, 15, 5)
					
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
					
					local rf = math.randomsteps(100, 250, 25)
					
					l.text=string.format("{\\p1\\an5\\blur0.1\\bord0.1\\shad0\\fscx100\\fscy100\\1c&H6FDBF6&\\3c&H000000&\\fad(%d,0)\\move(%.3f, %.3f, %.3f, %.3f)}m 0 0 l 1 0 1 1 0 1"
					,rf,x3,y3,x4,y4)
					
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