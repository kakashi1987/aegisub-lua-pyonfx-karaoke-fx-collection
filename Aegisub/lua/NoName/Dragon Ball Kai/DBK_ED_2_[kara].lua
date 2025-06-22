--Dragon Ball Kai (2014) ED 2
--Karaoke by Amberdrake
--VSFilter

function kara (line, l)
	if line.infade > 250 then
		line.infade = 250
	end
	if line.outfade > 250 then
		line.outfade = 250
	end
	
	if line.actor == "white" then
		color = "&HFFFFFF&"
	end
	if line.actor == "yellow" then
		color = "&H3FF7F7&"
	end
	
	for si,syl in ipairs(line.syls) do
		
		if syl.text~="" then
			--infade
			l.layer=5
			
			l.start_time=line.start_time-line.infade+25*syl.i-25
			l.end_time=line.start_time+syl.start_time
			
			local rt = math.randomsteps(50, 150, 25)
			local rm = syl.center + math.randomsteps(-30, -10, 5)
			if syl.i%2 == 0 then
				rd = -90
			else
				rd = 90
			end
			
			l.text=string.format("{\\an5\\blur0.6\\bord0.5\\shad1.5\\fscx100\\fscy100\\fry%d\\1c&H10FCFF&\\3c&H000000&\\4c&H000000&\\t(0,%d,\\fry0)\\move(%.3f, %.3f, %.3f, %.3f, 0, %.3f)}%s"
			,rd,rt,rm,syl.middle,syl.center,syl.middle,rt,syl.text)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--syl effect
			
			local text_shape = convert.text_to_shape(syl.text, line.styleref)
			local split_shape = shape.split(text_shape, 3)
			
			max_frame=100
			u_in=0
			a=0
			b=0
			
			for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
				
				l.start_time = s
				l.end_time = e
				
				local step = i / n
				
				l.layer = 3
				
				text_deform_x = 10*math.sin(math.rad(a))
				a = a + 30
				text_deform_y = 10*math.sin(math.rad(b))
				b = b + 60
				
				local sc = 100 + 10*math.sin(math.rad(utils.interpolate(step, 0, 180)))
				
				local deform = shape.filter(split_shape,
				function(x,y)
					local xdef = text_deform_x + math.random(-5,5)
					local ydef = text_deform_y + math.random(-5,5)
					return x+xdef, y+ydef
				end)
				
				l.text = string.format("{\\p4\\an5\\blur0.6\\bord0.5\\shad1.5\\fscx%d\\fscy%d\\1c&H10FCFF&\\3c&H000000&\\4c&H000000&\\pos(%.3f, %.3f)}%s"
				,sc,sc,syl.center,syl.middle-5,deform)
				
				io.write_line(l)
				
			end
			
		end
	end
	
	for si,syl in ipairs(line.syls) do
		--aura fx
		
		local aura = "m 0 0 l 3 -6 l 5 -12 l 7 -10 l 8 -23 l 9 -14 l 17 -27 l 13 -12 l 21 -30 l 26 -38 l 32 -44 l 32 -37 l 44 -53 l 45 -49 l 60 -66 l 54 -52 l 72 -62 l 60 -52 l 84 -69 l 84 -61 l 108 -83 l 89 -59 l 99 -68 l 92 -52 l 127 -69 l 106 -45 l 128 -57 l 120 -47 l 135 -58 l 131 -52 l 147 -61 l 135 -48 l 165 -63 l 135 -41 l 157 -51 l 131 -33 l 154 -34 l 132 -28 l 165 -29 l 140 -24 l 179 -28 l 148 -21 l 166 -22 l 149 -17 l 206 -17 l 170 -13 l 182 10 l 168 7 l 186 15 l 165 12 l 199 26 l 161 18 l 195 30 l 153 20 l 162 28 l 142 25 l 128 20 l 136 29 l 126 24 l 143 46 l 125 30 l 159 65 l 121 45 l 135 59 l 111 41 l 124 58 l 103 44 l 105 51 l 94 45 l 99 53 l 81 41 l 110 83 l 76 49 l 95 77 l 65 47 l 68 61 l 47 39 l 53 67 l 34 37 l 32 45 l 23 31 l 21 33 l 14 7 l 14 23 l 6 4 l 9 22 l 0 3 "
		max_frame = math.randomsteps(50,150,25)
		u_out = 0
		
		for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
			
			l.layer = 1
			
			l.start_time = s
			l.end_time = e
			
			local step = i / n
			
			if syl.i == 1 then
				ms = syl.left-50
			else
				ms = syl.left
			end
			if syl.i == #line.syls then
				me = syl.right+100
			else
				me = syl.right
			end
			
			local xpos, ypos = utils.interpolate(step, ms, me), line.middle
			
			local deform = shape.filter(aura,
			function(x,y)
				local xdef = math.randomsteps(-5,5,1)
				local ydef = math.randomsteps(-6,6,3)
				return x+xdef, y+ydef
			end)
			
			if syl.i == #line.syls then
				fad = 250
				max=math.ceil(fad/max_frame)
				if i>(n-math.ceil(fad/max_frame)) then
					alpha = utils.interpolate(u_out/max, "&H96&", "&HFF&")
					u_out=u_out+1
				else
					alpha="&H96&"
				end
			else
				alpha = "&H96&"
			end
			
			l.text = string.format("{\\p1\\an7\\blur1\\alpha%s\\fry180\\bord0\\shad0\\fscx40\\fscy40\\1c%s\\pos(%.3f, %.3f)}%s"
			,alpha,color,xpos,ypos,deform)
			
			io.write_line(l)
		end
	end
	
	for si,syl in ipairs(line.syls) do
		--aura outline fx
		
		local aura = "m 0 0 l 3 -6 l 5 -12 l 7 -10 l 8 -23 l 9 -14 l 17 -27 l 13 -12 l 21 -30 l 26 -38 l 32 -44 l 32 -37 l 44 -53 l 45 -49 l 60 -66 l 54 -52 l 72 -62 l 60 -52 l 84 -69 l 84 -61 l 108 -83 l 89 -59 l 99 -68 l 92 -52 l 127 -69 l 106 -45 l 128 -57 l 120 -47 l 135 -58 l 131 -52 l 147 -61 l 135 -48 l 165 -63 l 135 -41 l 157 -51 l 131 -33 l 154 -34 l 132 -28 l 165 -29 l 140 -24 l 179 -28 l 148 -21 l 166 -22 l 149 -17 l 206 -17 l 170 -13 l 182 10 l 168 7 l 186 15 l 165 12 l 199 26 l 161 18 l 195 30 l 153 20 l 162 28 l 142 25 l 128 20 l 136 29 l 126 24 l 143 46 l 125 30 l 159 65 l 121 45 l 135 59 l 111 41 l 124 58 l 103 44 l 105 51 l 94 45 l 99 53 l 81 41 l 110 83 l 76 49 l 95 77 l 65 47 l 68 61 l 47 39 l 53 67 l 34 37 l 32 45 l 23 31 l 21 33 l 14 7 l 14 23 l 6 4 l 9 22 l 0 3 "
		local aura_outline = shape.tooutline(aura, 10)
		max_frame = math.randomsteps(50,150,25)
		u_out = 0
		
		for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
			
			l.layer = 1
			
			l.start_time = s
			l.end_time = e
			
			local step = i / n
			
			if syl.i == 1 then
				ms = syl.left-50
			else
				ms = syl.left
			end
			if syl.i == #line.syls then
				me = syl.right+100
			else
				me = syl.right
			end
			
			local xpos, ypos = utils.interpolate(step, ms, me), line.middle
			
			local deform = shape.filter(aura_outline,
			function(x,y)
				local xdef = math.randomsteps(-5,5,1)
				local ydef = math.randomsteps(-6,6,3)
				return x+xdef, y+ydef
			end)
			
			if syl.i == #line.syls then
				fad = 250
				max=math.ceil(fad/max_frame)
				if i>(n-math.ceil(fad/max_frame)) then
					alpha = utils.interpolate(u_out/max, "&H32&", "&HFF&")
					u_out=u_out+1
				else
					alpha="&H32&"
				end
			else
				alpha = "&H32&"
			end
			
			l.text = string.format("{\\p1\\an7\\blur1\\alpha%s\\fry180\\bord0\\shad0\\fscx40\\fscy40\\1c%s\\pos(%.3f, %.3f)}%s"
			,alpha,color,xpos,ypos,deform)
			
			io.write_line(l)
		end
	end
	
	for si,syl in ipairs(line.syls) do
		--aura leftover fx
		
		local aura_leftover = shape.rectangle(line.width + 90, 15)
		local aura_split = shape.split(aura_leftover, 8)
		max_frame = 23,976
		u_in = 0
		u_out = 0
		
		for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
			
			l.layer = 1
			
			l.start_time = s
			l.end_time = e
			
			local step = i / n
			
			local xpos, ypos = line.left-35, line.middle
			
			if syl.i == 1 then
				cs = line.left-35
				
				fad = syl.duration
				max=math.ceil(fad/max_frame)
				if i<math.ceil(fad/max_frame) then
					alpha = utils.interpolate(u_in/max, "&HFF&", "&H32&")
					u_in=u_in+1
				else
					alpha="&H32&"
				end
				
				deform = shape.filter(aura_split,
				function(x,y)
					local ydef = math.randomsteps(-3, 3, 0.5)
					return x, y+ydef
				end)
				
				ysc = utils.interpolate(step, 0, 100)
			else
				
				deform = shape.filter(aura_split,
				function(x,y)
					local xdef = math.random(-2,2)
					local ydef = math.randomsteps(-0.2, 0.2, 0.1)
					return x+xdef, y+ydef
				end)
				ysc = 100
				cs = syl.left - syl.width
				alpha="&H32&"
			end
			if syl.i == #line.syls then
				ce = syl.right+35
				
				fad = 250
				max=math.ceil(fad/max_frame)
				if i>(n-math.ceil(fad/max_frame)) then
					alpha = utils.interpolate(u_out/max, "&H32&", "&HFF&")
					u_out=u_out+1
				else
					alpha="&H32&"
				end
			else
				ce = syl.left-25
				alpha="&H32&"
			end
			
			local rclip = utils.interpolate(step, cs, ce)
			
			l.text = string.format("{\\p1\\an6\\blur1\\alpha%s\\fry180\\bord0\\shad0\\fscx100\\fscy%d\\1c%s\\clip(%.3f,%.3f,%.3f,%.3f)\\pos(%.3f, %.3f)}%s"
			,alpha,ysc,color,line.left-30,line.top,rclip,line.bottom,xpos,ypos,deform)
			
			io.write_line(l)
		end
	end
	
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
			--outfade
			l.layer=5
			
			l.start_time=line.start_time+syl.end_time
			l.end_time=line.end_time+line.outfade+25*syl.i-25
			
			local rt = math.randomsteps(50, 150, 25)
			local rm = syl.center + math.randomsteps(10, 30, 5)
			if syl.i%2 == 0 then
				rd = 90
			else
				rd = -90
			end
			local of_start = l.end_time-l.start_time-rt
			local of_end = l.end_time-l.start_time
			
			l.text=string.format("{\\an5\\blur0.6\\bord0.5\\shad1.5\\fscx100\\fscy100\\fry0\\1c&H10FCFF&\\3c&H000000&\\4c&H000000&\\t(%d,%d,\\fry%d)\\move(%.3f, %.3f, %.3f, %.3f, %d, %d)}%s"
			,of_start,of_end,rd,syl.center,syl.middle,rm,syl.middle,of_start,of_end,syl.text)
			
			io.write_line(l)
		end
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end