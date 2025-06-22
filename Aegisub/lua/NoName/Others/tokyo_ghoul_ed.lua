--Tokyo Ghoul ED
--Karaoke by Amberdrake
--VSFilter

function romanji(line, l)
	
	if line.infade > 500 then
		line.infade = 250
	end
	if line.outfade > 500 then
		line.outfade = 250
	end
	
	if line.style == "ED_romanji_L" or line.style == "ED_romanji_R" or line.style == "ED_kanji_L" or line.style == "ED_kanji_R" then
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" then
				--fadein
				
				local a = 0
				
				local max_frame = 23.976
				local u_in1, u_in2 = 0, 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+15*char.i-15, line.start_time+char.start_time, max_frame) do
					
					local rp = 0.5*math.sin(math.rad(a))
					
					l.layer=4
					
					l.start_time=s
					l.end_time=e
					
					local fad1, fad2 = 150, 250
					local max1, max2 = math.ceil(fad1/max_frame), math.ceil(fad2/max_frame)
					
					if i<math.ceil(fad1/max_frame) then
						alpha = utils.interpolate(u_in1/max1, "&HFF&", "&H00&")
						u_in1 = u_in1 + 1
					else
						alpha="&H00&"
					end
					
					if i<math.ceil(fad2/max_frame) then
						sx, sy = char.center + math.randomsteps(-2,2,0.5), char.middle - 5*math.sin(math.rad(utils.interpolate(u_in2/max2, 0, 360))) + math.randomsteps(-2,2,0.25)
						u_in2 = u_in2 + 1
					else
						if i%8 == 0 then
							sx, sy = char.center+rp, char.middle+rp
						else
							sx, sy = char.center, char.middle
						end
					end
					
					l.text=string.format("{\\an5\\bord0\\shad0\\blur0\\alpha%s\\1c&H1A2B24&\\fscx100\\fscy100\\pos(%.3f,%.3f)}%s"
					,alpha,sx,sy,char.text)
					
					io.write_line(l)
					
					a = a + 90
				end
			end
			
			if char.text~="" then
				--fadeout
				
				local a = 0
				
				local max_frame = 23.976
				local u_out1, u_out2 = 0, 0
				
				for s, e, i, n in utils.frames(line.start_time+char.end_time, line.end_time+line.outfade+15*char.i+15, max_frame) do
					
					local rp = 0.5*math.sin(math.rad(a))
					
					l.layer=4
					
					l.start_time=s
					l.end_time=e
					
					local fad1, fad2 = 150, 250
					local max1, max2 = math.ceil(fad1/max_frame), math.ceil(fad2/max_frame)
					
					if i > (n-math.ceil(fad1/max_frame)) then
						alpha = utils.interpolate(u_out1/max1, "&H00&", "&HFF&")
						u_out1 = u_out1 + 1
					else
						alpha="&H00&"
					end
					
					if i > (n-math.ceil(fad2/max_frame)) then
						sx, sy = char.center + math.randomsteps(-2,2,0.5), char.middle - 5*math.sin(math.rad(utils.interpolate(u_out2/max2, 180, 540))) + math.randomsteps(-2,2,0.25)
						u_out2 = u_out2 + 1
					else
						if i%8 == 0 then
							sx, sy = char.center+rp, char.middle+rp
						else
							sx, sy = char.center, char.middle
						end
					end
					
					l.text=string.format("{\\an5\\bord0\\shad0\\blur0\\alpha%s\\1c&H1A2B24&\\fscx100\\fscy100\\pos(%.3f,%.3f)}%s"
					,alpha,sx,sy,char.text)
					
					io.write_line(l)
					
					a = a + 90
				end
			end
		end
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--syl fx
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				local tlx, tly, brx, bry = shape.bounding(split_shape)
				
				local max_frame = 23.976
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.layer=5
					
					l.start_time=s
					l.end_time=e
					
					local step = i / n
					
					local xc, yc = (tlx+brx)/2, (tly+bry)/2
					
					local deform = shape.filter(split_shape,
					function(x,y)
						local vx, vy = (x - xc)/2, (y - yc)/2
						x, y = utils.interpolate(step, x+vx, x) + math.randomsteps(-10, 10, 2.5), utils.interpolate(step, y+vy, y) + math.randomsteps(-10, 10, 2.5)
						return x, y
					end)
					
					local sx, sy = syl.center - syl.width/2 + math.randomsteps(-1,1,0.25), syl.middle - syl.height/2 + math.randomsteps(-1,1,0.2)
					
					l.text=string.format("{\\an7\\p4\\bord0\\shad0\\blur0\\1c&H1A2B24&\\fscx100\\fscy100\\pos(%.3f,%.3f)}%s"
					,sx,sy,deform)
					
					io.write_line(l)
				end
			end
		end
	end
	
	if line.style == "ED_TL_L" or line.style == "ED_TL_R" then
		
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" then
				--TL
				
				local a = 0
				
				local max_frame = 23.976
				local u_in1, u_in2, u_out1, u_out2 = 0, 0, 0, 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+15*char.i-15, line.end_time+line.outfade+15*char.i+15, max_frame) do
					
					local rp = 0.5*math.sin(math.rad(a))
					
					l.layer=4
					
					l.start_time=s
					l.end_time=e
					
					local fad1, fad2 = 150, 250
					local max1, max2 = math.ceil(fad1/max_frame), math.ceil(fad2/max_frame)
					
					if i<math.ceil(fad1/max_frame) then
						alpha = utils.interpolate(u_in1/max1, "&HFF&", "&H00&")
						u_in1 = u_in1 + 1
					elseif i > (n-math.ceil(fad1/max_frame)) then
						alpha = utils.interpolate(u_out1/max1, "&H00&", "&HFF&")
						u_out1 = u_out1 + 1
					else
						alpha="&H00&"
					end
					
					if i<math.ceil(fad2/max_frame) then
						sx, sy = char.center + math.randomsteps(-2,2,0.5), char.middle - 5*math.sin(math.rad(utils.interpolate(u_in2/max2, 0, 360))) + math.randomsteps(-2,2,0.25)
						u_in2 = u_in2 + 1
					elseif i > (n-math.ceil(fad2/max_frame)) then
						sx, sy = char.center + math.randomsteps(-2,2,0.5), char.middle - 5*math.sin(math.rad(utils.interpolate(u_out2/max2, 180, 540))) + math.randomsteps(-2,2,0.25)
						u_out2 = u_out2 + 1
					else
						if i%8 == 0 then
							sx, sy = char.center+rp, char.middle+rp
						else
							sx, sy = char.center, char.middle
						end
					end
					
					l.text=string.format("{\\an5\\bord0\\shad0\\blur0\\alpha%s\\1c&H1A2B24&\\fscx100\\fscy100\\pos(%.3f,%.3f)}%s"
					,alpha,sx,sy,char.text)
					
					io.write_line(l)
					
					a = a + 90
				end
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	romanji( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end