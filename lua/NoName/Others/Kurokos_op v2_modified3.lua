include("karaskel.lua")
script_name = "Apply Script Lua - تطبيق سكربت لوا"
script_description = "Kurokos OP"
script_author = "alkoon - الكون"
script_version = "1.2"

 

function A_to_ASS(a)
	return string.format("&H%02x&", 255-a)
end

function ASS_to_A(str)
	local a = str:match("&H(%x%x)&")
	if a then return 255-tonumber(a, 16) else return false end
end

 
function Char_FX(subs, meta, line, styles)	
	local l=table.copy(line)
	for i = 0, line.kara.n do			
	local syl = line.kara[i]
 	local l = table.copy(line)
 

	x = line.left + syl.center
	y = line.middle
                  char = syl.text

if char == "" or char == " " then l.text = "{}" else


if syl.i%2 == 0 then
 m = 20
fx1 = "\\t(\\frx250\\fry70)"
 else
fx1 = "\\t(\\frx-250\\fry-70)"
 m = -20
 end
w = -15

--------------------------------------
if line.actor == "burb" then
--------------------------------------

		l.start_time=line.start_time-250 + syl.i*50
		l.end_time=line.start_time + syl.start_time
                                    fx = "\\an5\\t(50,250,\\fscy135)\\t(250,485,\\fscy100)"

		l.text= string.format("{\\fad(100,0)"..fx.."\\bord4\\shad1\\blur4\\3a&H30&\\1a&HFF&\\3c&H8F129F&\\4c&H870498&\\move(%d,%d,%d,%d,0,490)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 	

		l.text= string.format("{\\fad(100,0)"..fx.."\\bord2\\1a&HFF&\\3a&H20&\\shad0\\be2\\3c&H000000&\\move(%d,%d,%d,%d,0,490)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 

                                    lfx = "\\1c&HF439F3&"
		l.text= string.format("{\\be1\\fad(100,0)"..fx.."\\shad0\\bord0"..lfx.."\\move(%d,%d,%d,%d,0,490)}",x,y,x,y) .. char
                                    l.layer=2
		subs.append(l) 	
 
		l.start_time=line.start_time+ syl.start_time
		l.end_time=line.end_time  +50 + syl.i*50
                                    fx = "\\an7\\t(50,250,\\fscy135)\\t(250,485,\\fscy100)"

		l.text= string.format("{\\an5\\fad(0,150)\\bord4\\shad1\\blur4\\3a&H30&\\1a&HFF&\\3c&H8F129F&\\4c&H870498&\\move(%d,%d,%d,%d)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 	

		l.text= string.format("{\\an5\\fad(0,150)\\bord2\\1a&HFF&\\shad0\\3a&H30&\\be2\\3c&H000000&\\move(%d,%d,%d,%d)}",x,y,x,y) .. char
                                    l.layer=2
		subs.append(l) 

                                    lfx = "\\1c&HFFFFFF&"
		l.text= string.format("{\\an5\\fad(0,150)\\shad1\\blur1\\bord0"..lfx.."\\move(%d,%d,%d,%d)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 


		l.start_time=line.start_time + syl.start_time
		l.end_time=line.start_time + syl.start_time + syl.duration/4 + 500
                                    fx = "\\an5"
	
		l.text= string.format("{\\fad(0,100)"..fx..""..fx1.."\\bord2\\1a&HFF&\\3a&H20&\\shad0\\be2\\3c&H000000&\\move(%d,%d,%d,%d)}",x,y,x+m,y+w) .. char
                                    l.layer=2
		subs.append(l) 

                                    lfx = "\\1a&H00&\\1c&HF439F3&\\3a&H00&\\3c&HFD52FC&"
		l.text= string.format("{\\be1\\fad(0,100)"..fx..""..fx1.."\\shad0\\bord0"..lfx.."\\move(%d,%d,%d,%d)}",x,y,x+m,y+w) .. char
                                    l.layer=2
		subs.append(l) 


--------------------------------------------
elseif line.actor == "oran" then
--------------------------------------------

		l.start_time=line.start_time-250 + syl.i*50
		l.end_time=line.start_time + syl.start_time
                                    fx = "\\an5\\t(50,250,\\fscy135)\\t(250,485,\\fscy100)"

		l.text= string.format("{\\fad(100,0)"..fx.."\\bord4\\shad0\\blur4\\3a&H30&\\1a&HFF&\\3c&H3ABBF8&\\move(%d,%d,%d,%d,0,490)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 	

		l.text= string.format("{\\fad(100,0)"..fx.."\\bord2\\1a&HFF&\\3a&H20&\\shad0\\be2\\3c&H000000&\\move(%d,%d,%d,%d,0,490)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 

                                    lfx = "\\1c&H3ABBF8&"
		l.text= string.format("{\\be1\\fad(0,0)"..fx.."\\shad0\\bord0"..lfx.."\\move(%d,%d,%d,%d,0,490)}",x,y,x,y) .. char
                                    l.layer=2
		subs.append(l) 	

                                    -----------------------------------------------------------------------------------------

		l.start_time=line.start_time+ syl.start_time
		l.end_time=line.end_time  +50 + syl.i*50
                                    fx = "\\an7\\t(50,250,\\fscy135)\\t(250,485,\\fscy100)"

		l.text= string.format("{\\an5\\fad(0,150)\\bord4\\shad0\\blur4\\3a&H30&\\1a&HFF&\\3c&H3ABBF8&\\move(%d,%d,%d,%d)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 	

		l.text= string.format("{\\an5\\fad(0,150)\\bord2\\1a&HFF&\\shad0\\3a&H30&\\be2\\3c&H000000&\\move(%d,%d,%d,%d)}",x,y,x,y) .. char
                                    l.layer=2
		subs.append(l) 

                                    lfx = "\\1c&HFFFFFF&"
		l.text= string.format("{\\an5\\fad(0,150)\\shad1\\blur1\\bord0"..lfx.."\\move(%d,%d,%d,%d)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 

                                    -----------------------------------------------------------------------------------------

		l.start_time=line.start_time + syl.start_time
		l.end_time=line.start_time + syl.start_time + syl.duration/4 + 500
                                    fx = "\\an5"
	
		l.text= string.format("{\\fad(0,100)"..fx..""..fx1.."\\bord2\\1a&HFF&\\3a&H20&\\shad0\\be2\\3c&H000000&\\move(%d,%d,%d,%d)}",x,y,x+m,y+w) .. char
                                    l.layer=2
		subs.append(l) 

                                    lfx =  "\\1c&H3ABBF8&"
		l.text= string.format("{\\be1\\fad(0,100)"..fx..""..fx1.."\\shad0\\bord0"..lfx.."\\move(%d,%d,%d,%d)}",x,y,x+m,y+w) .. char
                                    l.layer=2
		subs.append(l) 


--------------------------------------------
elseif line.actor == "blu" then
--------------------------------------------


		l.start_time=line.start_time-250 + syl.i*50
		l.end_time=line.start_time + syl.start_time
                                    fx = "\\an5\\t(50,250,\\fscy135)\\t(250,485,\\fscy100)"

		l.text= string.format("{\\fad(100,0)"..fx.."\\bord4\\shad0\\blur4\\1a&HFF&\\3c&HF0BF6D&\\move(%d,%d,%d,%d,0,490)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 	

		l.text= string.format("{\\fad(100,0)"..fx.."\\bord2\\1a&HFF&\\3a&H20&\\shad0\\be2\\3c&H000000&\\move(%d,%d,%d,%d,0,490)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 

                                    lfx = "\\1c&HD8DF79&"
		l.text= string.format("{\\be1\\fad(100,0)"..fx.."\\shad0\\bord0"..lfx.."\\move(%d,%d,%d,%d,0,490)}",x,y,x,y) .. char
                                    l.layer=2
		subs.append(l) 	

                                    -----------------------------------------------------------------------------------------

		l.start_time=line.start_time+ syl.start_time
		l.end_time=line.end_time  +50 + syl.i*50
                                    fx = "\\an7\\t(50,250,\\fscy135)\\t(250,485,\\fscy100)"

		l.text= string.format("{\\an5\\fad(0,150)\\bord4\\shad0\\blur4\\1a&HFF&\\3c&HF0BF6D&\\move(%d,%d,%d,%d)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 	

		l.text= string.format("{\\an5\\fad(0,150)\\bord2\\1a&HFF&\\shad0\\3a&H30&\\be2\\3c&H000000&\\move(%d,%d,%d,%d)}",x,y,x,y) .. char
                                    l.layer=2
		subs.append(l) 

                                    lfx = "\\1c&HFFFFFF&"
		l.text= string.format("{\\an5\\fad(0,150)\\shad1\\blur1\\bord0"..lfx.."\\move(%d,%d,%d,%d)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 

                                    -----------------------------------------------------------------------------------------

		l.start_time=line.start_time + syl.start_time
		l.end_time=line.start_time + syl.start_time + syl.duration/4 + 500
                                    fx = "\\an5"
	
		l.text= string.format("{\\fad(0,100)"..fx..""..fx1.."\\bord2\\1a&HFF&\\3a&H20&\\shad0\\be2\\3c&H000000&\\move(%d,%d,%d,%d)}",x,y,x+m,y+w) .. char
                                    l.layer=2
		subs.append(l) 

                                    lfx = "\\1c&HD8DF79&"
		l.text= string.format("{\\be1\\fad(0,100)"..fx..""..fx1.."\\shad0\\bord0"..lfx.."\\move(%d,%d,%d,%d)}",x,y,x+m,y+w) .. char
                                    l.layer=2
		subs.append(l) 

--------------------------------------------
elseif line.actor == "yell" then
--------------------------------------------


		l.start_time=line.start_time-250 + syl.i*50
		l.end_time=line.start_time + syl.start_time
                                    fx = "\\an5\\t(50,250,\\fscy135)\\t(250,485,\\fscy100)"

		l.text= string.format("{\\fad(100,0)"..fx.."\\bord4\\shad0\\blur4\\1a&HFF&\\3c&H33FFFF&\\move(%d,%d,%d,%d,0,490)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 	

		l.text= string.format("{\\fad(100,0)"..fx.."\\bord2\\1a&HFF&\\3a&H20&\\shad0\\be2\\3c&H000000&\\move(%d,%d,%d,%d,0,490)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 

                                    lfx = "\\1c&H33FFFF&"
		l.text= string.format("{\\be1\\fad(100,0)"..fx.."\\shad0\\bord0"..lfx.."\\move(%d,%d,%d,%d,0,490)}",x,y,x,y) .. char
                                    l.layer=2
		subs.append(l) 	

                                    -----------------------------------------------------------------------------------------

		l.start_time=line.start_time+ syl.start_time
		l.end_time=line.end_time  +50 + syl.i*50
                                    fx = "\\an7\\t(50,250,\\fscy135)\\t(250,485,\\fscy100)"

		l.text= string.format("{\\an5\\fad(0,150)\\bord4\\shad0\\blur4\\1a&HFF&\\3c&H33FFFF&\\move(%d,%d,%d,%d)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 	

		l.text= string.format("{\\an5\\fad(0,150)\\bord2\\1a&HFF&\\shad0\\3a&H310&\\be2\\3c&H000000&\\move(%d,%d,%d,%d)}",x,y,x,y) .. char
                                    l.layer=2
		subs.append(l) 

                                    lfx = "\\1c&HFFFFFF&"
		l.text= string.format("{\\an5\\fad(0,150)\\shad1\\blur1\\bord0"..lfx.."\\move(%d,%d,%d,%d)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 

                                    -----------------------------------------------------------------------------------------

		l.start_time=line.start_time + syl.start_time
		l.end_time=line.start_time + syl.start_time + syl.duration/4 + 500
                                    fx = "\\an5"
	
		l.text= string.format("{\\fad(0,100)"..fx..""..fx1.."\\bord2\\1a&HFF&\\3a&H20&\\shad0\\be2\\3c&H000000&\\move(%d,%d,%d,%d)}",x,y,x+m,y+w) .. char
                                    l.layer=2
		subs.append(l) 

                                    lfx = "\\1c&H33FFFF&"
		l.text= string.format("{\\be1\\fad(0,100)"..fx..""..fx1.."\\shad0\\bord0"..lfx.."\\move(%d,%d,%d,%d)}",x,y,x+m,y+w) .. char
                                    l.layer=2
		subs.append(l) 

--------------------------------------------
elseif line.actor == "blu-w" then
--------------------------------------------


		l.start_time=line.start_time-250 + syl.i*50
		l.end_time=line.start_time + syl.start_time
                                    fx = "\\an5\\t(50,250,\\fscy135)\\t(250,485,\\fscy100)"

		l.text= string.format("{\\fad(100,0)"..fx.."\\bord5\\shad0\\blur4\\1a&HFF&\\3c&HFEFF60&\\move(%d,%d,%d,%d,0,490)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 	

		l.text= string.format("{\\fad(100,0)"..fx.."\\bord2\\1a&HFF&\\3a&H20&\\shad0\\be2\\3c&H000000&\\move(%d,%d,%d,%d,0,490)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 

                                    lfx = "\\1c&HFEFF60&"
		l.text= string.format("{\\be1\\fad(100,0)"..fx.."\\shad0\\bord0"..lfx.."\\move(%d,%d,%d,%d,0,490)}",x,y,x,y) .. char
                                    l.layer=2
		subs.append(l) 	

                                    -----------------------------------------------------------------------------------------

		l.start_time=line.start_time+ syl.start_time
		l.end_time=line.end_time  +50 + syl.i*50
                                    fx = "\\an7\\t(50,250,\\fscy135)\\t(250,485,\\fscy100)"

		l.text= string.format("{\\an5\\fad(0,150)\\bord4\\shad0\\blur4\\1a&HFF&\\3c&HFEFF60&\\move(%d,%d,%d,%d)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 	

		l.text= string.format("{\\an5\\fad(0,150)\\bord2\\1a&HFF&\\shad0\\3a&H10&\\be2\\3c&H000000&\\move(%d,%d,%d,%d)}",x,y,x,y) .. char
                                    l.layer=2
		subs.append(l) 

                                    lfx = "\\1c&HFFFFFF&"
		l.text= string.format("{\\an5\\fad(0,150)\\shad1\\blur1\\bord0"..lfx.."\\move(%d,%d,%d,%d)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 

                                    -----------------------------------------------------------------------------------------

		l.start_time=line.start_time + syl.start_time
		l.end_time=line.start_time + syl.start_time + syl.duration/4 + 500
                                    fx = "\\an5"
	
		l.text= string.format("{\\fad(0,100)"..fx..""..fx1.."\\bord2\\1a&HFF&\\3a&H20&\\shad0\\be2\\3c&H000000&\\move(%d,%d,%d,%d)}",x,y,x+m,y+w) .. char
                                    l.layer=2
		subs.append(l) 

                                    lfx = "\\1c&HFEFF60&"
		l.text= string.format("{\\be1\\fad(0,100)"..fx..""..fx1.."\\shad0\\bord0"..lfx.."\\move(%d,%d,%d,%d)}",x,y,x+m,y+w) .. char
                                    l.layer=2
		subs.append(l) 


--------------------------------------------
elseif line.actor == "red" then
--------------------------------------------


		l.start_time=line.start_time-250 + syl.i*50
		l.end_time=line.start_time + syl.start_time
                                    fx = "\\an5\\t(50,250,\\fscy135)\\t(250,485,\\fscy100)"

		l.text= string.format("{\\fad(100,0)"..fx.."\\bord5\\shad0\\blur4\\1a&HFF&\\3c&H4517A3&\\move(%d,%d,%d,%d,0,490)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 	

		l.text= string.format("{\\fad(100,0)"..fx.."\\bord2\\1a&HFF&\\3a&H20&\\shad0\\be2\\3c&H000000&\\move(%d,%d,%d,%d,0,490)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 

                                    lfx = "\\1c&H541ACB&"
		l.text= string.format("{\\be1\\fad(100,0)"..fx.."\\shad0\\bord0"..lfx.."\\move(%d,%d,%d,%d,0,490)}",x,y,x,y) .. char
                                    l.layer=2
		subs.append(l) 	

                                    -----------------------------------------------------------------------------------------

		l.start_time=line.start_time+ syl.start_time
		l.end_time=line.end_time  +50 + syl.i*50
                                    fx = "\\an7\\t(50,250,\\fscy135)\\t(250,485,\\fscy100)"

		l.text= string.format("{\\an5\\fad(0,150)\\bord4\\shad0\\blur4\\1a&HFF&\\3c&H4517A3&\\move(%d,%d,%d,%d)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 	

		l.text= string.format("{\\an5\\fad(0,150)\\bord2\\1a&HFF&\\shad0\\3a&H10&\\be2\\3c&H000000&\\move(%d,%d,%d,%d)}",x,y,x,y) .. char
                                    l.layer=2
		subs.append(l) 

                                    lfx = "\\1c&HFFFFFF&"
		l.text= string.format("{\\an5\\fad(0,150)\\shad1\\blur1\\bord0"..lfx.."\\move(%d,%d,%d,%d)}",x,y,x,y) .. char
                                    l.layer=1
		subs.append(l) 

                                    -----------------------------------------------------------------------------------------

		l.start_time=line.start_time + syl.start_time
		l.end_time=line.start_time + syl.start_time + syl.duration/4 + 500
                                    fx = "\\an5"
	
		l.text= string.format("{\\fad(0,100)"..fx..""..fx1.."\\bord2\\1a&HFF&\\3a&H20&\\shad0\\be2\\3c&H000000&\\move(%d,%d,%d,%d)}",x,y,x+m,y+w) .. char
                                    l.layer=2
		subs.append(l) 

                                    lfx = "\\1c&H541ACB&"
		l.text= string.format("{\\be1\\fad(0,100)"..fx..""..fx1.."\\shad0\\bord0"..lfx.."\\move(%d,%d,%d,%d)}",x,y,x+m,y+w) .. char
                                    l.layer=2
		subs.append(l) 

--------------------------------------------
elseif line.actor == "color" then
--------------------------------------------

	local l = table.copy(line)
	local x = line.left + syl.center
	local y = line.middle
                  local char = syl.text



                  color = {"&H3ABBF8&","&HD8DF79&","&H33FFFF&","&HFEFF60&","&H541ACB&"}
                  cr = color[math.random(1,5)]

		l.start_time=line.start_time-250 + syl.i*50
		l.end_time=line.start_time + syl.start_time
                                    fx = "\\an5\\t(50,250,\\fscy135)\\t(250,485,\\fscy100)"

		l.text= string.format("{\\fad(100,0)"..fx.."\\bord5\\shad0\\blur4\\1a&HFF&\\3c"..cr.."\\move(%d,%d,%d,%d,0,490)}",x,y,x,y) .. char
                                    l.layer=2
		subs.append(l) 	

		l.text= string.format("{\\fad(100,0)"..fx.."\\bord2\\1a&HFF&\\3a&H20&\\shad0\\be2\\3c&H000000&\\move(%d,%d,%d,%d,0,490)}",x,y,x,y) .. char
                                    l.layer=2
		subs.append(l) 

                                    lfx = "\\1c"..cr..""
		l.text= string.format("{\\be1\\fad(100,0)"..fx.."\\shad0\\bord0"..lfx.."\\move(%d,%d,%d,%d,0,490)}",x,y,x,y) .. char
                                    l.layer=2
		subs.append(l) 	

                                    -----------------------------------------------------------------------------------------

		l.start_time=line.start_time+ syl.start_time
		l.end_time=line.end_time  +50 + syl.i*50
                                    fx = "\\an7\\t(50,250,\\fscy135)\\t(250,485,\\fscy100)"

                   color2 = {"&H046A9F&","&H757C15&","&H02A3A5&","&HA0A311&","&H330B85&"}
                   cr2 = color2[math.random(1,5)]


		l.text= string.format("{\\an5\\fad(0,150)\\bord4\\shad0\\blur4\\1a&HFF&\\3c"..cr.."\\move(%d,%d,%d,%d)}",x,y,x,y) .. char
                                    l.layer=2
		subs.append(l) 	

		l.text= string.format("{\\an5\\fad(0,150)\\bord2\\1a&HFF&\\shad0\\3a&H10&\\be2\\3c&H000000&\\move(%d,%d,%d,%d)}",x,y,x,y) .. char
                                    l.layer=3
		subs.append(l) 

                                    lfx = "\\1c&HFFFFFF&"
		l.text= string.format("{\\an5\\fad(0,150)\\shad1\\blur1\\bord0"..lfx.."\\move(%d,%d,%d,%d)}",x,y,x,y) .. char
                                    l.layer=2
		subs.append(l) 

                                    -----------------------------------------------------------------------------------------

		l.start_time=line.start_time + syl.start_time
		l.end_time=line.start_time + syl.start_time + syl.duration/4 + 500
                                    fx = "\\an5"

		l.text= string.format("{\\fad(0,100)"..fx..""..fx1.."\\bord2\\1a&HFF&\\3a&H20&\\shad0\\be2\\3c&H000000&\\move(%d,%d,%d,%d)}",x,y,x+m,y+w) .. char
                                    l.layer=3
		subs.append(l) 

                                    lfx = "\\1c"..cr..""
		l.text= string.format("{\\be1\\fad(0,100)"..fx..""..fx1.."\\shad0\\bord0"..lfx.."\\move(%d,%d,%d,%d)}",x,y,x+m,y+w) .. char
                                    l.layer=3
		subs.append(l) 

end

 end
 
  
	end
	end
function macro_load(subs,config)
	aegisub.progress.set(0)
	aegisub.progress.title(script_name)
	local meta, styles = karaskel.collect_head(subs)
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do	

		aegisub.progress.task("Applying Script - تطبيق السكربت")
		aegisub.progress.set((ai-1) / maxai*100)
                                           if aegisub.progress.is_cancelled()  then  
                                                               error("User cancelled - تم إلغاء التطبيق")
                                           end

		local linex = subs[i]
		if not linex.comment  and linex.class == "dialogue"  then
 		linex.effect = "UniveFX"  karaskel.preproc_line(subs, meta, styles, linex)
			Char_FX(subs, meta, linex, styles,config)		
			linex.comment = true
			linex.effect = "Unshow"
			subs[i] = linex
			else
			i = i + 1 
		end

                                           if #subs <= 5 then  ai = ai+ 10
		       elseif #subs > 5 then  ai = ai + 5
                                           end
	end
                    aegisub.progress.task("Finished - انتهـى")
                aegisub.progress.set(100)
        aegisub.set_undo_point(script_name)
end

aegisub.register_macro(script_name, script_description, macro_load)