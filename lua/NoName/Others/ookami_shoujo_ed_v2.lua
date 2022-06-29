--Ookami Shoujo to Kuro Ouji Ending
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	if line.infade > 500 then
		line.infade = 250
	end
	if line.outfade > 500 then
		line.outfade = 250
	end
	
	if line.style == "TL-ED" then
		
		for si,syl in ipairs(line.syls) do
			if syl.text~="" then
				--infade/outfade L1
				
				l.layer = 6
				
				l.start_time = line.start_time-line.infade
				l.end_time = line.end_time+line.outfade
				
				l.text = string.format("{\\an5\\bord2\\blur1.2\\shad0\\fscx100\\fscy100\\1c&HEAB8B5&\\3c&HFFFFFF&\\fad(250,0)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--infade/outfade L2
				
				l.layer = 5
				
				l.start_time = line.start_time-line.infade
				l.end_time = line.end_time+line.outfade
				
				l.text = string.format("{\\an5\\bord6\\blur1.8\\shad0\\fscx100\\fscy100\\1c&HEAB8B5&\\3c&HEAB8B5&\\fad(250,0)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--line circle fx
				
				if syl.i%2==0 then
					
					local rad = math.randomsteps(30, 60, 10)
					local circ = shape.ellipse(rad, rad)
					local color_array = {"&H2EED1F&", "&HD2FFAF&", "&H45E3FB&", "&HFC72E6&", "&HEAB8B5&"}
					local color = color_array[math.random(1,table.getn(color_array))]
					local x, y = syl.center, syl.middle + math.randomsteps(-15, 15, 7.5)
					
					for j = 1,2,1 do
						
						if j == 1 then
							alpha = "&HFF&"
							local bord_val = math.random(8,12)
							bord = string.format("\\bord%d\\t(\\bord1)", bord_val)
							local sc_start = math.randomsteps(50, 70, 10)
							sc = string.format("\\fscx%d\\fscy%d\\t(\\fscx100\\fscy100)", sc_start, sc_start)
							fad = 500
						end
						
						if j == 2 then
							alpha = "&H00&"
							bord = string.format("\\bord0")
							local sc_start = math.randomsteps(10, 30, 10)
							sc = string.format("\\fscx%d\\fscy%d\\t(\\fscx90\\fscy90)", sc_start, sc_start)
							fad = 750
						end
						
						l.start_time = line.start_time-line.infade + math.randomsteps(0, 1000, 250)
						l.end_time = line.end_time+line.outfade - math.randomsteps(0, 1000, 250)
						
						l.layer = 3
						
						l.text = string.format("{\\p1\\an5%s\\blur1.3\\shad0%s\\1a%s\\fad(%d,%d)\\1c%s\\3c%s\\pos(%.3f, %.3f)}%s"
						,bord,sc,alpha,fad,fad,color,color,x,y,circ)
						
						io.write_line(l)
					end
				end
			end
		end
	end
	
	if line.style == "Romaji-ED" then
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--fadein L1
				
				l.layer = 6
				
				l.start_time = line.start_time-line.infade
				l.end_time = line.start_time+syl.start_time
				
				l.text = string.format("{\\an5\\bord2\\blur1.2\\shad0\\fscx100\\fscy100\\1c&HEAB8B5&\\3c&HFFFFFF&\\fad(250,0)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--fadein L2
				
				l.layer = 5
				
				l.start_time = line.start_time-line.infade
				l.end_time = line.start_time+syl.start_time
				
				l.text = string.format("{\\an5\\bord6\\blur1.8\\shad0\\fscx100\\fscy100\\1c&HEAB8B5&\\3c&HEAB8B5&\\fad(250,0)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--fadeout L1
				
				l.layer = 6
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade
				
				l.text = string.format("{\\an5\\bord2\\blur1.2\\shad0\\fscx100\\fscy100\\1c&HEAB8B5&\\3c&HFFFFFF&\\fad(0,250)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--fadeout L2
				
				l.layer = 5
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade
				
				l.text = string.format("{\\an5\\bord6\\blur1.8\\shad0\\fscx100\\fscy100\\1c&HEAB8B5&\\3c&HEAB8B5&\\fad(0,250)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--syl fx L1
				
				l.layer = 9
				
				local fx_start = line.start_time+syl.start_time
				local fx_end = line.start_time+syl.end_time
				local max_frame = 25
				
				local a = 0
				
				for s, e, i, n in utils.frames(fx_start, fx_end, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					local sc = 105 + 15*math.sin(math.abs(math.rad(a)))
					a = a + 15
					
					l.text = string.format("{\\an5\\bord2\\blur1.2\\shad0\\fscx%d\\fscy%d\\1c&HEAB8B5&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
					,sc,sc,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--syl fx L2
				
				l.layer = 8
				
				local fx_start = line.start_time+syl.start_time
				local fx_end = line.start_time+syl.end_time
				local max_frame = 25
				
				local a = 0
				
				for s, e, i, n in utils.frames(fx_start, fx_end, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					local sc = 105 + 15*math.sin(math.abs(math.rad(a)))
					a = a + 15
					
					
					l.text = string.format("{\\an5\\bord6\\blur1.8\\shad0\\fscx%s\\fscy%s\\1c&HEAB8B5&\\3c&HEAB8B5&\\pos(%.3f, %.3f)}%s"
					,sc,sc,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--syl hearts fx
				
				l.layer = math.random(5,10)
				
				local maxj = math.random(1,3)
				for j = 1, maxj, 1 do
					
					l.start_time = line.start_time + syl.start_time + math.randomsteps(0, 150, 50)
					l.end_time = line.start_time + syl.end_time + math.randomsteps(1000, 1500, 250)
					
					local heart = shape.heart(12, 0)
					
					local x, y = syl.center + math.randomsteps(-20, 20, 5), syl.middle + math.randomsteps(-20, 20, 5)
					local x_m, y_m = x + math.randomsteps(-5, 5, 10), y + math.randomsteps(-5, 5, 10)
					
					l.text = string.format("{\\p1\\an5\\bord0\\blur1.1\\shad0\\fscx100\\fscy100\\1c&H9A90F2&\\fad(500, 500)\\move(%.3f, %.3f, %.3f, %.3f)}%s"
					,x,y,x_m,y_m,heart)	
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--line circle fx
				
				if syl.i%2==0 then
					
					local rad = math.randomsteps(30, 60, 10)
					local circ = shape.ellipse(rad, rad)
					local color_array = {"&H2EED1F&", "&HD2FFAF&", "&H45E3FB&", "&HFC72E6&", "&HEAB8B5&"}
					local color = color_array[math.random(1,table.getn(color_array))]
					local x, y = syl.center, syl.middle + math.randomsteps(-15, 15, 7.5)
					
					for j = 1,2,1 do
						
						if j == 1 then
							alpha = "&HFF&"
							local bord_val = math.random(8,12)
							bord = string.format("\\bord%d\\t(\\bord1)", bord_val)
							local sc_start = math.randomsteps(50, 70, 10)
							sc = string.format("\\fscx%d\\fscy%d\\t(\\fscx100\\fscy100)", sc_start, sc_start)
							fad = 500
						end
						
						if j == 2 then
							alpha = "&H00&"
							bord = string.format("\\bord0")
							local sc_start = math.randomsteps(10, 30, 10)
							sc = string.format("\\fscx%d\\fscy%d\\t(\\fscx90\\fscy90)", sc_start, sc_start)
							fad = 750
						end
						
						l.start_time = line.start_time-line.infade + math.randomsteps(0, 1000, 250)
						l.end_time = line.end_time+line.outfade - math.randomsteps(0, 1000, 250)
						
						l.layer = 3
						
						l.text = string.format("{\\p1\\an5%s\\blur1.3\\shad0%s\\1a%s\\fad(%d,%d)\\1c%s\\3c%s\\pos(%.3f, %.3f)}%s"
						,bord,sc,alpha,fad,fad,color,color,x,y,circ)
						
						io.write_line(l)
					end
				end
			end
		end
	end
	
	if line.style == "Kanji-ED" then
		
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" then
				--fadein L1
				
				l.layer = 6
				
				l.start_time = line.start_time-line.infade
				l.end_time = line.start_time+char.start_time
				
				l.text = string.format("{\\an5\\bord2\\blur1.2\\shad0\\fscx100\\fscy100\\1c&HEAB8B5&\\3c&HFFFFFF&\\fad(250,0)\\pos(%.3f, %.3f)}%s"
				,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--fadein L2
				
				l.layer = 5
				
				l.start_time = line.start_time-line.infade
				l.end_time = line.start_time+char.start_time
				
				l.text = string.format("{\\an5\\bord6\\blur1.8\\shad0\\fscx100\\fscy100\\1c&HEAB8B5&\\3c&HEAB8B5&\\fad(250,0)\\pos(%.3f, %.3f)}%s"
				,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--fadeout L1
				
				l.layer = 6
				
				l.start_time = line.start_time+char.end_time
				l.end_time = line.end_time+line.outfade
				
				l.text = string.format("{\\an5\\bord2\\blur1.2\\shad0\\fscx100\\fscy100\\1c&HEAB8B5&\\3c&HFFFFFF&\\fad(0,250)\\pos(%.3f, %.3f)}%s"
				,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--fadeout L2
				
				l.layer = 5
				
				l.start_time = line.start_time+char.end_time
				l.end_time = line.end_time+line.outfade
				
				l.text = string.format("{\\an5\\bord6\\blur1.8\\shad0\\fscx100\\fscy100\\1c&HEAB8B5&\\3c&HEAB8B5&\\fad(0,250)\\pos(%.3f, %.3f)}%s"
				,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--char fx L1
				
				l.layer = 9
				
				local fx_start = line.start_time+char.start_time
				local fx_end = line.start_time+char.end_time
				local max_frame = 25
				
				local a = 0
				
				for s, e, i, n in utils.frames(fx_start, fx_end, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					local sc = 105 + 15*math.sin(math.abs(math.rad(a)))
					a = a + 15
					
					l.text = string.format("{\\an5\\bord2\\blur1.2\\shad0\\fscx%d\\fscy%d\\1c&HEAB8B5&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
					,sc,sc,char.center,char.middle,char.text)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" then
				--char fx L2
				
				l.layer = 8
				
				local fx_start = line.start_time+char.start_time
				local fx_end = line.start_time+char.end_time
				local max_frame = 25
				
				local a = 0
				
				for s, e, i, n in utils.frames(fx_start, fx_end, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					local sc = 105 + 15*math.sin(math.abs(math.rad(a)))
					a = a + 15
					
					l.text = string.format("{\\an5\\bord6\\blur1.8\\shad0\\fscx%s\\fscy%s\\1c&HEAB8B5&\\3c&HEAB8B5&\\pos(%.3f, %.3f)}%s"
					,sc,sc,char.center,char.middle,char.text)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" then
				--char hearts fx
				
				l.layer = math.random(5,10)
				
				local maxj = math.random(1,3)
				for j = 1, maxj, 1 do
					
					l.start_time = line.start_time + char.start_time + math.randomsteps(0, 150, 50)
					l.end_time = line.start_time + char.end_time + math.randomsteps(1000, 1500, 250)
					
					local heart = shape.heart(10, 0)
					
					local x, y = char.center + math.randomsteps(-20, 20, 5), char.middle + math.randomsteps(-20, 20, 5)
					local x_m, y_m = x + math.randomsteps(-5, 5, 10), y + math.randomsteps(-5, 5, 10)
					
					l.text = string.format("{\\p1\\an5\\bord0\\blur1.1\\shad0\\fscx100\\fscy100\\1c&H9A90F2&\\fad(500, 500)\\move(%.3f, %.3f, %.3f, %.3f)}%s"
					,x,y,x_m,y_m,heart)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" then
				--line circle fx
				
				if char.i%2==0 then
					
					local rad = math.randomsteps(20, 50, 10)
					local circ = shape.ellipse(rad, rad)
					local color_array = {"&H2EED1F&", "&HD2FFAF&", "&H45E3FB&", "&HFC72E6&", "&HEAB8B5&"}
					local color = color_array[math.random(1,table.getn(color_array))]
					local x, y = char.center + math.randomsteps(-15, 15, 7.5), char.middle
					
					for j = 1,2,1 do
						
						if j == 1 then
							alpha = "&HFF&"
							local bord_val = math.random(8,12)
							bord = string.format("\\bord%d\\t(\\bord1)", bord_val)
							local sc_start = math.randomsteps(50, 70, 10)
							sc = string.format("\\fscx%d\\fscy%d\\t(\\fscx100\\fscy100)", sc_start, sc_start)
							fad = 500
						end
						
						if j == 2 then
							alpha = "&H00&"
							bord = string.format("\\bord0")
							local sc_start = math.randomsteps(10, 30, 10)
							sc = string.format("\\fscx%d\\fscy%d\\t(\\fscx90\\fscy90)", sc_start, sc_start)
							fad = 750
						end
						
						l.start_time = line.start_time-line.infade + math.randomsteps(0, 1000, 250)
						l.end_time = line.end_time+line.outfade - math.randomsteps(0, 1000, 250)
						
						l.layer = 3
						
						l.text = string.format("{\\p1\\an5%s\\blur1.3\\shad0%s\\1a%s\\fad(%d,%d)\\1c%s\\3c%s\\pos(%.3f, %.3f)}%s"
						,bord,sc,alpha,fad,fad,color,color,x,y,circ)
						
						io.write_line(l)
					end
				end
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end