function kara (line, l)
	if line.infade > 500 then
		line.infade = 250
	end
	if line.outfade > 500 then
		line.outfade = 250
	end
	
	if line.style == "OP_romanji_stars" then
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--stars infade/outfade
				l.start_time = line.start_time-line.infade
				l.end_time = line.end_time+line.outfade
				
				l.layer = 6
				
				l.text = string.format("{\\an5\\blur3\\bord2\\shad0\\fscx100\\fscy100\\1a&HFF&\\3a&HFF&\\1c&HFFFFFF&\\3c&HE0CBC8&\\t(0,250,\\1a&H00&\\3a&H64&\\1c&H54251C&)\\fad(0,250))\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~=" " then
				--stars infade effect
				
				max_frame = 25
				
				for s, e, i, n in utils.frames(line.start_time-250, line.start_time, max_frame) do
					
					local star = shape.star(6, 2, 6)
					
					rs = math.randomsteps(0,175,25)
					
					l.start_time = s + rs
					l.end_time = e + rs + 100
					
					l.layer = 8
					
					step = i / n
					
					bord = 3*math.sin(math.rad(utils.interpolate(step, 90, 180)))
					sc = utils.interpolate(step, 80, 60)
					
					x = math.random(line.left, line.right)
					y = math.random(line.top, line.bottom)
					
					l.text = string.format("{\\an5\\p1\\blur3\\bord%d\\shad0\\fscx%d\\fscy%d\\fad(0,100)\\3a&H64&\\1c&HFFFFFF&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
					,bord,sc,sc,x,y,star)
					
					io.write_line(l)
				end
				
				if syl.text~="" then
					--stars syl effect
					
					maxj = 3
					for j = 1, maxj, 1 do
						
						max_frame=25
						u_in=0
						a=0
						
						for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
							
							l.start_time = s
							l.end_time = e+50
							
							l.layer = 8
							
							step = i / n
							
							sc = 110 + j*20*math.sin(math.rad(utils.interpolate(step, 0 , 90))) + 3*math.sin(math.rad(a))
							a = a + 90
							
							l.text = string.format("{\\an5\\blur3\\bord2\\shad0\\fscx%d\\fscy%d\\fad(0,50)\\1a&HFF&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
							,sc,sc,syl.center,syl.middle,syl.text)
							
							io.write_line(l)
						end
					end
					
				end
				
			end
		end
		
		for ci,char in ipairs(line.chars) do
			if char.text~=" " then
				--stars particle border test
				
				local text_shape = convert.text_to_shape(char.text, line.styleref)
				local text_outline_shape = shape.tooutline(shape.split(text_shape), 1)
				local text_outline_pixels = convert.shape_to_pixels(text_outline_shape, true)
				local star = shape.ellipse(3,3)
				
				local l = table.copy(line)
				
				for pi, pixel in ipairs(text_outline_pixels) do
					
					l.start_time = line.start_time-line.infade
					l.end_time = line.end_time+line.outfade
					
					l.layer = math.random(5,7)
					
					x = char.left + pixel.x + math.random(-1,1)
					y = char.top + pixel.y + math.random(-1,1)
					
					alpha_array = {"&HFF&" , "&H00&" , "&HFF&" , "&HFF&" , "&HFF&" , "&HFF&"}
					alpha=alpha_array[math.random(1,table.getn(alpha_array))]
					
					l.text = string.format("{\\an5\\p1\\blur3\\bord0.5\\shad0\\fscx50\\fscy50\\alpha%s\\fad(250,250)\\1c&HFFFFFF&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
					,alpha,x,y,star)
					
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