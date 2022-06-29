-- Karaoke Effect by Spyne21 - Vsfilter

function romaji(line, l)
	for si, syl in ipairs(line.syls) do
		if line.i%2==1 then
			move_infade=syl.center
			move_outfade=syl.center
			move_syl_infade=syl.middle-10
			move_syl_outfade=syl.middle+10
		else
			move_infade=syl.center+100
			move_outfade=syl.center-100
			move_syl_infade=syl.center+10
			move_syl_outfade=syl.center-10
		end
		if syl.text~="" then
			l.start_time = line.start_time-300
			l.end_time = line.start_time
			l.text = string.format("{\\an5\\bord1\\shad0\\blur2\\1c&H000000&\\3c&HFFFFFF&\\fscx100\\fscy100\\move(%.3f,%.3f,%.3f,%.3f,0,300)\\fad(600,0)}%s"
			,move_infade,syl.middle,move_syl_infade,syl.middle,syl.text)
			l.layer=1
			io.write_line(l)
			l.start_time = line.start_time
			l.end_time = line.end_time
			l.text = string.format("{\\an5\\bord1\\shad0\\blur2\\1c&H000000&\\3c&HFFFFFF&\\fscx100\\fscy100\\move(%.3f,%.3f,%.3f,%.3f)\\t(%d,%d,\\1c&HFFFFFF&\\fscx120\\fscy120)\\t(%d,%d,\\1c&H000000&\\fscx100\\fscy100)}%s"
			,move_syl_infade,syl.middle,move_syl_outfade,syl.middle,syl.start_time,syl.start_time+syl.duration/2,syl.start_time+syl.duration/2,syl.start_time+syl.duration,syl.text)
			l.layer=2
			io.write_line(l)
			l.start_time = line.end_time
			l.end_time = line.end_time+300
			l.dur=l.end_time-l.start_time
			l.text = string.format("{\\an5\\bord1\\shad0\\blur2\\1c&H000000&\\3c&HFFFFFF&\\fscx100\\fscy100\\move(%.3f,%.3f,%.3f,%.3f,0,300)\\fad(0,600)}%s"
			,move_syl_outfade,syl.middle,move_outfade,syl.middle,syl.text)
			l.layer=0
			io.write_line(l)
		end
	end
end

for li, line in ipairs(lines) do
	romaji( line, table.copy(line) )
	io.progressbar(li / #lines)
end