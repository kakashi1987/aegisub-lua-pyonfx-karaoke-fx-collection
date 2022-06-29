--Tokyo Ghoul S2 ED
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	if line.infade > 500 then
		line.infade = 250
	end
	if line.outfade > 500 then
		line.outfade = 250
	end
	
	for si,syl in ipairs(line.syls) do
		
		if syl.text~="" then
			
			l.layer = 1
			
			l.start_time = line.start_time
			l.end_time = line.end_time
			
			l.text = string.format("{\\b1\\an5\\bord0\\blur0\\fscx100\\fscy100\\frz0\\1c&H0000FF&\\pos(%.3f, %.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
			
		end
		
		local layer = math.random(5, 9)
		
		if syl.text~="" then
			--masking
			
			local color_dist = utils.distributor({"&HE3D44A&", "&H360C35&", "&HBD9D90&", "&H8DB7E9&", "&H220FC7&"})
			
			local clip_src = convert.text_to_shape(syl.text, line.styleref)
			local tlx, tly, brx, bry = shape.bounding(clip_src)
			local xc, yc = (tlx+brx)/2, (tly+bry)/2
			
			local maxj = 5
			for j = 1, maxj, 1 do
				
				local max_frame = 23.976
				
				local u_in, u_out, u_fx = 0, 0, 0
				
				local a = 0
				
				l.layer = layer
				
				local x,y = syl.center + math.randomsteps(-40, 40, 5), syl.middle + math.randomsteps(-40, 40, 5)
				
				local color = color_dist:get()
				
				local frz = math.randomsteps(0, 360, 15)
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					step = i / n
					
					local infad, outfad = line.infade, line.outfade
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					local fxmax = math.ceil((syl.end_time-syl.start_time)/max_frame)
					
					alpha = "&H00&"
					clip_fix = shape.filter(clip_src,
					function(x,y)
						
						local vx, vy = (x - xc)/2, (y - yc)/2
						
						x = x + vx*math.sin(math.rad(utils.interpolate(step, 0, 180)))
						y = y + vy*math.sin(math.rad(utils.interpolate(step, 0, 180)))
						return x, y
					end
					)
					
					u_fx = u_fx + 1
					
					local x, y = syl.center, syl.middle
					
					local clip = shape.move(clip_fix, syl.left, syl.top)
					
					l.text = string.format("{\\p4\\b1\\an5\\bord0\\blur0\\fscx100\\fscy100\\frz0\\alpha%s\\1c%s\\pos(%.3f, %.3f)}%s"
					,alpha,color,x,y,clip)
					
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