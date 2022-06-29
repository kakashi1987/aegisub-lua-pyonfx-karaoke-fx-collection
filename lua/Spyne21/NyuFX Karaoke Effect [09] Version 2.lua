-- Karaoke Effect by Spyne21 - Vsfilter

temp = {}
function set_temp(ref,val) 
	temp[ref] = val
	return val
end

function roumaji(line, l)
	--Infade text
	for si, syl in ipairs(line.syls) do
		l.start_time=line.start_time+50*syl.i-300
		l.end_time=line.start_time+syl.start_time
		l.text=string.format("{\\an5\\bord2\\shad0\\blur2\\1c&HFFFFFF&\\3c&H000000&\\fscx100\\fsxy100\\frz%d\\pos(%d,%d)\\t(0,300,\\frz0)\\fad(300,0)}%s"
		,math.random(-180,180),syl.center,syl.middle,syl.text)
		io.write_line(l)
	end
	--Sylables effect
	for si, syl in ipairs(line.syls) do
		l.layer=0
		l.start_time=line.start_time+syl.start_time
		l.end_time=line.start_time+syl.end_time
		l.text=string.format("{\\an5\\bord2\\shad0\\blur2\\1c&HFFFFFF&\\3c&H000000&\\fscx100\\fscy100\\pos(%d,%d)}%s"
		,syl.center,syl.middle,syl.text)
		io.write_line(l)
	end
	for si, syl in ipairs(line.syls) do
		for s, e, i, n in utils.frames(line.start_time+syl.start_time,line.start_time+syl.end_time, 41.71) do
			l.layer=1
			l.start_time = s
			l.end_time = e
			local x, y = syl.center + math.random(-2.5,2.5), syl.middle + math.random(-2.5,2.5)
			local fscx,fscy=120+math.random(-50,50),120+math.random(-50,50)
			l.text=string.format("{\\an5\\bord2\\shad0\\blur2\\1c&H000000&\\3c&HFFFFFF&\\fscx100\\fscy100\\pos(%.3f,%.3f)\\fscx%3f\\fscy%3f}%s"
			,x,y,fscx,fscy,syl.text)
			io.write_line(l)
		end
	end
	--Shape effect
	for si, syl in ipairs(line.syls) do
	local maxj=50,math.ceil(syl.duration/10*10) -- Number of loop
		for j=1,maxj do
			if syl.text ~="" then
				l.layer=0
				l.start_time=line.start_time+syl.start_time+(j/maxj)*math.floor(300)
				l.end_time=line.start_time+syl.end_time+1000+(j/maxj)*math.floor(300)
				l.text=string.format("{\\an5\\bord2\\shad0\\blur1.5\\1c&HFFFFFF&\\3c&HFFFFFF&\\fscx100\\fscy100\\move(%d,%d,%d,%d)\\fad(300,300)\\p1}%s"
				,set_temp("x",syl.center+math.random(-10,10)),set_temp("y",syl.middle+math.random(-10,10)),temp.x+math.random(-50,50),temp.y+math.random(-50,50),shape.ellipse(2.5, 2.5))
				io.write_line(l)
			end
		end
	end
	--Outfade text
	for si, syl in ipairs(line.syls) do
		l.start_time=line.start_time+syl.end_time
		l.end_time=line.end_time+50*syl.i-300
		l.dur=l.end_time-l.start_time
		l.text=string.format("{\\an5\\bord2\\shad0\\blur2\\1c&HFFFFFF&\\3c&H000000&\\fscx100\\fsxy100\\pos(%d,%d)\\t(%d,%d,\\frz%d)\\fad(0,300)}%s"
		,syl.center,syl.middle,l.dur-300,l.dur,math.random(-50,50),syl.text)
		io.write_line(l)
	end
end

for li, line in ipairs(lines) do
	roumaji( line, table.copy(line) )
	io.progressbar(li / #lines)
end