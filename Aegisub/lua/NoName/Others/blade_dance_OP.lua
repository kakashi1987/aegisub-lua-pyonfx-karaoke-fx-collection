--Seirei Tsukai no Blade Dance Opening
--Karaoke by Amberdrake
--VSFilterMod

function kara (line, l)
	
	if line.infade > 250 then
		line.infade = 250
	end
	if line.outfade > 250 then
		line.outfade = 250
	end
	
	a = 0
	if line.style == "OP_romanji" or line.style == "OP_romanji_overlap" or line.style == "OP_kanji" then
		for ci, char in pairs(line.chars) do
			
			if char.text=="" or char.text==" " then
				a = 0
			else
				a = a + 1
			end
			
			if a == 3 + math.random(-2,2) then
				color = "&H3FF2FB&"
			else
				color = "&HFEF6FF&"
			end
			
			local ord = 10*math.sin(math.deg(45*a))
			
			if char.text~="" or char.text~=" " then
				--infade
				
				max_frame = 100
				u_in = 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade, line.start_time+char.start_time, max_frame) do
					
					l.layer = 5
					
					l.start_time=s
					l.end_time=e
					
					local fad = line.infade
					max=math.ceil(fad/max_frame)
					if i<math.ceil(fad/max_frame) then
						alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
						u_in=u_in+1
					else
						alpha="&H00&"
					end
					
					l.text=string.format("{\\an5\\bord1\shad0\\blur1\\1c%s\\3c&H752CB1&\\jitter(1,1,1,1)\\alpha%s\\pos(%.3f,%.3f)}%s"
					,color,alpha,char.center,char.middle,char.text)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" or char.text~=" " then
				--infade outline
				
				max_frame = 100
				u_in = 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade, line.start_time+char.start_time, max_frame) do
					
					l.layer = 5
					
					l.start_time=s
					l.end_time=e
					
					local fad = line.infade
					max=math.ceil(fad/max_frame)
					if i<math.ceil(fad/max_frame) then
						alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
						u_in=u_in+1
					else
						alpha="&H00&"
					end
					
					l.text=string.format("{\\an5\\bord3\shad0\\blur5\\1a&HFF&\\3c&H752CB1&\\jitter(1,1,1,1)\\alpha%s\\pos(%.3f,%.3f)}%s"
					,alpha,char.center,char.middle,char.text)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" or char.text~=" " then
				--char fx
				
				max_frame = 25
				local b = 0
				
				local text_shape = convert.text_to_shape(char.text, line.styleref)
				
				for s, e, i, n in utils.frames(line.start_time+char.start_time, line.start_time+char.end_time, max_frame) do
					
					l.layer = 5
					
					l.start_time=s
					l.end_time=e
					
					local step = i / n
					
					if i%2 == 0 then
						dis = -2
					else
						dis = 2
					end
					
					local x, y = char.left+dis, utils.interpolate(step, char.top-ord, char.top)
					
					local deform = shape.filter(text_shape,
					function(x,y)
						xdef = math.randomsteps(-10,10,2.5)*math.sin(b)
						ydef = math.randomsteps(-10,10,2.5)*math.sin(b)
						b = b + 90
						return x+xdef, y+ydef
					end)
					
					l.text=string.format("{\\p4\\an7\\bord1\\shad0\\blur1\\fscx100\\fscy100\\1c%s\\3c&H752CB1&\\pos(%.3f,%.3f)}%s"
					,color,x,y,deform)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" or char.text~=" " then
				--char fx outline
				
				max_frame = 25
				local b = 0
				
				local text_shape = convert.text_to_shape(char.text, line.styleref)
				
				for s, e, i, n in utils.frames(line.start_time+char.start_time, line.start_time+char.end_time, max_frame) do
					
					l.layer = 4
					
					l.start_time=s
					l.end_time=e
					
					local step = i / n
					
					if i%2 == 0 then
						dis = -2
					else
						dis = 2
					end
					
					local x, y = char.left+dis, utils.interpolate(step, char.top-ord, char.top)
					
					local deform = shape.filter(text_shape,
					function(x,y)
						xdef = math.randomsteps(-10,10,2.5)*math.sin(b)
						ydef = math.randomsteps(-10,10,2.5)*math.sin(b)
						b = b + 90
						return x+xdef, y+ydef
					end)
					
					l.text=string.format("{\\p4\\an7\\bord3\\shad0\\blur5\\fscx100\\fscy100\\1a&HFF&\\3c&H752CB1&\\pos(%.3f,%.3f)}%s"
					,x,y,deform)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" or char.text~=" " then
				--outfade
				
				l.layer = 5
				
				l.start_time=line.start_time+char.end_time
				l.end_time=line.end_time+line.outfade
				
				l.text=string.format("{\\an5\\bord1\shad0\\blur1\\1c%s\\3c&H752CB1&\\fad(0,%d)\\jitter(1,1,1,1)\\pos(%.3f,%.3f)}%s"
				,color,line.outfade,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" or char.text~=" " then
				--outfade outline
				
				l.layer = 4
				
				l.start_time=line.start_time+char.end_time
				l.end_time=line.end_time+line.outfade
				
				l.text=string.format("{\\an5\\bord3\shad0\\blur5\\1a&HFF&\\3c&H752CB1&\\fad(0,%d)\\jitter(1,1,1,1)\\pos(%.3f,%.3f)}%s"
				,line.outfade,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
		end
	end
	
	if line.style == "OP_TL" then
		
		for ci, char in pairs(line.chars) do
			
			if char.text=="" or char.text==" " then
				a = 0
			else
				a = a + 1
			end
			
			if a == 3 + math.random(-2,2) then
				color = "&H3FF2FB&"
			else
				color = "&HFEF6FF&"
			end
			
			local ord = 10*math.sin(math.deg(45*a))
			
			if char.text~="" or char.text~=" " then
				--infade
				l.layer = 5
				
				l.start_time=line.start_time-line.infade
				l.end_time=line.end_time+line.outfade
				
				l.text=string.format("{\\an5\\bord1\shad0\\blur1\\1c%s\\3c&H752CB1&\\jitter(1,1,1,1)\\fad(%d,%d)\\pos(%.3f,%.3f)}%s"
				,color,line.infade,line.outfade,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" or char.text~=" " then
				--infade outline
				
				l.layer = 5
				
				l.start_time=line.start_time-line.infade
				l.end_time=line.end_time+line.outfade
				
				l.text=string.format("{\\an5\\bord3\shad0\\blur5\\1a&HFF&\\3c&H752CB1&\\jitter(1,1,1,1)\\fad(%d,%d)\\pos(%.3f,%.3f)}%s"
				,line.infade,line.outfade,char.center,char.middle,char.text)
				
				io.write_line(l)
				
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end