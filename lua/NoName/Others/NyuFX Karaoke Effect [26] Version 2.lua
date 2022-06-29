-- Karaoke Effect by Spyne21 - Vsfilter

-- General notes :

-- %d : digits
-- %s : string
-- %f : float


-- Function roumaji
function roumaji(line, l)

	-- math.randomseed() function sets a seed for the pseudo-random generator : Equal seeds produce equal sequences of numbers.
	math.randomseed(8317)
	-- Code Shape
	local shape = "m 9 23 b 8 22 7 21 6 20 b 4 18 3 16 2 12 b 2 9 3 5 4 3 b 5 2 6 1 7 1 b 8 3 8 4 9 5 b 10 4 10 3 11 1 b 13 2 14 3 14 3 b 15 5 16 8 16 12 b 15 16 14 18 12 20 b 11 21 10 22 9 23","m 9 23 b 8 22 7 21 5 19 b 4 18 2 16 1 11 b 1 8 2 5 4 3 b 5 2 6 1 7 1 b 8 3 8 4 9 5 b 10 4 10 3 11 1 b 13 2 14 3 14 3 b 16 5 17 8 17 11 b 16 16 14 18 13 19 b 11 21 10 22 9 23"
	
	--Infade text
	-- Corresponding to "star2syl" of Aegisub
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
			-- Layer number
			l.layer=2
			
			-- Time of beginning and ending of "star2syl" syllables
			l.start_time=line.start_time+50*syl.i-line.infade/2
			l.end_time=line.start_time+syl.start_time
			
			-- Text line
			l.text=string.format("{\\an5\\bord2.5\\shad0\\blur2\\1c&H000000&\\3c&HF3E2F7&\\fscx100\\fscy100\\pos(%.3f,%.3f)\\fad(300,0)}%s"
			,syl.center,syl.middle,syl.text)
			
			-- Write line
			io.write_line(l)
		end
	end
	
	--Syllables effect
	-- Corresponding to "syl" of Aegisub
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
			-- Layer number
			l.layer=2
			
			-- Time of beginning and ending of "syl" syllables
			l.start_time=line.start_time+syl.start_time
			l.end_time=line.start_time+syl.end_time
			
			-- Text line
			l.text=string.format("{\\an5\\bord2.5\\shad0\\blur2\\1c&H000000&\\3c&HF3E2F7&\\fscx100\\fscy100\\pos(%.3f,%.3f)\\t(0,100,\\fscx130\\fscy130)\\t(100,%d,\\fscx100\\fscy100)}%s"
			,syl.center,syl.middle,syl.duration,syl.text)
			
			-- Write line
			io.write_line(l)
		end
	end
	
	-- Colors : change for color_vsfilter if you use vsfiltermod
	-- Used for the Shape 1 and Shape 2
	local color_vsfiltermod="1vc(&HFAF9F5&,&HFAF9F5&,&HF7E2F9&,&HF7E2F9&)"
	local color_vsfilter="1c&HF9E6F5&"
	
	--Shape effect 1
	-- Shape 1 is defined when you put "shape 1" in "actor" of Aegisub
	if line.actor=="shape 1" then
		for si,syl in ipairs(line.syls) do
			-- Layer number
			l.layer=0
			
			-- Loop of 10 shape, maxj is the maximum.
			local maxj=10
			for j=0, maxj do
			
				-- time t1,t2 for begenning and ending move tag
				local t1=0
				local t2=2000
				
				-- Defined an frx,fry,frz value by syllable
				local frx=math.random(-1000,1000)
				local fry=math.random(-1000,1000)
				local frz=math.random(-1000,1000)
				
				-- Time of beginning and ending of "shape 1" syllables
				l.start_time = line.start_time+syl.start_time+(syl.duration/maxj)*j
				l.end_time = line.start_time+syl.start_time+1000+(syl.duration/maxj)*j
				
				-- Text line
				l.text=string.format("{\\an5\\bord0.5\\shad0\\blur1\\fscx50\\fscy55\\%s\\3c&HF3E2F7&\\move(%d,%d,%d,%d,%d,%d)\\t(0.8,\\frx%d\\fry%d\\frz%d)\\fad(0,300)\\p1}%s"
				,color_vsfiltermod,syl.center+math.random(-100,50),line.top-math.random(50),syl.center+math.random(50,100),line.bottom+math.random(150),t1,t2,frx,fry,frz,shape)
				
				-- Write line
				io.write_line(l)
			end
		end
	end
	
	--Shape effect 2
	-- Shape 2 is defined when you put "shape 2" in "actor" of Aegisub
	if line.actor=="shape 2" then
		for si,syl in ipairs(line.syls) do
			-- Layer number
			l.layer=0
			
			-- Loop of 10 shape, maxj is the maximum.
			local maxj=10
			for j=0, maxj do
			
				-- Defined an frx,fry,frz value by syllable			
				local frx=math.random(-1000,1000)
				local fry=math.random(-1000,1000)
				local frz=math.random(-1000,1000)
				
				-- Time of beginning and ending of "shape 2" syllables
				l.start_time=line.start_time+50*syl.i-line.infade/2
				l.end_time=line.end_time+50*syl.i+line.outfade/2
				
				-- Text line
				l.text=string.format("{\\an5\\bord0.5\\shad0\\blur1\\fscx50\\fscy55\\%s\\3c&HF3E2F7&\\frx%d\\fry%d\\frz%d\\pos(%d,%d)\\fad(300,300)\\p1}%s"
				,color_vsfiltermod,frx,fry,frz,syl.center+math.random(-100,100),math.random(line.top-math.random(0,25),line.bottom+math.random(0,25)),shape)
				
				-- Write line
				io.write_line(l)
			end
		end
	end
	
	--Outfade text
	-- Corresponding to "syl2end" of Aegisub
	for si,syl in ipairs(line.syls) do
		if syl.text~="" then
			-- Layer number
			l.layer=1
			
			-- Time of beginning and ending of "syl2end" syllables
			l.start_time=line.start_time+syl.end_time
			l.end_time=line.end_time+50*syl.i+line.outfade/2
			
			-- Text line
			l.text=string.format("{\\an5\\bord2.5\\shad0\\blur2\\1c&H000000&\\3c&HF3E2F7&\\fscx100\\fscy100\\pos(%.3f,%.3f)\\fad(0,300)}%s"
			,syl.center,syl.middle,syl.text)
			
			-- Write line
			io.write_line(l)
		end
	end
end

-- Loop for generate each lines
for li, line in ipairs(lines) do
	-- Call roumaji function (effects)
	roumaji( line, table.copy(line) )
	-- Update progressbar during the whole process to know how long you've to wait
	io.progressbar(li / #lines)
end