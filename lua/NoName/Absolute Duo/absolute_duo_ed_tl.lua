--Absolute Duo ED
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	if line.infade > 250 then
		line.infade = 250
	end
	if line.outfade > 250 then
		line.outfade = 250
	end
	
	if line.style == "AD_ED_romaji" or line.style == "AD_ED_kanji" then
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" and syl.text~=" " and syl.text~="　" then
				--infade
				
				local max_frame = 23
				
				local u_in = 0
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+50*syl.i-50, line.start_time+syl.start_time, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e
					
					local infad = 1000
					local inmax = math.ceil(infad/max_frame)
					
					if i < math.ceil(infad/max_frame) then
						
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
						
						deform = shape.filter(split_shape,
						function(x, y)
							xdef = utils.interpolate(u_in/inmax, 25*math.sin(math.rad(3*y + utils.interpolate(u_in/inmax, 90, 0))), 0)
							ydef = 0
							return x+xdef, y+ydef
						end)
						u_in = u_in + 1
					else
						alpha = "&H00&"
						
						deform = text_shape
					end
					
					l.text = string.format("{\\p4\\an7\\bord2\\blur3\\shad0\\fscx100\\fscy100\\alpha%s\\1c&HBE853C&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
					,alpha,syl.left,syl.top,deform)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" and syl.text~=" " and syl.text~="　" then
				--syl fx
				
				local max_frame = 23
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				
				local a = 0
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.layer = 4
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					local deform = shape.filter(split_shape,
					function(x, y)
						xdef = 0
						ydef = 25*math.sin(math.rad(x+a))
						return x+xdef, y+ydef
					end)
					
					a = a + 12
					
					local bord, blur = 2 + 3*math.sin(math.rad(utils.interpolate(step, 0, 180))), 3 + 4*math.sin(math.rad(utils.interpolate(step, 0, 180)))
					
					l.text = string.format("{\\p4\\an7\\bord%d\\blur%d\\shad0\\fscx100\\fscy100\\1c&HBE853C&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
					,bord,blur,syl.left,syl.top,deform)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" and syl.text~=" " and syl.text~="　" then
				--outfade
				
				local max_frame = 23
				
				local u_out = 0
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				
				for s, e, i, n in utils.frames(line.start_time+syl.end_time, line.end_time+line.outfade+50*syl.i-50, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e
					
					local outfad = 1000
					local outmax = math.ceil(outfad/max_frame)
					
					if i > (n-math.ceil(outfad/max_frame)) then
						
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						
						deform = shape.filter(split_shape,
						function(x, y)
							xdef = utils.interpolate(u_out/outmax, 0, 25*math.sin(math.rad(3*y + utils.interpolate(u_out/outmax, 0, 90))))
							ydef = 0
							return x+xdef, y+ydef
						end)
						u_out = u_out + 1
					else
						alpha = "&H00&"
						
						deform = text_shape
					end
					
					l.text = string.format("{\\p4\\an7\\bord2\\blur3\\shad0\\fscx100\\fscy100\\alpha%s\\1c&HBE853C&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
					,alpha,syl.left,syl.top,deform)
					
					io.write_line(l)
				end
			end
		end
	end
	
	if line.style == "AD_ED_TL" then
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" and syl.text~=" " and syl.text~="　" then
				--infade
				
				local max_frame = 23
				
				local u_in = 0
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+50*syl.i-50, line.start_time+line.duration/2, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e
					
					local infad = 1000
					local inmax = math.ceil(infad/max_frame)
					
					if i < math.ceil(infad/max_frame) then
						
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
						
						deform = shape.filter(split_shape,
						function(x, y)
							xdef = utils.interpolate(u_in/inmax, 25*math.sin(math.rad(3*y + utils.interpolate(u_in/inmax, 90, 0))), 0)
							ydef = 0
							return x+xdef, y+ydef
						end)
						u_in = u_in + 1
					else
						alpha = "&H00&"
						
						deform = text_shape
					end
					
					l.text = string.format("{\\p4\\an7\\bord2\\blur3\\shad0\\fscx100\\fscy100\\alpha%s\\1c&HBE853C&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
					,alpha,syl.left,syl.top,deform)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" and syl.text~=" " and syl.text~="　" then
				--outfade
				
				local max_frame = 23
				
				local u_out = 0
				
				local text_shape = convert.text_to_shape(syl.text, line.styleref)
				local split_shape = shape.split(text_shape, 1)
				
				for s, e, i, n in utils.frames(line.start_time+line.duration/2, line.end_time+line.outfade+50*syl.i-50, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e
					
					local outfad = 1000
					local outmax = math.ceil(outfad/max_frame)
					
					if i > (n-math.ceil(outfad/max_frame)) then
						
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						
						deform = shape.filter(split_shape,
						function(x, y)
							xdef = utils.interpolate(u_out/outmax, 0, 25*math.sin(math.rad(3*y + utils.interpolate(u_out/outmax, 0, 90))))
							ydef = 0
							return x+xdef, y+ydef
						end)
						u_out = u_out + 1
					else
						alpha = "&H00&"
						
						deform = text_shape
					end
					
					l.text = string.format("{\\p4\\an7\\bord2\\blur3\\shad0\\fscx100\\fscy100\\alpha%s\\1c&HBE853C&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
					,alpha,syl.left,syl.top,deform)
					
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