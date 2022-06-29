--Log Horizon Ending
--Karaoke by Amberdrake
--VSFilter

function kara (line, l)
	if line.infade > 500 then
		line.infade = 250
	end
	if line.outfade > 500 then
		line.outfade = 250
	end
	
	if line.style == "ED_Romanji" then
		
		for si,syl in ipairs(line.syls) do
			
			if line.i < 5 then
				color = "&H8EFCFA&" --yellow
			elseif line.i >= 5 and line.i < 8 then
				color = "&HA1FDBE&" --green
			elseif line.i == 8 and syl.i <= 13 then
				color = "&HA1FDBE&" --green
			elseif line.i == 8 and syl.i > 13 and syl.i < 20 then
				color = "&HFDF2BB&" --light_blue
			elseif line.i == 8 and syl.i == 20 then
				color = "&HFAC073&" --dark_blue
			elseif line.i >= 9 and line.i < 13 then
				color = "&HFAC073&" --dark_blue
			elseif line.i >= 13 and line.i < 15 then
				color = "&HF9AAD7&" --purple
			elseif line.i == 15 and syl.i < 5 then
				color = "&HA558F1&" --pink
			elseif line.i == 15 and syl.i >= 5 then
				color = "&H6EADF5&" --orange
			elseif line.i > 15 then
				color = "&H6EADF5&" --orange
			end
			
			if syl.text~="" then
				--infade
				
				l.start_time = line.start_time-line.infade/2
				l.end_time = line.start_time+syl.start_time
				
				l.layer = 8
				
				l.text = string.format("{\\an5\\blur0.4\\bord4\\shad0\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" and syl.text ~=" " then
				
				local max_frame = 25
				local a = 0
				local u_out = 0
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					--circles syl circles layer 1
					l.start_time = s
					l.end_time = e+50
					
					l.layer = 3
					
					local step = i / n
					
					local circle = shape.ring(45, 40)
					
					local fad = syl.duration/4
					local max=math.ceil(fad/max_frame)
					if i>(n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						u_out=u_out+1
					else
						alpha="&H00&"
					end
					
					local sc = 50+70*math.sin(math.rad(utils.interpolate(step, 0, 90))) + 5*math.sin(math.rad(a))
					a = a + 90
					
					local x, y = syl.center+2, syl.middle+7
					
					l.text = string.format("{\\an5\\p1\\blur0.4\\fscx%d\\fscy%d\\fad(0,50)\\alpha%s\\1c%s\\pos(%.3f, %.3f)}%s"
					,sc,sc,alpha,color,x,y,circle)
					
					io.write_line(l)
					
				end
			end
			
			if syl.text~="" and syl.text ~=" " then
				
				local max_frame = 25
				local a = 0
				local u_out=0
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					--circles syl circles layer 2
					l.start_time = s
					l.end_time = e+50
					
					l.layer = 3
					
					local step = i / n
					
					local circle = shape.ellipse(50, 50)
					
					local fad = syl.duration/4
					local max=math.ceil(fad/max_frame)
					if i>(n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						u_out=u_out+1
					else
						alpha="&H00&"
					end
					
					local sc = 70+50*math.sin(math.rad(utils.interpolate(step, 0, 90))) + 5*math.sin(math.rad(a))
					a = a + 90
					
					local x, y = syl.center+2, syl.middle+7
					
					l.text = string.format("{\\an5\\p1\\blur0.4\\bord0\\fscx%d\\fscy%d\\fad(0,50)\\alpha%s\\1c%s\\pos(%.3f, %.3f)}%s"
					,sc,sc,alpha,color,x,y,circle)
					
					io.write_line(l)
					
				end
			end
			
			if syl.text~="" then
				
				local max_frame = 25
				local b = 0
				local u_out=0
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					--syl effect
					l.start_time = s
					l.end_time = e
					
					l.layer = 8
					
					local step = i / n
					
					local scx, scy = 90 + 10*math.sin(math.rad(b)), 110 + 10*math.sin(math.rad(b))
					b = b + 80
					
					l.text = string.format("{\\an5\\blur0.4\\bord4\\fscx%d\\fscy%d\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f, %.3f)}%s"
					,scx,scy,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
					
				end
			end
			
			if syl.text~="" then
				
				local max_frame = 25
				local b = 0
				local u_out=0
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					--syl effect bord
					l.start_time = s
					l.end_time = e
					
					l.layer = 7
					
					local step = i / n
					
					local scx, scy = 90 + 10*math.sin(math.rad(b)), 110 + 10*math.sin(math.rad(b))
					b = b + 80
					
					l.text = string.format("{\\an5\\blur0.4\\bord8\\fscx%d\\fscy%d\\1c%s\\3c%s\\pos(%.3f, %.3f)}%s"
					,scx,scy,color,color,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
					
				end
			end
			
			if syl.text~="" then
				--outfade bord
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade/2
				
				l.layer = 7
				
				l.text = string.format("{\\an5\\blur0.4\\bord8\\shad0\\1c%s\\3c%s\\pos(%.3f, %.3f)}%s"
				,color,color,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--outfade
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade/2
				
				l.layer = 8
				
				l.text = string.format("{\\an5\\blur0.4\\bord4\\shad0\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
		end
	end
	
	if line.style == "ED_TL" then
		
		if line.text~="" then
			
			l.start_time = line.start_time-line.infade/2
			l.end_time = line.end_time+line.outfade/2
			
			l.layer = 8
			
			l.text = string.format("{\\an5\\blur0.4\\bord4\\shad0\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f, %.3f)}%s"
			,line.center,line.middle,line.text)
			
			io.write_line(l)
		end
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end