function kara (line, l)
	if line.infade > 500 then
		line.infade = 250
	end
	if line.outfade > 500 then
		line.outfade = 250
	end
	
	if line.style == "OP_romanji" then
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--romanji infade
				l.start_time = line.start_time-line.infade+25*syl.i-25
				l.end_time = line.start_time+syl.start_time
				
				l.layer = 8
				
				l.text = string.format("{\\an5\\blur2\\bord3\\shad0\\fscx100\\fscy100\\frx-90\\t(0,250,\\frx0)\\fad(150,0)\\1c&HFFFFF7&\\3c&HA6794B&\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--romanji syl effect
				
				max_frame = 25
				a = 0
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					maxj = syl.width
					for j = 1,maxj,1 do
						
						l.start_time = s
						l.end_time = e+50
						
						l.layer = 8
						
						step = i / n
						
						clip_src = shape.rectangle(1,syl.height+50)
						clip = shape.move(clip_src,syl.left+j,syl.middle-25)
						
						color = utils.interpolate(j/maxj, utils.interpolate(step, "&HFFFFFF&", "&HEE9C47&" ), utils.interpolate(step, "&HEE9C47&", "&HFFFFFF&"))
						
						sc = 100+30*math.sin(math.rad(utils.interpolate(step, 0, 180))) + 10*math.sin(math.rad(a))
						a = a + 90
						
						l.text = string.format("{\\an5\\blur0\\bord0\\shad0\\fscx100\\fad(0,50)\\fscy%d\\1c%s\\clip(%s)\\pos(%.3f, %.3f)}%s"
						,sc,color,clip,syl.center,syl.middle,syl.text)
						
						io.write_line(l)
						
					end
					
				end
			end
			
			if syl.text~="" then
				--romanji syl effect border
				
				max_frame = 25
				a = 0
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.start_time = s
					l.end_time = e+50
					
					l.layer = 7
					
					step = i / n
					
					sc = 100+30*math.sin(math.rad(utils.interpolate(step, 0, 180))) + 10*math.sin(math.rad(a))
					a = a + 90
					
					l.text = string.format("{\\an5\\blur2\\bord3\\1a&HFF&\\shad0\\fscx100\\fscy%d\\fad(0,50)\\3c&HA6794B&\\pos(%.3f, %.3f)}%s"
					,sc,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
					
				end
			end
			
			if syl.text~="" then
				--romanji outfade
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade+25*syl.i-25
				
				l.layer = 8
				
				of_start = l.end_time - l.start_time - 250
				of_end = l.end_time - l.start_time
				
				l.text = string.format("{\\an5\\blur2\\bord3\\shad0\\fscx100\\fscy100\\frx0\\t(%d,%d,\\frx90)\\fad(0,150)\\1c&HFFFFF7&\\3c&HA6794B&\\pos(%.3f, %.3f)}%s"
				,of_start,of_end,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
		end
		
		for wi, word in ipairs(line.words) do
			
			if word.text~=" " then
				--word effect 1
				
				max_frame = 50
				
				for s, e, i, n in utils.frames(line.start_time+word.start_time, line.start_time+word.end_time, max_frame) do
					
					local crest = "m 0 0 l 101 -55 b 140 -76 147 -112 134 -136 b 129 -142 131 -149 131 -155 b 125 -145 123 -134 124 -121 b 127 -130 132 -140 133 -120 b 134 -91 114 -73 93 -69 b 116 -92 117 -115 119 -128 b 119 -148 123 -152 127 -157 b 112 -158 107 -146 106 -141 b 105 -133 106 -121 102 -111 b 99 -101 93 -89 80 -83 b 97 -102 101 -122 100 -140 b 101 -149 104 -151 108 -154 b 97 -155 88 -146 87 -132 b 86 -116 75 -99 65 -95 b 82 -117 85 -133 77 -144 b 76 -123 69 -116 57 -112 b 71 -122 73 -137 71 -145 b 66 -135 62 -134 56 -133 b 46 -131 38 -128 31 -124 b 12 -112 10 -94 15 -69 b 30 -87 41 -90 51 -83 b 40 -64 53 -56 73 -53 l 24 -21 l 23 -39 "
					
					l.start_time = s
					l.end_time = e + 500
					
					l.layer = 6
					
					step = i / n
					
					x = utils.interpolate(step, word.left, word.right)-15
					y = line.middle+30+40*math.sin(math.rad(utils.interpolate(step, 0, 360)))+5
					
					l.text = string.format("{\\an5\\p1\\blur1\\bord1\\shad0\\fscx20\\fscy20\\fad(0,500)\\1c&HFFFFF7&\\3c&HA6794B&\\\\pos(%.3f, %.3f)}%s"
					,x,y,crest)
					
					io.write_line(l)
				end
				
			end
			
			if word.text~=" " then
				--word effect 2
				
				max_frame = 25
				
				for s, e, i, n in utils.frames(line.start_time+word.start_time, line.start_time+word.end_time, max_frame) do
					
					local crest = "m 0 0 l 101 -55 b 140 -76 147 -112 134 -136 b 129 -142 131 -149 131 -155 b 125 -145 123 -134 124 -121 b 127 -130 132 -140 133 -120 b 134 -91 114 -73 93 -69 b 116 -92 117 -115 119 -128 b 119 -148 123 -152 127 -157 b 112 -158 107 -146 106 -141 b 105 -133 106 -121 102 -111 b 99 -101 93 -89 80 -83 b 97 -102 101 -122 100 -140 b 101 -149 104 -151 108 -154 b 97 -155 88 -146 87 -132 b 86 -116 75 -99 65 -95 b 82 -117 85 -133 77 -144 b 76 -123 69 -116 57 -112 b 71 -122 73 -137 71 -145 b 66 -135 62 -134 56 -133 b 46 -131 38 -128 31 -124 b 12 -112 10 -94 15 -69 b 30 -87 41 -90 51 -83 b 40 -64 53 -56 73 -53 l 24 -21 l 23 -39 "
					
					l.start_time = s
					l.end_time = e + 500
					
					l.layer = 6
					
					step = i / n
					
					x = utils.interpolate(step, word.left, word.right)-15
					y = line.middle+30+40*math.sin(math.rad(utils.interpolate(step, 180, 540)))+5
					
					l.text = string.format("{\\an5\\p1\\blur1\\bord1\\shad0\\fscx20\\fscy20\\fad(0,500)\\1c&HFFFFF7&\\3c&HA6794B&\\\\pos(%.3f, %.3f)}%s"
					,x,y,crest)
					
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