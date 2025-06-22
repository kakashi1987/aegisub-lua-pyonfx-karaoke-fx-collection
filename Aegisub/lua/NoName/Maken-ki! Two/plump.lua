function cfx (line, l)

	for si,syl in ipairs(line.syls) do
	
		if syl.text~="" then
		
			l.layer=1
			
			l.start_time=line.start_time+50*syl.i+250
			l.end_time=line.end_time
			
			dur=l.end_time-l.start_time
			
			l.text = string.format("{\\an5\\blur1\\be1\\fscx180\\fscy100\\fry10\\fax-0.1\\fay-0.1\\t(0,%d,\\fax0\\fay0.1\\fscx200\\fscy120)\\t(%d,%d,\\fax-0.1\\fay-0.1\\fscx230\\fscy150)\\t(%d,%d,\\fax0.1\\fay0.1\\fscx240\\fscy180)\\t(%d,%d,\\fax-0.1\\fay-0.1\\fscx250\\fscy190)\\clip(m 736 0 l 688 140 672 156 667 705 1267 715 1272 0)\\move(%.3f, %.3f, %.3f, %.3f,0,500)}%s"
			,dur/4,dur/4,dur/2,dur/2,3*dur/4,3*dur/4,dur,syl.center+200, syl.middle-760 ,syl.center+200+15*syl.i,syl.middle-480-20*syl.i,syl.text)
			
			io.write_line(l)
		
		end
	
	end

end

for li, line in ipairs(lines) do
	
	cfx( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end