--Kara no Kyoukai 2 ED
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	
	if line.infade>=1000 then
		line.infade=1000
	end
	
	if line.outfade>=1000 then
		line.outfade=1000
	end
	
	for si, syl in ipairs(line.syls) do
		if syl.text~="" then
			
			local l = table.copy(line)
			
			for pi, pixel in ipairs(convert.text_to_pixels(syl.text, line.styleref)) do
				
				l.layer=1
				
				l.start_time=line.start_time+100*syl.i-line.infade-600
				l.end_time=line.start_time+syl.start_time
				
				inf_st=math.randomsteps(50, 500, 50)
				inf_ed=math.randomsteps(50, 750, 50)
				
				x = syl.center
				y = syl.middle
				
				px = syl.left + pixel.x
				py = syl.top + pixel.y
				
				rad1=line.height*1.5
				rad2=line.height*2
				
				ang = math.randomsteps(1, 360, 1)
				local ex,ey = math.ellipse(syl.center,syl.middle,rad1,rad2,ang)
				
				x1=px-x
				y1=py-y
				
				x2=ex-x1
				y2=ey-y1
				
				mov=math.atan2(x2,y2)
				
				if line.style=="ed_romanji_L" or line.style=="ed_kanji_L" then
					dir=-1
				else
					dir=1
				end
				
				xmove=x+(dir*mov)
				ymove=y+mov
				
				l.text=string.format("{\\an7\\bord0\\blur0\\shad0\\fscx100\\fscy100\\1c&HFAFAFA&\\fad(%d,0)\\move(%.3f,%.3f,%.3f,%.3f,%d,%d)\\p1}m 0 0 l 1 0 1 1 0 1"
				,inf_ed,xmove,ymove,px,py,inf_st,inf_ed)
				
				io.write_line(l)
			end
			
		end
		
		if syl.text~="" then
			
			l.layer=2
			
			l.start_time=line.start_time+100*syl.i-line.infade-500
			l.end_time=line.start_time+syl.start_time+750
			
			l.text=string.format("{\\an5\\bord1\\blur2\\shad0\\fscx99\\fscy99\\1a&HFF&\\1c&HFAFAFA&\\3c&HFAFAFA&\\fad(750,750)\\pos(%.3f,%.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
			
		end
		
		if syl.text~="" then
			
			local l = table.copy(line)
			
			for pi, pixel in ipairs(convert.text_to_pixels(syl.text, line.styleref)) do
				
				l.layer=1
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time+1000
				
				dur=l.end_time-l.start_time
				randfad=math.randomsteps(50, dur, 50)
				
				x = syl.center
				y = syl.middle
				
				px = syl.left + pixel.x
				py = syl.top + pixel.y
				
				rad1=line.height*1.5
				rad2=line.height*2
				
				ang = math.randomsteps(1, 360, 1)
				local ex,ey = math.ellipse(syl.center,syl.middle,rad1,rad2,ang)
				
				x1=px-x
				y1=py-y
				
				x2=ex-x1
				y2=ey-y1
				
				
				z=0
				mov=math.deg(math.atan2(x2,y2)+z)
				z=z+1
				
				if line.style=="ed_romanji_L" or line.style=="ed_kanji_L" then
					dir=-1
				else
					dir=1
				end
				
				xmove=x+(dir*mov)
				ymove=y+mov
				
				l.text=string.format("{\\an7\\bord0\\blur0\\shad0\\fscx100\\fscy100\\1c&HFAFAFA&\\fad(0,%d)\\move(%.3f,%.3f,%.3f,%.3f,%d,%d)\\p1}m 0 0 l 1 0 1 1 0 1"
				,randfad,px,py,xmove,ymove,randfad,dur)
				
				io.write_line(l)
			end
			
		end
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end