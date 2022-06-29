--Fate/kaleid liner PRISMA ILLYA ED
--Karaoke by Amberdrake
--VSfilter

function kara (line, l)
	for ci,char in ipairs(line.chars) do
		
		if line.infade>150 then
			line.infade=50
		end
		
		l.layer = 1
		
		l.start_time = line.start_time-line.infade
		l.end_time = line.start_time+char.start_time
		
		if char.i%2==1 then
			amp=1
		else
			amp=-1
		end
		
		l.text = string.format("{\\an5\\bord0.9\\shad3\\blur0.6\\fscx100\\fscy100\\1vc(&H00BF5ADA&,&H00BF5ADA&,&HEEC1F4&,&HEEC1F4&)\\fad(250,0)\\move(%.3f,%.3f,%.3f,%.3f,0,250)}%s"
		,char.center, char.middle+(amp*10), char.center, char.middle, char.text)
		
		io.write_line(l)
		
	end
	
	for ci,char in ipairs(line.chars) do
		if char.text~="" then
			
			local getshape = convert.text_to_shape(char.text, line.styleref)
			
			for s, e, i, n in utils.frames(line.start_time+char.start_time, line.start_time+char.end_time, 25) do
				
				l.start_time = s
				l.end_time = e
				
				l.layer = 2
				
				local frame_pct = i / n
				local deform = shape.filter(getshape,
				function(x,y)
					local xdef = math.sin(y/(line.width/4)+frame_pct*50)*15
					local ydef = math.sin(x/(line.height/4)+frame_pct*50)*15
					return x+xdef, y+ydef
				end)
				
				rotation=math.random(-10,10)
				local scale=math.random(100, 120)
				
				if line.style=="ed-romanji" then
					compensate=-22
				end
				if line.style=="ed-kanji" then
					compensate=-17
				end
				
				l.text = string.format("{\\an8\\bord0.9\\shad3\\blur0.6\\fscx%d\\fscy%d\\frz%d\\jitter(2,2,2,2)\\1vc(&H00BF5ADA&,&H00BF5ADA&,&HEEC1F4&,&HEEC1F4&)\\pos(%.3f, %.3f)\\p4}%s"
				,scale,scale,rotation,char.center,char.middle+compensate,deform)
				
				io.write_line(l)
				
			end
			
		end
		
	end
	
	for ci,char in ipairs(line.chars) do
		
		if line.outfade>150 then
			line.outfade=50
		end
		
		l.layer = 1
		
		l.start_time = line.start_time+char.end_time
		l.end_time = line.end_time+line.outfade
		
		if char.i%2==1 then
			amp=-1
		else
			amp=1
		end
		
		outfade_start=(line.end_time+line.outfade)-(line.start_time+char.end_time)-250
		outfade_end=(line.end_time+line.outfade)-(line.start_time+char.end_time)
			
		
		l.text = string.format("{\\an5\\bord0.9\\shad3\\blur0.6\\fscx100\\fscy100\\1vc(&H00BF5ADA&,&H00BF5ADA&,&HEEC1F4&,&HEEC1F4&)\\fad(0,250)\\move(%.3f,%.3f,%.3f,%.3f,%d,%d)}%s"
		,char.center, char.middle ,char.center, char.middle+(amp*10), outfade_start, outfade_end, char.text)
		
		io.write_line(l)
		
	end
	
end

for li, line in ipairs(lines) do
	kara(line, table.copy(line) )
	io.progressbar(li / #lines)
end