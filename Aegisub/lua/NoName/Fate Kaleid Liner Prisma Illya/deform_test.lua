--Fate/kaleid liner PRISMA ILLYA OP
--Karaoke by Amberdrake
--VSFilter
--deform test

function kara(line, l)
	
	if line.infade > 500 then
		line.infade = 250
	end
	if line.outfade > 500 then
		line.outfade = 250
	end
	
	for si,syl in ipairs(line.syls) do
		
		if syl.text~="" then
			--placeholder 1
			
			l.layer = 5
			
			l.start_time = line.start_time-line.infade
			l.end_time = line.start_time+syl.start_time
			
			l.text = string.format("{\\an7\\bord2\\blur1.5\\shad0\\fscx100\\fscy100\\fad(250,0)\\1c&HAF1FEC&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
			,syl.left,syl.top,syl.text)
			
			io.write_line(l)
		end
		if syl.text~="" then
			--placeholder 2
			
			l.layer = 5
			
			l.start_time = line.start_time+syl.end_time
			l.end_time = line.end_time+line.outfade
			
			l.text = string.format("{\\an7\\bord2\\blur1.5\\shad0\\fscx100\\fscy100\\fad(0,250)\\1c&HAF1FEC&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
			,syl.left,syl.top,syl.text)
			
			io.write_line(l)
		end
		
		if syl.text~="" and syl.text~=" " and syl.text~="　" then
			text_shape = convert.text_to_shape(syl.text, line.styleref)
			tlx, tly, brx, bry = shape.bounding(text_shape)
			xc, yc = (tlx+brx)/2, (tly+bry)/2
			text_split = shape.split(text_shape, 1)
			text_outline = shape.tooutline(text_split, 2)
		end
		
		if syl.text~="" then
			--syl_fx
			
			local max_frame = 25
			
			for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
				
				l.layer = 5
				
				l.start_time = s
				l.end_time = e
				
				local step = i / n
				
				local deform = shape.filter(text_shape,
				function(x,y)
					local xdef = 0
					local min_x, max_x = tlx, brx
					
					if y >= yc then
						ydef = 50*math.sin(math.pi*(x/max_x))*math.sin(math.rad(utils.interpolate(step, 0, 180)))
					end
					if y < yc then
						ydef = -50*math.sin(math.pi*(x/max_x))*math.sin(math.rad(utils.interpolate(step, 0, 180)))
					end
					
					return x+xdef, y+ydef
				end
				)
				
				l.text = string.format("{\\an7\\p4\\bord2\\blur1.5\\shad0\\fscx100\\fscy100\\1c&HAF1FEC&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
				,syl.left,syl.top,deform)
				
				io.write_line(l)
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end