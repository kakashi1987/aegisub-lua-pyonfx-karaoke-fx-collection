--Fairy Tail S2 176+ ED
--Karaoke by Amberdrake
--VSFilter

function kara (line, l)
	if line.infade < 1000 then
		line.infade = 1000
	end
	
	if line.style == "ED_romanji" then
		for ci,char in ipairs(line.chars) do
			
			max_frame=25
			u_in=0
			
			for s, e, i, n in utils.frames(line.start_time-line.infade+15*char.i-15, line.start_time, max_frame) do
				--infade
				max_frame=25
				u_in=0
				
				l.start_time = s
				l.end_time = e
				
				l.layer = 4
				
				local step = i / n
				
				fad=500
				max=math.ceil(fad/max_frame)
				if i<math.ceil(fad/max_frame) then
					alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
					u_in=u_in+1
				else
					alpha="&H00&"
				end
				
				if char.i % 2 == 1 then
					start_y = char.middle - 25
				else
					start_y = char.middle + 25
				end
				local x = utils.interpolate(step ,char.center-35, char.center)
				local y = utils.interpolate(step, start_y, char.middle)+5*math.sin(math.rad(utils.interpolate(step, 0, 360)))
				
				l.text = string.format("{\\an5\\blur0.9\\bord1\\fscx100\\fscy100\\alpha%s\\1c&HE7F8FF&\\3c&H2850BE&\\pos(%.3f, %.3f)}%s"
				,alpha,x,y,char.text)
				
				io.write_line(l)
				
			end
			
			if char.text~="" then
				
				l.layer=4
				
				l.start_time=line.start_time
				l.end_time=line.start_time+char.start_time
				
				l.text=string.format("{\\an5\\blur0.9\\bord1\\fscx100\\fscy100\\1c&HE7F8FF&\\3c&H2850BE&\\pos(%.3f, %.3f)}%s"
				,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
		end
		
		for ci,char in ipairs(line.chars) do
			
			max_frame=150
			u_in=0
			
			for s, e, i, n in utils.frames(line.start_time+char.start_time, line.start_time+char.end_time, max_frame) do
				--syl effect layer 1
				
				l.start_time = s
				l.end_time = e+350
				
				l.layer = 2
				
				local step = i / n
				
				local x = char.center+math.randomsteps(-3, 3, 0.5)
				local y = char.middle+math.randomsteps(-3, 3, 0.25)
				
				l.text = string.format("{\\an5\\blur3\\fscx100\\fscy100\\fad(0,350)\\1c&H2850BE&\\pos(%.3f, %.3f)}%s"
				,x,y,char.text)
				
				io.write_line(l)
				
			end
			
		end
		
		for ci,char in ipairs(line.chars) do
			
			max_frame=150
			u_in=0
			
			for s, e, i, n in utils.frames(line.start_time+char.start_time, line.start_time+char.end_time, max_frame) do
				--syl effect layer 2
				
				l.start_time = s
				l.end_time = e+350
				
				l.layer = 3
				
				local step = i / n
				
				local x = char.center+math.randomsteps(-3, 3, 0.25)
				local y = char.middle+math.randomsteps(-3, 3, 0.5)
				
				l.text = string.format("{\\an5\\blur0.6\\fscx100\\fscy100\\fad(0,350)\\1c&HE7F8FF&\\pos(%.3f, %.3f)}%s"
				,x,y,char.text)
				
				io.write_line(l)
				
			end
			
			if char.text~="" then
				--outfade
				l.layer=4
				
				l.start_time=line.start_time+char.end_time
				l.end_time=line.end_time+line.outfade+15*char.i-30*#line.chars
				
				l.text=string.format("{\\an5\\blur0.9\\bord1\\fscx100\\fscy100\\fad(0,500)\\1c&HE7F8FF&\\3c&H2850BE&\\pos(%.3f, %.3f)}%s"
				,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
		end
	end
	
	if line.style == "green_leaves" or line.style == "light_green_leaves" or line.style == "white_leaves" then
		
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" then
				--leaves
				l.layer = 5
				
				l.start_time = line.start_time+char.start_time-350
				l.end_time = line.start_time+char.end_time+350
				
				local sx = math.random(-50,50)
				local sy = math.random(-60,60)
				local fx = math.random(60,100)
				local fy = math.random(-100,-60)
				
				if line.style == "green_leaves" then
					color = "&H49553E&"
				end
				if line.style == "light_green_leaves" then
					color = "&H269BA3&"
				end
				if line.style == "white_leaves" then
					color = "&HFFFFFF&"
				end
				
				local pos = lines[2].chars[1].left + math.random(0, lines[2].width)
				
				local leaf = "m 0 0 b -2 -7 0 -13 3 -17 b 12 -26 25 -31 38 -37 b 40 -38 41 -36 40 -35 b 39 -23 36 -11 30 -2 b 26 2 22 4 15 4 b 10 4 6 3 0 0 "
				
				l.text=string.format("{\\p1\\an7\\blur0.8\\fscx50\\fscy50\\frx%d\\fry%d\\t(\\frx%d\\fry%d)\\fad(350,350)\\1c%s\\move(%.3f, %.3f, %.3f, %.3f)}%s"
				,sx,sy,fx,fy,color,pos+25,char.middle-25,pos-25,char.middle+25,leaf)
				
				io.write_line(l)
			end
			
		end
	end
end

for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end