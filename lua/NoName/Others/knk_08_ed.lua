--Kara no Kyoukai: Mirai Fukuin ED
--Karaoke by Amberdrake
--VSFilterMod

function kara(line, l)
	
	if line.infade>500 then
		line.infade=500
	end
	
	if line. outfade>500 then
		line.outfade=500
	end
	
	for si,syl in ipairs(line.syls) do
		
		if syl.text~="" then
		--romanji/kanji infade
			
			if line.style=="ed_romanji_L" or line.style=="ed_romanji_R" or line.style=="ed_kanji_L" or line.style=="ed_kanji_R" then
				
				l.layer=1
				
				l.start_time=line.start_time-line.infade+50*syl.i-50
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\blur0.4\\bord0\\shad0\\fscx100\\fscy100\\1c&HFFFFFF&\\fad(250,0)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
		
		if syl.text~="" then
		--romanji/kanji effect 1
			
			if line.style=="ed_romanji_L" or line.style=="ed_romanji_R" or line.style=="ed_kanji_L" or line.style=="ed_kanji_R" then
				
				l.layer=2
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time+500
				
				l.text=string.format("{\\an5\\blur0.4\\bord3\\1a&HFF&\\shad0\\fscx100\\fscy100\\3c&HFFFFFF&\\t(\\fscx130\\fscy130)\\fad(0,%d)\\pos(%.3f,%.3f)}%s"
				,syl.duration,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
		
		if syl.text~="" then
		--romanji/kanji effect 2
			
			if line.style=="ed_romanji_L" or line.style=="ed_romanji_R" or line.style=="ed_kanji_L" or line.style=="ed_kanji_R" then
				
				local l = table.copy(line)
				
				for pi, pixel in ipairs(convert.text_to_pixels(syl.text, line.styleref) ) do
					
					l.layer=1
					
					l.start_time=line.start_time+syl.start_time
					l.end_time=line.start_time+syl.end_time+750
					
					local cx = syl.center
					local cy = syl.middle
					
					local px = syl.left + pixel.x
					local py = syl.top + pixel.y
					
					local vx, vy = px - cx, py - cy
					
					local angle = math.deg(math.atan2(vx, vy))
					
					local x,y = math.ellipse(cx,cy,60,90,angle)
					
					step=utils.interpolate(1, l.start_time, l.end_time)
					
					local xdef=math.sin(y/line.width+step)
					local ydef=math.sin(x/line.height+step)
					
					local randomfad=math.randomsteps(100,750,50)
					
					l.text=string.format("{\\an5\\bord1\\blur0.6\\fscx100\\fscy100\\1c&HFFFFFF&\\3c&HFFFFFF&\\fad(0,%d)\\moves3(%.3f,%.3f, %.3f,%.3f, %.3f,%.3f)\\p1}m 0 0 l 1 0 1 1 0 1"
					,randomfad,px,py,x+xdef,y+ydef,x+xdef+math.random(-30,30),y+ydef+math.random(-30,30))
					
					io.write_line(l)
				end
			end
			
		end
		
	end
	
	for ci,char in ipairs(line.chars) do
		--alleluia effect
		
		if line.style=="ed_alleluia" or line.style=="ed_alleluia_L" or line.style=="ed_alleluia_R" then
			
			max_frame=100
			u_in=0
			u_out=0
			
			for s, e, i, n in utils.frames(line.start_time+char.start_time, line.start_time+char.end_time, max_frame) do
				
				l.start_time = s
				l.end_time = e+500
				
				l.layer = 3
				
				local step = i / n
				shift = step
				
				fad=500
				max=math.ceil(fad/max_frame)
				if i>(n-math.ceil(fad/max_frame)) then
					alpha = utils.interpolate(u_out/max, "&H00&", "&HFF&")
					u_out=u_out+1
				else
					alpha="&H00&"
				end
				
				x=char.center+math.randomsteps(-9,9,2)
				y=char.middle+math.randomsteps(-9,9,1)
				
				l.text = string.format("{\\an5\\blur0.6\\bord0\\fscx100\\fscy100\\fad(0,250)\\alpha%s\\1c&HFFFFFF&\\pos(%.3f, %.3f)}%s"
				,alpha,x,y,char.text)
				
				io.write_line(l)
				
			end
			
		end
		
	end
	
end

for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end