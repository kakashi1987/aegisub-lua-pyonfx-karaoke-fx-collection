--Dragon Ball Kai 99+ Ending
--Karaoke by Amberdrake
--VSFilter

function kara (line, l)
	if line.infade > 250 then
		line.infade = 250
	end
	if line.outfade > 250 then
		line.outfade = 250
	end
	if line.i==11 or line.i==15 then
		line.outfade = -500
	end
	
	for si,syl in ipairs(line.syls) do
		
		if line.style == "ED_ah" then
			
			if syl.text~="" then
				
				l.layer=1
				
				max_frame=25
				a=0
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					--ah bord
					
					l.start_time = s
					l.end_time = e+100
					
					sc1 = 100+math.random(15,20)*math.sin(math.rad(a))
					sc2 = 100+math.randomsteps(15,20,0.5)*math.sin(math.rad(a))
					a = a + 90
					
					rp1 = math.randomsteps(-1, 1, 0.5)
					rp2 = math.randomsteps(-1.5, 1.5, 0.5)
					
					l.text = string.format("{\\an5\\blur3\\bord1\\shad0\\fad(0,100)\\fscx%d\\fscy%d\\1a&HFF&\\3c&H8AA4F5&\\pos(%.3f, %.3f)}%s"
					,sc1,sc2,line.center+rp1,line.middle+rp2,syl.text)
					
					io.write_line(l)
					
				end
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				
				l.layer=3
				
				max_frame=25
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					--ah fill 1
					
					l.start_time = s
					l.end_time = e+100
					
					sc = 80+math.randomsteps(0,20,5)
					
					rp1 = math.randomsteps(-2, 2, 0.5)
					rp2 = math.randomsteps(-3, 3, 1)
					
					l.text = string.format("{\\an5\\blur1\\bord0\\shad0\\fad(0,100)\\alpha&H64&\\fscx%d\\fscy%d\\1c&H3B6CE7&\\pos(%.3f, %.3f)}%s"
					,sc,sc,line.center+rp2,line.middle+rp1,syl.text)
					
					io.write_line(l)
					
				end
				
				io.write_line(l)
			end
			if syl.text~="" then
				
				l.layer=2
				
				max_frame=25
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					--ah fill 2
					
					l.start_time = s
					l.end_time = e+100
					
					sc = 80+math.randomsteps(0,20,5)
					
					rp1 = math.randomsteps(-2, 2, 0.5)
					rp2 = math.randomsteps(-3, 3, 1)
					
					l.text = string.format("{\\an5\\blur1\\bord1\\shad0\\fad(0,100)\\1a&HFF&\\3a&H64&\\fscx%d\\fscy%d\\3c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
					,sc,sc,line.center+rp2,line.middle+rp1,syl.text)
					
					io.write_line(l)
					
				end
				
				io.write_line(l)
			end
			
		end
		
		if line.style == "ED_romanji" then
			
			if syl.text~="" then
				--romanji infade
				l.layer=1
				
				l.start_time=line.start_time-line.infade+50*syl.i-50
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\blur0.6\\bord1\\shad0\\fscx100\\fscy100\\fad(250,0)\\1c&H3B6CE7&\\3c&H371816&\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--romanji effect
				if syl.text~="" then
					
					local getshape = convert.text_to_shape(syl.text, line.styleref)
					
					l.layer=2
					
					max_frame=25
					a=0
					
					for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
						
						l.start_time = s
						l.end_time = e
						
						l.layer = 2
						
						local frame_pct = i / n
						
						local deform = shape.filter(getshape,
						function(x,y)
							local xdef = math.randomsteps(-15,15,0.25)
							local ydef = math.randomsteps(-20,20,0.5)
							return x+xdef, y+ydef
						end)
						
						sc = 110+math.random(5,10)*math.sin(math.rad(a))
						a = a + 90
						
						l.text=string.format("{\\an7\\p4\\blur0.6\\bord1\\shad0\\fscx%d\\fscy%d\\1c&H3B6CE7&\\3c&H371816&\\pos(%.3f, %.3f)}%s"
						,sc,sc,syl.left-3,syl.top-3,deform)
						
						io.write_line(l)
					end
				end
				
				if syl.text~="" then
					--romanji bord effect
					l.layer=1
					
					max_frame=25
					a=0
					
					maxj=5
					for j=1,maxj,0.5 do
						for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
							--ah bord
							
							l.start_time = s
							l.end_time = e
							
							sc1 = 110+math.random(15,20)*math.sin(math.rad(a))
							sc2 = 110+math.randomsteps(15,20,0.5)*math.sin(math.rad(a))
							a = a + 90
							
							rp1 = math.randomsteps(-j, j, 0.5)
							rp2 = math.randomsteps(-3.5, 3.5, 0.5)
							
							l.text = string.format("{\\an5\\blur0\\bord1\\shad0\\fscx%d\\fscy%d\\1a&HFF&\\3c&H64&\\3c&H3B6CE7&\\pos(%.3f, %.3f)}%s"
							,sc1,sc2,syl.center+rp1,syl.middle+rp2,syl.text)
							
							io.write_line(l)
							
						end
					end
					
					io.write_line(l)
				end
				
				if syl.text~="" then
					--romanji outfade
					l.layer=1
					
					l.start_time=line.start_time+syl.end_time
					l.end_time=line.end_time+line.outfade+50*syl.i-50
					
					l.text=string.format("{\\an5\\blur0.6\\bord1\\shad0\\fscx100\\fscy100\\fad(0,250)\\1c&H3B6CE7&\\3c&H371816&\\pos(%.3f, %.3f)}%s"
					,syl.center,syl.middle,syl.text)
					
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