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
	
	for si,syl in ipairs(line.syls) do
		
		if syl.text~="" and syl.text~=" " and syl.text~="　" then
			--infade
			
			local max_frame = 23
			
			local u_in = 0
			
			local text_shape = convert.text_to_shape(syl.text, line.styleref)
			local split_shape = shape.split(text_shape, 1)
			
			for s, e, i, n in utils.frames(line.start_time-line.infade, line.end_time, max_frame) do
				
				l.layer = 5
				
				l.start_time = s
				l.end_time = e
				
				local infad = 2500
				local inmax = math.ceil(infad/max_frame)
				
				if i < math.ceil(infad/max_frame) then
					
					alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H00&")
					
					deform = shape.filter(split_shape,
					function(x, y)
						xdef = 75*math.sin(math.rad(10*x + utils.interpolate(u_in/inmax, 75, 0)))
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
	end
	
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end