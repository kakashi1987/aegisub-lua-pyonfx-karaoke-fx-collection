-- Karaoke Effect by Spyne21 - Vsfilter

function roumaji(line, l)
	--Infade text
	for si,syl in ipairs(line.chars) do
		l.start_time=line.start_time-300
		l.end_time=line.start_time+syl.start_time
		l.text=string.format("{\\an5\\bord2\\shad0\\blur2\\1c&HA80B00&\\3c&HFFFFFF&\\fscx0\\fscy0\\move(%d,%d,%d,%d,0,300)\\t(0,300,\\fscx100\\fscy100)\\fad(150,0)}%s"
		,syl.center,syl.middle+math.random(25,50),syl.center,syl.middle,syl.text)
		io.write_line(l)
	end
	--Syllables effect
	for si,syl in ipairs(line.chars) do
		l.start_time=line.start_time+syl.start_time
		l.end_time=line.start_time+syl.end_time
		l.text=string.format("{\\an5\\bord2\\shad0\\blur2\\1c&HA80B00&\\3c&HFFFFFF&\\fscx100\\fscy100\\move(%d,%d,%d,%d)\\t(0,%d,\\1c&HFFFFFF&\\4c&HFFFFFF&\\fry360)\\t(%d,%d,\\1c&HA80B00&\\3c&HFFFFFF&)}%s"
		,syl.center,syl.middle+10,syl.center,syl.middle,syl.duration/2,syl.duration/2,syl.duration,syl.text)
		io.write_line(l)
	end
	--Shapes effect
	local maxj=10 -- Number of loop
	for j=1,maxj do
		for si,syl in ipairs(line.syls) do
			if syl.text~="" then
				shapes = {"m 10 0 l 10 17 b 8 15 6 15 4 16 b 2 17 0 19 0 24 b 0 30 10 30 12 21 l 12 7 b 14 8 16 9 18 13 b 18 7 14 4 10 0","m 10 4 l 10 18 b 7 13 -2 13 1 21 b 3 27 12 30 12 21 l 12 10 l 28 7 l 28 15 b 25 11 16 11 19 18 b 22 25 30 27 30 18 l 30 0","m 10 0 l 10 17 b 8 15 6 15 4 16 b 2 17 0 19 0 24 b 0 30 10 30 12 21 l 12 7 b 14 8 16 9 18 13 b 18 7 14 4 10 0"}
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				color=convert.rgb_to_ass(math.random(255), math.random(255), math.random(255))
				l.text=string.format("{\\an5\\bord0.5\\shad0\\blur1\\1c%s\\3c&HFFFFFF&\\fscx50\\fscy50\\move(%d,%d,%d,%d)\\fad(0,300)\\p1}%s"
				,color,syl.center,syl.middle,syl.center+math.random(-50,50),syl.middle+math.random(-50,50),shapes[math.random(3)])
				io.write_line(l)
			end
		end
	end
	--Outfade text
	for si, syl in ipairs(line.chars) do
		l.start_time=line.start_time+syl.end_time
		l.end_time=line.end_time+300
		l.dur=l.end_time-l.start_time
		l.text=string.format("{\\an5\\bord2\\shad0\\blur2\\1c&HA80B00&\\3c&HFFFFFF&\\fscx100\\fscy100\\move(%d,%d,%d,%d,%d,%d)\\t(%d,%d,\\fscx0\\fscy0)\\fad(0,150)}%s"
		,syl.center,syl.middle,syl.center,syl.middle-math.random(25,50),l.dur-300,l.dur,l.dur-300,l.dur,syl.text)
		io.write_line(l)
	end
end

for li, line in ipairs(lines) do
	roumaji( line, table.copy(line) )
	io.progressbar(li / #lines)
end