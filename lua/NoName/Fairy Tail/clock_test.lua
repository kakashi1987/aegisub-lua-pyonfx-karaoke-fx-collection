--TEST

function kara (line, l)
	
	line.infade = 150
	
	line.outfade = 150
	
	for si,syl in ipairs(line.syls) do
		
		if syl.text~="" and syl.i == 1 then
			--particle
			local shape_source = shape.ellipse(200,200)
			local source_split = shape.split(shape_source, 1)
			local source_outline = shape.tooutline(source_split, 2)
			local particle = shape.star(4,2,4)
			
			local max_frame = 23.976
			local u_in, u_out = 0, 0
			
			for s, e, i, n in utils.frames(line.start_time-line.infade, line.end_time+line.outfade, max_frame) do
				
				local fad = 250
				local max = math.ceil(fad/max_frame)
				if i < math.ceil(fad/max_frame) then
					alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
					u_in = u_in + 1
				elseif i > (n-math.ceil(fad/max_frame)) then
					alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
					u_out = u_out + 1
				else
					alpha = "&H00&"
				end
				
				for pi, pixel in ipairs(convert.shape_to_pixels(source_outline)) do
					
					l.layer=1
					
					l.start_time=s
					l.end_time=e
					
					local step = i / n
					
					if line.i%2 == 0 then
						xs = line.left - 30
						xshift = utils.interpolate(step, 0, -50)
						yshift = utils.interpolate(step, 0, 25)
						mod = 1
					else
						xs = line.right + 30
						xshift = utils.interpolate(step, 0, 50)
						yshift = utils.interpolate(step, 0, -25)
						mod = -1
					end
					
					local x, y = xs + pixel.x + xshift + math.randomsteps(-1, 1, 0.1), line.middle + pixel.y + yshift + math.randomsteps(-1, 1, 0.1)
					
					l.text=string.format("{\\p1\\an7\\blur1.5\\bord0.1\\fscx50\\fscy50\\alpha%s\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f, %.3f)}%s"
					,alpha,x,y,particle)
					
					io.write_line(l)
				end
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end