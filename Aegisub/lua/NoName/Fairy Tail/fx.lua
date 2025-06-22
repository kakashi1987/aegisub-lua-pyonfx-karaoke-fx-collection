--Fairy Tail (2014) OP 2 v2
--Karaoke by Amberdrake
--VSFilter

function kara (line, l)
	
	
		line.infade = 150
		line.outfade = 150
	
	for si,syl in ipairs(line.syls) do
		
		if syl.text~="" then
			
			l.start_time = line.start_time-line.infade+15*syl.i-15
			l.end_time = line.start_time+syl.start_time
			
			l.layer = 7
			
			l.text = string.format("{\\an5\\blur0.8\\bord3\\shad0\\fscx100\\fscy100\\fad(150,0)\\pos(%.3f, %.3f)}%s"
			,syl.center,syl.middle+10,syl.text)
			
			io.write_line(l)
			
		end
		
		if syl.text~="" then
			
			l.start_time = line.start_time+syl.start_time
			l.end_time = line.start_time+syl.end_time
			
			l.layer = 7
			
			l.text = string.format("{\\an5\\blur0.8\\bord3\\shad0\\fscx130\\fscy130\\t(\\fscx100\\fscy100)\\pos(%.3f, %.3f)}%s"
			,syl.center,syl.middle+10,syl.text)
			
			io.write_line(l)
			
		end
		
		if syl.text~="" then
			
			l.start_time = line.start_time+syl.end_time
			l.end_time = line.end_time+line.outfade+15*syl.i-15
			
			l.layer = 7
			
			l.text = string.format("{\\an5\\blur0.8\\bord3\\shad0\\fscx100\\fscy100\\fad(0,150)\\pos(%.3f, %.3f)}%s"
			,syl.center,syl.middle+10,syl.text)
			
			io.write_line(l)
			
		end
		
		if syl.text~="" and syl.i == 1 then
			--layer 1
			local L1 = shape.ellipse(70,70)
			
			local max_frame = 23.976
			local u_in, u_out = 0, 0
			
			for s, e, i, n in utils.frames(line.start_time-line.infade, line.end_time+line.outfade, max_frame) do
				
				l.layer=3
				
				l.start_time=s
				l.end_time=e
				
				local step = i / n
				
				local x, y = utils.interpolate(step, line.left, line.right), line.top - 5
				
				local fad = 250
				local max = math.ceil(fad/max_frame)
				if i < math.ceil(fad/max_frame) then
					alpha = utils.interpolate(u_in/max, "&HFF&", "&H64&")
					color = utils.interpolate(u_in/max, "&HFFFFFF&", "&HFF0000&")
					u_in = u_in + 1
				elseif i > (n-math.ceil(fad/max_frame)) then
					alpha = utils.interpolate(u_out/max, "&H64&", "&HFF&")
					color = utils.interpolate(u_in/max, "&HFF0000&", "&H000000&")
					u_out = u_out + 1
				else
					alpha = "&H64&"
					color = "&HFF0000&"
				end
				l.text=string.format("{\\p1\\an5\\blur3\\bord0\\fscx50\\fscy50\\alpha%s\\1c%s\\pos(%.3f, %.3f)}%s"
				,alpha,color,x,y,L1)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" and syl.i == 1 then
			--layer 2
			local L2 = shape.ellipse(60,60)
			
			local max_frame = 23.976
			local u_in, u_out = 0, 0
			
			for s, e, i, n in utils.frames(line.start_time-line.infade, line.end_time+line.outfade, max_frame) do
				
				l.layer=4
				
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
				
				local x, y = utils.interpolate(step, line.left, line.right), line.top - 5
				
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
				l.text=string.format("{\\p1\\an5\\blur0.8\\bord0\\fscx50\\fscy50\\alpha%s\\1c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
				,alpha,x,y,L2)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" and syl.i == 1 then
			--layer 3
			local L3 = shape.ellipse(5,5)
			
			local max_frame = 23.976
			local u_in, u_out = 0, 0
			
			for s, e, i, n in utils.frames(line.start_time-line.infade, line.end_time+line.outfade, max_frame) do
				
				l.layer=5
				
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
				
				local x, y = xs + xshift, line.middle - 5 + yshift
				
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
				l.text=string.format("{\\p1\\an5\\blur0.2\\bord0\\fscx50\\fscy50\\alpha%s\\1c&H000000&\\pos(%.3f, %.3f)}%s"
				,alpha,x,y,L3)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" and syl.i == 1 then
			--hand 1
			
			local hand = shape.star(2, 5, 25)
			
			local max_frame = 23.976
			local u_in, u_out = 0, 0
			
			local rs = math.random(-720, -360)
			local re = rs + math.randomsteps(360, 720, 60)
			
			for s, e, i, n in utils.frames(line.start_time-line.infade, line.end_time+line.outfade, max_frame) do
				
				l.layer=6
				
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
				
				local x, y = utils.interpolate(step, line.left, line.right), line.top - 5
				
				local frz = utils.interpolate(step, rs, re)
				
				local fad = 250
				local max = math.ceil(fad/max_frame)
				if i < math.ceil(fad/max_frame) then
					alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
					color = utils.interpolate(u_in/max, "&HFFFFFF&", "&HFF0000&")
					u_in = u_in + 1
				elseif i > (n-math.ceil(fad/max_frame)) then
					alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
					color = utils.interpolate(u_in/max, "&HFF0000&", "&H000000&")
					u_out = u_out + 1
				else
					alpha = "&H00&"
					color = "&HFF0000&"
				end
				
				l.text=string.format("{\\p1\\an8\\blur0.2\\bord0\\fscx20\\fscy18\\frz%.3f\\alpha%s\\1c%s\\pos(%.3f, %.3f)\\org(%.3f, %.3f)}%s"
				,frz,alpha,color,x,y,x,y,hand)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" and syl.i == 1 then
			--hand 2
			
			local hand = shape.star(2, 5, 25)
			
			local max_frame = 23.976
			local u_in, u_out = 0, 0
			
			local rs = math.randomsteps(-720, -360, 30)
			local re = rs + math.randomsteps(1440, 2880, 80)
			
			for s, e, i, n in utils.frames(line.start_time-line.infade, line.end_time+line.outfade, max_frame) do
				
				l.layer=6
				
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
				
				local x, y = utils.interpolate(step, line.left, line.right), line.top - 5
				
				local frz = utils.interpolate(step, rs, re)
				
				local fad = 250
				local max = math.ceil(fad/max_frame)
				if i < math.ceil(fad/max_frame) then
					alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
					color = utils.interpolate(u_in/max, "&HFFFFFF&", "&HFF0000&")
					u_in = u_in + 1
				elseif i > (n-math.ceil(fad/max_frame)) then
					alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
					color = utils.interpolate(u_in/max, "&HFF0000&", "&H000000&")
					u_out = u_out + 1
				else
					alpha = "&H00&"
					color = "&HFF0000&"
				end
				
				l.text=string.format("{\\p1\\an8\\blur0.2\\bord0\\fscx25\\fscy25\\frz%.3f\\alpha%s\\1c%s\\pos(%.3f, %.3f)\\org(%.3f, %.3f)}%s"
				,frz,alpha,color,x,y,x,y,hand)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" and syl.i == 1 then
			--particle
			local shape_source = shape.ellipse(250,250)
			local source_split = shape.split(shape_source, 1)
			local source_outline = shape.tooutline(source_split, 1)
			local particle = shape.star(4,2,4)
			local tlx, tly, brx, bry = shape.bounding(source_outline)
			
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
					
					local width, height = (tlx+brx)/8, (tly+bry)/8
					
					local x1 = utils.interpolate(step, line.left, line.right) + 16
					
					local x, y = x1 + pixel.x + math.randomsteps(-1, 1, 0.1) - width, line.top + pixel.y + math.randomsteps(-1, 1, 0.1) - height + 11
					
					local sc = math.randomsteps(200, 300, 100)
					
					l.text=string.format("{\\p1\\an5\\blur3\\bord0.1\\fscx%d\\fscy%d\\alpha%s\\1c&HFFFFFF&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}m 0 0 l 1 0 1 1 0 1"
					,sc,sc,alpha,x,y)
					
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