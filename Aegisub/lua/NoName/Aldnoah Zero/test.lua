--Aldnoah.Zero ED2
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	if line.infade > 500 then
		line.infade = 250
	end
	if line.outfade > 500 then
		line.outfade = 250
	end
	for ci,char in ipairs(line.chars) do
		
		local layer = math.random(5, 9)
		
		if char.text~="" and char.text~=" " and char.text~="　" then
			text_shape = convert.text_to_shape(char.text, line.styleref)
			text_split = shape.split(text_shape, 1)
			tlx, tly, brx, bry = shape.bounding(text_shape)
			xc, yc = (tlx+brx)/2, (tly+bry)/2
		end
		
		if char.text~="" and char.text~=" " and char.text~="　" then
			
			local max_frame = 25
			local u_in, u_out, u_fx = 0, 0, 0
			
			for s, e, i, n in utils.frames(line.start_time - line.infade + 15*char.i-15, line.end_time + line.outfade + 15*char.i-15, max_frame) do
				
				l.start_time = s
				l.end_time = e
				
				local step = i / n
				
				local infad, outfad = 250, 250
				local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
				local fxmax = math.ceil((char.end_time-char.start_time)/max_frame)
				
				l.layer = 5
				
				if s >= (line.start_time+char.start_time) and s <= (line.start_time + char.start_time + char.duration) then
					deform = text_shape
					u_fx = u_fx + 1
				elseif i < math.ceil(infad/max_frame) then
					deform = shape.filter(text_split,
					function(x, y)
						if x < xc then
							x = utils.interpolate(u_in/inmax, tlx, x)
						end
						if x >= xc then
							x = utils.interpolate(u_in/inmax, brx, x)
						end
						if y < yc then
							y = utils.interpolate(u_in/inmax, tly, y)
						end
						if y >= yc then
							y = utils.interpolate(u_in/inmax, bry, y)
							
						end
						return x, y
					end)
					u_in = u_in + 1
				elseif i > (n-math.ceil(outfad/max_frame)) then
					deform = shape.filter(text_split,
					function(x, y)
						if x < xc then
							x = utils.interpolate(u_out/outmax, x, tlx)
						end
						if x >= xc then
							x = utils.interpolate(u_out/outmax, x, brx)
						end
						if y < yc then
							y = utils.interpolate(u_out/outmax, y, tly)
						end
						if y >= yc then
							y = utils.interpolate(u_out/outmax, y, bry)
							
						end
						return x, y
					end)
					u_out = u_out + 1
				else
					deform = text_shape
					u_out = u_out + 1
				end
				l.text = string.format("{\\p4\\an7\\bord1\\blur3\\fscx100\\fscy100\\1c&H87FF61&\\3c&H87FF61&\\pos(%.3f, %.3f)}%s"
				,char.left,char.top,deform)
				
				io.write_line(l)
			end
		end
	end
	
end

for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end