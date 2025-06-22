--Aldnoah.Zero OP v2
--Effects by Amberdrake
--VSFilter

function kara(line, l)
	if line.style == "AZ_OP_Romaji" then
		for si,syl in ipairs(line.syls) do
			
			line.infade = 750
			line.outfade = 750
			
			if syl.text~="" then
				--infade
				
				local clip_src = convert.text_to_shape(syl.text, line.styleref)
				local clip_fix = shape.filter(clip_src,
				function(x,y)
					x = x/8
					y = y/8
					return x, y
				end
				)
				
				local clip = shape.move(clip_fix, syl.left, syl.top)
				
				local color_dist = utils.distributor({"&HFFFEBD&", "&HF67ECE&"})
				
				local maxj = 5
				for j = 1, maxj, 1 do
					
					l.layer = 3
					
					l.start_time = line.start_time - line.infade
					l.end_time = line.start_time + 500
					
					local color = color_dist:get()
					
					local x1, y1 = syl.left + math.randomsteps(-100, 100, 25), syl.top + math.randomsteps(-100, 100, 25)
					local x2, y2 = syl.left, syl.top
					
					l.text = string.format("{\\an7\\blur5\\bord0.2\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c%s\\clip(%s)\\fad(500,100)\\move(%.3f, %.3f, %.3f, %.3f)}%s"
					,color,clip,x1,y1,x2,y2,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--outfade
				
				local clip_src = convert.text_to_shape(syl.text, line.styleref)
				local clip_fix = shape.filter(clip_src,
				function(x,y)
					x = x/8
					y = y/8
					return x, y
				end
				)
				
				local clip = shape.move(clip_fix, syl.left, syl.top)
				
				local color_dist = utils.distributor({"&HFFFEBD&", "&HF67ECE&"})
				
				local maxj = 5
				for j = 1, maxj, 1 do
					
					l.layer = 4
					
					l.start_time = line.end_time - 500
					l.end_time = line.end_time + line.outfade
					
					local color = color_dist:get()
					
					local x1, y1 = syl.left + math.randomsteps(-100, 100, 25), syl.top + math.randomsteps(-100, 100, 25)
					local x2, y2 = syl.left, syl.top
					
					l.text = string.format("{\\an7\\blur5\\bord0.2\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c%s\\fad(100,500)\\clip(%s)\\move(%.3f, %.3f, %.3f, %.3f)}%s"
					,color,clip,x1,y1,x2,y2,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--background and outfade
				
				l.layer = 1
				
				l.start_time = line.start_time-750
				l.end_time = line.end_time+750
				
				l.text = string.format("{\\an5\\blur5\\bord4\\shad0\\fscx100\\fscy100\\fad(750,750)\\1c&HFFFFFF&\\3c&HFFFEBD&\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--background and outfade outline
				
				l.layer = 2
				
				l.start_time = line.start_time-500
				l.end_time = line.end_time+500
				
				l.text = string.format("{\\an5\\blur1\\bord1\\shad0\\fscx100\\fscy100\\fad(750,750)\\1a&HFF&\\3c&H000000&\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--syl fx ellipses
				
				l.layer = 6
				
				local color_dist = utils.distributor({"&HFFFEBD&", "&HF67ECE&"})
				
				local maxj = syl.duration/20
				for j = 1, maxj, 1 do
					
					l.start_time = line.start_time + syl.start_time + math.randomsteps(0, syl.duration, 50)
					l.end_time = l.start_time + 500
					
					local color = color_dist:get()
					
					local rd_wd = math.randomsteps(30, 50, 5)
					
					local fx_shape = shape.ellipse(rd_wd,2)
					
					local x1, y1 = math.randomsteps(syl.left, syl.right, 5), math.randomsteps(syl.top + 15, syl.bottom - 10, 5)
					local x2, y2 = x1 + math.randomsteps(-10, 10, 10), y1
					
					local fx_dur = l.end_time - l.start_time
					
					local maxk = 2
					for k = 1, maxk, 1 do
						
						if k == 1 then
							bord = 5
							blur = 10
						end
						if k == 2 then
							bord = 0
							blur = 3
						end
						
						l.text = string.format("{\\p1\\an5\\blur%d\\bord%d\\shad0\\fscx100\\fscy100\\t(0,%d,\\fscy150)\\t(%d,%d,\\fscy100)\\1c&HFFFFFF&\\3c%s\\fad(150,350)\\move(%.3f, %.3f, %.3d, %.3d)}%s"
						,blur,bord,fx_dur/2,fx_dur/2,fx_dur,color,x1,y1,x2,y2,fx_shape)
						
						io.write_line(l)
					end
				end
			end
			
			if syl.text~="" then
				--syl fx text
				
				local maxj = math.random(5,8)
				for j = 1, maxj, 1 do
					
					local max_frame = 100
					
					for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
						
						l.layer = 7
						
						l.start_time = s
						l.end_time = e + 250
						
						local clip_src = shape.rectangle(20, 20)
						
						local clx, cly = math.randomsteps(syl.left, syl.right, 10), math.randomsteps(syl.top, syl.bottom, 10)
						
						local clip = shape.move(clip_src, clx, cly)
						
						l.text = string.format("{\\an5\\blur0.6\\bord0\\shad0\\fscx120\\fscy120\\1c&HFFFFFF&\\3c&H000000&\\fad(100,150)\\clip(%s)\\pos(%.3f, %.3f)}%s"
						,clip,syl.center,syl.middle,syl.text)
						
						io.write_line(l)
					end
				end
			end
		end
	end
	if line.style == "AZ_OP_TL" then
		for si,syl in ipairs(line.syls) do
			
			
			if syl.text~="" then
				--background and outfade
				
				l.layer = 1
				
				l.start_time = line.start_time
				l.end_time = line.end_time
				
				l.text = string.format("{\\an5\\blur5\\bord4\\shad0\\fscx100\\fscy100\\fad(250,250)\\1c&HFFFFFF&\\3c&HFFFEBD&\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--background and outfade outline
				
				l.layer = 2
				
				l.start_time = line.start_time
				l.end_time = line.end_time
				
				l.text = string.format("{\\an5\\blur1\\bord1\\shad0\\fscx100\\fscy100\\fad(250,250)\\1a&HFF&\\3c&H000000&\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	kara(line, table.copy(line) )
	
	io.progressbar(li / #lines)
end