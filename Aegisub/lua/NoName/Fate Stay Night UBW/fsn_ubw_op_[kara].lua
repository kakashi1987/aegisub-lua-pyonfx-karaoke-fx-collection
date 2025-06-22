--Fate/stay night: Unlimited Blade Works OP
--Effects by Amberdrake
--VSFilter

function kara(line, l)
	if line.style == "UBW_OP_Romanji" or line.style == "UBW_OP_Kanji" then
		
		line.infade = 150
		line.outfade = 150
		
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" then
				--Text
				
				local max_frame = 23.976
				
				local u_in, u_out, u_fx = 0, 0, 0
				
				local sx1, sy1 = char.left - math.randomsteps(15, 30, 5)-100, math.random(char.top - 5, char.bottom + 5)
				local sx2, sy2 = math.random(char.left-40, char.right+40), math.random(char.top-35, char.bottom+40)
				local sx3, sy3 = char.center + math.random(-40, 40), char.middle + math.random(-35, 40)
				local sx4, sy4 = char.center, char.middle
				
				local fx1, fy1 = char.center, char.middle
				local fx2, fy2 = math.random(char.left+char.width/3, char.right-char.width/3), math.random(char.top+char.height/3, char.bottom-char.height/3)
				local fx3, fy3 = math.randomsteps(char.left+char.width/3, char.right-char.width/3, 0.5), math.randomsteps(char.top+char.height/3, char.bottom-char.height/3, 0.5)
				local fx4, fy4 = char.center, char.middle
				
				local ex1, ey1 = char.center, char.middle
				local ex2, ey2 = math.random(char.left-40, char.right+40), math.random(char.top-35, char.bottom+40)
				local ex3, ey3 = char.center + math.random(-40, 40), char.middle + math.random(-35, 40)
				local ex4, ey4 = char.right + math.randomsteps(15, 30, 5)+100, char.middle + math.randomsteps(-15, 15, 5)
				
				local rfrx, rfry = math.randomsteps(-90, 90, 15), math.randomsteps(-90, 90, 10)
				
				local half = #line.chars/2
				if char.i <= half then
					color = utils.interpolate(char.i/half, "&H4D2DF2&", "&H4F37BF&")
				end
				if char.i > half then
					color = utils.interpolate(char.i/(half*2), "&H4F37BF&", "&H4D2DF2&")
				end
				
				local a = 0
				
				for s, e, i, n in utils.frames(line.start_time+15*char.i-15-line.infade, line.end_time+15*char.i-15+line.outfade-250, max_frame) do
					
					l.layer = 4
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					local infad, outfad = 100, 250
					local inmax, outmax, fxmax = math.ceil(infad/max_frame), math.ceil(outfad/max_frame), math.ceil((char.end_time-char.start_time)/max_frame)
					
					if i < math.ceil(infad/max_frame) then
						alpha = utils.interpolate(u_in/inmax, "&HFF&", "&H64&")
						local spoint = math.bezier(u_in/inmax,
						{
						{sx1, sy1},
						{sx2, sy2},
						{sx3, sy3},
						{sx4, sy4}
						}
						)
						frx, fry = utils.interpolate(u_in/inmax, rfrx, 0), utils.interpolate(u_in/inmax, rfry, 0)
						x, y = spoint[1] , spoint[2]
						sc = 100
						u_in = u_in + 1
					elseif s >= (line.start_time+char.start_time) and s <= (line.start_time + char.start_time + char.duration) then
						alpha="&H00&"
						local fxpoint = math.bezier((s - (line.start_time + char.start_time))/char.duration,
						{
						{fx1, fy1},
						{fx2, fy2},
						{fx3, fy3},
						{fx4, fy4}
						}
						)
						frx, fry = 0, 0
						x, y = fxpoint[1] , fxpoint[2]
						sc = 100 + 10*math.sin(math.rad(utils.interpolate(u_fx/fxmax, 0, 180)))
					elseif i > (n-math.ceil(outfad/max_frame)) then
						alpha = utils.interpolate(u_out/outmax, "&H00&", "&H64&")
						local epoint = math.bezier(u_out/outmax,
						{
						{ex1, ey1},
						{ex2, ey2},
						{ex3, ey3},
						{ex4, ey4}
						}
						)
						frx, fry = utils.interpolate(u_out/outmax, 0, rfrx), utils.interpolate(u_out/outmax, 0, rfry)
						x, y = epoint[1] , epoint[2]
						sc = 100
						u_out = u_out + 1
					else
						alpha="&H00&"
						frx, fry = 0, 0
						x, y = char.center, char.middle
						sc = 100
					end
					
					l.text = string.format("{\\an5\\blur3\\bord3\\be1\\shad0\\fscx%d\\fscy%d\\frx%.3f\\fry%.3f\\alpha%s\\1c&HFFFFFF&\\3c%s\\4c&H000000&\\pos(%.3f, %.3f)}%s"
					,sc,sc,frx,fry,alpha,color,x,y,char.text)
					
					io.write_line(l)
				end
			end
		end
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--bezier
				
				local main_color_dist = utils.distributor({"&HFFFFFF&", "&H000000"})
				local bord_color_dist = utils.distributor({"&H000000&", "&HFFFFFF"})
				
				local maxj = math.random(3,6)
				for j = 1, maxj, 1 do
					max_frame = 1
					
					local rs = math.randomsteps(line.start_time+syl.start_time, (line.start_time+syl.start_time+line.start_time+syl.end_time)/2, 100)
					local re = math.randomsteps(line.start_time+syl.end_time, line.start_time+syl.end_time+300, 100)
					
					local layer = math.randomsteps(3, 5, 2)
					
					local main_color = main_color_dist:get()
					local bord_color = bord_color_dist:get()
					
					if syl.i == 1 then
						lead = math.random(-15, -10)
						spread = math.randomsteps(-10, 10, 2)
					elseif syl.i == #line.syls then
						lead = math.random(10, 15)
						spread = math.randomsteps(-10, 10, 2)
					else
						lead = 0
						spread = 0
					end
					
					if j%2 == 1 then
						x1, y1 = syl.left + lead, syl.top+syl.height/2 + spread
						x2, y2 = math.random(syl.left+syl.width/2, syl.right), math.random(syl.top+syl.height/2, syl.bottom+10)
						x3, y3 = math.random(syl.left, syl.left+syl.width/2), math.random(syl.top, syl.top+syl.height/2)
						x4, y4 = syl.right+lead, syl.top+syl.height/2 + spread
					else
						x1, y1 = syl.left + lead, syl.top+syl.height/2 + spread
						x2, y2 = math.random(syl.left+syl.width/2, syl.right),math.random(syl.top, syl.top+syl.height/2)
						x3, y3 = math.random(syl.left, syl.left+syl.width/2), math.random(syl.top+syl.height/2, syl.bottom+10)
						x4, y4 = syl.right+lead, syl.top+syl.height/2 + spread
					end
					
					local random_end = math.randomsteps(250, 500, 50)
					local fad = random_end/2
					
					for s, e, i, n in utils.frames(rs, re, max_frame) do
						
						l.layer = layer
						
						l.start_time=s
						l.end_time=s+random_end
						
						local step = i / n
						
						local point = math.bezier(step,
						{
						{x1, y1},
						{x2, y2},
						{x3, y3},
						{x4, y4}
						}
						)
						
						local x, y = point[1] , point[2]+5
						
						l.text=string.format("{\\p1\\an8\\bord0.1\\shad0\\blur1.5\\fscx70\\fscy70\\t(\\fscx0\\fscy0)\\1c%s\\3c%s\\fad(0,%d)\\pos(%.3f,%.3f)}m 0 0 l 1 0 1 1 0 1"
						,main_color,bord_color,fad,x,y)
						
						io.write_line(l)
					end
				end
			end
		end
	end
	if line.style == "UBW_OP_TL" then
		
		line.infade = 150
		line.outfade = 150
		
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" then
				--Text infade
				
				local max_frame = 50
				
				local u_in, u_out = 0, 0
				
				local sx1, sy1 = char.left - math.randomsteps(15, 30, 5)-100, math.random(char.top - 5, char.bottom + 5)
				local sx2, sy2 = math.random(char.left-40, char.right+40), math.random(char.top-35, char.bottom+40)
				local sx3, sy3 = char.center + math.random(-40, 40), char.middle + math.random(-35, 40)
				local sx4, sy4 = char.center, char.middle
				
				local ex1, ey1 = char.center, char.middle
				local ex2, ey2 = math.random(char.left-40, char.right+40), math.random(char.top-35, char.bottom+40)
				local ex3, ey3 = char.center + math.random(-40, 40), char.middle + math.random(-35, 40)
				local ex4, ey4 = char.right + math.randomsteps(15, 30, 5)+100, char.middle + math.randomsteps(-15, 15, 5)
				
				local rfrx, rfry = math.randomsteps(-90, 90, 15), math.randomsteps(-90, 90, 10)
				
				local half = #line.chars/2
				if char.i <= half then
					color = utils.interpolate(char.i/half, "&H4D2DF2&", "&H4F37BF&")
				end
				if char.i > half then
					color = utils.interpolate(char.i/(half*2), "&H4F37BF&", "&H4D2DF2&")
				end
				
				local a = 0
				
				for s, e, i, n in utils.frames(line.start_time+15*char.i-15-line.infade, line.start_time+15*char.i-15-line.infade+100, max_frame) do
					
					l.layer = 4
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					alpha = utils.interpolate(step, "&HFF&", "&H64&")
					local spoint = math.bezier(step,
					{
					{sx1, sy1},
					{sx2, sy2},
					{sx3, sy3},
					{sx4, sy4}
					}
					)
					frx, fry = utils.interpolate(step, rfrx, 0), utils.interpolate(step, rfry, 0)
					x, y = spoint[1] , spoint[2]
					u_in = u_in + 1
					
					l.text = string.format("{\\an5\\blur3\\bord3\\be1\\shad0\\fscx100\\fscy100\\frx%.3f\\fry%.3f\\alpha%s\\1c&HFFFFFF&\\3c%s\\4c&H000000&\\pos(%.3f, %.3f)}%s"
					,frx,fry,alpha,color,x,y,char.text)
					
					io.write_line(l)
				end
			end
			
			if char.text~="" then
				--Text
				
				l.layer = 4
				
				l.start_time = line.start_time+15*char.i-15-line.infade+100
				l.end_time = line.end_time+15*char.i-15+line.outfade-500
				
				local half = #line.chars/2
				if char.i <= half then
					color = utils.interpolate(char.i/half, "&H4D2DF2&", "&H4F37BF&")
				end
				if char.i > half then
					color = utils.interpolate(char.i/(half*2), "&H4F37BF&", "&H4D2DF2&")
				end
				
				l.text = string.format("{\\an5\\blur3\\bord3\\be1\\shad0\\fscx100\\fscy100\\frx0\\fry0\\1c&HFFFFFF&\\3c%s\\4c&H000000&\\pos(%.3f, %.3f)}%s"
				,color,x,y,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--Text outfade
				
				local max_frame = 50
				
				local u_in, u_out = 0, 0
				
				local sx1, sy1 = char.left - math.randomsteps(15, 30, 5)-100, math.random(char.top - 5, char.bottom + 5)
				local sx2, sy2 = math.random(char.left-40, char.right+40), math.random(char.top-35, char.bottom+40)
				local sx3, sy3 = char.center + math.random(-40, 40), char.middle + math.random(-35, 40)
				local sx4, sy4 = char.center, char.middle
				
				local ex1, ey1 = char.center, char.middle
				local ex2, ey2 = math.random(char.left-40, char.right+40), math.random(char.top-35, char.bottom+40)
				local ex3, ey3 = char.center + math.random(-40, 40), char.middle + math.random(-35, 40)
				local ex4, ey4 = char.right + math.randomsteps(15, 30, 5)+100, char.middle + math.randomsteps(-15, 15, 5)
				
				local rfrx, rfry = math.randomsteps(-90, 90, 15), math.randomsteps(-90, 90, 10)
				
				local half = #line.chars/2
				if char.i <= half then
					color = utils.interpolate(char.i/half, "&H4D2DF2&", "&H4F37BF&")
				end
				if char.i > half then
					color = utils.interpolate(char.i/(half*2), "&H4F37BF&", "&H4D2DF2&")
				end
				
				local a = 0
				
				for s, e, i, n in utils.frames(line.end_time+15*char.i-15+line.outfade-500, line.end_time+15*char.i-15+line.outfade-250, max_frame) do
					
					l.layer = 4
					
					l.start_time = s
					l.end_time = e
					
					local step = i / n
					
					local alpha = utils.interpolate(step, "&H00&", "&H64&")
					local epoint = math.bezier(step,
					{
					{ex1, ey1},
					{ex2, ey2},
					{ex3, ey3},
					{ex4, ey4}
					}
					)
					frx, fry = utils.interpolate(step, 0, rfrx), utils.interpolate(step, 0, rfry)
					x, y = epoint[1] , epoint[2]
					
					l.text = string.format("{\\an5\\blur3\\bord3\\be1\\shad0\\fscx100\\fscy100\\frx%.3f\\fry%.3f\\alpha%s\\1c&HFFFFFF&\\3c%s\\4c&H000000&\\pos(%.3f, %.3f)}%s"
					,frx,fry,alpha,color,x,y,char.text)
					
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