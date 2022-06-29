--Fate/Apocrypha OP2
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	line.infade = 500
	line.outfade = 750
	
	for si, syl in ipairs(line.syls) do
		
		if syl.text~="" then
			--infade L1+2
			
			rs = math.randomsteps(-50, 50, 25)
			
			l.start_time=line.start_time-line.infade + rs
			l.end_time=line.start_time
			
			trans_end = l.end_time-l.start_time
			
			maxj = 2
			for j = 1,maxj,1 do
				
				if j == 1 then
					
					l.layer = 5
					
					l.text=string.format("{\\an5\\bord1\\blur3\\shad0\\fscx100\\fscy100\\1a&FF&\\1c&HFFFFFF&\\3c&H265FD8&\\fad(%d,250)\\pos(%.3f,%.3f)}%s"
					,250+rs,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
					
				end
				if j == 2 then
					
					l.layer = 6
					
					l.text=string.format("{\\an5\\bord1\\blur0.6\\shad0\\fscx100\\fscy100\\1a&FF&\\1c&FFFFFF&\\3c&H26FFFE&\\t(%d,%d,\\bord0.8)\\t(%d,%d,\\3c&H000000&)\\fad(250,0)\\pos(%.3f,%.3f)}%s"
					,trans_end-250,trans_end,trans_end-50,trans_end,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
					
				end
			end
		end
		
		if syl.text~="" then
			--infade L3
			l.layer = 4
			
			l.start_time=line.start_time-line.infade+250
			l.end_time=line.start_time
			
			l.text=string.format("{\\an5\\bord0\\blur0.4\\shad0\\fscx100\\fscy100\\1a&HFF&\\1c&H265FD8&\\t(0,250,\\1a&H00&)\\t(150,500,\\1c&HFFFFFF&)\\pos(%.3f,%.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--placeholder
			l.layer = 7
			
			l.start_time=line.start_time
			l.end_time=line.end_time
			
			l.text=string.format("{\\an5\\bord0.6\\blur0.4\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&H000000&\\pos(%.3f,%.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--syl fx 1
			
			fx_st = syl.duration/4
			fx_ed = syl.duration/2
			
			maxj = 2
			for j = 1,maxj,1 do
				
				if j == 1 then
					
					l.layer = 8
					
					l.start_time=line.start_time+syl.start_time
					l.end_time=line.start_time+syl.end_time+500
					
					l.text=string.format("{\\an5\\bord1\\blur3\\shad0\\fscx100\\fscy100\\1a&HFF&\\1c&HFFFFFF&\\3c&H265FD8&\\fad(%d,500)\\pos(%.3f,%.3f)}%s"
					,fx_st,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
					
				end
				if j == 2 then
					
					l.start_time=line.start_time+syl.start_time
					l.end_time=line.start_time+syl.end_time
					
					l.layer = 9
					
					l.text=string.format("{\\an5\\bord0.8\\blur0.6\\shad0\\fscx100\\fscy100\\1c&FFFFFF&\\3c&H000000&\\t(0,%d,\\bord1.2\\1c&H5EFFFB&\\3c&H26FFFE&)\\t(%d,%d,\\bord0.8\\1c&FFFFFF&\\3c&H000000&)\\pos(%.3f,%.3f)}%s"
					,fx_st,fx_ed,syl.duration,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
					
				end
			end
		end
		
		if syl.text~="" and syl.text~=" " and syl.text~="　" then
			--syl fx 2
			
			local l = table.copy(line)
			
			local cx, cy = math.random(syl.x - syl.width/2, syl.x + syl.width/2), math.random(syl.y - syl.height/2, syl.y + syl.height/2)
			
			local bx1, by1 = syl.left + math.randomsteps(-50,-10,25), syl.top + math.randomsteps(-30,30,10)
			local bx2, by2 = syl.left + math.randomsteps(-55,-15,5), syl.top + math.randomsteps(-45,45,15)
			local bx3, by3 = syl.left + math.randomsteps(-30,-5,5), syl.bottom + math.randomsteps(-55,55,10)
			local bx4, by4 = syl.left + math.randomsteps(-40,-10,5), syl.bottom + math.randomsteps(-20,20,5)
			
			for pi, pixel in ipairs(convert.text_to_pixels(syl.text, line.styleref)) do
				
				l.layer = math.random(7,10)
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time + 1000
				
				local x, y = syl.center, syl.middle
				
				local px, py = syl.left + pixel.x, syl.top + pixel.y
				
				local bpoint = math.bezier(math.randomsteps(0, 1, 0.01),
				{
				{bx1, by1},
				{bx2, by2},
				{bx3, by3},
				{bx4, by4}
				}
				)
				
				local mx, my = bpoint[1] + math.random(-1,1), bpoint[2] + math.random(-1,1)
				
				local ms, me = math.randomsteps(0, 1000, 50), l.end_time-l.start_time
				
				local fad = math.random(syl.duration+500, syl.duration+1000)
				
				local cd1, cd2 = math.abs(cx-px), math.abs(cy-py)
				
				l.text=string.format("{\\an7\\bord0.1\\blur3\\shad0\\fscx100\\fscy100\\fad(0,%d)\\1c&H26FFFE&\\3c&H26FFFE&\\4a&H64&\\move(%.3f,%.3f,%.3f,%.3f, %.3f,%.3f)\\p1}m 0 0 l 1 0 1 1 0 1"
				,fad,px,py,mx,my,ms,me)
				
				io.write_line(l)
			end
			
		end
		
		if syl.text~="" then
			--outfade fx 2
			
			l.start_time=line.end_time
			l.end_time=line.end_time+250+25*syl.i
			
			maxj = 2
			for j = 1,maxj,1 do
				
				if j == 1 then
					
					l.layer = 8
					
					l.text=string.format("{\\an5\\bord1\\blur3\\shad0\\fscx100\\fscy100\\1a&HFF&\\1c&HFFFFFF&\\3c&H265FD8&\\fad(0,250)\\pos(%.3f,%.3f)}%s"
					,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
					
				end
				if j == 2 then
					
					l.layer = 9
					
					l.text=string.format("{\\an5\\bord0.8\\blur0.6\\shad0\\fscx100\\fscy100\\1c&FFFFFF&\\3c&H000000&\\t(\\bord1.2\\1c&H5EFFFB&\\3c&H5EFFFB&)\\pos(%.3f,%.3f)}%s"
					,syl.center,syl.middle,syl.text)
					
					io.write_line(l)
					
				end
			end
		end
		
		if syl.text~="" and syl.text~=" " and syl.text~="　" then
			--outfade fx2
			
			local l = table.copy(line)
			
			local cx, cy = math.random(syl.x - syl.width/2, syl.x + syl.width/2), math.random(syl.y - syl.height/2, syl.y + syl.height/2)
			
			local bx1, by1 = syl.left - math.random(-5,40), syl.top + math.random(-25,-15)
			local bx2, by2 = syl.right + math.random(-15,35), syl.top + math.random(-15,-10)
			local bx3, by3 = syl.left + math.random(-5,45), syl.top + math.random(-25,-5)
			local bx4, by4 = syl.right + math.random(-15,50), syl.top + math.random(-30,-15)
			
			for pi, pixel in ipairs(convert.text_to_pixels(syl.text, line.styleref)) do
				
				l.layer = 3
				
				l.start_time=line.end_time+250+25*syl.i
				l.end_time=line.end_time+15*syl.i+line.outfade+math.randomsteps(0,250,25)
				
				local x, y = syl.center, syl.middle
				
				local px, py = syl.left + pixel.x, syl.top + pixel.y
				
				local bpoint = math.bezier(math.randomsteps(0, 1, 0.01),
				{
				{bx1, by1},
				{bx2, by2},
				{bx3, by3},
				{bx4, by4}
				}
				)
				
				local mx, my = bpoint[1] + math.random(-1,1), bpoint[2] + math.random(-1,1)
				
				local ms, me = math.randomsteps(0, 250, 25), l.end_time-l.start_time
				
				local fad = math.randomsteps(150, 250, 25)
				
				local cd1, cd2 = math.abs(cx-px), math.abs(cy-py)
				
				l.text=string.format("{\\an7\\bord0.2\\blur1.5\\shad0\\fscx100\\fscy100\\fad(0,%d)\\1c&H5EFFFB&\\3c&H5EFFFB&\\t(0,250,\\1c&H265FD8&\\3c&H6292FE&)\\alpha&H96&\\move(%.3f,%.3f,%.3f,%.3f, %.3f,%.3f)\\p1}m 0 0 l 1 0 1 1 0 1"
				,fad,px,py,mx,my,ms,me)
				
				io.write_line(l)
			end
			
		end
		
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end