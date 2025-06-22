--Sword Art Online II Ending
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	if line.i == 1 or line.i == 22 or line.i == 43 then
		line.infade=0
	else
		line.infade=1500
	end
	line.outfade=1500
	
	if line.actor == "dblue" then
		bordcolor = "&HB06447&"
		triangle_color = "&HEFC79C&"
	end
	if line.actor == "lblue" then
		bordcolor = "&HB79B52&"
		triangle_color = "&HFADEAA&"
	end
	if line.actor == "purple" then
		bordcolor = "&HA83B51&"
		triangle_color = "&HF7A8DE&"
	end
	
	if line.style == "ED_romanji_L" or line.style == "ED_romanji_R" or line.style == "ED_kanji_L" or line.style == "ED_kanji_R" then
		
		for ci, char in pairs(line.chars) do
			
			if char.text~="" and char.text~=" " then
				--infade
				
				l.layer=5
				
				l.start_time=line.start_time-line.infade
				l.end_time=line.start_time+char.start_time
				
				local xrot, yrot = math.randomsteps(-360,360,45), math.randomsteps(-360,360,30)
				local rf = math.randomsteps(500,1500,100)
				local randomfad = math.randomsteps(200,1000,100)
				local msx, msy = char.center - math.random(25,50), char.middle + math.randomsteps(-15,15,5)
				
				l.text=string.format("{\\an5\\bord1.5\\blur0.8\\1c&HFFFFEB&\\3c%s\\frx%.3f\\fry%.3f\\t(0,%d,\\frx0\\fry0)\\fad(%d,0)\\move(%.3f,%.3f,%.3f,%.3f,0,%d)}%s"
				,bordcolor,xrot,yrot,rf,randomfad,msx,msy,char.center,char.middle,rf,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" and char.text~=" " then
				--char fx
				
				max_frame = 250
				
				for s, e, i, n in utils.frames(line.start_time+char.start_time, line.start_time+char.end_time, max_frame) do
					
					l.layer=6
					
					l.start_time=s
					l.end_time=e + 500
					
					step = i / n
					
					local rxs, rxe, rys, rye = math.randomsteps(-2,2,0.5), math.randomsteps(-2,2,1), math.randomsteps(-3,3,1), math.randomsteps(-3,3,0.5)
					x, y = utils.interpolate(step, rxs, rxe), utils.interpolate(step, rys, rye)
					
					l.text=string.format("{\\an5\\bord1.5\\blur0.8\\1c&HFFFFEB&\\3c%s\\fad(0,500)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
					,bordcolor,char.center+x,char.middle+y,char.center-3*x,char.middle-3*y,char.text)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" and char.text~=" " then
				--triangles fx
				
				local triangle = shape.triangle(25)
				
				l.layer=math.random(4,7)
				
				l.start_time=line.start_time+char.start_time-500
				l.end_time=line.start_time+char.end_time+500
				
				local xrots, yrots, xrote, yrote = math.randomsteps(-360,-45,45), math.randomsteps(-360,-30,30), math.randomsteps(90,360,90), math.randomsteps(15,360,15)
				
				if line.style == "ED_romanji_L" or line.style == "ED_kanji_L" then
					msx, msy, mex, mey = char.center - math.random(20,40), char.middle + math.randomsteps(-15,15,5), char.center + math.random(20,40), char.middle + math.randomsteps(-15,15,2.5)
				end
				if line.style == "ED_romanji_R" or line.style == "ED_kanji_R" then
					msx, msy, mex, mey = char.center + math.random(20,40), char.middle + math.randomsteps(-15,15,5), char.center - math.random(20,40), char.middle + math.randomsteps(-15,15,2.5)
				end
				
				l.text=string.format("{\\an5\\p1\\bord0\\blur0.8\\1c%s\\alpha&H32&\\frx%.3f\\fry%.3f\\t(\\frx%.3f\\fry%.3f)\\fad(250,250)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,triangle_color,xrots,yrots,xrote,yrote,msx,msy,mex,mey,triangle)
				
				io.write_line(l)
			end
			
			if char.text~="" and char.text~=" " then
				--outfade
				
				l.layer=5
				
				l.start_time=line.start_time+char.end_time
				l.end_time=line.end_time+line.outfade
				
				local xrot, yrot = math.randomsteps(-360,360,45), math.randomsteps(-360,360,30)
				local rf = math.randomsteps(500,1500,100)
				local randomfad = math.randomsteps(200,1000,100)
				local msx, msy = char.center + math.random(25,50), char.middle + math.randomsteps(-15,15,5)
				local of_start = l.end_time-l.start_time-rf
				local of_end = l.end_time-l.start_time
				
				l.text=string.format("{\\an5\\bord1.5\\blur0.8\\1c&HFFFFEB&\\3c%s\\frx0\\fry0\\t(%d,%d,\\frx%.3f\\fry%.3f)\\fad(0,%d)\\move(%.3f,%.3f,%.3f,%.3f,%d,%d)}%s"
				,bordcolor,of_start,of_end,xrot,yrot,randomfad,char.center,char.middle,msx,msy,of_start,of_end,char.text)
				
				io.write_line(l)
			end
		end
	end
	
	if line.style == "ED_TL_L" or line.style == "ED_TL_R" then
		
		for ci, char in pairs(line.chars) do
			
			if char.text~="" and char.text~=" " then
				--infade
				
				l.layer=5
				
				l.start_time=line.start_time-line.infade
				l.end_time=line.start_time+char.end_time
				
				local xrot, yrot = math.randomsteps(-360,360,45), math.randomsteps(-360,360,30)
				local rf = math.randomsteps(500,1500,100)
				local randomfad = math.randomsteps(200,1000,100)
				local msx, msy = char.center - math.random(25,50), char.middle + math.randomsteps(-15,15,5)
				
				l.text=string.format("{\\an5\\bord1.5\\blur0.8\\1c&HFFFFEB&\\3c%s\\frx%.3f\\fry%.3f\\t(0,%d,\\frx0\\fry0)\\fad(%d,0)\\move(%.3f,%.3f,%.3f,%.3f,0,%d)}%s"
				,bordcolor,xrot,yrot,rf,randomfad,msx,msy,char.center,char.middle,rf,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" and char.text~=" " then
				--outfade
				
				l.layer=5
				
				l.start_time=line.start_time+char.end_time
				l.end_time=line.end_time+line.outfade
				
				local xrot, yrot = math.randomsteps(-360,360,45), math.randomsteps(-360,360,30)
				local rf = math.randomsteps(500,1500,100)
				local randomfad = math.randomsteps(200,1000,100)
				local msx, msy = char.center + math.random(25,50), char.middle + math.randomsteps(-15,15,5)
				local of_start = l.end_time-l.start_time-rf
				local of_end = l.end_time-l.start_time
				
				l.text=string.format("{\\an5\\bord1.5\\blur0.8\\1c&HFFFFEB&\\3c%s\\frx0\\fry0\\t(%d,%d,\\frx%.3f\\fry%.3f)\\fad(0,%d)\\move(%.3f,%.3f,%.3f,%.3f,%d,%d)}%s"
				,bordcolor,of_start,of_end,xrot,yrot,randomfad,char.center,char.middle,msx,msy,of_start,of_end,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" and char.text~=" " then
				--triangles fx
				
				local triangle = shape.triangle(25)
				
				l.layer=math.random(4,7)
				
				l.start_time=line.start_time+char.start_time-500
				l.end_time=line.start_time+char.end_time+500
				
				local xrots, yrots, xrote, yrote = math.randomsteps(-360,-45,45), math.randomsteps(-360,-30,30), math.randomsteps(90,360,90), math.randomsteps(15,360,15)
				
				if line.style == "ED_romanji_L" or line.style == "ED_kanji_L" then
					msx, msy, mex, mey = char.center - math.random(20,40), char.middle + math.randomsteps(-15,15,5), char.center + math.random(20,40), char.middle + math.randomsteps(-15,15,2.5)
				end
				if line.style == "ED_romanji_R" or line.style == "ED_kanji_R" then
					msx, msy, mex, mey = char.center + math.random(20,40), char.middle + math.randomsteps(-15,15,5), char.center - math.random(20,40), char.middle + math.randomsteps(-15,15,2.5)
				end
				
				l.text=string.format("{\\an5\\p1\\bord0\\blur0.8\\1c%s\\alpha&H32&\\frx%.3f\\fry%.3f\\t(\\frx%.3f\\fry%.3f)\\fad(250,250)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,triangle_color,xrots,yrots,xrote,yrote,msx,msy,mex,mey,triangle)
				
				io.write_line(l)
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end