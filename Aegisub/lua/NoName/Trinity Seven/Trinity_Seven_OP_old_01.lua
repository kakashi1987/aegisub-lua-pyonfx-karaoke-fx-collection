--Trinity Seven OP
--Effects by Amberdrake
--VSFilter

function kara(line, l)
	
	line.infade = 250
	line.outfade = 250
	
	for ci,char in ipairs(line.chars) do
		
		if char.text~="" then
		
			if char.text~="" and char.text~=" " then
				--static text effect
				
				local ln = shape.rectangle(line.width, 1)
				
				local max_frame = 23.976
				local a = 0
				local u_out = 0
				
				l
				
				for s, e, i, n in utils.frames(line.start_time - line.infade, line.end_time + line.outfade, max_frame) do
					
					l.layer = 4
					
					l.start_time = s
					l.end_time = e
					
					local fad = 150
					local max=math.ceil(fad/max_frame)
					if i>(n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						u_out=u_out+1
					else
						alpha="&H00&"
					end
					
					if char.text == "i" then
						an = 8
						scy = 100 + a
						a = a + 1
						x, y = char.center, char.top
					elseif char.text == "l" then
						an = 2
						scy = 100 + a
						a = a + 1
						x, y = char.center, char.bottom
					else
						an = 5
						scy = 100
						a = a + 0
						x, y = char.center, char.middle
					end
					
					
					l.text=string.format("{\\an%d\\bord0.2\\shad0\\blur3\\fscx100\\fscy%.3f\\alpha%s\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f,%.3f)}%s"
					,an,scy,alpha,x,y,char.text)
					
					io.write_line(l)
				end
			end
		end
		
		if line.style == "OP_Romaji_L" then
			if char.text~="" and char.i == 1 then
				--romaji L line effect
				
				local ln = shape.rectangle(line.width, 1)
				
				local max_frame = 23.976
				local a = 0
				local u_out = 0
				
				for s, e, i, n in utils.frames(line.start_time - line.infade, line.end_time + line.outfade, max_frame) do
					
					l.layer = 4
					
					l.start_time = s
					l.end_time = e
					
					local fad = 150
					local max=math.ceil(fad/max_frame)
					if i>(n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						u_out=u_out+1
					else
						alpha="&H00&"
					end
					
					local x, y = lines[line.i].chars[1].right-30, line.bottom + 3
					
					local scx = 100 + a
					a = a + 0.05
					
					l.text=string.format("{\\p1\\an7\\bord0.2\\shad0\\blur3\\fscx%.3f\\fscy100\\alpha%s\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f,%.3f)}%s"
					,scx,alpha,x,y,ln)
					
					io.write_line(l)
				end
			end
		end
		
		if line.style == "OP_Romaji_R" then
			if char.text~="" and char.i == 1 then
				--romaji R line effect
				
				local ln = shape.rectangle(line.width, 1)
				
				local max_frame = 23.976
				local a = 0
				local u_out = 0
				
				for s, e, i, n in utils.frames(line.start_time - line.infade, line.end_time + line.outfade, max_frame) do
					
					l.layer = 4
					
					l.start_time = s
					l.end_time = e
					
					local fad = 150
					local max=math.ceil(fad/max_frame)
					if i>(n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						u_out=u_out+1
					else
						alpha="&H00&"
					end
					
					local x, y = lines[line.i].chars[#line.chars].right+30, line.bottom + 3
					
					local scx = 100 + a
					a = a + 0.03
					
					l.text=string.format("{\\p1\\an9\\bord0.2\\shad0\\blur3\\fscx%.3f\\fscy100\\alpha%s\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f,%.3f)}%s"
					,scx,alpha,x,y,ln)
					
					io.write_line(l)
				end
			end
		end
		
		if line.style == "OP_Kanji_L" then
			if char.text~="" and char.i == 1 then
				--kanji L line effect
				
				local ln = shape.rectangle(1, line.width + (line.width/3))
				
				local max_frame = 23.976
				local a = 0
				local u_out = 0
				
				for s, e, i, n in utils.frames(line.start_time - line.infade, line.end_time + line.outfade, max_frame) do
					
					l.layer = 4
					
					l.start_time = s
					l.end_time = e
					
					local fad = 150
					local max=math.ceil(fad/max_frame)
					if i>(n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						u_out=u_out+1
					else
						alpha="&H00&"
					end
					
					local x, y = line.left + 30, lines[line.i].chars[#line.chars].bottom
					
					local scy = 100 + a
					a = a + 0.03
					
					l.text=string.format("{\\p1\\an1\\bord0.2\\shad0\\blur3\\fscx100\\fscy%.3f\\alpha%s\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f,%.3f)}%s"
					,scy,alpha,x,y,ln)
					
					io.write_line(l)
				end
			end
		end
		
		if line.style == "OP_Kanji_R" then
			if char.text~="" and char.i == 1 then
				--kanji R line effect
				
				local ln = shape.rectangle(1, line.width + (line.width/3))
				
				local max_frame = 23.976
				local a = 0
				local u_out = 0
				
				for s, e, i, n in utils.frames(line.start_time - line.infade, line.end_time + line.outfade, max_frame) do
					
					l.layer = 4
					
					l.start_time = s
					l.end_time = e
					
					local fad = 150
					local max=math.ceil(fad/max_frame)
					if i>(n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						u_out=u_out+1
					else
						alpha="&H00&"
					end
					
					local x, y = line.right - 30, lines[line.i].chars[#line.chars].bottom
					
					local scy = 100 + a
					a = a + 0.03
					
					l.text=string.format("{\\p1\\an3\\bord0.2\\shad0\\blur3\\fscx100\\fscy%.3f\\alpha%s\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f,%.3f)}%s"
					,scy,alpha,x,y,ln)
					
					io.write_line(l)
				end
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	kara(line, table.copy(line) )
	
	io.progressbar(li / #lines)
end