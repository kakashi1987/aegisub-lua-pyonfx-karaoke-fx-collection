--Fairy Tail 176+ Opening
--Karaoke by Amberdrake
--VSFilter

function kara (line, l)
	if line.infade > 500 then
		line.infade = 250
	end
	if line.outfade > 500 then
		line.outfade = 250
	end
	
	for si,syl in ipairs(line.syls) do
		
		if line.style == "OP_romanji_fire" then
			
			if syl.text~="" then
				--fire infade
				l.start_time = line.start_time-line.infade
				l.end_time = line.start_time+syl.start_time
				
				l.layer = 8
				
				if syl.i%2==1 then
					y=-20
				else
					y=20
				end
				
				l.text = string.format("{\\an5\\blur3\\bord2\\shad0\\fscx100\\fscy100\\fad(250,0)\\1c&H0A014C&\\3c&H43C7E2&\\move(%.3f, %.3f, %.3f, %.3f, 0, 250)}%s"
				,syl.center-20,syl.middle+y,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--syl effect
				max_frame=25
				u_in=0
				a=0
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					l.layer = 8
					
					sc = 120+10*math.sin(math.rad(a))
					a = a + 90
					
					l.text = string.format("{\\an5\\blur3\\bord2\\shad0\\fscx%d\\fscy%d\\1c&H0A014C&\\3c&H43C7E2&\\pos(%.3f, %.3f)}%s"
					,sc,sc,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--fire explosion layer 3
				local boom = shape.ellipse(40, 40)
				
				max_frame=25
				
				if syl.i%2==1 then
					xpos = syl.left+syl.width/4
					ypos = syl.top+syl.height/4
				else
					xpos = syl.right-syl.width/4
					ypos = syl.bottom-syl.height/4
				end
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					l.layer = 3
					
					step = i / n
					
					sc = 70+40*math.sin(math.rad(utils.interpolate(step, 0, 90)))
					
					l.text = string.format("{\\an5\\p1\\blur3\\bord0\\fscx%d\\fscy%d\\1c&H37CFF6&\\pos(%.3f, %.3f)}%s"
					,sc,sc,xpos,ypos,boom)
					
					io.write_line(l)
					
				end
				
			end
			
			if syl.text~="" then
				--fire explosion layer 2
				
				max_frame=25
				
				if syl.i%2==1 then
					xpos = syl.left+syl.width/4
					ypos = syl.top+syl.height/4
				else
					xpos = syl.right-syl.width/4
					ypos = syl.bottom-syl.height/4
				end
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					l.layer = 2
					
					step = i / n
					
					local exp = shape.ellipse(50,50)
					local deform = shape.filter(shape.split(exp),
					function(x,y)
						local xdef = math.randomsteps(-2,2,1)
						local ydef = math.randomsteps(-2,2,0.5)
						return x+xdef, y+ydef
					end)
					
					sc = 70+40*math.sin(math.rad(utils.interpolate(step, 0, 90)))
					
					l.text = string.format("{\\an5\\p1\\blur3\\bord0\\fscx%d\\fscy%d\\1c&H75F8F7&\\pos(%.3f, %.3f)}%s"
					,sc,sc,xpos,ypos,deform)
					
					io.write_line(l)
					
				end
				
			end
			
			if syl.text~="" then
				--fire explosion layer 1
				
				max_frame=25
				u_in = 0
				u_out = 0
				
				if syl.i%2==1 then
					xpos = syl.left+syl.width/4
					ypos = syl.top+syl.height/4
				else
					xpos = syl.right-syl.width/4
					ypos = syl.bottom-syl.height/4
				end
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					l.layer = 3
					
					step = i / n
					
					local ring = shape.ring(30,28)
					local deform = shape.filter(shape.split(ring),
					function(x,y)
						local xdef = math.randomsteps(-1,1,0.25)
						local ydef = math.randomsteps(-1,1,0.5)
						return x+xdef, y+ydef
					end)
					
					fad = syl.duration/4
					max=math.ceil(fad/max_frame)
					if i<math.ceil(fad/max_frame) then
						alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
						u_in=u_in+1
					elseif i>(n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						u_out=u_out+1
					else
						alpha="&H00&"
					end
					
					sc = 70+50*math.sin(math.rad(utils.interpolate(step, 0, 90)))
					
					l.text = string.format("{\\an5\\p1\\blur1.5\\bord0\\fscx%d\\fscy%d\\1c&H75F8F7&\\pos(%.3f, %.3f)}%s"
					,sc,sc,xpos,ypos,deform)
					
					io.write_line(l)
					
				end
				
			end
			
			if syl.text~="" then
				--fire outfade
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade
				
				of_start = l.end_time-l.start_time-250
				of_end = l.end_time-l.start_time
				
				l.layer = 8
				
				if syl.i%2==1 then
					y=20
				else
					y=-20
				end
				
				l.text = string.format("{\\an5\\blur3\\bord2\\shad0\\fscx100\\fscy100\\fad(0,250)\\1c&H0A014C&\\3c&H43C7E2&\\move(%.3f, %.3f, %.3f, %.3f, %d, %d)}%s"
				,syl.center,syl.middle,syl.center+20,syl.middle+y,of_start,of_end,syl.text)
				
				io.write_line(l)
				
			end
			
		end
		
		if line.style == "OP_romanji_circles" then
			
			if syl.text~="" then
				--circles infade
				maxj = line.height
				for j = 1,maxj,1 do
					
					l.start_time = line.start_time-line.infade+50*syl.i-50
					l.end_time = line.start_time+syl.start_time
					
					l.layer = 8
					
					clip_src = shape.rectangle(line.width,1)
					clip = shape.move(clip_src,line.left,line.top+j)
					
					color = utils.interpolate(j/maxj,"&H000000&","&H0400B7&")
					
					l.text = string.format("{\\an5\\blur0.4\\bord0\\shad0\\fscx100\\fscy100\\fad(250,0)\\1c%s\\clip(%s)\\pos(%.3f, %.3f)}%s"
					,color,clip,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
				end
				
			end
			
			if syl.text~="" then
				--circles infade border
				
				l.start_time = line.start_time-line.infade+50*syl.i-50
				l.end_time = line.start_time+syl.start_time
				
				l.layer = 7
				
				l.text = string.format("{\\an5\\blur0.6\\bord1\\shad0\\fscx100\\fscy100\\fad(250,0)\\3c&H000000&\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--circles syl effect fill
				
				l.start_time = line.start_time+syl.start_time
				l.end_time = line.start_time+syl.end_time
				
				l.layer = 8
				
				l.text = string.format("{\\an5\\blur0.4\\bord0\\shad0\\fscx100\\fscy100\\t(0,%d,\\fscx120\\fscy120)\\t(%d,%d,\\fscx100\\fscy100)\\1c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
				,syl.duration/2,syl.duration/2,syl.duration,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--circles syl effect bord
				
				l.start_time = line.start_time+syl.start_time
				l.end_time = line.start_time+syl.end_time
				
				l.layer = 8
				
				l.text = string.format("{\\an5\\blur3\\bord2\\1a&HFF&\\3a&H64&\\shad0\\fscx100\\fscy100\\t(0,%d,\\fscx120\\fscy120)\\t(%d,%d,\\fscx100\\fscy100)\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
				,syl.duration/2,syl.duration/2,syl.duration,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--circles syl effect sparks
				
				maxj = 20
				for j = 1,maxj,1 do
					
					l.start_time = line.start_time+syl.start_time
					l.end_time = line.start_time+syl.end_time
					
					spark = shape.star(8,2,8)
					
					l.layer = 9
					
					xpos = math.randomsteps(syl.left-2, syl.right+2, 0.5)
					ypos = math.randomsteps(syl.top-2, syl.bottom+2, 0.25)
					sx = syl.center
					sy = syl.middle
					vx = xpos - sx
					vy = ypos - sy
					xmove = syl.center+2*vx+math.random(-3,3)
					ymove = syl.middle+2*vy+math.random(-2,2)
					
					l.text = string.format("{\\an5\\p1\\blur3\\bord1\\3a&H32&\\shad0\\fscx50\\fscy50\\fad(0,%d)\\1c&HFFFFFF&\\3c&FFFFFF&\\move(%.3f, %.3f, %.3f, %.3f)}%s"
					,syl.duration/2,xpos,ypos,xmove,ymove,spark)
					
					io.write_line(l)
					
				end
			end
			
			if syl.text~="" then
				
				max_frame = 25
				a = 0
				u_out=0
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					--circles syl circles layer 1
					l.start_time = s
					l.end_time = e+50
					
					l.layer = 3
					
					step = i / n
					
					local circle = shape.ring(20,19)
					
					fad = syl.duration/4
					max=math.ceil(fad/max_frame)
					if i>(n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						u_out=u_out+1
					else
						alpha="&H00&"
					end
					
					sc = 100+20*math.sin(math.rad(utils.interpolate(step, 0, 90))) + 5*math.sin(math.rad(a))
					a = a + 90
					
					l.text = string.format("{\\an5\\p1\\blur3\\bord0.5\\fscx%d\\fscy%d\\fad(0,50)\\alpha%s\\3a&H64&\\1c&HD186A7&\\3c&HEF5C46&\\pos(%.3f, %.3f)}%s"
					,sc,sc,alpha,syl.center,syl.middle+3,circle)
					
					io.write_line(l)
					
				end
			end
			
			if syl.text~="" then
				
				max_frame = 25
				a = 0
				u_out=0
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					--circles syl circles layer 2
					l.start_time = s
					l.end_time = e+50
					
					l.layer = 3
					
					step = i / n
					
					local circle = shape.ring(30,29)
					
					fad = syl.duration/4
					max=math.ceil(fad/max_frame)
					if i>(n-math.ceil(fad/max_frame)) then
						alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
						u_out=u_out+1
					else
						alpha="&H00&"
					end
					
					sc = 100+20*math.sin(math.rad(utils.interpolate(step, 0, 90))) + 5*math.sin(math.rad(a))
					a = a + 90
					
					l.text = string.format("{\\an5\\p1\\blur3\\bord0.5\\fscx%d\\fscy%d\\fad(0,50)\\alpha%s\\3a&H64&\\1c&HD186A7&\\3c&HEF5C46&\\pos(%.3f, %.3f)}%s"
					,sc,sc,alpha,syl.center,syl.middle+3,circle)
					
					io.write_line(l)
					
				end
			end
			
			if syl.text~="" then
				--circles outfade
				maxj = line.height
				for j = 1,maxj,1 do
					
					l.start_time = line.start_time+syl.end_time
					l.end_time = line.end_time
					
					l.layer = 8
					
					clip_src = shape.rectangle(line.width,1)
					clip = shape.move(clip_src,line.left,line.top+j)
					
					color = utils.interpolate(j/maxj,"&H000000&","&H0400B7&")
					
					l.text = string.format("{\\an5\\blur0.4\\bord0\\shad0\\fscx100\\fscy100\\1c%s\\clip(%s)\\pos(%.3f, %.3f)}%s"
					,color,clip,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
				end
				
			end
			
			if syl.text~="" then
				--circles out border
				
				l.layer = 7
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time
				
				l.text = string.format("{\\an5\\blur0.6\\bord1\\shad0\\fscx100\\fscy100\\fad(0,250)\\3c&H000000&\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
	end
	
	if line.style == "OP_romanji_stars" then
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--stars infade/outfade
				l.start_time = line.start_time-line.infade
				l.end_time = line.end_time+line.outfade
				
				l.layer = 6
				
				l.text = string.format("{\\an5\\blur3\\bord2\\shad0\\fscx100\\fscy100\\1a&HFF&\\3a&HFF&\\1c&HFFFFFF&\\3c&HE0CBC8&\\t(0,250,\\1a&H00&\\3a&H64&\\1c&H54251C&)\\fad(0,250))\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~=" " then
				--stars infade effect
				
				max_frame = 25
				
				for s, e, i, n in utils.frames(line.start_time-250, line.start_time+250, max_frame) do
					
					local star = shape.star(6, 2, 6)
					
					rs = math.randomsteps(0,250,50)
					
					l.start_time = s + rs
					l.end_time = e + rs + 250
					
					l.layer = 8
					
					step = i / n
					
					bord = 3*math.sin(math.rad(utils.interpolate(step, 90, 180)))
					sc = utils.interpolate(step, 80, 60)
					
					x = math.random(line.left, line.right)
					y = math.random(line.top, line.bottom)+5
					
					l.text = string.format("{\\an5\\p1\\blur3\\bord%d\\shad0\\fscx%d\\fscy%d\\fad(0,100)\\3a&H64&\\1c&HFFFFFF&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
					,bord,sc,sc,x,y,star)
					
					io.write_line(l)
				end
				
				if syl.text~="" then
					--stars syl effect
					
					maxj = 3
					for j = 1, maxj, 1 do
						
						max_frame=25
						u_in=0
						a=0
						
						for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
							
							l.start_time = s
							l.end_time = e+50
							
							l.layer = 8
							
							step = i / n
							
							sc = 110 + j*20*math.sin(math.rad(utils.interpolate(step, 0 , 90))) + 3*math.sin(math.rad(a))
							a = a + 90
							
							l.text = string.format("{\\an5\\blur3\\bord2\\shad0\\fscx%d\\fscy%d\\fad(0,50)\\1a&HFF&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
							,sc,sc,syl.center,syl.middle,syl.text)
							
							io.write_line(l)
						end
					end
					
				end
				
			end
		end
		
		for ci,char in ipairs(line.chars) do
			if char.text~=" " then
				--stars particle border
				
				local text_shape = convert.text_to_shape(char.text, line.styleref)
				local text_outline_shape = shape.tooutline(shape.split(text_shape), 1)
				local text_outline_pixels = convert.shape_to_pixels(text_outline_shape, true)
				local star = shape.ellipse(3,3)
				
				local l = table.copy(line)
				
				for pi, pixel in ipairs(text_outline_pixels) do
					
					l.start_time = line.start_time-line.infade
					l.end_time = line.end_time+line.outfade
					
					l.layer = math.random(5,7)
					
					x = char.left + pixel.x + math.random(-1,1)
					y = char.top + pixel.y + math.random(-1,1)
					
					alpha_array = {"&HFF&" , "&H00&" , "&HFF&" , "&HFF&" , "&HFF&" , "&HFF&"}
					alpha=alpha_array[math.random(1,table.getn(alpha_array))]
					
					l.text = string.format("{\\an5\\p1\\blur3\\bord0.5\\shad0\\fscx50\\fscy50\\alpha%s\\fad(250,250)\\1c&HFFFFFF&\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
					,alpha,x,y,star)
					
					io.write_line(l)
					
				end
				
			end
			
		end
		
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
	
	if line.style == "OP_romanji_alt" then
		
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" then
				--alt infade
				l.start_time = line.start_time-line.infade+25*char.i-25
				l.end_time = line.start_time+char.start_time
				
				l.layer = 3
				
				l.text = string.format("{\\an5\\blur2\\bord3\\shad0\\fscx0\\fscy100\\t(0,250,\\fscx100)\\fad(100,0)\\1c&HFFFFF7&\\3c&HA6794B&\\pos(%.3f, %.3f)}%s"
				,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--alt outfade
				l.start_time = line.start_time+char.end_time
				l.end_time = line.end_time+25*char.i-25
				
				l.layer = 3
				
				of_start = l.end_time-l.start_time-250
				of_end = l.end_time-l.start_time
				
				l.text = string.format("{\\an5\\blur2\\bord3\\shad0\\fscx100\\fscy100\\fad(0,100)\\t(%d,%d,\\fscx0)\\1c&HFFFFF7&\\3c&HA6794B&\\pos(%.3f, %.3f)}%s"
				,of_start,of_end,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
		end
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--alt effect
				l.start_time = line.start_time+syl.start_time
				l.end_time = line.start_time+syl.end_time
				
				l.layer = 4
				
				l.text = string.format("{\\an5\\blur2\\bord6\\shad0\\fscx120\\fscy120\\1c&HFFFFF7&\\3c&HFFFFFF&\\t(\\bord3\\fscx100\\fscy100\\3c&HA6794B&)\\move(%.3f, %.3f, %.3f, %.3f)}%s"
				,syl.center,syl.middle-15,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
		end
	end
end

for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end