--Shinmai Maou no Testament OP
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	line.infade = 300
	line.outfade = 550
	
	local pos_dist = utils.distributor({-0.5, 0.75, -0.75, 0.5})
	
	for ci,char in ipairs(line.chars) do
		
		local y_shift = pos_dist:get()
		
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
			local x2, y2 = char.left, char.top + y_shift
			
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
			local x2, y2 = char.left, char.top + y_shift
			
			l.text = string.format("{\\an7\\bord0.1\\blur0.8\\shad2\\fscx100\\fscy100\\4a&H64&\\1c&HFFFFFF&\\3c&H000000&\\4c&H000000&\\clip(%s)\\move(%.3f, %.3f, %.3f, %.3f, 0,%d)}%s"
			,clip,x1,y1,x2,y2,line.infade,char.text)
			
			io.write_line(l)
		end
		
		if char.text~="" and char.text~=" " and char.text~="　" then
			--text fx
			
			local l = table.copy(line)
			
			for pi, pixel in ipairs(convert.text_to_pixels(char.text, line.styleref)) do
				
				local max_frame = 100
				
				local u_out = 0
				
				for s, e, i, n in utils.frames(line.start_time+char.start_time, line.start_time+char.end_time, max_frame) do
					
					l.layer = 5
					
					l.start_time=s
					l.end_time=e
					
					local outfad = char.duration/8
					local outmax = math.ceil(outfad/max_frame)
					
					local px, py = char.left + pixel.x, char.top + pixel.y
					local x, y = px + math.randomsteps(-0.5, 0.5, 0.25), py + math.randomsteps(-1, 1, 0.5) + y_shift
					
					if i > (n-math.ceil(outfad/max_frame)) then
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&HFF&")
						u_out = u_out + 1
					else
						alpha="&H00&"
					end
					
					l.text=string.format("{\\an7\\bord0\\blur0.1\\shad0.8\\fscx125\\fscy125\\alpha%s\\1c&HFFFFFF&\\4c&H000000&\\pos(%.3f,%.3f)\\p1}m 0 0 l 1 0 1 1 0 1"
					,alpha,x,y)
					
					io.write_line(l)
				end
			end
		end
	end
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
			--moon fx
			
			l.layer = 3
			
			l.start_time = line.start_time+syl.start_time
			l.end_time = line.start_time+syl.end_time
			
			local moon = "m -11 -20 l -14 -19 l -16 -17 l -18 -15 l -19 -14 l -20 -13 l -21 -12 l -21 -11 l -22 -10 l -23 -8 l -24 -6 l -24 -5 l -24 -2 l -24 2 l -24 5 l -23 7 l -22 11 l -21 13 l -19 15 l -18 17 l -16 19 l -13 21 l -12 22 l -9 23 l -6 24 l -2 25 l 1 25 l 6 24 l 9 23 l 12 21 l 14 20 l 16 18 l 18 17 l 19 15 l 21 13 l 21 11 l 23 9 l 24 7 l 24 3 l 24 -2 l 23 -5 l 22 -7 l 21 -7 l 21 -6 l 21 -4 l 21 -1 l 21 1 l 20 4 l 19 6 l 18 8 l 16 9 l 15 11 l 13 13 l 11 14 l 9 15 l 5 16 l 3 17 l 0 17 l -2 17 l -4 16 l -6 16 l -8 15 l -10 14 l -11 13 l -13 12 l -15 10 l -16 8 l -17 7 l -18 5 l -19 4 l -19 2 l -19 0 l -19 -2 l -19 -4 l -19 -6 l -18 -8 l -18 -10 l -17 -12 l -16 -13 l -14 -15 l -13 -17 l -11 -18 l -10 -19 "
			
			local x1, x2 = syl.left, syl.right
			
			if line.style == "Shinmai_OP_romaji" then
				sc = 70
				y = syl.middle+4
			elseif line.style == "Shinmai_OP_kanji" then
				sc = 60
				y = syl.middle+3
			else
				sc = 60
				y = syl.middle+3
			end
			
			if syl.i == 1 then
				infad = 150
				outfad = 0
			elseif syl.i == #line.syls then
				infad = 0
				outfad = 150
			else
				infad = 0
				outfad = 0
			end
			
			l.text = string.format("{\\an7\\p1\\bord0\\blur0.6\\shad2\\fscx%d\\fscy%d\\frz0\\t(\\frz360)\\fad(%d,%d)\\4a&H64&\\1c&HFFFFFF&\\3c&H000000&\\4c&H000000&\\move(%.3f, %.3f, %.3f, %.3f)}%s"
			,sc,sc,infad,outfad,x1,y,x2,y,moon)
			
			io.write_line(l)
		end
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end