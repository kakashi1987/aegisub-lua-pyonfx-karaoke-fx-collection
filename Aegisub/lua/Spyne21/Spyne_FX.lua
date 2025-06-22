-- Karaoke Effect by Spyne21 - Vsfilter

function roumaji(line, l)
	--Infade text
	for si, syl in ipairs(line.syls) do
		if syl.text~="" then
			l.start_time=line.start_time-300+50*syl.i
			l.end_time=line.start_time+syl.start_time
			l.text=string.format("{\\an5\\bord2\\shad0\\blur2\\1c&HFFFFFF&\\3c&H1611C9&\\fscx100\\fscy100\\pos(%.3f,%.3f)\\fad(300,0)}%s"
			,syl.center,syl.middle,syl.text)
			io.write_line(l)
		end
	end
	local si=0
	for _, syl in ipairs(line.syls) do
		if syl.text~="" then
		maxj=50
		local height=syl.height+4
		for j=0,maxj do
			if syl.text~="" then
				if si%2==0 then
					x1=syl.right-j-1
					y1=syl.top+j
				else
					x1=syl.left+j+1
					y1=syl.top+j
				end
			l.start_time=line.start_time+syl.start_time+300*(j/maxj)-300
			l.end_time=line.start_time+syl.start_time+300*(j/maxj)
			l.text=string.format("{\\an5\\bord1\\shad0\\blur1\\1c&HFFFFFF&\\3c&H1611C9&\\fscx100\\fscy100\\pos(%.3f,%.3f))\\fad(50,50)\\p1}%s"
			,x1,y1,shape.ellipse(2, 2))
			l.layer=5
			io.write_line(l)
			end
		end
		si=si+1
		end
	end
	--Sylables effect
	local si=0
	for _, syl in ipairs(line.syls) do
		if syl.text~="" then
			local height=syl.height+4
			local maxj=syl.width+4
			for j=0,maxj do
				for i=0,1 do
					if i==0 then
						fad="fad(0,300)"
						y_rand=90
						if si%2==0 then
							x_rand=-90
							x1=syl.right-j-1
							y1=syl.top-j-height
							x2=syl.right-j
							y2=syl.top+j
						else
							x1=syl.left+j
							y1=syl.top-j-height
							x2=syl.left+j+1
							y2=syl.top+j
							x_rand=90

						end
					else
						fad=""
						x_rand=0
						y_rand=0
						if si%2==0 then
							x1=syl.right-j-1
							y1=syl.top+j
							x2=syl.right-j
							y2=syl.top+j+height
						else
							x1=syl.left+j
							y1=syl.top+j
							x2=syl.left+j+1
							y2=syl.top+j+height
						end
					end
					l.start_time=line.start_time+syl.start_time
					l.end_time=line.start_time+syl.end_time
					local clip_1 = "clip("..x1..","..y1..","..x2..","..y2..")"
					local clip_2 = "clip("..x1+x_rand..","..y1+y_rand..","..x2+x_rand..","..y2+y_rand..")"
					l.text = string.format("{\\an5\\bord2\\shad0\\blur2\\1c&HFFFFFF&\\3c&H1611C9&\\fscx100\\fscy100\\move(%.3f,%.3f,%.3f,%.3f)\\%s\\t(0,%d,\\%s)\\%s\\fad(0,300)}%s"
					,syl.center, line.middle,syl.center+x_rand, line.middle+y_rand,clip_1,syl.duration,clip_2,fad,syl.text)
					io.write_line(l)
				end
			end
			si=si+1
		end
	end
end

for li, line in ipairs(lines) do
	roumaji( line, table.copy(line) )
	io.progressbar(li / #lines)
end