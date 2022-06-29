--Fairy Tail (2014) OP 2
--Karaoke by Amberdrake
--VSFilter

function kara (line, l)
	
	line.infade = 150
	
	line.outfade = 150
	
	for si,syl in ipairs(line.syls) do
		
		if syl.text~="" then
			--bord infade
			l.layer=4
			
			l.start_time=line.start_time-line.infade
			l.end_time=line.start_time+syl.start_time
			
			l.text=string.format("{\\an5\\blur2\\bord2\\fscx100\\fscy100\\frx-90\\t(0,150,\\frx0)\\1c&H0564DF&\\3c&H0564DF&\\move(%.3f, %.3f, %.3f, %.3f, 0, 150)}%s"
			,syl.center,syl.bottom,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--infade
			l.layer=5
			
			l.start_time=line.start_time-line.infade
			l.end_time=line.start_time+syl.start_time
			
			l.text=string.format("{\\an5\\blur0.6\\bord0\\fscx100\\fscy100\\frx-90\\t(0,150,\\frx0)\\1c&H18FFF0&\\move(%.3f, %.3f, %.3f, %.3f, 0, 150)}%s"
			,syl.center,syl.bottom,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--syl fx
			
			max_frame = 25
			local text_shape = convert.text_to_shape(syl.text, line.styleref)
			a = 0
			
			for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
				
				l.start_time = s
				l.end_time = e + 250
				
				l.layer = 6
				
				local step = i / n
				
				local sc = utils.interpolate(step, 100, 150)+10*math.sin(math.rad(utils.interpolate(step, 0, 720)))+math.randomsteps(-10,10,5)
				
				local xpos, ypos = syl.left, syl.top - 5
				
				local dir = math.sin(math.rad(a))
				a = a + math.randomsteps(15,90,15)
				local xmov, ymov = xpos + dir, ypos + dir
				
				local deform = shape.filter(shape.split(text_shape),
				function(x,y)
					local xdef = math.randomsteps(-10,10,1)
					local ydef = math.randomsteps(-10,10,0.5)
					return x+xdef, y+ydef
				end)
				
				local primary_color_array = {"&H7AFAF3&" , "&H4E5BF9&" , "&H3088FF&"}
				local random_primary_color=primary_color_array[math.random(1,table.getn(primary_color_array))]
				
				local secondary_color_array = {"&H0564DF&" , "&H081BE1&" , "&H18FFF0&"}
				local random_secondary_color=secondary_color_array[math.random(1,table.getn(secondary_color_array))]
				
				l.text = string.format("{\\an7\\p4\\blur1.2\\bord2\\fscx%d\\fscy%d\\1c&%s\\3c%s\\fad(0,250)\\1a&H96&\\3a&H32&\\move(%.3f, %.3f, %.3f, %.3f)}%s"
				,sc,sc,random_primary_color,random_secondary_color,xpos,ypos,xmov,ymov,deform)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" then
			--syl fx2
			
			max_frame = 25
			local text_shape = convert.text_to_shape(syl.text, line.styleref)
			a = 0
			
			for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
				
				l.start_time = s
				l.end_time = e
				
				l.layer = 7
				
				local step = i / n
				
				local xpos, ypos = syl.left, syl.top + 2
				
				local deform = shape.filter(shape.split(text_shape),
				function(x,y)
					local xdef = math.randomsteps(-10,10,1)
					local ydef = math.randomsteps(-10,10,0.5)
					return x+xdef, y+ydef
				end)
				
				l.text = string.format("{\\an7\\p4\\blur0.2\\bord0.5\\fscx90\\fscy90\\3c&H000000&\\fad(0,250)\\1a&HFF&\\pos(%.3f, %.3f)}%s"
				,xpos,ypos,deform)
				
				io.write_line(l)
			end
		end
		
		if syl.text~="" then
			--bord outfade
			l.layer=4
			
			l.start_time=line.start_time+syl.end_time
			l.end_time=line.end_time+line.outfade
			
			local of_start = l.end_time-l.start_time-150
			local of_end = l.end_time-l.start_time
			
			l.text=string.format("{\\an5\\blur2\\bord2\\fscx100\\fscy100\\frx0\\t(%d,%d,\\frx90)\\1c&H0564DF&\\3c&H0564DF&\\move(%.3f, %.3f, %.3f, %.3f, %d, %d)}%s"
			,of_start,of_end,syl.center,syl.middle,syl.center,syl.top,of_start,of_end,syl.text)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--outfade
			l.layer=5
			
			l.start_time=line.start_time+syl.end_time
			l.end_time=line.end_time+line.outfade
			
			local of_start = l.end_time-l.start_time-150
			local of_end = l.end_time-l.start_time
			
			l.text=string.format("{\\an5\\blur0.6\\bord0\\fscx100\\fscy100\\frx0\\t(%d,%d,\\frx90)\\1c&H18FFF0&\\move(%.3f, %.3f, %.3f, %.3f, %d, %d)}%s"
			,of_start,of_end,syl.center,syl.middle,syl.center,syl.top,of_start,of_end,syl.text)
			
			io.write_line(l)
		end
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end