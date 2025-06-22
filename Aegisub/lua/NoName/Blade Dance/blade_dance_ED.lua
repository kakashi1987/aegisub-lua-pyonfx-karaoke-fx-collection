--Seirei Tsukai no Blade Dance ED
--Karaoke by Amberdrake
--VSFilter

function romanji(line, l)
	
	if line.infade > 150 then
		line.infade = 150
	end
	if line.outfade > 150 then
		line.outfade = 150
	end
	
	if line.style == "ED_romanji" or line.style == "ED_romanji_overlap" or line.style == "ED_kanji" or line.style == "ED_kanji_overlap" then
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--infade/outfade
				
				l.layer = 5
				
				l.start_time = line.start_time-line.infade
				l.end_time = line.start_time+syl.start_time
				
				local color = utils.interpolate(syl.i/#line.syls, "&H9FAA4E&", "&H923E27&")
				
				l.text = string.format("{\\an5\\blur0.4\\bord0\\shad0\\fscx100\\fscy100\\1c%s\\fad(150,0)\\pos(%.3f, %.3f)}%s"
				,color,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--infade outline 1
				
				l.layer = 4
				
				l.start_time = line.start_time-line.infade
				l.end_time = line.start_time+syl.start_time
				
				l.text = string.format("{\\an5\\blur0.6\\bord3\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&HFFFFFF&\\fad(150,0)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--infade outline 2
				
				l.layer = 3
				
				l.start_time = line.start_time-line.infade
				l.end_time = line.start_time+syl.start_time
				
				l.text = string.format("{\\an5\\blur1\\bord6\\shad3\\fscx100\\fscy100\\1c&H762907&\\3c&H762907&\\4c&HDFCD7E&\\4a&H32&\\fad(150,0)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--syl fx
				
				l.layer = 6
				
				l.start_time = line.start_time+syl.start_time
				l.end_time = line.start_time+syl.end_time
				
				local color = utils.interpolate(syl.i/#line.syls, "&H9FAA4E&", "&H923E27&")
				
				l.text = string.format("{\\an5\\blur0.4\\bord0\\shad0\\fscx110\\fscy110\\fsp4\\t(\\fscx100\\fscy100\\fsp0)\\1c%s\\pos(%.3f, %.3f)}%s"
				,color,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--syl fx outline 1
				
				l.layer = 4
				
				l.start_time = line.start_time+syl.start_time
				l.end_time = line.start_time+syl.end_time
				
				l.text = string.format("{\\an5\\blur0.8\\bord3\\shad0\\fscx120\\fscy120\\fsp3\\t(\\fscx100\\fscy100\\fsp0)\\1c&HFFFFFF&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--syl fx outline 2
				
				l.layer = 3
				
				l.start_time = line.start_time+syl.start_time
				l.end_time = line.start_time+syl.end_time
				
				l.text = string.format("{\\an5\\blur1\\bord6\\shad4\\fscx130\\fscy130\\fsp2\\t(\\fscx100\\fscy100\\fsp0)\\1c&H762907&\\3c&H762907&\\4c&HDFCD7E&\\4a&H32&\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--syl ball fx
				if line.style == "ED_romanji" or line.style == "ED_romanji_overlap" then
					ball = shape.ellipse(8,8)
					an = 7
				end
				if line.style == "ED_kanji" or line.style == "ED_kanji_overlap" then
					ball = shape.ellipse(7,7)
					an = 4
				end
				
				max_frame=25
				u_in=0
				u_out=0
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.layer = 8
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					local fad = 150
					if syl.i == 1 then
						
						max=math.ceil(fad/max_frame)
						if i<math.ceil(fad/max_frame) then
							alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
							u_in=u_in+1
						else
							alpha="&H32&"
						end
						
					elseif syl.i == #line.syls then
						
						max=math.ceil(fad/max_frame)
						if i>(n-math.ceil(fad/max_frame)) then
							alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
							u_out=u_out+1
						else
							alpha="&H00&"
						end
						
					else
						alpha="&H00&"
					end
					
					local x, y = utils.interpolate(step, syl.left, syl.right), syl.top-5+7*math.sin(math.rad(utils.interpolate(step, 90, 270)))
					
					l.text = string.format("{\\p1\\an%d\\blur1.2\\bord3\\fscx100\\fscy100\\1c&H762907&\\3c&HFFFFFF&\\alpha%s\\pos(%.3f, %.3f)}%s"
					,an,alpha,x,y,ball)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--outfade
				
				l.layer = 5
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade
				
				local color = utils.interpolate(syl.i/#line.syls, "&H9FAA4E&", "&H923E27&")
				
				l.text = string.format("{\\an5\\blur0.4\\bord0\\shad0\\fscx100\\fscy100\\1c%s\\fad(0,150)\\pos(%.3f, %.3f)}%s"
				,color,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--outfade outline 1
				
				l.layer = 4
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade
				
				l.text = string.format("{\\an5\\blur0.6\\bord3\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&HFFFFFF&\\fad(0,150)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--outfade outline 2
				
				l.layer = 3
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade
				
				l.text = string.format("{\\an5\\blur1\\bord6\\shad3\\fscx100\\fscy100\\1c&H762907&\\3c&H762907&\\4c&HDFCD7E&\\4a&H32&\\fad(0,150)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
		end
	end
	
	if line.style == "ED_high" then
		
		for si,syl in ipairs(line.syls) do
			
			local hx, hy = 1160 ,38
			
			if syl.text~="" then
				--high fx
				
				l.layer = 5
				
				l.start_time = line.start_time+syl.start_time
				l.end_time = line.start_time+syl.end_time
				
				l.text = string.format("{\\an5\\blur0.4\\bord0\\shad0\\fscx100\\fscy100\\fsp0\\t(\\fscx135\\fscy130\\blur1.2\\fsp4)\\fad(0,%d)\\1c&H923E27&\\pos(%.3f, %.3f)}%s"
				,syl.duration/4,hx,hy,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--high fx outline 1
				
				l.layer = 4
				
				l.start_time = line.start_time+syl.start_time
				l.end_time = line.start_time+syl.end_time
				
				l.text = string.format("{\\an5\\blur0.6\\bord3\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&HFFFFFF&\\t(\\fscx140\\fscy140\\blur2)\\fad(0,%d)\\pos(%.3f, %.3f)}%s"
				,syl.duration/3,hx,hy,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--high fx outline 2
				
				l.layer = 3
				
				l.start_time = line.start_time+syl.start_time
				l.end_time = line.start_time+syl.end_time
				
				l.text = string.format("{\\an5\\blur1\\bord6\\shad3\\fscx100\\fscy100\\1c&H762907&\\3c&H762907&\\4c&HDFCD7E&\\4a&H32&\\t(\\fscx150\\fscy150\\blur3)\\fad(0,%d)\\pos(%.3f, %.3f)}%s"
				,syl.duration/2,hx,hy,syl.text)
				
				io.write_line(l)
			end
		end
	end
	
	if line.style == "ED_TL" then
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--infade/outfade
				
				l.layer = 5
				
				l.start_time = line.start_time-line.infade
				l.end_time = line.end_time+line.outfade
				
				local color = utils.interpolate(syl.i/#line.syls, "&H9FAA4E&", "&H923E27&")
				
				l.text = string.format("{\\an5\\blur0.4\\bord0\\shad0\\fscx100\\fscy100\\1c%s\\fad(150,150)\\pos(%.3f, %.3f)}%s"
				,color,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--infade outline 1
				
				l.layer = 4
				
				l.start_time = line.start_time-line.infade
				l.end_time = line.end_time+line.outfade
				
				l.text = string.format("{\\an5\\blur0.6\\bord3\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&HFFFFFF&\\fad(150,150)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--infade outline 2
				
				l.layer = 3
				
				l.start_time = line.start_time-line.infade
				l.end_time = line.end_time+line.outfade
				
				l.text = string.format("{\\an5\\blur1\\bord6\\shad3\\fscx100\\fscy100\\1c&H762907&\\3c&H762907&\\4c&HDFCD7E&\\4a&H32&\\fad(150,150)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
		end
	end
end

for li, line in ipairs(lines) do
	
	romanji( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end