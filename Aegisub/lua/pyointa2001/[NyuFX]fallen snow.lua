l = lines[1]
preline_end_time = l.start_time-100
function romaji(line,l)
	l.comment = false
	l.effect = "fx"
	local interline_duration = line.start_time - preline_end_time
	if interline_duration < 0 then interline_duration = 0 end
	for ci, char in ipairs(line.chars) do 
		if char.text ~= "" then 
			local x = {}
			local y = {}
			local a = {}
			local top = {}
			local snow_x = {}
			local snow_y = {}
			local snow_a = {}
			l.text = string.format("{\\an7\\pos(%d,%d)\\fad(300,300)}%s",char.left,char.top,char.text)
			l.start_time = line.start_time
			l.end_time = line.end_time
			io.write_line(l)
			local i = 1
			for pi, pixel in ipairs( convert.text_to_pixels(char.text, line.styleref) ) do
				x[pi],y[pi],a[pi] = pixel.x, pixel.y,pixel.a
				if top[x[pi]] == nil then top[x[pi]] = y[pi] end
				if pixel.y < top[x[pi]] then top[x[pi]] = pixel.y end
				if y[pi] <= top[x[pi]] + line.styleref.fontsize * 0.02 then
					snow_x[i],snow_y[i],snow_a[i] = x[pi],y[pi],a[pi]
					i = i + 1
				end
			end
			for j = 1, #snow_x do
				local alpha = (snow_a[j] == 255 and "") or ("\\1a" .. convert.a_to_ass(snow_a[j]))
				local size1 = math.random(300,400)
				local size2 = math.random(4,30)
				local line_duration = line.end_time - line.start_time + interline_duration
				local random = math.random(1,3)
				if random == 1 or random == 2 then
					l.start_time = line.start_time - 3000 + j * (line_duration / #snow_x)
					l.end_time = line.end_time
					l.text = string.format("{\\an7\\bord0\\shad0\\blur1\\fad(1000,300)\\move(%d,%d,%d,%d,%d,%d)\\fscx%d\\fscy%d\\1c&HFFFFFF&%s\\p1}m 0 0 l 1 0 l 1 1 l 0 1",math.random(50,100)+snow_x[j]+char.left,snow_y[j]+line.top-math.random(100,150),snow_x[j]+char.left+math.random(-1,1),snow_y[j]+line.top-5,0,3000,size1,size1,alpha)
					io.write_line(l)
				else 
					l.start_time = line.start_time - 3000 + j * (line_duration / #snow_x)
					l.end_time = l.start_time + 3000
					l.text = string.format("{\\an%d\\bord0\\shad0\\blur2\\fad(1000,1000)\\move(%d,%d,%d,%d)\\fscx%d\\fscy%d\\t(\\frz%d)\\1c&HFFFFFF&%s\\p1}m 19 4 b 23 8 23 15 19 19 b 15 23 8 23 4 19 b 0 15 0 8 4 4 b 8 0 15 0 19 4",math.random(1,9),math.random(50,100)+snow_x[j]+char.left,snow_y[j]+line.top-math.random(66,100),snow_x[j]+char.left+math.random(-10,10),line.bottom+10,size2,size2,math.random(720),alpha)
					io.write_line(l)
				end
				
			end
		end
	end
	preline_end_time = line.end_time
end

for li, line in ipairs(lines) do
	if line.style == "romaji" then
		romaji( line, table.copy(line) )
	end
	io.progressbar(li / #lines)
end

