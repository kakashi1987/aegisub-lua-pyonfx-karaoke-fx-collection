--Magi: Kingdom of Magic OP/ED
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	if line.infade > 500 then
		line.infade = 250
	end
	if line.outfade > 500 then
		line.outfade = 250
	end
	
	if line.style == "OP Romaji" or line.style == "ED Romaji" then
		
		for si,syl in ipairs(line.syls) do
			if syl.text~="" then
				--infade L1
				
				l.layer = 6
				
				l.start_time = line.start_time-line.infade
				l.end_time = line.start_time+syl.start_time
				
				l.text = string.format("{\\an5\\bord1\\blur2.5\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&H593B31&\\fad(250,0)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--infade L2
				
				l.layer = 5
				
				l.start_time = line.start_time-line.infade
				l.end_time = line.start_time+syl.start_time
				
				l.text = string.format("{\\an5\\bord1.5\\blur4\\shad0\\fscx100\\fscy100\\1c&HFBCC76&\\3c&HFBCC76&\\fad(250,0)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--syl fx L1
				
				l.layer = 8
				
				l.start_time = line.start_time+syl.start_time
				l.end_time = line.start_time+syl.end_time
				
				l.text = string.format("{\\an2\\bord1\\blur2.5\\shad0\\fscx100\\fscy100\\t(0,%d,\\fscx100\\fscy125)\\t(%d,%d,\\fscx100\\fscy100)\\1c&HFFFFFF&\\3c&H593B31&\\pos(%.3f, %.3f)}%s"
				,syl.duration/4,syl.duration/4,syl.duration,syl.center,syl.bottom,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--syl fx L2
				
				l.layer = 3
				
				l.start_time = line.start_time+syl.start_time
				l.end_time = line.start_time+syl.end_time
				
				l.text = string.format("{\\an2\\bord3.5\\blur8\\shad0\\fscx100\\fscy100\\t(0,%d,\\fscx100\\fscy135)\\t(%d,%d,\\fscx100\\fscy100)\\1c&HFBCC76&\\3c&HFBCC76&\\pos(%.3f, %.3f)}%s"
				,syl.duration/4,syl.duration/4,syl.duration,syl.center,syl.bottom,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--outfade L1
				
				l.layer = 6
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade
				
				l.text = string.format("{\\an5\\bord1\\blur2.5\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&H593B31&\\fad(0,250)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--outfade L2
				
				l.layer = 5
				
				l.start_time = line.start_time+syl.end_time
				l.end_time = line.end_time+line.outfade
				
				l.text = string.format("{\\an5\\bord1.5\\blur4\\shad0\\fscx100\\fscy100\\1c&HFBCC76&\\3c&HFBCC76&\\fad(0,250)\\pos(%.3f, %.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				--syl rukh fx
				
				l.layer = math.random(5,10)
				
				local maxj = math.random(2,4)
				for j = 1, maxj, 1 do
					
					local start_t = line.start_time + syl.start_time + math.randomsteps(-150, 150, 50)
					local end_t = start_t + math.randomsteps(1000, 1500, 250)
					
					local rukh1 = "m 0 0 b -19 -16 -31 -36 -36 -61 b -26 -56 -16 -49 -5 -34 b 2 -49 10 -56 18 -61 b 18 -43 12 -22 1 -1 "
					local rukh2 = "m 0 0 b -18 -5 -34 -10 -41 -18 b -28 -23 -14 -21 0 -15 b 7 -22 14 -24 39 -24 b 23 -8 11 -3 0 0 "
					
					local rukh_dist = utils.distributor({rukh1, rukh1, rukh2, rukh2})
					
					local max_frame = 50
					local u_in, u_out = 0, 0
					
					local x_1, y_1 = syl.center + math.randomsteps(-20, 20, 5), syl.middle + math.randomsteps(-20, 20, 5)
					local x_2, y_2 = x_1 + math.randomsteps(-15, 15, 30), y_1 + math.randomsteps(-15, 15, 30)
					
					for s, e, i, n in utils.frames(start_t, end_t, max_frame) do
						
						l.start_time = s
						l.end_time = e
						
						local step = i / n
						
						local fad = 500
						local max=math.ceil(fad/max_frame)
						if i<math.ceil(fad/max_frame) then
							alpha = utils.interpolate(u_in/max, "&HFF&", "&H00&")
							u_in=u_in+1
						elseif i>(n-math.ceil(fad/max_frame)) then
							alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
							u_out=u_out+1
						else
							alpha="&H00&"
						end
						
						local x, y = utils.interpolate(step, x_1, x_2), utils.interpolate(step, y_1, y_2)
						
						local rukh = rukh_dist:get()
						
						l.text = string.format("{\\p4\\an5\\bord1.5\\blur4\\shad0\\fscx100\\fscy100\\1c&HF6F8F8&\\3c&HB1F0FA&\\alpha%s\\pos(%.3f, %.3f)}%s"
						,alpha,x,y,rukh)
						
						io.write_line(l)
					end
				end
			end
			
		end
	end
	
	if line.style == "OP TL" or line.style == "ED TL" then
	
		if line.text~="" then
			--infade L1
			
			l.layer = 6
			
			l.start_time = line.start_time-line.infade
			l.end_time = line.end_time+line.outfade
			
			l.text = string.format("{\\an5\\bord1\\blur2.5\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&H593B31&\\fad(250,250)\\pos(%.3f, %.3f)}%s"
			,line.center,line.middle,line.text)
			
			io.write_line(l)
		end
		
		if line.text~="" then
			--infade L2
			
			l.layer = 5
			
			l.start_time = line.start_time-line.infade
			l.end_time = line.end_time+line.outfade
			
			l.text = string.format("{\\an5\\bord1.5\\blur4\\shad0\\fscx100\\fscy100\\1c&HFBCC76&\\3c&HFBCC76&\\fad(250,250)\\pos(%.3f, %.3f)}%s"
			,line.center,line.middle,line.text)
			
			io.write_line(l)
		end
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end