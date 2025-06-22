

local sp = "m 0 -5 b -6 -5 -6 5 0 5 b 6 5 7 -5 0 -5 m 5 -1 l 31 0 l 5 1 m -4 -1 l -30 0 l -4 1 m -1 -5 l 0 -28 l 1 -5 m -1 5 l 0 28 l 1 5 l 1 5 "
local sap = "m 30 23 b 24 23 24 33 30 33 b 36 33 37 23 30 23 m 35 27 l 61 28 l 35 29 m 26 27 l 0 28 l 26 29 m 29 23 l 30 0 l 31 23 m 29 33 l 30 56 l 31 33 l 31 33 "
local pix = "m 0 0 l 1 0 l 1 1 l 0 1 "

function rom1(line, l)
	
	sk1 = "m 5 25 l 10 34 l 0 38 b 6 47 16 54 24 54 b 18 60 12 69 14 79 l 25 77 l 27 87 b 37 84 46 78 50 70 b 53 78 61 85 73 87 l 75 77 l 85 78 b 87 68 83 59 78 52 b 87 51 96 46 100 38 l 90 33 l 95 24 b 86 21 74 21 66 25 b 68 15 65 7 58 0 l 50 7 l 42 0 b 34 7 32 15 34 26 b 26 21 13 21 5 25 m 13 28 b 20 24 29 26 37 29 b 35 21 38 13 43 8 l 50 14 l 57 8 b 62 13 65 21 63 28 b 71 26 79 24 87 28 l 83 35 l 91 39 b 88 45 81 49 72 51 b 78 56 80 63 79 72 l 70 71 l 69 79 b 60 79 54 73 50 65 b 46 71 39 77 31 79 l 30 71 l 20 72 b 20 66 22 58 29 52 b 19 50 13 46 9 40 l 17 36 l 13 28 m 49 44 l 30 51 l 49 46 l 50 63 l 51 46 l 71 50 l 51 44 l 62 29 l 50 42 l 38 30 l 49 44 m 43 44 b 43 53 56 53 56 44 b 56 35 43 35 43 44 m 47 31 b 47 35 53 35 53 31 b 53 27 47 27 47 31 m 60 39 b 60 43 66 43 66 39 b 66 35 60 35 60 39 m 33 40 b 33 44 39 44 39 40 b 39 36 33 36 33 40 m 39 54 b 39 58 45 58 45 54 b 45 50 39 50 39 54 m 55 54 b 55 58 61 58 61 54 b 61 50 55 50 55 54"
	sk = "m 62 50 b 70 65 93 65 100 50 b 92 35 70 35 62 50 m 58 42 b 75 46 91 30 85 15 b 69 10 54 25 58 42 m 50 38 b 65 30 65 7 50 0 b 35 8 35 30 50 38 m 42 42 b 46 25 30 9 15 15 b 10 31 25 46 42 42 m 38 50 b 30 35 7 35 0 50 b 8 65 30 65 38 50 m 42 58 b 25 54 9 70 15 85 b 31 90 46 75 42 58 m 50 62 b 35 70 35 93 50 100 b 65 92 65 70 50 62 m 58 58 b 54 75 70 91 85 85 b 90 69 75 54 58 58 "
	for si, syl in ipairs(line.syls) do
		
		if syl.text == "" or syl.text == " " then l.text = "{Hello World XD}" else
			if line.style == "Romaji" then
				x = syl.x
				y = line.middle+2
			elseif line.style == "Kanji" then
				x = syl.x
				y = line.middle+ 49
			end
			dr = 40*(syl.duration/8)
			l.start_time = line.start_time + syl.start_time
			l.end_time = line.start_time + syl.start_time + syl.duration
			l.layer = 0
			l.text = string.format("{\\an5\\1c&HE3E2FC&\\fad(50,50)\\3c&HA4A3F0&\\t(\\frz"..dr..")\\bord2\\blur2\\fscy35\\fscx35\\shad0\\t(0,"..dr/(2)..",\\fscx110\\fscy100)\\t("..dr/(2)..","..dr..",\\fscx50\\fscy50)\\pos(%.3f,%.3f)\\p1}", x,y ) .. sk
			io.write_line(l)
			
		end
		
	end
	
	for ci, char in ipairs(line.chars) do
		if line.style == "Romaji" then
			x= char.left
			y = line.top
		elseif line.style == "Kanji" then
			x= char.left
			y = line.top +47
		end
		if char.text == "" or char.text == " "  or char.text == "　" then l.text = "{Hello World XD}" else
			dr = char.duration
			l.start_time = line.start_time + char.start_time
			l.end_time = line.start_time + char.start_time + char.duration
			l.layer = 2
			l.text = string.format("{\\an7\\bord2\\blur2\\shad0\\t(0,"..dr/(2)..",\\bord5\\blur7)\\t("..dr/(2)..","..dr..",\\bord2\\blur2)\\1c&H000000&\\3c&HB28FEE&\\pos(%.3f,%.3f)}", x,y ) .. char.text
			io.write_line(l)
			fd = 0
			l.start_time = line.start_time - line.infade/2
			l.end_time = line.end_time +fd --+ line.outfade/2
			l.layer = 2
			l.text = string.format("{\\an7\\fad("..line.infade/(2)..",0)\\bord2.5\\be2.5\\shad0\\1c&H000000&\\3c&H000000&\\pos(%.3f,%.3f)}",x,y ) .. char.text
			io.write_line(l)
			
			l.start_time = line.start_time - line.infade/2
			l.end_time = line.end_time + fd --+ line.outfade/2
			l.layer = 2
			l.text = string.format("{\\an7\\fad("..line.infade/(2)..",0)\\bord1.5\\be1.5\\shad0\\1c&H000000&\\3c&Hffffff&\\pos(%.3f,%.3f)}", x,y) .. char.text
			io.write_line(l)
			
			rr2 = math.random(-360,360)*2
			m = math.random(550,800)
			tfx2 = "\\t(50,"..m..",\\fscx70\\fscy70\\fry"..rr2.."\\frx"..rr2..")"
			
			if line.style == "Romaji" then
				x= char.center
				y = line.middle
			elseif line.style == "Kanji" then
				x= char.center
				y = line.middle + 47
			end
			
			x1, y1 = x+math.random(50,90), y+math.random(90,160)
			
			l.start_time = line.end_time + fd
			l.end_time = line.end_time + m + fd
			l.layer = 2
			l.text = string.format("{\\an5\\fad(0,"..math.random(70,130)..")\\bord2.5\\be2.5\\shad0\\1c&H000000&\\3c&H000000&\\t(\\bord2\\be2)"..tfx2.."\\move(%.3f,%.3f,%.3f,%.3f)}", x,y,x1,y1) .. char.text
			io.write_line(l)
			
			l.start_time = line.end_time + fd
			l.end_time = line.end_time + m + fd
			l.layer = 2
			l.text = string.format("{\\an5\\fad(0,"..math.random(70,130)..")\\bord1.5\\be1.5\\shad0\\1c&H000000&\\3c&Hffffff&"..tfx2.."\\t(\\bord1\\be1)\\move(%.3f,%.3f,%.3f,%.3f)}", x,y,x1,y1) .. char.text
			io.write_line(l)
			
			local text_p = convert.text_to_pixels(char.text, line.styleref)
			lops = char.height/3.4
			
			for i = 1, lops do
				
				local poss = math.random(1,#text_p)
				if line.style == "Romaji" then
					x = math.round(char.left) + text_p[poss].x
					y = math.round(char.top) + text_p[poss].y
				elseif line.style == "Kanji" then
					x = math.round(char.left) + text_p[poss].x
					y = math.round(char.top) + text_p[poss].y + 47
				end
				local rand = math.random(-360,360)
				
				sp = " m 0 0 b -2 -3 -3 -5 -4 -5 b 13 -4 12 3 13 13 b 13 13 13 13 13 13 b 13 13 13 13 13 13 b 9 7 -6 9 -4 -2 b -4 -2 -2 1 0 0 "
				
				local lops_t = utils.interpolate(i/lops, 50 , char.duration+200 )
				rc = {"&HE3E2FC&","&HA4A3F0&"}
				rcc = rc[math.random(1,2)]
				c1 = "\\1c"..rcc..""
				sz = math.random(20,35)
				sz2 = math.random(45,75)
				rr = math.random(100,360)
				rr2 = math.random(-360,360)
				tfx = "\\fscx"..sz.."\\fscy"..sz.."\\fry"..rr.."\\frz"..rr.."\\frx"..rr..""
				tfx2 = "\\t(\\fscx"..sz2.."\\fscy"..sz2.."\\fry"..rr2.."\\frz"..rr2.."\\frx"..rr2..")"
				
				l.start_time = line.start_time - line.infade/2
				l.end_time = line.start_time + char.start_time+ lops_t
				l.text =string.format("{\\an5\\fad"..line.infade/(2)..",0)\\pos(%d,%d)"..tfx..""..c1.."\\3c&HA4A3F0&\\fscx35\\fscy35\\shad0\\blur2\\3a&H80&\\bord1\\p1}",
				x,y) ..sp
				l.layer = 4
				io.write_line(l)
				
				l.start_time = line.start_time + char.start_time + lops_t
				l.end_time = l.start_time + math.random(400,550)
				l.d = l.end_time - l.start_time
				lops_time = utils.interpolate(i/lops, 0 , l.d )
				local ran = math.random(70,100)
				l.text =string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,"..math.random(80,150)..")\\fscx35\\fscy35"..tfx..""..tfx2..""..c1.."\\3c&HA4A3F0&\\shad0\\blur2\\3a&H80&\\bord1\\p1}",
				x,y, x+ran,y+ran) ..sp
				l.layer = 4
				io.write_line(l)
			end
			
		end
	end
end

for li, line in ipairs(lines) do
	if not line.comment then
		
		rom1( line, table.copy(line) )
		
	end
	io.progressbar(li / #lines)
end

