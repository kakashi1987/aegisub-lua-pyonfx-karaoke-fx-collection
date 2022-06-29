--Shinmai Maou no Testament OP
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	line.infade = 300
	line.outfade = 550
	
	for ci,char in ipairs(line.chars) do
		
		if char.text~="" then
			--text infade layer 1
			
			l.layer = 5
			
			if line.style == "Shinmai_OP_romaji" then
				fix = 150
			else
				fix = 0
			end
			
			l.start_time = line.start_time-line.infade - fix
			l.end_time = line.start_time+char.start_time
			
			local clip_src = shape.rectangle(char.width + 6, line.height + 10)
			
			local clip = shape.move(clip_src, char.left-3, line.top - line.height/2 - 5)
			
			local x1, y1 = char.left, char.top + line.height/2
			local x2, y2 = char.left, char.top
			
			l.text = string.format("{\\an7\\bord0.1\\blur0.8\\shad2\\fscx100\\fscy100\\4a&H64&\\1c&HFFFFFF&\\3c&H000000&\\4c&H000000&\\clip(%s)\\move(%.3f, %.3f, %.3f, %.3f, 0, %d)}%s"
			,clip,x1,y1,x2,y2,line.infade,char.text)
			
			io.write_line(l)
		end
		
		if char.text~="" then
			--text infade layer 2
			
			l.layer = 5
			
			if line.style == "Shinmai_OP_romaji" then
				fix = 150
			else
				fix = 0
			end
			
			l.start_time = line.start_time-line.infade - fix
			l.end_time = line.start_time+char.start_time
			
			local clip_src = shape.rectangle(char.width + 6, line.height + 10)
			
			local clip = shape.move(clip_src, char.left-3, line.top + line.height/2 + 5)
			
			local x1, y1 = char.left, char.top - line.height/2
			local x2, y2 = char.left, char.top
			
			l.text = string.format("{\\an7\\bord0.1\\blur0.8\\shad2\\fscx100\\fscy100\\4a&H64&\\1c&HFFFFFF&\\3c&H000000&\\4c&H000000&\\clip(%s)\\move(%.3f, %.3f, %.3f, %.3f, 0,%d)}%s"
			,clip,x1,y1,x2,y2,line.infade,char.text)
			
			io.write_line(l)
		end
		
		if char.text~="" then
			--placeholder
			
			l.layer = 5
			
			l.start_time = line.start_time + char.start_time
			l.end_time = line.end_time + line.outfade
			
			l.text = string.format("{\\an7\\bord0.1\\blur0.8\\shad2\\fscx100\\fscy100\\4a&H64&\\1c&HFFFFFF&\\3c&H000000&\\4c&H000000&\\fad(0,550)\\pos(%.3f, %.3f)}%s"
			,char.left,char.top,char.text)
			
			io.write_line(l)
		end
		
		if char.text~="" and char.i == 1 and line.style == "Shinmai_OP_romaji" then
			--vertical line 1
			
			local max_frame = 23.976
			local u_in, u_out = 0, 0
			
			for s, e, i, n in utils.frames(line.start_time - line.infade - 250, line.end_time + line.outfade, max_frame) do
				
				l.layer = 4
				
				l.start_time = s
				l.end_time = e
				
				local step = i / n
				
				local infad, outfad = 350, 550
				local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
				
				if i < math.ceil(infad/max_frame) then
					alpha="&H00&"
					v_line_1_src = shape.rectangle(3, utils.interpolate(u_in/inmax, 0, 130))
					u_in = u_in + 1
				elseif i > (n-math.ceil(outfad/max_frame)) then
					alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
					v_line_1_src = shape.rectangle(3, 130)
					u_out = u_out + 1
				else
					alpha="&H00&"
					v_line_1_src = shape.rectangle(3, 130)
				end
				
				local x, y = line.left - 10, line.top + 15
				
				l.text = string.format("{\\p1\\an8\\bord0\\blur0.5\\shad2\\frx-40\\fscx100\\fscy100\\1a%s\\4a&H64&\\1c&HFFFFFF&\\3c&H000000&\\4c&H000000&\\pos(%.3f, %.3f)}%s"
				,alpha,x,y,v_line_1_src)
				
				io.write_line(l)
			end
		end
		
		if char.text~="" and char.i == 1 and line.style == "Shinmai_OP_romaji" then
			--vertical line 2
			
			local max_frame = 23.976
			local u_in, u_out = 0, 0
			
			for s, e, i, n in utils.frames(line.start_time - line.infade - 250, line.end_time + line.outfade, max_frame) do
				
				l.layer = 4
				
				l.start_time = s
				l.end_time = e
				
				local step = i / n
				
				local infad, outfad = 350, 550
				local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
				
				if i < math.ceil(infad/max_frame) then
					alpha="&H00&"
					v_line_2_src = shape.star(2, 1, utils.interpolate(u_in/inmax, 0, 140))
					u_in = u_in + 1
				elseif i > (n-math.ceil(outfad/max_frame)) then
					alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
					v_line_2_src = shape.star(2, 1, 140)
					u_out = u_out + 1
				else
					alpha="&H00&"
					v_line_2_src = shape.star(2, 1, 140)
				end
				
				local tlx, tly, brx, bry = shape.bounding(v_line_2_src)
				
				local v_line_2 = shape.filter(v_line_2_src,
				function(x,y)
					
					local x = x + 0
					
					if y > (tly+bry)/2 then
						y = y + 0
					else
						y = (tly+bry)/2
					end
					
					return x, y
				end)
				
				local x, y = line.left - 16, line.top + 15
				
				l.text = string.format("{\\p1\\an2\\bord0\\blur0.4\\shad2\\fscx100\\fscy100\\1a%s\\4a&H64&\\1c&HFFFFFF&\\3c&H000000&\\4c&H000000&\\pos(%.3f, %.3f)}%s"
				,alpha,x,y,v_line_2)
				
				io.write_line(l)
			end
		end
		
		if char.text~="" and char.i == 1 and line.style == "Shinmai_OP_romaji" then
			--horizontal line 1
			
			local max_frame = 12
			local u_in, u_out = 0, 0
			local a = 0
			
			for s, e, i, n in utils.frames(line.start_time - line.infade - 250, line.end_time + line.outfade, max_frame) do
				
				l.layer = 4
				
				l.start_time = s
				l.end_time = e
				
				local step = i / n
				
				local infad, outfad = 350, 550
				local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
				
				if i < math.ceil(infad/max_frame) then
					alpha="&H00&"
					v_line_1_src = shape.rectangle(utils.interpolate(u_in/inmax, 0, line.width + 10), 2)
					u_in = u_in + 1
				elseif i > (n-math.ceil(outfad/max_frame)) then
					alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
					v_line_1_src = shape.rectangle(line.width + 10 + a, 2)
					u_out = u_out + 1
				else
					alpha="&H00&"
					v_line_1_src = shape.rectangle(line.width + 10 + a, 2)
				end
				
				a = a + 0.1
				
				local x, y = line.left - 9, line.top + 13
				
				l.text = string.format("{\\p1\\an4\\bord0\\blur0.3\\shad2\\frx-40\\fscx100\\fscy100\\1a%s\\4a&H64&\\1c&HFFFFFF&\\3c&H000000&\\4c&H000000&\\pos(%.3f, %.3f)}%s"
				,alpha,x,y,v_line_1_src)
				
				io.write_line(l)
			end
		end
		
		if char.text~="" and char.i == 1 and line.style == "Shinmai_OP_romaji" then
			--horizontal line 2
			
			local max_frame = 23.976
			local u_in, u_out = 0, 0
			local a = 0
			
			for s, e, i, n in utils.frames(line.start_time - line.infade - 250, line.end_time + line.outfade, max_frame) do
				
				l.layer = 4
				
				l.start_time = s
				l.end_time = e
				
				local step = i / n
				
				local infad, outfad = 350, 550
				local inmax, outmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame)
				
				if i < math.ceil(infad/max_frame) then
					alpha="&H00&"
					v_line_2_src = shape.star(2, utils.interpolate(u_in/inmax, 0, line.width + 20), 1)
					u_in = u_in + 1
				elseif i > (n-math.ceil(outfad/max_frame)) then
					alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
					v_line_2_src = shape.star(2, line.width + 20 + a, 1)
					u_out = u_out + 1
				else
					alpha="&H00&"
					v_line_2_src = shape.star(2, line.width + 20 + a, 1)
				end
				
				local tlx, tly, brx, bry = shape.bounding(v_line_2_src)
				
				local v_line_2 = shape.filter(v_line_2_src,
				function(x,y)
					if x > (tlx+brx)/2 then
						x = x + 0
					else
						x = (tlx+brx)/2
					end
					
					local y = y + 0
					
					return x, y
				end)
				
				a = a + 0.2
				
				local x, y = line.left - 9, line.top + 8
				
				l.text = string.format("{\\p1\\an6\\bord0\\blur0.4\\shad2\\fscx100\\fscy100\\1a%s\\4a&H64&\\1c&HFFFFFF&\\3c&H000000&\\4c&H000000&\\pos(%.3f, %.3f)}%s"
				,alpha,x,y,v_line_2)
				
				io.write_line(l)
			end
		end
	end
	
end

for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end