--Fate/Apocrypha ED2
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	line.infade = 250
	line.outfade = 250
	
	for si, syl in ipairs(line.syls) do
		
		if syl.text~="" then
			--placeholder in L1
			l.layer = 5
			
			l.start_time=line.start_time-line.infade
			l.end_time=line.start_time+syl.start_time
			
			l.text=string.format("{\\an5\\bord1\\blur3\\shad0\\fscx100\\fscy100\\1c&HFFF2B0&\\3c&HFFF2B0&\\fad(250,0)\\pos(%.3f,%.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--placeholder in L2
			l.layer = 7
			
			l.start_time=line.start_time-line.infade
			l.end_time=line.start_time+syl.start_time
			
			l.text=string.format("{\\an5\\bord0.3\\blur0.8\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&HEF9C62&\\fad(250,0)\\pos(%.3f,%.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--placeholder out L1
			l.layer = 5
			
			l.start_time=line.start_time+syl.end_time
			l.end_time=line.end_time+line.outfade
			
			l.text=string.format("{\\an5\\bord1\\blur3\\shad0\\fscx100\\fscy100\\1c&HFFF2B0&\\3c&HFFF2B0&\\fad(0,250)\\pos(%.3f,%.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--placeholder out L2
			l.layer = 7
			
			l.start_time=line.start_time+syl.end_time
			l.end_time=line.end_time+line.outfade
			
			l.text=string.format("{\\an5\\bord0.3\\blur0.8\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&HEF9C62&\\fad(0,250)\\pos(%.3f,%.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
		end
		
		if line.actor == "fx1" then
			
			if syl.text~="" and syl.text~=" " and syl.text~="　" then
				--syl fx1
				
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
						ydef = 15*math.sin(math.rad(x+utils.interpolate(step,0,180)))
						return x+xdef, y+ydef
					end)
					
					local maxk = 2
					for k=1,maxk,1 do
						
						if k == 1 then
							l.layer = 5
							
							l.text = string.format("{\\p4\\an7\\bord1\\blur3\\shad0\\fscx100\\fscy100\\1c&HFFF2B0&\\3c&HFFF2B0&\\pos(%.3f, %.3f)}%s"
							,syl.left,syl.top,deform)
							
							io.write_line(l)
						end
						if k == 2 then
							l.layer = 7
							
							l.text = string.format("{\\p4\\an7\\bord0.3\\blur0.8\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&HEF9C62&\\pos(%.3f, %.3f)}%s"
							,syl.left,syl.top,deform)
							
							io.write_line(l)
						end
						
					end
				end
			end
			
			local maxj = 6
			for j=1,maxj,1 do
				
				if syl.text~="" then
					--FX1 - syl drops
					l.layer = 8
					
					l.start_time = math.random(line.start_time+syl.start_time-500, line.start_time+syl.end_time-500)
					l.end_time = l.start_time+750
					
					local ex, ey = math.random(syl.left,syl.right), syl.bottom-5
					local sx, sy = ex - 75, ey - 75
					
					local drop = "m 0 -9 b -1 8 -5 16 -6 25 b -6 35 -3 36 0 36 b 3 36 6 35 6 25 b 5 16 1 8 0 -9 "
					
					l.text=string.format("{\\p1\\an7\\blur0.8\\fscx10\\fscy20\\frz45\\fad(50,250)\\1c&HFFB700&\\move(%.3f, %.3f, %.3f, %.3f)}%s"
					,sx,sy,ex,ey,drop)
					
					io.write_line(l)
				end
			end
			
			local maxj = 4
			for j=1,maxj,1 do
				
				if syl.text~="" then
					--FX 1 - syl circle fx
					l.layer = 6
					
					l.start_time = math.random(line.start_time+syl.start_time-250, line.start_time+syl.end_time-250)
					l.end_time = l.start_time+750
					
					local x, y = math.random(syl.left,syl.right) - 10, syl.bottom - 15
					
					local circle = shape.ellipse(30, 30)
					
					l.text=string.format("{\\p1\\an7\\bord1\\blur0.8\\fscx30\\fscy30\\t(\\fscx100\\fscy100)\\frx70\\fad(50,250)\\1a&HFF&\\3a&H64&\\3c&HFFB700&\\pos(%.3f, %.3f)}%s"
					,x,y,circle)
					
					io.write_line(l)
				end
			end
		end
		
		if line.actor == "fx2" then
			
			if syl.text~="" then
				--FX2 - syl fx1
				l.layer = 5
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\bord1\\blur3\\shad0\\fscx130\\fscy130\\t(\\fscx100\\fscy100)\\1c&HFFF2B0&\\3c&HFFF2B0&\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--FX2 - syl fx1
				l.layer = 7
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\bord0.3\\blur0.8\\shad0\\fscx130\\fscy130\\t(\\fscx100\\fscy100)\\1c&HFFFFFF&\\3c&HEF9C62&\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			
			--FX2 - syl fx2
			max_frame = 75
			
			for s, e, i, n in utils.frames(line.start_time+syl.start_time-250, line.start_time+syl.end_time+250, max_frame) do
				
				local rs = math.randomsteps(0,250,25)
				
				l.start_time = line.start_time+syl.start_time + rs
				l.end_time = l.start_time + 1000 + math.randomsteps(-250,250,50)
				
				l.layer = math.random(4,8)
				
				local step = i / n
				
				local sc = utils.interpolate(step, 80, 40)
				
				local x = math.random(syl.left, syl.right)
				local y = math.random(line.top, line.bottom)+5
				
				local shape = shape.ellipse(3, 3)
				
				l.text = string.format("{\\an5\\p1\\blur3\\bord0.2\\shad0\\fscx%d\\fscy%d\\fad(250,250)\\alpha&H64&\\1c&HFFFFFF&\\3c&HFFFFFF&\\move(%.3f, %.3f, %.3f, %.3f)}%s"
				,sc,sc,x,y,x+math.random(-5,5),y+math.random(-5,5),shape)
				
				io.write_line(l)
			end
			
		end
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end