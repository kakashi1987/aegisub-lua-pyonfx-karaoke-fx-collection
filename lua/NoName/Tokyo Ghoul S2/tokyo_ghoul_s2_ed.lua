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
	if line.style == "TGs2_ED_romaji" or line.style == "TGs2_ED_kanji" then
		for si,syl in ipairs(line.syls) do
			
			local layer = math.random(5, 9)
			
			if syl.text~="" and syl.text~=" " and syl.text~="　" then
				text_shape = convert.text_to_shape(syl.text, line.styleref)
				tlx, tly, brx, bry = shape.bounding(text_shape)
				xc, yc = (tlx+brx)/2, (tly+bry)/2
			end
			
			if syl.text~="" and syl.text~=" " and syl.text~="　" then
				--main
				
				local max_frame = 50
				
				local u_in, u_out, u_fx = 0, 0, 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+25*syl.i-25+12*syl.i, line.end_time+line.outfade+25*syl.i-25-12*#line.syls, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					step = i / n
					
					local infad, outfad = line.infade, line.outfade
					local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
					local fxmax = math.ceil((syl.end_time-syl.start_time)/max_frame)
					
					if s >= (line.start_time+syl.start_time) and s <= (line.start_time + syl.start_time + syl.duration) then
						l.layer = 4
						alpha = "&H00&"
						deform = shape.filter(text_shape,
						function(x,y)
							local vx, vy = (x - xc)*0.3, (y - yc)*0.3
							local xdef = vx*math.sin(math.rad(utils.interpolate(u_fx/fxmax, 0, 180)))
							local ydef = vy*math.sin(math.rad(utils.interpolate(u_fx/fxmax, 0, 180)))
							return (x+xdef)/8, (y+ydef)/8
						end
						)
						u_fx = u_fx + 1
					elseif i < math.ceil(infad/max_frame) then
						l.layer = 3
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
						deform = shape.filter(text_shape,
						function(x,y)
							local vx, vy = (x - xc)*0.3, (y - yc)*0.3
							local x = utils.interpolate(u_in/inmax, x + vx + math.randomsteps(-50, 50, 5), x)
							local y = utils.interpolate(u_in/inmax, y + vy + math.randomsteps(-50, 50, 5), y)
							return x/8, y/8
						end
						)
						u_in = u_in + 1
					elseif i > (n-math.ceil(outfad/max_frame)) then
						l.layer = 3
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						deform = shape.filter(text_shape,
						function(x,y)
							local vx, vy = (x - xc)*0.3, (y - yc)*0.3
							local x = utils.interpolate(u_out/outmax, x, x + vx + math.randomsteps(-50, 50, 5))
							local y = utils.interpolate(u_out/outmax, y, y + vy + math.randomsteps(-50, 50, 5))
							return x/8, y/8
						end
						)
						u_out = u_out + 1
					else
						l.layer = 3
						deform = shape.filter(text_shape,
						function(x,y)
							local x = x/8
							local y = y/8
							return x, y
						end
						)
						alpha="&H00&"
					end
					
					local x, y = syl.center - syl.width/2, syl.middle - syl.height/2
					
					l.text = string.format("{\\p1\\an7\\bord3\\blur3\\fscx100\\fscy100\\alpha%s\\1c&H915026&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
					,alpha,x,y,deform)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" and syl.text~=" " and syl.text~="　" then
				--masking
				
				local color_dist = utils.distributor({"&HE3D44A&", "&H360C35&", "&HBD9D90&", "&H8DB7E9&", "&H220FC7&"})
				
				local maxj = 5
				for j = 1, maxj, 1 do
					
					local max_frame = 50
					
					local u_in, u_out, u_fx = 0, 0, 0
					
					local a = 0
					
					l.layer = layer
					
					local color = color_dist:get()
					
					local frz1 = math.randomsteps(0, 360, 15)
					
					for s, e, i, n in utils.frames(line.start_time-line.infade+25*syl.i-25+12*syl.i, line.end_time+line.outfade+25*syl.i-25-12*#line.syls, max_frame) do
						
						l.start_time = s
						l.end_time = e
						
						step = i / n
						
						local infad, outfad = line.infade, line.outfade
						local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
						local fxmax = math.ceil((syl.end_time-syl.start_time)/max_frame)
						
						if s >= (line.start_time+syl.start_time) and s <= (line.start_time + syl.start_time + syl.duration) then
							alpha = "&H00&"
							clip_fix = shape.filter(text_shape,
							function(x,y)
								local vx, vy = (x - xc)*0.3, (y - yc)*0.3
								local xdef = vx*math.sin(math.rad(utils.interpolate(u_fx/fxmax, 0, 180)))
								local ydef = vy*math.sin(math.rad(utils.interpolate(u_fx/fxmax, 0, 180)))
								return (x+xdef)/8, (y+ydef)/8
							end
							)
							frz = utils.interpolate(u_fx/fxmax, frz1, frz1+360)
							u_fx = u_fx + 1
						elseif i < math.ceil(infad/max_frame) then
							alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
							clip_fix = shape.filter(text_shape,
							function(x,y)
								local vx, vy = (x - xc)*0.3, (y - yc)*0.3
								local x = utils.interpolate(u_in/inmax, x + vx + math.randomsteps(-50, 50, 5), x)
								local y = utils.interpolate(u_in/inmax, y + vy + math.randomsteps(-50, 50, 5), y)
								return x/8, y/8
							end
							)
							frz = frz1
							u_in = u_in + 1
						elseif i > (n-math.ceil(outfad/max_frame)) then
							alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
							clip_fix = shape.filter(text_shape,
							function(x,y)
								local vx, vy = (x - xc)*0.3, (y - yc)*0.3
								local x = utils.interpolate(u_out/outmax, x, x + vx + math.randomsteps(-50, 50, 5))
								local y = utils.interpolate(u_out/outmax, y, y + vy + math.randomsteps(-50, 50, 5))
								return x/8, y/8
							end
							)
							frz = frz1
							u_out = u_out + 1
						else
							alpha="&H00&"
							clip_fix = shape.filter(text_shape,
							function(x,y)
								local x = x/8
								local y = y/8
								return x, y
							end
							)
							frz = frz1
						end
						
						local x, y = syl.center, syl.middle
						
						local clip = shape.move(clip_fix, syl.left, syl.top)
						
						l.text = string.format("{\\an5\\bord0\\blur3\\fscx100\\fscy100\\frz%d\\alpha%s\\1c%s\\clip(%s)\\pos(%.3f, %.3f)}%s"
						,frz,alpha,color,clip,x,y,syl.text)
						
						io.write_line(l)
					end
				end
			end
		end
	end
	
	if line.style == "TGs2_ED_TL" then
		
		for ci,syl in ipairs(line.syls) do
			
			local layer = math.random(5, 9)
			
			if syl.text~="" then
				text_shape = convert.text_to_shape(syl.text, line.styleref)
				tlx, tly, brx, bry = shape.bounding(text_shape)
				xc, yc = (tlx+brx)/2, (tly+bry)/2
			end
			
			if syl.text~=""  then
				--main
				
				l.layer = 4
				
				l.start_time = line.start_time-line.infade+25*syl.i-25+12*syl.i
				l.end_time = line.end_time+line.outfade+25*syl.i-25-12*#line.syls
				
				local x, y = syl.center - syl.width/2, syl.middle - syl.height/2
				
				l.text = string.format("{\\an7\\bord3\\blur3\\fscx100\\fscy100\\fad(%d,%d)\\1c&H915026&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
				,line.infade,line.outfade,x,y,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--masking
				
				local color_dist = utils.distributor({"&HE3D44A&", "&H360C35&", "&HBD9D90&", "&H8DB7E9&", "&H220FC7&"})
				
				local clip_fix = shape.filter(text_shape,
				function(x,y)
					local x = x/8
					local y = y/8
					return x, y
				end
				)
				
				local maxj = 4
				for j = 1, maxj, 1 do
					
					l.layer = layer
					
					local color = color_dist:get()
					
					local frz = math.randomsteps(0, 360, 15)
					
					l.start_time = line.start_time-line.infade+25*syl.i-25+12*syl.i
					l.end_time = line.end_time+line.outfade+25*syl.i-25-12*#line.syls
					
					local x, y = syl.center, syl.middle
					
					local clip = shape.move(clip_fix, syl.left, syl.top)
					
					l.text = string.format("{\\an5\\bord0\\blur3\\fscx100\\fscy100\\frz%d\\fad(%d,%d)\\1c%s\\clip(%s)\\pos(%.3f, %.3f)}%s"
					,frz,line.infade,line.outfade,color,clip,x,y,syl.text)
					
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