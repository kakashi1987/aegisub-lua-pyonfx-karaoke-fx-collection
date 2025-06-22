--Bokura wa Minna Kawaisou Opening
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	line.infade = 500
	line.outfade = 500
	
	for si,syl in ipairs(line.syls) do
		
		if line.actor == "circle" then
			
			if syl.text~="" then
				--circle syl fx
				
				l.layer = 2
				
				l.start_time = line.start_time + syl.start_time - 150
				l.end_time = line.end_time + 250
				
				local x1, y1 = syl.center - 35, syl.middle - 35
				local x2, y2 = syl.center, syl.middle
				
				l.text = string.format("{\\an5\\bord0\\blur5\\shad0\\fad(150,250)\\fscx150\\fscy150\\t(0,250,\\blur0.8\\fscx100\\fscy100)\\1c&H000000&\\3c&H000000&\\move(%.3f, %.3f, %.3f, %.3f, 0, 250)}%s"
				,x1,y1,x2,y2,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--circle fx
				
				l.layer = 1
				
				l.start_time = line.start_time + syl.start_time - 250
				l.end_time = line.end_time + 250
				
				local r = (syl.width+syl.height)/2
				local circle = shape.ellipse(r+15, r+15)
				
				local x1, y1 = syl.center - 25, syl.middle - 25
				local x2, y2 = syl.center - 3, syl.middle + 3
				
				l.text = string.format("{\\p1\\an5\\bord2.5\\blur1.2\\shad0\\fad(150,250)\\fscx130\\fscy130\\t(0,250,\\fscx100\\fscy100)\\1c&HFFFFFF&\\3c&H000000&\\move(%.3f, %.3f, %.3f, %.3f, 0, 250)}%s"
				,x1,y1,x2,y2,circle)
				
				io.write_line(l)
			end
		else
			if line.actor == "letters1" then
				
				if syl.text~="" then
					--letters1 fx
					local maxk = math.random(2, 4)
					for k = 1, maxk, 1 do
						
						local start = math.randomsteps(syl.left-5, syl.right+5, 10)
						
						local max_frame = 25
						local a = 0
						local u_in, u_out = 0, 0
						
						local letter_array = {"誕生日おめでとうサッルリアナ", "僕等はみんあかわいそう", "為せば成るなさねばならぬ", "何事も成らぬは", "人の為さぬなりけり"}
						local letter = letter_array[math.random(1,table.getn(letter_array))]
						
						local sc = math.randomsteps(20, 40, 10)
						
						local layer = math.randomsteps(4, 6, 2)
						
						for s, e, i, n in utils.frames(line.start_time+syl.start_time - 500 + 50*k - 50, line.start_time+syl.end_time + 500 - 50*k - 50, max_frame) do
							
							l.layer = layer
							
							l.start_time = s
							l.end_time = e
							
							local step = i / n
							
							local fad = 500
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
							
							local w = syl.width/2
							
							local x1, y1 = start, syl.top
							local x2, y2 = x1, y1 + a
							
							clip_src = shape.rectangle(line.width + 50, line.height + 75)
							clip = shape.move(clip_src,line.left - 25,line.top - 50)
							
							l.text = string.format("{\\fn@DFKaiSho-Md\\an6\\bord0\\blur0.6\\frz-90\\shad0\\fscx%d\\fscy%d\\alpha%s\\1c&H000000&\\pos(%.3f, %.3f)\\clip(%s)}%s"
							,sc,sc,alpha,x2,y2,clip,letter)
							
							a = a + 1.5
							io.write_line(l)
						end
					end
				end
				
				if syl.text~="" then
					--letters1 syl fx
					
					local max_frame = 25
					local b = 0
					
					for s, e, i, n in utils.frames(line.start_time+syl.start_time - 150, line.start_time+syl.end_time + 150, max_frame) do
						
						l.layer = 5
						
						l.start_time = s
						l.end_time = e
						
						local step = i / n
						
						x, y = syl.center, utils.interpolate(step, syl.middle-10, syl.middle)
						frz = 5*math.sin(math.rad(b))
						
						l.text = string.format("{\\an5\\bord3\\blur3\\shad0\\fscx100\\fscy100\\frz%.3f\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f, %.3f)}%s"
						,frz,x,y,syl.text)
						
						b = b + 60
						io.write_line(l)
					end
				end
			end
			
			if line.actor == "letters2" then
				
				if syl.text~="" then
					--letters2 fx
					local maxm = math.random(5, 10)
					for m = 1, maxm, 1 do
						
						l.layer = 4
						
						l.start_time=line.start_time+syl.start_time-250
						l.end_time=line.start_time+syl.end_time+250
						
						local xrots, yrots, xrote, yrote, zrots, zrote = math.randomsteps(-360,-45,45), math.randomsteps(-360,-30,30), math.randomsteps(90,360,90), math.randomsteps(15,360,15), math.randomsteps(-90, -45, 5), math.randomsteps(45, 90, 5)
						
						local msx, msy, mex, mey = syl.center - math.random(20,40), syl.middle + math.randomsteps(-25,25,5), syl.center + math.random(20,40), syl.middle + math.randomsteps(-30,30,10)
						
						l.text=string.format("{\\fn@DFKaiSho-Md\\an6\\bord0\\blur0.6\\1c&H000000&\\fscx80\\fscy80\\frx%.3f\\fry%.3f\\frz%.3f\\t(\\frx%.3f\\fry%.3f\\frz%.3f)\\fad(250,250)\\move(%.3f,%.3f,%.3f,%.3f)}傘"
						,xrots,yrots,zrots,xrote,yrote,zrote,msx,msy,mex,mey)
						
						io.write_line(l)
					end
				end
			end
		end
		
		if line.actor == "letters2" or line.actor == "normal" then
			if syl.text~="" then
				-- syl fx
				
				local max_frame = 25
				local c = 0
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.layer = 5
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					x, y = syl.center, syl.middle + 5*math.sin(math.rad(c))
					
					l.text = string.format("{\\an5\\bord3\\blur3\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f, %.3f)}%s"
					,x,y,syl.text)
					
					c = c + 10
					io.write_line(l)
				end
			end
		end
		
		if line.actor == "letters1" or line.actor == "letters2" or line.actor == "normal" then
			for j = 1, 2, 1 do
				
				if j == 1 then
					bord = 0
					blur1 = 5
					blur2 = 0.8
					layer = 5
				else
					bord = 3
					blur1 = 10
					blur2 = 3
					layer = 4
				end
				
				if line.actor == "letters1" then
					fix = 150
				else
					fix = 0
				end
				
				if syl.text~="" then
					--infade
					
					l.layer = layer
					
					l.start_time = line.start_time - line.infade
					l.end_time = line.start_time + syl.start_time - fix
					
					local x1, y1 = syl.center, syl.middle - 25
					local x2, y2 = syl.center, syl.middle
					
					l.text = string.format("{\\an5\\blur%.2f\\bord%d\\shad0\\fscx100\\fscy100\\fad(450,0)\\1c&H000000&\\3c&H000000&\\t(0,450,\\blur%.2f\\1c&HFFFFFF&)\\move(%.3f, %.3f, %.3f, %.3f, 0, 500)}%s"
					,blur1,bord,blur2,x1,y1,x2,y2,syl.text)
					
					io.write_line(l)
				end
				
				if syl.text~="" then
					--outfade
					
					l.layer = layer
					
					l.start_time = line.start_time + syl.end_time + fix
					l.end_time = line.end_time + line.outfade
					
					local ofs, ofe = l.end_time - l.start_time - 450, l.end_time - l.start_time
					
					local x1, y1 = syl.center, syl.middle
					local x2, y2 = syl.center, syl.middle + 25
					
					l.text = string.format("{\\an5\\bord%d\\shad0\\fscx100\\fscy100\\fad(0,450)\\1c&HFFFFFF&\\3c&H000000&\\blur%.2f\\t(%.3f,%.3f,\\blur%.2f\\1c&H000000&)\\move(%.3f, %.3f, %.3f, %.3f, %.3f, %.3f)}%s"
					,bord,blur2,ofs,ofe,blur1,x1,y1,x2,y2,ofs-50,ofe,syl.text)
					
					io.write_line(l)
				end
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	kara(line, table.copy(line) )
	
	io.progressbar(li / #lines)
end