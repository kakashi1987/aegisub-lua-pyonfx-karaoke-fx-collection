--Shinmai Maou no Testament ED2
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	if line.infade > 250 then
		line.infade = 250
	end
	if line.outfade > 250 then
		line.outfade = 250
	end
	
	if line.actor == "black" then
		color = "&H000000&"
	end
	if line.actor == "purple" then
		color = "&HB22F69&"
	end
	if line.actor == "blue" then
		color = "&HB79B3E&"
	end
	if line.actor == "red" then
		color = "&H27139F&"
	end
	if line.style == "Shinmai_ED_TL" then
		for si,char in ipairs(line.chars) do
			
			if char.text~="" then
				--if/of
				
				local max_frame = 23.976
				
				local u_in, u_out = 0, 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+50*char.i-50, line.end_time+line.outfade+50*char.i-50, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e
					
					local fad = 500
					local max = math.ceil(fad/max_frame)
					
					if i < math.ceil(fad/max_frame) then
						alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
						sc = 100+10*math.sin((math.rad(utils.interpolate(u_in/max, 0, 180))))
						u_in = u_in + 1
					elseif i > (n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						sc = 100+5*math.sin((math.rad(utils.interpolate(u_out/max, 0, 180))))
						u_out = u_out + 1
					else
						alpha = "&H00&"
						sc = 100
					end
					
					l.text = string.format("{\\an5\\blur3\\bord3\\shad0\\fscx%d\\fscy%d\\alpha%s\\1c%s\\3c&HFFFFFF&\\pos(%.3f,%.3f)}%s"
					,sc,sc,alpha,color,char.center,char.middle,char.text)
					
					io.write_line(l)
				end
			end
		end
	end
	if line.style == "Shinmai_ED_romaji" or line.style == "Shinmai_ED_kanji" then
		for si,char in ipairs(line.chars) do
			
			if char.text~="" then
				--if/of
				
				local max_frame = 23.976
				
				local u_in, u_out = 0, 0
				
				for s, e, i, n in utils.frames(line.start_time-line.infade+50*char.i-50, line.end_time+line.outfade+50*char.i-50, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e
					
					local fad = 500
					local max = math.ceil(fad/max_frame)
					
					if i < math.ceil(fad/max_frame) then
						alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
						sc = 100+10*math.sin((math.rad(utils.interpolate(u_in/max, 0, 180))))
						u_in = u_in + 1
					elseif i > (n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						sc = 100+5*math.sin((math.rad(utils.interpolate(u_out/max, 0, 180))))
						u_out = u_out + 1
					else
						alpha = "&H00&"
						sc = 100
					end
					
					l.text = string.format("{\\an5\\blur3\\bord3\\shad0\\fscx%d\\fscy%d\\alpha%s\\1c%s\\3c&HFFFFFF&\\pos(%.3f,%.3f)}%s"
					,sc,sc,alpha,color,char.center,char.middle,char.text)
					
					io.write_line(l)
				end
			end
		end
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--fx
				
				local max_frame = 50
				
				local b = 0
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time+500, max_frame) do
					
					l.layer = 6
					
					l.start_time = s - 75
					l.end_time = e + 75
					
					local step = i / n
					
					local sc = 100 + 40*math.sin(math.rad(utils.interpolate(step, 0, 180))) + 10*math.sin(b)
					b = b + 15
					
					local x, y = syl.center + math.random(-1,1), syl.middle+math.random(-1,1)
					
					l.text = string.format("{\\an5\\blur3\\bord1\\shad0\\fscx%d\\fscy%d\\fad(75,75)\\1a&H96&\\1c%s\\3c&HFFFFFF&\\pos(%.3f,%.3f)}%s"
					,sc,sc,color,x,y,syl.text)
					
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