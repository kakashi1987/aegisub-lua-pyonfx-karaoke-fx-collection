--NyuFx 1.6 Ver.

function rom1(line, l)
	
	local pix = "m 0 -9 b -13 -9 -13 9 0 9 b 13 9 13 -9 0 -9 "
	for si, syl in ipairs(line.syls) do
		local l = table.copy(line)
		if si == 1 then timx = 0 end
			
			local y = line.middle
			local x = syl.left
			
			local pi = math.pi
			local sin = math.sin
			local cos = math.cos
			
			sign_x = (-1)^(math.random(5)+syl.i)
			sign_y = (-1)^(math.random(4)-syl.i)
			scale_x = math.random(-syl.width/1.5,syl.width)
			scale_y = math.random(-syl.height,syl.height)
			
			shape = "m 0 -10 b 0 -10 5 -14 11 -10 b 11 -10 15 -5 11 0 b 6 4 0 0 0 0 b -4 -5 0 -10 0 -10 "
			angle = math.random(36)*10
			maxj = 6*(scale_x^2+scale_y^2)^0.5
			for j = 1, maxj do
				s_i = -pi
				s_f = pi
				
				s = s_i + (s_f-s_i)*(j-1)/(maxj-1)
				x_s = sign_x*(cos(5*s))
				y_s = sign_y*(sin(4*s))
				
				x_pos = (syl.left+scale_x*x_s)
				y_pos = (line.middle-scale_y*y_s)
				
				ff = 25
				l = table.copy(line)
				l.effect = "curve fx"
				l.start_time = line.start_time + syl.start_time + ((maxj-j)/(maxj-1))*syl.duration
				l.end_time = line.start_time + syl.start_time + ((maxj-j)/(maxj-1))*syl.duration + 200
				l.dur = l.end_time - l.start_time
				local alf =string.format("\\3a&H%02X&",200)
				l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\bord2\\shad0\\blur1.5\\1c&H7C8CFD&\\3c&H1419CA&"..alf.."\\fad(0,200)\\fscx"..ff.."\\fscy"..ff.."\\p1\\t(\\fscx10\\fscy10)\\org(%d,%d)\\fr%d}",x_pos,y_pos, x_pos, y_pos, x,y,angle) ..shape
				l.layer = 0
				io.write_line(l)
			end
			
			pin =0
			longsil=string.len(syl.text)
			modt=0
			
			for ci, char in string.uchars(syl.text) do
				cc = utils.text_extents(char,line.styleref)
				local y = line.middle
				local x = syl.left + pin + cc/2
				
				if syl.text == "" or syl.text == " " then l.text = "{Hello Alkoon XD}" else
					
					l.start_time=line.start_time -500 +timx
					l.end_time=line.start_time -40 + timx
					fx = "\\1a&H57&\\1c&H000000&\\blur1\\bord0\\shad0\\t(\\frz100)\\t(\\frz-100)\\t(\\frz0)"
					l.text= string.format("{\\an5\\fad(150,0)\\org(%d,%d)\\frz100\\move(%d,%d,%d,%d)"..fx.."}",x+50,y+30,x+1-50,y+1-20,x+1,y+1) .. char
					l.layer=1
					io.write_line(l)
					fx = "\\1c&Hffffff&\\blur0\\bord0\\shad0\\t(\\frz100)\\t(\\frz-100)\\t(\\frz0)"
					l.text= string.format("{\\an5\\fad(150,0)\\org(%d,%d)\\frz100\\move(%d,%d,%d,%d)"..fx.."}",x+50,y+30,x-50,y-20,x,y) .. char
					l.layer=1
					io.write_line(l)
					fx = "\\1a&H20&\\1c&H000000&\\blur1\\bord0\\shad0\\t(\\frz100)\\t(\\frz-100)\\t(\\frz0)"
					l.text= string.format("{\\an5\\fad(150,0)\\org(%d,%d)\\frz100\\move(%d,%d,%d,%d)"..fx.."}",x+50+2,y+30+2,x-50+2,y-20+2,x+2,y+2) .. char
					l.layer=1
					io.write_line(l)
					
					---------------------------------------------------------------------------------------------------------------------------------------------
					
					l.start_time=line.start_time -40 +timx
					l.end_time=line.start_time + syl.start_time + modt + 100
					
					l.text= string.format("{\\an5\\fad(100,100)\\pos(%d,%d)\\1a&H57&\\1c&H000000&\\blur1\\bord0\\shad0}",x+1,y+1) .. char
					l.layer=1
					io.write_line(l)
					l.text= string.format("{\\an5\\pos(%d,%d)\\1c&Hffffff&\\blur0\\bord0\\shad0}",x,y) .. char
					l.layer=1
					io.write_line(l)
					l.text= string.format("{\\an5\\pos(%d,%d)\\1a&H20&\\1c&H000000&\\blur1\\bord0\\shad0}",x+2,y+2) .. char
					l.layer=1
					io.write_line(l)
					
					l.start_time=line.start_time+ syl.start_time + modt
					l.end_time=line.end_time -700 + 30 + si*60
					
					l.text= string.format("{\\an5\\pos(%d,%d)\\fad(150,0)\\bord1.5\\blur1.5\\3a&H30&\\shad0\\3c&H1FC227&\\1c&H3EF744&}",x,y) .. char
					l.layer=1
					io.write_line(l)
					
					l.start_time=line.start_time-50+ timx
					l.end_time=line.end_time -600 + 30 + si*60
					local a1 =string.format("\\1a&H%02X&",220)
					l.text= string.format("{\\an5"..a1.."\\pos(%d,%d)\\fad(120,130)\\frx190\\\fscy95\\1c&Hffffff&\\blur1\\bord0\\shad0}",x,y+19) .. char
					l.layer=1
					io.write_line(l)
					
					fx2 = "\\3c&H3FFF3B&\\1c&H3EF744&\\shad0\\bord0\\blur1.3"
					
					local loops = 25
					for i=1, loops do
						local movex = i / loops
						local fsx = 100 + 25 * movex
						local alfa = utils.interpolate(movex,"&HDD&","&HFF&")
						movy = y- i
						l.start_time= line.start_time + syl.start_time + modt - 100
						l.end_time= line.start_time + syl.end_time + modt
						l.text= string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,150)"..fx2.."\\fscy"..fsx.."\\fscx"..fsx.."\\alpha"..alfa.."}",x,y,x,movy) .. char
						l.layer=3
						io.write_line(l)
						
					end
					
					local loops = 10
					for i=1, loops do
						local movex = i / loops
						local fsx = 100 + 25 * movex
						local alfa = utils.interpolate(movex,"&HDD&","&HFF&")
						movy = y+i +18
						
						iniEnf=line.start_time+syl.start_time+modt-100
						finEnf=line.start_time+syl.end_time+modt
						l.start_time=iniEnf
						l.end_time=finEnf
						l.text= string.format("{\\an5\\frx190\\move(%d,%d,%d,%d)\\alpha&HFC&\\fad(200,150)\\blur2"..fx2.."\\fscy"..fsx.."\\fscx"..fsx.."\\alpha"..alfa.."}",x,movy,x,y+18,0) .. char
						l.layer=3
						io.write_line(l)
						
					end
				end
				
				if syl.duration < 150 then
					modt=modt+300/(longsil*2)
				elseif syl.duration < 500 then
					modt=modt+700/(longsil*2)
				elseif syl.duration < 900 then
					modt=modt+1000/(longsil*2)
				elseif syl.duration >= 2000 then
					modt=modt+1600/(longsil*2)
				else
					modt=modt+1400/(longsil*2)
				end
				
				local text_p = convert.text_to_pixels(char, line.styleref, x % 1, y % 1)
				lops = #text_p
				for i = 1, lops do
					
					fss = math.random(5,55)
					
					if fss >= 35 then
						rm = math.random(-60,35)
						mr = math.random(-30,30)
					else
						rm = math.random(-35,20)
						mr = math.random(-20,30)
					end
					local poss = math.random(1,#text_p)
					local xx = math.round(x-7) + text_p[poss].x
					local yy = math.round(y-18) + text_p[poss].y
					l.start_time = line.end_time -700 + si*60
					l.end_time = line.end_time -580 + si*40 + math.random(400,900)
					tt = l.end_time - l.start_time
					local rx = math.cos(math.rad(i*10))*rm
					local ry = math.sin(math.rad(i*10))*mr
					lfx = "\\t("..tt-(300)..","..tt+(150)..",\\3c&H1FC227&\\1c&H3EF744&\\bord1.5\\blur2\\3a&H30&\\fscx"..fss.."\\fscy"..fss..")"
					l.text = string.format("{\\an5\\move(%d,%d,%d,%d,"..tt-(400)..","..tt..")\\fad(30,"..math.random(150,300)..")\\org(%d,%d)\\t(%d,%d,\\frz%d)\\be0\\fscx5\\fscy5\\bord1\\blur1.5\\3a&H40&\\shad0\\3c&H1FC227&\\1c&H3EF744&"..lfx.."\\p1}%s", xx, yy,xx+rx,yy+ry,x,y,tt-400,tt,math.random(-150,150),pix)
					l.layer = 2
					io.write_line(l)
					
				end
				
				pin = pin+cc
				timx=timx +(500/#line.syls)
				
			end
			
		end
		
	end
	
	function rom2(line, l)
		
		for si, syl in ipairs(line.syls) do
			local l = table.copy(line)
			char = syl.text
			
			local y = syl.middle
			local x = syl.left
			
			l.start_time=line.start_time -450
			l.end_time=line.start_time + syl.start_time
			
			l.text= string.format("{\\an5\\fad(250,0)\\pos(%d,%d)\\1a&H57&\\1c&H000000&\\blur1\\bord0\\shad0}",x+1,y+1) .. char
			l.layer=1
			io.write_line(l)
			l.text= string.format("{\\an5\\fad(250,0)\\pos(%d,%d)\\1c&Hffffff&\\blur0\\bord0\\shad0}",x,y) .. char
			l.layer=1
			io.write_line(l)
			l.text= string.format("{\\an5\\fad(250,0)\\pos(%d,%d)\\1a&H20&\\1c&H000000&\\blur1\\bord0\\shad0}",x+2,y+2) .. char
			l.layer=1
			io.write_line(l)
			
			l.start_time=line.start_time+ syl.start_time
			l.end_time=line.end_time +500
			
			l.text= string.format("{\\an5\\pos(%d,%d)\\fad(0,200)\\bord1.5\\blur1.5\\3a&H30&\\shad0\\3c&H1FC227&\\1c&H3EF744&}",x,y) .. char
			l.layer=1
			io.write_line(l)
			
			local a1 =string.format("\\1a&H%02X&",220)
			l.start_time=line.start_time -450
			l.end_time=line.end_time +500
			l.text= string.format("{\\an5"..a1.."\\pos(%d,%d)\\fad(250,200)\\frx190\\\fscy95\\1c&Hffffff&\\bord0\\blur1\\shad0}",x,y+19) .. char
			l.layer=1
			io.write_line(l)
			
			fx2 = "\\3c&H3FFF3B&\\1c&H3EF744&\\shad0\\bord0\\blur1.3"
			
			local loops = syl.width/2.5
			for i=1, loops do
				local movex = i / loops
				local fsx = 100 + 40 * movex
				local alfa = utils.interpolate(movex,"&HDD&","&HFF&")
				movy = y - i/1.4
				l.start_time= line.start_time + syl.start_time
				l.end_time= line.start_time + syl.start_time + syl.duration /2
				l.text= string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(150,150)"..fx2.."\\fscy"..fsx.."\\fscx"..fsx.."\\alpha"..alfa.."}",x,movy,x,movy) .. char
				l.layer=3
				io.write_line(l)
				
			end
			
			local loops = 10
			for i=1, loops do
				local movex = i / loops
				local fsx = 100 + 35 * movex
				local alfa = utils.interpolate(movex,"&HDD&","&HFF&")
				movy = y+i/1.4 +18
				l.start_time= line.start_time + syl.start_time
				l.end_time= line.start_time + syl.start_time + syl.duration/2
				l.text= string.format("{\\an5\\frx190\\move(%d,%d,%d,%d)\\alpha&HAA&\\fad(100,150)\\blur2"..fx2.."\\fscy"..fsx.."\\fscx"..fsx.."\\alpha"..alfa.."}",x,movy,x,y+18) .. char
				l.layer=3
				io.write_line(l)
				
			end
		end
	end
end
for li, line in ipairs(lines) do
	if not line.comment then
		if line.actor == "1" then
			rom1( line, table.copy(line) )
		elseif line.actor =="3" then
			rom2( line, table.copy(line) )
		end
	end
	io.progressbar(li / #lines)
end
print("Finished!")

