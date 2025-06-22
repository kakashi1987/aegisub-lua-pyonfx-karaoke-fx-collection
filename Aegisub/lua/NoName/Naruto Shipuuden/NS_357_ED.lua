--Naruto Shipuuden 357+ ED
--Karaoke by Amberdrake
--VSFilter

function kara(line, l)
	if line.infade>500 then
		line.infade=500
	end
	
	if line.outfade>500 then
		line.outfade=500
	end
	
	if line.style == "Romaji" then
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" then
				--infade white
				l.layer=3
				
				l.start_time=line.start_time-line.infade+25*char.i
				l.end_time=line.start_time+char.start_time
				
				l.text=string.format("{\\an5\\blur0.4\\fscx100\\fscy100\\1c&HF5FBF9&\\fad(250,0)\\move(%.3f,%.3f,%.3f,%.3f,0,500)}%s"
				,char.center,char.middle-35,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			if char.text~="" then
				--infade bord
				l.layer=2
				
				l.start_time=line.start_time-line.infade+25*char.i
				l.end_time=line.start_time+char.start_time
				
				l.text=string.format("{\\an5\bord0.2\\blur0.4\\fscx100\\fscy100\\1a&HFF&\\3c&H00&\\fad(250,0)\\move(%.3f,%.3f,%.3f,%.3f,0,500)}%s"
				,char.center,char.middle-35,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--infade blue
				l.layer=1
				
				l.start_time=line.start_time-line.infade+25*char.i
				l.end_time=line.start_time+char.start_time
				
				l.text=string.format("{\\an5\\blur1\\fscx100\\fscy100\\1c&HC3250D&\\fad(250,0)\\move(%.3f,%.3f,%.3f,%.3f,0,500)}%s"
				,char.center+3,char.middle-32,char.center+3,char.middle+3,char.text)
				
				io.write_line(l)
			end
		end
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				--syl effect white
				
				max_frame=25
				u_in=0
				u_out=0
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					l.layer = 3
					
					local step = i / n
					
					shift=math.sin(math.rad(utils.interpolate(step,0,180)))
					
					l.text = string.format("{\\an5\\blur0.4\\fscx100\\fscy100\\1c&HF5FBF9&\\pos(%.3f, %.3f)}%s"
					,syl.center-5*shift,syl.middle-5*shift,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--syl effect white bord
				
				max_frame=25
				u_in=0
				u_out=0
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					l.layer = 2
					
					local step = i / n
					
					shift=math.sin(math.rad(utils.interpolate(step,0,180)))
					
					l.text = string.format("{\\an5\bord0.2\\blur0.4\\fscx100\\fscy100\\1a&HFF&\\3c&H000000&\\pos(%.3f, %.3f)}%s"
					,syl.center-5*shift,syl.middle-5*shift,syl.text)
					
					io.write_line(l)
				end
			end
			
			if syl.text~="" then
				--syl effect blue
				
				max_frame=25
				u_in=0
				u_out=0
				
				for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
					
					l.start_time = s
					l.end_time = e
					
					l.layer = 1
					
					local step = i / n
					
					shift=math.sin(math.rad(utils.interpolate(step,0,180)))
					
					l.text = string.format("{\\an5\\blur1\\fscx100\\fscy100\\1c&HC3250D&\\pos(%.3f, %.3f)}%s"
					,syl.center+5*shift,syl.middle+5*shift,syl.text)
					
					io.write_line(l)
				end
			end
		end
		
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" then
				--outfade white
				l.layer=3
				
				l.start_time=line.start_time+char.end_time
				l.end_time=line.end_time+line.outfade+25*char.i
				
				of_start=l.end_time-l.start_time-500
				of_end=l.end_time-l.start_time
				
				l.text=string.format("{\\an5\\blur0.4\\fscx100\\fscy100\\1c&HF5FBF9&\\fad(0,250)\\move(%.3f,%.3f,%.3f,%.3f,%d,%d)}%s"
				,char.center,char.middle,char.center,char.middle+35,of_start,of_end,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--outfade white bord
				l.layer=2
				
				l.start_time=line.start_time+char.end_time
				l.end_time=line.end_time+line.outfade+25*char.i
				
				of_start=l.end_time-l.start_time-500
				of_end=l.end_time-l.start_time
				
				l.text=string.format("{\\an5\\bord0.2\\blur0.4\\fscx100\\fscy100\\1a&HFF&\\3c&H000000&\\fad(0,250)\\move(%.3f,%.3f,%.3f,%.3f,%d,%d)}%s"
				,char.center,char.middle,char.center,char.middle+35,of_start,of_end,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--outfade blue
				l.layer=1
				
				l.start_time=line.start_time+char.end_time
				l.end_time=line.end_time+line.outfade+25*char.i
				
				of_start=l.end_time-l.start_time-500
				of_end=l.end_time-l.start_time
				
				l.text=string.format("{\\an5\\blur1\\fscx100\\fscy100\\1c&HC3250D&\\fad(0,250)\\move(%.3f,%.3f,%.3f,%.3f,%d,%d)}%s"
				,char.center+3,char.middle+3,char.center+3,char.middle+38,of_start,of_end,char.text)
				
				io.write_line(l)
			end
		end
	end
	
	if line.style == "Romaji_left" or line.style == "Romaji_right" then
		--alt
		
		for ci,char in ipairs(line.chars) do
			
			if line.style == "Romaji_left" then
				shift = -50
				line.infade = 150
				line.outfade = 150
			end
			if line.style == "Romaji_right" then
				shift = 50
				line.outfade = 150
				line.outfade = 150
			end
			
			if char.text~="" then
				--infade white alt
				l.layer=3
				
				l.start_time=line.start_time-line.infade
				l.end_time=line.start_time+char.start_time
				
				l.text=string.format("{\\an5\\blur0.4\\fscx100\\fscy100\\1c&HF5FBF9&\\fad(250,0)\\move(%.3f,%.3f,%.3f,%.3f,0,150)}%s"
				,char.center+shift,char.middle,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--infade bord alt
				l.layer=2
				
				l.start_time=line.start_time-line.infade
				l.end_time=line.start_time+char.start_time
				
				l.text=string.format("{\\an5\\bord0.2\\blur0.4\\fscx100\\fscy100\\1a&HFF&\\3c&H00&\\fad(250,0)\\move(%.3f,%.3f,%.3f,%.3f,0,150)}%s"
				,char.center+shift,char.middle,char.center,char.middle,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--infade blue alt
				l.layer=1
				
				l.start_time=line.start_time-line.infade
				l.end_time=line.start_time+char.start_time
				
				l.text=string.format("{\\an5\\blur1\\fscx100\\fscy100\\1c&HC3250D&\\fad(250,0)\\move(%.3f,%.3f,%.3f,%.3f,0,150)}%s"
				,char.center+shift+3,char.middle+3,char.center+3,char.middle+3,char.text)
				
				io.write_line(l)
			end
		end
		
		for si,syl in ipairs(line.syls) do
			
			if syl.text~="" then
				-- white alt effect
				l.layer=3
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\blur1\\fscx130\\fscy130\\t(0,%d,\\fscx100\\fscy100)\\1c&HF5FBF9&\\pos(%.3f,%.3f)}%s"
				,syl.duration,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				-- white alt bord effect
				l.layer=2
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\blur1\\bord0.2\\fscx130\\fscy130\\t(0,%d,\\fscx100\\fscy100)\\1a&HFF&\\3c&H000000&\\pos(%.3f,%.3f)}%s"
				,syl.duration,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
			if syl.text~="" then
				-- blue alt effect
				l.layer=1
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\blur1\\fscx130\\fscy130\\t(0,%d,\\fscx100\\fscy100)\\1c&HC3250D&\\pos(%.3f,%.3f)}%s"
				,syl.duration,syl.center+3,syl.middle+3,syl.text)
				
				io.write_line(l)
			end
		end
		
		for ci,char in ipairs(line.chars) do
			
			if char.text~="" then
				--outfade white alt
				l.layer=3
				
				l.start_time=line.start_time+char.end_time
				l.end_time=line.end_time+line.outfade
				
				of_start=l.end_time-l.start_time-150
				of_end=l.end_time-l.start_time
				
				l.text=string.format("{\\an5\\blur0.4\\fscx100\\fscy100\\1c&HF5FBF9&\\fad(0,250)\\move(%.3f,%.3f,%.3f,%.3f,%d,%d)}%s"
				,char.center,char.middle,char.center+shift,char.middle,of_start,of_end,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--outfade white bord alt
				l.layer=2
				
				l.start_time=line.start_time+char.end_time
				l.end_time=line.end_time+line.outfade
				
				of_start=l.end_time-l.start_time-150
				of_end=l.end_time-l.start_time
				
				l.text=string.format("{\\an5\\bord0.2\\blur0.4\\fscx100\\fscy100\\1a&HFF&\\3c&H000000&\\fad(0,250)\\move(%.3f,%.3f,%.3f,%.3f,%d,%d)}%s"
				,char.center,char.middle,char.center+shift,char.middle,of_start,of_end,char.text)
				
				io.write_line(l)
			end
			
			if char.text~="" then
				--outfade blue alt
				l.layer=1
				
				l.start_time=line.start_time+char.end_time
				l.end_time=line.end_time+line.outfade
				
				of_start=l.end_time-l.start_time-150
				of_end=l.end_time-l.start_time
				
				l.text=string.format("{\\an5\\blur1\\fscx100\\fscy100\\1c&HC3250D&\\fad(0,250)\\move(%.3f,%.3f,%.3f,%.3f,%d,%d)}%s"
				,char.center+3,char.middle+3,char.center+shift+3,char.middle+3,of_start,of_end,char.text)
				
				io.write_line(l)
			end
		end
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end
