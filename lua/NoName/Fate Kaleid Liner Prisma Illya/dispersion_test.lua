function romanji(line, l)
	
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
			
			l.layer=1
			
			l.start_time=line.start_time+50*syl.i-line.infade
			l.end_time=line.start_time+syl.start_time
			
			l.text=string.format("{\\an5\\blur0.4\\1c&HF0A7ED&\\fad(100,0)\\pos(%.3f,%.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
			
		end
		
	end
	
	for si, syl in pairs(line.syls) do
		
		local l = table.copy(line)
		
		for pi, pixel in ipairs( convert.text_to_pixels(syl.text, line.styleref) ) do
			
			x = syl.left + pixel.x
			y = syl.top + pixel.y
			
			
			random={-50,-45,-40,-35,-30,-25,-15,-10-5,0,5,10,15,20,25,30,35,40,45,50}
			random=random[math.random(1,table.getn(random))]
			
			random2={50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200}
			random2=random2[math.random(1,table.getn(random2))]
			
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.start_time+syl.end_time
			l.text = string.format("{\\an5\\bord0\\1c&00742FB5&\\3c&HBFA6F3&\\fscx100\\fscy100\\t(\\bord1\\blur2)\\fad(0,%d)\\move(%.3f,%.3f,%.3f,%.3f)\\p1}m 0 0 l 1 0 1 1 0 1"
			,random2,x,y,x+random,y+random)
			l.layer=1
			io.write_line(l)
		end
		
	end
	
end

for li, line in ipairs(lines) do
	
	romanji( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end