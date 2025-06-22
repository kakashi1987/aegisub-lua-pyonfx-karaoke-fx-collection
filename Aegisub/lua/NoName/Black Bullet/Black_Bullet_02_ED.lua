--Black Bullet 02 Ending
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	if line.style == "ED_romanji" or line.style == "ED_kanji" then
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--infade
				maxj = line.height+60
				for j = 1,maxj,1 do
					
					l.layer = 4
					
					l.start_time = line.start_time-line.infade+25*syl.i-25
					l.end_time = line.start_time+syl.start_time
					
					clip_src = shape.rectangle(line.width+50,1)
					clip = shape.move(clip_src,line.left-25,line.top-30+j)
					
					color = utils.interpolate(j/maxj,"&HFFFFFF&","&HF5D16B&")
					
					l.text = string.format("{\\an5\\blur0.6\\bord0\\shad0\\frz90\\t(0,500,\\frz0)\\fad(500,0)\\fscx100\\fscy100\\1c%s\\clip(%s)\\move(%.3f, %.3f, %.3f, %.3f, 0, 500)}%s"
					,color,clip,syl.center-15,syl.middle-15,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--infade bord
				l.layer = 3
				
				l.start_time = line.start_time-line.infade+25*syl.i-25
				l.end_time = line.start_time+syl.start_time
				
				l.text = string.format("{\\an5\\blur1\\bord1\\shad0\\frz90\\t(0,500,\\frz0)\\fad(500,0)\\fscx100\\fscy100\\1a&HFF&\\3c&H412924&\\move(%.3f, %.3f, %.3f, %.3f, 0, 500)}%s"
				,syl.center-15,syl.middle-15,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--syl effect
				
				max_frame = 25
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					maxj = line.height+10
					for j = 1,maxj,1 do
						
						l.layer = 4
						
						l.start_time = s
						l.end_time = e
						
						step = i / n
						
						clip_src = shape.rectangle(line.width+50,1)
						clip = shape.move(clip_src,line.left-25,line.top-5+j)
						
						color = utils.interpolate(j/maxj, utils.interpolate(step, "&HF5D16B&", "&H451056&"), utils.interpolate(step, "&H451056&","&HF5D16B&"))
						
						l.text = string.format("{\\an5\\blur1\\bord0\\shad0\\frz0\\fscx100\\fscy100\\1c%s\\clip(%s)\\pos(%.3f, %.3f)}%s"
						,color,clip,syl.center,syl.middle,syl.text)
						
						io.write_line(l)
					end
				end
			end
			
			if syl.text~="" then
				--syl effect outline
				
				l.layer = 3
				
				l.start_time = line.start_time+syl.start_time
				l.end_time = line.start_time+syl.end_time
				
				l.text = string.format("{\\an5\\blur1\\bord1\\shad0\\frz0\\fscx100\\fscy100\\1a&HFF&\\3c&HFFFFFFF&\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--syl effect bord
				
				max_frame = 100
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					local text_shape = convert.text_to_shape(syl.text, line.styleref)
					local text_outline_shape = shape.tooutline(shape.split(text_shape), 5)
					local text_outline_pixels = convert.shape_to_pixels(text_outline_shape, true)
					
					local l = table.copy(line)
					
					for pi, pixel in ipairs(text_outline_pixels) do
						
						l.layer = 2
						
						l.start_time = s
						l.end_time = e + 250
						
						x = syl.left + pixel.x + math.randomsteps(-3, 3, 0.5)
						y = syl.top + pixel.y + math.randomsteps(-3, 3, 0.25)
						
						l.text = string.format("{\\p1\\an7\\blur0.8\\bord0\\shad2\\fscx100\\fscy100\\fad(100,150)\\1c&HFFFFFF&\\4c&HF5D16B&\\pos(%.3f, %.3f)}m 0 0 l 1 0 1 1 0 1"
						,x,y)
						
						io.write_line(l)
					end
				end
			end
			
			if syl.text~="" then
				--outfade
				maxj = line.height+60
				for j = 1,maxj,1 do
					l.layer = 4
					
					l.start_time = line.start_time+syl.end_time
					l.end_time = line.end_time+line.outfade+25*syl.i-25
					
					of_start = l.end_time-l.start_time-500
					of_end = l.end_time-l.start_time
					
					clip_src = shape.rectangle(line.width+50,1)
					clip = shape.move(clip_src,line.left-25,line.top-30+j)
					
					color = utils.interpolate(j/maxj,"&HFFFFFF&","&HF5D16B&")
					
					l.text = string.format("{\\an5\\blur0.6\\bord0\\shad0\\frz0\\t(%d,%d,\\frz-90)\\fad(0,500)\\fscx100\\fscy100\\1c%s\\clip(%s)\\move(%.3f, %.3f, %.3f, %.3f, %d, %d)}%s"
					,of_start,of_end,color,clip,syl.center,syl.middle,syl.center+15,syl.middle+15,of_start,of_end,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--outfade bord
				l.layer = 3
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade+25*syl.i-25
				
				of_start = l.end_time-l.start_time-500
				of_end = l.end_time-l.start_time
				
				l.text = string.format("{\\an5\\blur1\\bord1\\shad0\\frz0\\t(%d,%d,\\frz-90)\\fad(0,500)\\fscx100\\fscy100\\1a&HFF&\\3c&H412924&\\move(%.3f, %.3f, %.3f, %.3f, %d, %d)}%s"
				,of_start,of_end,syl.center,syl.middle,syl.center+15,syl.middle+15,of_start,of_end,syl.text)
				
				io.write_line(l)
			end
		end
	end
	
	if line.style == "ED_TL" then
		
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" then
				--infade
				maxj = line.height+60
				for j = 1,maxj,1 do
					
					l.layer = 4
					
					l.start_time = line.start_time-line.infade+13*char.i-13
					l.end_time = line.start_time+char.end_time
					
					clip_src = shape.rectangle(line.width+50,1)
					clip = shape.move(clip_src,line.left-25,line.top-30+j)
					
					color = utils.interpolate(j/maxj,"&HFFFFFF&","&HF5D16B&")
					
					l.text = string.format("{\\an5\\blur0.6\\bord0\\shad0\\fad(500,0)\\fscx100\\fscy100\\1c%s\\clip(%s)\\pos(%.3f, %.3f)}%s"
					,color,clip,char.center,char.middle,char.text)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" then
				--infade bord
				l.layer = 3
				
				l.start_time = line.start_time-line.infade+13*char.i-13
				l.end_time = line.start_time+char.end_time
				
				l.text = string.format("{\\an5\\blur1\\bord1\\shad0\\fscx100\\fad(500,0)\\fscy100\\1a&HFF&\\3c&H412924&\\pos(%.3f, %.3f)}%s"
				,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--outfade
				maxj = line.height+60
				for j = 1,maxj,1 do
					l.layer = 4
					
					l.start_time = line.start_time+char.end_time
					l.end_time = line.end_time+line.outfade+13*char.i-13
					
					clip_src = shape.rectangle(line.width+50,1)
					clip = shape.move(clip_src,line.left-25,line.top-30+j)
					
					color = utils.interpolate(j/maxj,"&HFFFFFF&","&HF5D16B&")
					
					l.text = string.format("{\\an5\\blur0.6\\bord0\\shad0\\fad(0,500)\\fscx100\\fscy100\\1c%s\\clip(%s)\\pos(%.3f, %.3f)}%s"
					,color,clip,char.center,char.middle,char.text)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" then
				--outfade bord
				l.layer = 3
				
				l.start_time = line.start_time+char.end_time
				l.end_time = line.end_time+line.outfade+13*char.i-13
				
				l.text = string.format("{\\an5\\blur1\\bord1\\shad0\\fad(0,500)\\fscx100\\fscy100\\1a&HFF&\\3c&H412924&\\pos(%.3f, %.3f)}%s"
				,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
		end
	end
	
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end