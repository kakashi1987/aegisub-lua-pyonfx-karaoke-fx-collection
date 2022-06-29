--Dragon Ball Kai 99+ OP
--Karaoke by Amberdrake
--VSFilter

function kara (line, l)
	if line.infade > 150 then
		line.infade = 150
	end
	if line.outfade > 150 then
		line.outfade = 150
	end
	
	for si,syl in ipairs(line.syls) do
		
		if syl.text~="" then
			--infade
			l.layer=1
			
			l.start_time=line.start_time-line.infade+25*syl.i-25
			l.end_time=line.start_time+syl.start_time
			
			l.text=string.format("{\\an5\\blur0.6\\bord0.5\\shad3\\fscx100\\fscy100\\fad(150,0)\\1c&HFFFFFF&\\3c&HFFFFFF&\\4c&HFFFFFF&\\t(0,150,\\1c&H10FCFF&\\3c&H000000&\\4c&H000000&)\\pos(%.3f, %.3f)}%s"
			,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--outfade
			l.layer=3
			
			l.start_time=line.start_time+syl.end_time
			l.end_time=line.end_time+line.outfade+25*syl.i-25
			
			of_start = l.end_time-l.start_time-150
			of_end = l.end_time-l.start_time
			
			l.text=string.format("{\\an5\\blur0.6\\bord0.5\\shad3\\fscx100\\fscy100\\fad(0,150)\\1c&H10FCFF&\\3c&H000000&\\4c&H000000&\\t(%d,%d,\\1c&HFFFFFF&\\3c&HFFFFFF&\\4c&HFFFFFF&)\\pos(%.3f, %.3f)}%s"
			,of_start,of_end,syl.center,syl.middle,syl.text)
			
			io.write_line(l)
		end
		
		if syl.text~="" then
			--syl effect
			max_frame=25
			u_in=0
			a=0
			
			for s, e, i, n in utils.frames(line.start_time+syl.start_time, line.start_time+syl.end_time, max_frame) do
				
				max_frame=25
				u_in=0
				
				l.start_time = s
				l.end_time = e
				
				l.layer = 3
				
				sc = 120+10*math.sin(math.rad(a))
				a = a + 90
				
				l.text = string.format("{\\an5\\blur0.6\\bord0.5\\shad3\\fscx%d\\fscy%d\\1c&H10FCFF&\\3c&H000000&\\4c&H000000&\\pos(%.3f, %.3f)}%s"
				,sc,sc,syl.center,syl.middle,syl.text)
				
				io.write_line(l)
				
			end
			
		end
		
	end
	
	for ci,char in ipairs(line.chars) do
		
		if line.i == 1 or line.i == 2 or line.i == 3 or line.i == 4 or line.i == 5 or line.i == 6 or line.i == 9 or line.i == 10 then
			color = "&HFFFFFF&"
		end
		if line.i == 7 or line.i == 8 or line.i == 11 or line.i == 12 or line.i == 13 or line.i == 14 or line.i == 15 or line.i == 16 or line.i == 17 then
			color = "&H3FF7F7&"
		end
		
		if char.text~=" " then
			--aura effect
			max_frame=25
			u_in=0
			
			for s, e, i, n in utils.frames(line.start_time+char.start_time, line.start_time+char.end_time, max_frame) do
				
				max_frame=25
				u_in=0
				
				l.start_time = s
				l.end_time = e
				
				l.layer = 1
				
				local aura = "m 0 0 l 0 4 l -5 6 l -5 -16 l -8 0 l -11 -22 l -12 -9 l -23 -37 l -29 -20 l -34 -14 l -36 14 l -41 -13 l -44 12 l -47 -10 l -49 23 l -53 31 l -62 -11 l -64 10 l -70 -11 l -69 11 l -82 -22 l -88 -33 l -81 21 l -92 -7 l -81 42 l -93 3 l -95 19 l -98 9 l -96 26 l -102 17 l -92 58 l -108 44 l -97 61 l -118 55 l -101 70 l -125 65 l -101 89 l -120 83 l -106 93 l -124 88 l -110 97 l -132 92 l -111 106 l -159 114 l -132 117 l -143 120 l -132 121 l -192 128 l -169 131 l -203 142 l -158 136 l -189 144 l -140 145 l -164 152 l -141 151 l -156 157 l -128 155 l -140 178 l -110 171 l -163 226 l -118 195 l -134 221 l -115 205 l -118 228 l -110 220 l -132 258 l -102 241 l -111 264 l -94 254 l -106 269 l -93 263 l -101 274 l -85 261 l -108 288 l -83 271 l -110 303 l -88 289 l -119 341 l -106 334 l -111 342 l -94 329 l -100 340 l -68 308 l -72 324 l -43 299 l -31 288 l -22 286 l -25 303 l -12 286 l -11 305 l -3 295 l -6 321 l 3 299 l 2 309 l 10 293 l 14 312 l 16 299 l 21 316 l 22 305 l 37 351 l 34 323 l 53 391 l 46 324 l 57 348 l 55 321 l 65 334 l 56 293 l 63 300 l 60 291 l 73 304 l 60 281 l 69 290 l 64 277 l 79 298 l 71 280 l 87 302 l 80 286 l 92 302 l 84 287 l 119 334 l 114 316 l 124 331 l 117 311 l 102 263 l 118 277 l 114 264 l 126 278 l 119 267 l 143 289 l 124 261 l 138 269 l 135 261 l 126 249 l 146 264 l 133 241 l 170 245 l 137 235 l 165 234 l 139 220 l 168 224 l 143 214 l 175 209 l 149 204 l 168 195 l 153 195 l 179 182 l 146 187 l 190 173 l 146 181 l 170 169 l 131 176 l 167 159 l 138 160 l 178 143 l 168 141 l 182 136 l 160 142 l 146 144 l 193 118 l 143 134 l 185 103 l 162 109 l 188 92 l 171 101 l 221 61 l 182 77 l 144 89 l 166 69 l 137 84 l 162 64 l 140 73 l 164 41 l 135 59 l 167 23 l 146 34 l 180 -4 l 129 33 l 160 -2 l 122 26 l 124 17 l 118 21 l 137 -12 l 109 19 l 119 -1 l 112 5 l 115 -8 l 97 12 l 108 -19 l 94 1 l 99 -21 l 93 -7 l 94 -36 l 77 -2 l 81 -40 l 61 1 l 66 -35 l 57 -9 l 49 -49 l 49 -11 l 41 -46 l 37 -6 l 24 -74 l 19 -7 l 16 -33 l 9 -6 l 6 -35 "
				
				local deform = shape.filter(aura,
				function(x,y)
					local xdef = math.randomsteps(-12,12,3)
					local ydef = math.randomsteps(-12,12,4)
					return x+xdef, y+ydef
				end)
				
				l.text = string.format("{\\p1\\an5\\blur1\\alpha&H96&\\bord0\\shad0\\fscx15\\fscy18\\1c%s\\pos(%.3f, %.3f)}%s"
				,color,char.center+30,char.middle+20,deform)
				
				io.write_line(l)
				
			end
			
		end
		
		if char.text~=" " then
			--aura outline effect
			max_frame=25
			u_in=0
			
			for s, e, i, n in utils.frames(line.start_time+char.start_time, line.start_time+char.end_time, max_frame) do
				
				max_frame=25
				u_in=0
				
				l.start_time = s
				l.end_time = e
				
				l.layer = 2
				
				local aura = "m 0 0 l 0 4 l -5 6 l -5 -16 l -8 0 l -11 -22 l -12 -9 l -23 -37 l -29 -20 l -34 -14 l -36 14 l -41 -13 l -44 12 l -47 -10 l -49 23 l -53 31 l -62 -11 l -64 10 l -70 -11 l -69 11 l -82 -22 l -88 -33 l -81 21 l -92 -7 l -81 42 l -93 3 l -95 19 l -98 9 l -96 26 l -102 17 l -92 58 l -108 44 l -97 61 l -118 55 l -101 70 l -125 65 l -101 89 l -120 83 l -106 93 l -124 88 l -110 97 l -132 92 l -111 106 l -159 114 l -132 117 l -143 120 l -132 121 l -192 128 l -169 131 l -203 142 l -158 136 l -189 144 l -140 145 l -164 152 l -141 151 l -156 157 l -128 155 l -140 178 l -110 171 l -163 226 l -118 195 l -134 221 l -115 205 l -118 228 l -110 220 l -132 258 l -102 241 l -111 264 l -94 254 l -106 269 l -93 263 l -101 274 l -85 261 l -108 288 l -83 271 l -110 303 l -88 289 l -119 341 l -106 334 l -111 342 l -94 329 l -100 340 l -68 308 l -72 324 l -43 299 l -31 288 l -22 286 l -25 303 l -12 286 l -11 305 l -3 295 l -6 321 l 3 299 l 2 309 l 10 293 l 14 312 l 16 299 l 21 316 l 22 305 l 37 351 l 34 323 l 53 391 l 46 324 l 57 348 l 55 321 l 65 334 l 56 293 l 63 300 l 60 291 l 73 304 l 60 281 l 69 290 l 64 277 l 79 298 l 71 280 l 87 302 l 80 286 l 92 302 l 84 287 l 119 334 l 114 316 l 124 331 l 117 311 l 102 263 l 118 277 l 114 264 l 126 278 l 119 267 l 143 289 l 124 261 l 138 269 l 135 261 l 126 249 l 146 264 l 133 241 l 170 245 l 137 235 l 165 234 l 139 220 l 168 224 l 143 214 l 175 209 l 149 204 l 168 195 l 153 195 l 179 182 l 146 187 l 190 173 l 146 181 l 170 169 l 131 176 l 167 159 l 138 160 l 178 143 l 168 141 l 182 136 l 160 142 l 146 144 l 193 118 l 143 134 l 185 103 l 162 109 l 188 92 l 171 101 l 221 61 l 182 77 l 144 89 l 166 69 l 137 84 l 162 64 l 140 73 l 164 41 l 135 59 l 167 23 l 146 34 l 180 -4 l 129 33 l 160 -2 l 122 26 l 124 17 l 118 21 l 137 -12 l 109 19 l 119 -1 l 112 5 l 115 -8 l 97 12 l 108 -19 l 94 1 l 99 -21 l 93 -7 l 94 -36 l 77 -2 l 81 -40 l 61 1 l 66 -35 l 57 -9 l 49 -49 l 49 -11 l 41 -46 l 37 -6 l 24 -74 l 19 -7 l 16 -33 l 9 -6 l 6 -35 "
				local aura_outline = shape.tooutline(shape.split(aura), 5)
				local deform = shape.filter(aura_outline,
				function(x,y)
					local xdef = math.randomsteps(-12,12,3)
					local ydef = math.randomsteps(-12,12,4)
					return x+xdef, y+ydef
				end)
				
				l.text = string.format("{\\p1\\an5\\blur1\\alpha&H32&\\bord0\\shad0\\fscx15\\fscy18\\1c%s\\pos(%.3f, %.3f)}%s"
				,color,char.center+30,char.middle+20,deform,deform)
				
				io.write_line(l)
				
			end
			
		end
	end
end

for li, line in ipairs(lines) do
	
	kara( line, table.copy(line) )
	
	io.progressbar(li / #lines)
end