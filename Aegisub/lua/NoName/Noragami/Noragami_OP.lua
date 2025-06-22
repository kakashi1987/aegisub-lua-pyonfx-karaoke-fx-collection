function kara(line, l)
	--Noragami Opening
	--Karaoke by Amberdrake
	
	for si,syl in ipairs(line.syls) do
		
		if line.style == "OP_Kanji" then
			--fadein kanji
			if syl.text~="" then
				--left color 2
				
				l.layer=5
				
				l.start_time=line.start_time
				l.end_time=line.start_time+500
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H52FFF3&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\pos(%.3f,%.3f)}%s"
				,syl.center-6,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--left color 1
				
				l.layer=4
				
				l.start_time=line.start_time
				l.end_time=line.start_time+500
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H79FF9E&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\pos(%.3f,%.3f)}%s"
				,syl.center-2,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--original color
				
				l.layer=1
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H16009B&\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--border fadein
				
				l.layer=1
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord2\\blur3\\1c&H16009B&\\3c&HD2D2D6&\\1a&HFF&\\fad(500,0)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--right color
				
				l.layer=3
				
				l.start_time=line.start_time
				l.end_time=line.start_time+500
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&HEB01DF&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\pos(%.3f,%.3f)}%s"
				,syl.center+2,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--right color 2
				
				l.layer=2
				
				l.start_time=line.start_time
				l.end_time=line.start_time+550
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&HF2FF57&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\pos(%.3f,%.3f)}%s"
				,syl.center+6,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
		
		if line.style == "OP_Romanji" then
			--fadein romanji
			if syl.text~="" then
				--left color 2
				
				l.layer=5
				
				l.start_time=line.start_time
				l.end_time=line.start_time+500
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H52FFF3&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\pos(%.3f,%.3f)}%s"
				,syl.center-6,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--left color 1
				
				l.layer=4
				
				l.start_time=line.start_time
				l.end_time=line.start_time+500
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H79FF9E&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\pos(%.3f,%.3f)}%s"
				,syl.center-2,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--original color
				
				l.layer=1
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H16009B&\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--border fadein
				
				l.layer=1
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord2\\blur3\\1c&H16009B&\\3c&HD2D2D6&\\1a&HFF&\\fad(500,0)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--right color
				
				l.layer=3
				
				l.start_time=line.start_time
				l.end_time=line.start_time+500
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&HEB01DF&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\pos(%.3f,%.3f)}%s"
				,syl.center+2,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--right color 2
				
				l.layer=2
				
				l.start_time=line.start_time
				l.end_time=line.start_time+500
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&HF2FF57&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\pos(%.3f,%.3f)}%s"
				,syl.center+6,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
		
		if line.style == "OP_Kanji_right" then
			--fadein kanji right
			if syl.text~="" then
				--left color 2
				
				l.layer=5
				
				l.start_time=line.start_time
				l.end_time=line.start_time+500
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H52FFF3&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\pos(%.3f,%.3f)}%s"
				,syl.center-6,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--left color 1
				
				l.layer=4
				
				l.start_time=line.start_time
				l.end_time=line.start_time+500
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H79FF9E&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\pos(%.3f,%.3f)}%s"
				,syl.center-2,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--original color
				
				l.layer=1
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H16009B&\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--border fadein
				
				l.layer=1
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord2\\blur3\\1c&H16009B&\\3c&HD2D2D6&\\1a&HFF&\\fad(500,0)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--right color
				
				l.layer=3
				
				l.start_time=line.start_time
				l.end_time=line.start_time+500
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&HEB01DF&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\pos(%.3f,%.3f)}%s"
				,syl.center+2,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--right color 2
				
				l.layer=2
				
				l.start_time=line.start_time
				l.end_time=line.start_time+500
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&HF2FF57&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\pos(%.3f,%.3f)}%s"
				,syl.center+6,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
		
		if line.style == "OP_Romanji_right" then
			--fadein romanji right
			if syl.text~="" then
				--left color 2
				
				l.layer=5
				
				l.start_time=line.start_time
				l.end_time=line.start_time+500
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H52FFF3&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\pos(%.3f,%.3f)}%s"
				,syl.center-6,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--left color 1
				
				l.layer=4
				
				l.start_time=line.start_time
				l.end_time=line.start_time+500
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H79FF9E&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\pos(%.3f,%.3f)}%s"
				,syl.center-2,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--original color
				
				l.layer=1
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H16009B&\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--border fadein
				
				l.layer=1
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord2\\blur3\\1c&H16009B&\\3c&HD2D2D6&\\1a&HFF&\\fad(500,0)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--right color
				
				l.layer=3
				
				l.start_time=line.start_time
				l.end_time=line.start_time+500
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&HEB01DF&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\pos(%.3f,%.3f)}%s"
				,syl.center+2,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--right color 2
				
				l.layer=2
				
				l.start_time=line.start_time
				l.end_time=line.start_time+500
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&HF2FF57&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\pos(%.3f,%.3f)}%s"
				,syl.center+6,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
		
		if line.style == "OP_Kanji" then
			--kanji syl effect - move down
			
			if syl.text~="" then
				
				l.layer=2
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H16009B&\\jitter(2,2,2,2,1)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,syl.center,syl.middle-10,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
		end
		
		if line.style == "OP_Romanji" then
			--romanji syl effect - move down
			
			if syl.text~="" then
				
				l.layer=2
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H16009B&\\jitter(2,2,2,2,1)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,syl.center,syl.middle-10,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
		end
		
		if line.style == "OP_Kanji_right" then
			--kanji right syl effect - move down
			
			if syl.text~="" then
				
				l.layer=2
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H16009B&\\jitter(2,2,2,2,1)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,syl.center,syl.middle-10,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
		end
		
		if line.style == "OP_Romanji_right" then
			--romanji right syl effect - move down
			
			if syl.text~="" then
				
				l.layer=2
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H16009B&\\jitter(2,2,2,2,1)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,syl.center,syl.middle-10,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
			end
			
		end
		
		if line.style == "OP_Kanji" then
			--kanji border effect
			
			if syl.text~="" then
				
				l.layer=1
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\blur3\\1c&HD2D2D6&\\fscx110\\fscy110\\jitter(2,2,2,2,4)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,syl.center,syl.middle-10,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
		end
		
		if line.style == "OP_Romanji" then
			--romanji border effect
			
			if syl.text~="" then
				
				l.layer=1
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\blur3\\1c&HD2D2D6&\\fscx110\\fscy110\\jitter(2,2,2,2,4)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,syl.center,syl.middle-10,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
		end
		
		if line.style == "OP_Kanji_right" then
			--kanji right border effect
			
			if syl.text~="" then
				
				l.layer=1
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\blur3\\1c&HD2D2D6&\\fscx110\\fscy110\\jitter(2,2,2,2,4)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,syl.center,syl.middle-10,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
		end
		
		if line.style == "OP_Romanji_right" then
			--romanji right border effect
			
			if syl.text~="" then
				
				l.layer=1
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\blur3\\1c&HD2D2D6&\\fscx110\\fscy110\\jitter(2,2,2,2,4)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,syl.center,syl.middle-10,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
		end
		
		if line.style == "OP_Kanji" then
			--kanji text fadeout effect
			
			if syl.text~="" then
				
				l.layer=1
				
				l.start_time=line.start_time+syl.end_time
				l.end_time=line.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H16009B&\\fad(0,500)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
		end
		
		if line.style == "OP_Romanji" then
			--romanji text fadeout effect
			
			if syl.text~="" then
				
				l.layer=1
				
				l.start_time=line.start_time+syl.end_time
				l.end_time=line.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H16009B&\\fad(0,500)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
		end
		
		if line.style == "OP_Kanji_right" then
			--kanji right text fadeout effect
			
			if syl.text~="" then
				
				l.layer=1
				
				l.start_time=line.start_time+syl.end_time
				l.end_time=line.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H16009B&\\fad(0,500)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
		end
		
		if line.style == "OP_Romanji_right" then
			--romanji right text fadeout effect
			
			if syl.text~="" then
				
				l.layer=1
				
				l.start_time=line.start_time+syl.end_time
				l.end_time=line.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H16009B&\\fad(0,500)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
		end
		
		if line.style == "OP_Kanji" then
			--kanji border fadeout effect
			
			if syl.text~="" then
				
				l.layer=1
				
				l.start_time=line.start_time+syl.end_time
				l.end_time=line.end_time
				
				l.text=string.format("{\\an5\\bord2\\blur3\\1c&H16009B&\\3c&HD2D2D6&\\1a&HFF&\\fad(0,500)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
		end
		
		if line.style == "OP_Romanji" then
			--romanji border fadeout effect
			
			if syl.text~="" then
				
				l.layer=1
				
				l.start_time=line.start_time+syl.end_time
				l.end_time=line.end_time
				
				l.text=string.format("{\\an5\\bord2\\blur3\\1c&H16009B&\\3c&HD2D2D6&\\1a&HFF&\\fad(0,500)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
		end
		
		if line.style == "OP_Kanji_right" then
			--kanji right border fadeout effect
			
			if syl.text~="" then
				
				l.layer=1
				
				l.start_time=line.start_time+syl.end_time
				l.end_time=line.end_time
				
				l.text=string.format("{\\an5\\bord2\\blur3\\1c&H16009B&\\3c&HD2D2D6&\\1a&HFF&\\fad(0,500)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
		end
		
		if line.style == "OP_Romanji_right" then
			--romanji right border fadeout effect
			
			if syl.text~="" then
				
				l.layer=1
				
				l.start_time=line.start_time+syl.end_time
				l.end_time=line.end_time
				
				l.text=string.format("{\\an5\\bord2\\blur3\\1c&H16009B&\\3c&HD2D2D6&\\1a&HFF&\\fad(0,500)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
		end
		
		if line.style == "OP_Hey" then
			--hey effect
			if syl.text~="" then
				--left color 2
				
				l.layer=5
				
				l.start_time=line.start_time
				l.end_time=line.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H52FFF3&\\1a&H64&\\fscx100\\fscy100\\t(\\1a&HFF&\\fscx130\\fscy130)\\pos(%.3f,%.3f)}%s"
				,syl.center-6,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--left color 1
				
				l.layer=4
				
				l.start_time=line.start_time
				l.end_time=line.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H79FF9E&\\1a&H64&\\fscx100\\fscy100\\t(\\1a&HFF&\\fscx130\\fscy130)\\pos(%.3f,%.3f)}%s"
				,syl.center-2,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--original color
				
				l.layer=1
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H16009B&\\fscx100\\fscy100\\t(\\fscx130\\fscy130)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--right color
				
				l.layer=3
				
				l.start_time=line.start_time
				l.end_time=line.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&HEB01DF&\\1a&H64&\\fscx100\\fscy100\\t(\\1a&HFF&\\fscx130\\fscy130)\\pos(%.3f,%.3f)}%s"
				,syl.center+2,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--right color 2
				
				l.layer=2
				
				l.start_time=line.start_time
				l.end_time=line.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&HF2FF57&\\1a&H64&\\fscx100\\fscy100\\t(\\1a&HFF&\\fscx130\\fscy130))\\pos(%.3f,%.3f)}%s"
				,syl.center+6,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
		
		
		if line.style == "Chikutaku_kanji" then
		--chikutaku kanji fadein
		
			if syl.text~="" then
				
				l.layer=2
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				random_jitter = math.random(1,6)
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H16009B&\\jitter(%d,%d,%d,%d,%d,%d)\\fad(250,0)\\pos(%.3f,%.3f)}%s"
				,random_jitter,random_jitter,random_jitter,random_jitter,random_jitter,random_jitter,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
		
		if line.style == "Chikutaku_kanji" then
		--chikutaku kanji border fadein
		
			if syl.text~="" then
				
				
				l.layer=1
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				random_jitter = math.random(1,6)
				
				l.text=string.format("{\\an5\\blur3\\1c&HD2D2D6&\\fscx110\\fscy110\\jitter(%d,%d,%d,%d,%d,%d)\\fad(250,0)\\pos(%.3f,%.3f)}%s"
				,random_jitter,random_jitter,random_jitter,random_jitter,random_jitter,random_jitter,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
		end

		
		if line.style == "Chikutaku_romanji" then
		--chikutaku romanji fadein
			
			if syl.text~="" then
				
				l.layer=2
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				random_jitter = math.random(1,6)
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H16009B&\\jitter(%d,%d,%d,%d,%d,%d)\\fad(250,0)\\pos(%.3f,%.3f)}%s"
				,random_jitter,random_jitter,random_jitter,random_jitter,random_jitter,random_jitter,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
		
		if line.style == "Chikutaku_romanji" then
		--chikutaku romanji border fadein
		
			if syl.text~="" then
				
				l.layer=1
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				random_jitter = math.random(1,6)
				
				l.text=string.format("{\\an5\\blur3\\1c&HD2D2D6&\\fscx110\\fscy110\\jitter(%d,%d,%d,%d,%d,%d)\\fad(250,0)\\pos(%.3f,%.3f)}%s"
				,random_jitter,random_jitter,random_jitter,random_jitter,random_jitter,random_jitter,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
		end
		
		
		if line.style == "Chikutaku_romanji" then
		--chikutaku romanji effect
			
			if syl.text~="" then
				--left color 2
				
				l.layer=5
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H52FFF3&\\1a&H64&\\fscx100\\fscy120\\jitter(9,0,5,3)\\fad(%d,50)\\pos(%.3f,%.3f)}%s"
				,syl.duration,syl.center-6,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--left color 1
				
				l.layer=4
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H79FF9E&\\1a&H64&\\fscx100\\fscy120\\jitter(2,1,6,8)\\fad(%d,50)\\pos(%.3f,%.3f)}%s"
				,syl.duration,syl.center-2,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--original color
				
				l.layer=1
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H16009B&\\fscx100\\fscy100\\fad(0,250)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--right color
				
				l.layer=3
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&HEB01DF&\\1a&H64&\\fscx100\\fscy120\\jitter(6,4,1,8)\\fad(%d,50)\\pos(%.3f,%.3f)}%s"
				,syl.duration,syl.center+2,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--right color 2
				
				l.layer=2
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&HF2FF57&\\1a&H64&\\fscx100\\fscy120\\jitter(3,5,7,1)\\fad(%d,50)\\pos(%.3f,%.3f)}%s"
				,syl.duration,syl.center+6,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end

		
		if line.style == "Chikutaku_kanji" then
		--chikutaku kanji effect
		
			if syl.text~="" then
				--left color 2
				
				l.layer=5
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H52FFF3&\\1a&H64&\\fscx100\\fscy120\\\jitter(5,8,4,6)\\fad(%d,50)\\pos(%.3f,%.3f)}%s"
				,syl.duration,syl.center-6,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--left color 1
				
				l.layer=4
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H79FF9E&\\1a&H64&\\fscx100\\fscy120\\jitter(1,9,8,2)\\fad(%d,50)\\pos(%.3f,%.3f)}%s"
				,syl.duration,syl.center-2,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--original color
				
				l.layer=1
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H16009B&\\fscx100\\fscy100\\fad(0,250)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--right color
				
				l.layer=3
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&HEB01DF&\\1a&H64&\\fscx100\\fscy120\\jitter(3,6,8,9)\\fad(%d,50)\\pos(%.3f,%.3f)}%s"
				,syl.duration,syl.center+2,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--right color 2
				
				l.layer=2
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&HF2FF57&\\1a&H64&\\fscx100\\fscy120\\jitter(8,2,5,3)\\fad(%d,50)\\pos(%.3f,%.3f)}%s"
				,syl.duration,syl.center+6,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
		
		if line.style == "OP_Kanji_gray" then
			--fadein gray kanji
			if syl.text~="" then
				--left color 2
				
				l.layer=5
				
				l.start_time=line.start_time
				l.end_time=line.start_time+500
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H52FFF3&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\jitter(1,1,1,1,.1,.1)\\pos(%.3f,%.3f)}%s"
				,syl.center-6,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--left color 1
				
				l.layer=4
				
				l.start_time=line.start_time
				l.end_time=line.start_time+500
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H79FF9E&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\jitter(1,1,1,1,.1,.1)\\pos(%.3f,%.3f)}%s"
				,syl.center-2,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--original color
				
				l.layer=1
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&HD2D2D6&\\jitter(1,1,1,1,.1,.1)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--border fadein
				
				l.layer=1
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord2\\blur3\\1c&H16009B&\\3c&HDE6C99&\\1a&HFF&\\fad(500,0)\\jitter(1,1,1,1,.1,.1)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--right color
				
				l.layer=3
				
				l.start_time=line.start_time
				l.end_time=line.start_time+500
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&HEB01DF&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\jitter(1,1,1,1,.1,.1)\\pos(%.3f,%.3f)}%s"
				,syl.center+2,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--right color 2
				
				l.layer=2
				
				l.start_time=line.start_time
				l.end_time=line.start_time+550
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&HF2FF57&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\jitter(1,1,1,1,.1,.1)\\pos(%.3f,%.3f)}%s"
				,syl.center+6,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
		
		if line.style == "OP_Romanji_gray" then
			--fadein gray romanji
			if syl.text~="" then
				--left color 2
				
				l.layer=5
				
				l.start_time=line.start_time
				l.end_time=line.start_time+500
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H52FFF3&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\jitter(1,1,1,1,.1,.1)\\pos(%.3f,%.3f)}%s"
				,syl.center-6,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--left color 1
				
				l.layer=4
				
				l.start_time=line.start_time
				l.end_time=line.start_time+500
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&H79FF9E&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\jitter(1,1,1,1,.1,.1)\\pos(%.3f,%.3f)}%s"
				,syl.center-2,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--original color
				
				l.layer=1
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&HD2D2D6&\\jitter(1,1,1,1,.1,.1)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--border fadein
				
				l.layer=1
				
				l.start_time=line.start_time
				l.end_time=line.start_time+syl.start_time
				
				l.text=string.format("{\\an5\\bord2\\blur3\\1c&H16009B&\\3c&HDE6C99&\\1a&HFF&\\fad(500,0)\\jitter(1,1,1,1,.1,.1)\\pos(%.3f,%.3f)}%s"
				,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--right color
				
				l.layer=3
				
				l.start_time=line.start_time
				l.end_time=line.start_time+500
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&HEB01DF&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\jitter(1,1,1,1,.1,.1)\\pos(%.3f,%.3f)}%s"
				,syl.center+2,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
			if syl.text~="" then
				--right color 2
				
				l.layer=2
				
				l.start_time=line.start_time
				l.end_time=line.start_time+500
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&HF2FF57&\\1a&H64&\\fscy120\\t(0,500,\\1a&HFF&)\\jitter(1,1,1,1,.1,.1)\\pos(%.3f,%.3f)}%s"
				,syl.center+6,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
		
		if line.style == "OP_Kanji_gray" then
			--kanji gray syl effect - move down
			
			if syl.text~="" then
				
				l.layer=2
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&HD2D2D6&\\jitter(2,2,2,2,1)\\fad(0,%d)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,syl.duration/2,syl.center,syl.middle+10,syl.center,syl.middle+20,syl.text)
				
				io.write_line(l)
			end
			
		end
		
		if line.style == "OP_Romanji_gray" then
			--romanji gray syl effect - move down
			
			if syl.text~="" then
				
				l.layer=2
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\bord0\\blur0.4\\1c&HD2D2D6&\\jitter(2,2,2,2,1)\\fad(0,%d)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,syl.duration/2,syl.center,syl.middle-10,syl.center,syl.middle-20,syl.text)
				
				io.write_line(l)
			end
			
		end
		
		if line.style == "OP_Kanji_gray" then
			--kanji gray border effect
			
			if syl.text~="" then
				
				l.layer=1
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\blur3\\1c&HDE6C99&\\fscx120\\fscy120\\jitter(2,2,2,2,4)\\fad(0,%d)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,syl.duration/2,syl.center,syl.middle+10,syl.center,syl.middle+20,syl.text)
				
				io.write_line(l)
				
			end
		end
		
		if line.style == "OP_Romanji_gray" then
			--romanji gray border effect
			
			if syl.text~="" then
				
				l.layer=1
				
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				
				l.text=string.format("{\\an5\\blur3\\1c&HDE6C99&\\fscx120\\fscy120\\jitter(2,2,2,2,4)\\fad(0,%d)\\move(%.3f,%.3f,%.3f,%.3f)}%s"
				,syl.duration/2,syl.center,syl.middle-10,syl.center,syl.middle-20,syl.text)
				
				io.write_line(l)
				
			end
		end
		
		
		
	end
end
for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end