 

script_name = "Naruto fxs"
script_description = "Naruto the movie Fxs"
script_author = "alkoon"
script_version = "1.2"

 

include("karaskel.lua")
include("zheolib.lua")

           function frames(starts, ends, frame_time)
	if type(starts) ~= "number" or type(ends) ~= "number" or type(frame_time) ~= "number" or frame_time <= 0 then
		error("number, number and number expected", 2)
	end

	local cur_start_time, i, n = starts, 0, math.ceil((ends - starts) / frame_time)
	local function next_frame()
		if cur_start_time >= ends then
			return nil
		end
		local return_start_time = cur_start_time
		local return_end_time = return_start_time + frame_time <= ends and return_start_time + frame_time or ends
		cur_start_time = return_end_time
		i = i + 1
		return return_start_time, return_end_time, i, n
	end
	return next_frame
            end
 

function do_fx(subs, meta, styles, line)
for k = 1, line.kara.n do
local syl = line.kara[k] 
local l = table.copy(line)

                         local x = line.left + syl.center
                         local y = line.middle

---------- ( SAI ) ------------
if line.actor == "1" then
 

	     l.start_time = line.start_time  -400+syl.i*40
	     l.end_time = line.start_time +syl.start_time
	     local movex = string.format("{\\an5\\fad(150,0)\\be1\\1c&H000000&\\shad1\\4c&Hffffff&\\bord2\\3c&H000000&\\move(%d,%d,%d,%d,0,350)}", x , y+25 , x , y)
                         l.text = movex .. syl.text 
	     l.layer = 1
	     subs.append(l)

	     l.start_time = line.start_time  +syl.start_time
	     l.end_time = line.end_time+ 200 
	     local movex = string.format("{\\an5\\be1\\1c&Hffffff&\\shad1\\4c&Hffffff&\\bord2\\3c&H000000&\\move(%d,%d,%d,%d,0,350)}", x , y , x , y)
                         l.text = movex .. syl.text 
	     l.layer = 1
	     subs.append(l)

	     local dist = 1
	     local loops = (line.width/2)/dist + 5

	     for j =1, loops do
	     local posy = y - 45 + (j)*dist
	     local posx = meta.res_x
	     local dur = syl.duration
	     l.start_time = line.start_time +syl.start_time --+(j/loops)*dur
	     l.end_time = l.start_time +syl.duration +100 --+(j/loops)*dur
	     local linefx = string.format("{\\an5\\fad(0,100)\\bord0\\shad0\\be1\\1c&H000000&}")
	     local movex = string.format("{\\an5\\move(%d,%d,%d,%d)\\clip(%d,%d,%d,%d)\\t(%d,%d,\\fscx100\\blur3)}", x , y , x +math.random(-40,40) , y , 0 , posy , posx+10-2 + (j)*dist , posy+dist ,10,dur )
                         l.text = linefx .. movex .. syl.text_stripped
	     l.layer = 1

	     subs.append(l)
	     end		
 
 	     local dist = 1
	     local loops = (line.width/4)/dist
	     for j =1, loops do

	     local posy = y - 35+ (j)*dist
	     local posx = meta.res_x
	     l.start_time = line.end_time  +200
	     l.end_time = line.end_time  + 750
                         rand = math.random(-30,30)
	     local movex = string.format("{\\fad(0,150)\\an5\\be2\\1c&Hffffff&\\3c&H000000&\\move(%d,%d,%d,%d,60,500)\\clip(%d,%d,%d,%d)\\t(\\clip(%d,%d,%d,%d))}", x , y , x ,y+rand, 0 , posy , posx+10-2 + (j)*dist , posy+dist, 0 , posy+rand , posx+10-2 + (j)*dist , posy+dist+rand  )
                         l.text = movex .. syl.text 
	     l.layer = 1
	     subs.append(l)

	     end	

------ (Copys of Naruto)-------
elseif line.actor == "2" then



		      if  x <= line.left + line.width/2  then 
		               posx2 = x - 50
		               posy2 = y 
		      elseif x >=  line.left + line.width/2 then
		               posx2 = x + 50
		               posy2 = y 
		      end

	     l.start_time = line.start_time  -500 + syl.i*40
	     l.end_time = line.start_time  + syl.start_time
	     local movex = string.format("{\\an5\\fad(150,0)\\move(%d,%d,%d,%d,0,300)}", x , y , x , y)
                         l.text = movex .. syl.text 
	     l.layer = 1
	     subs.append(l)
 
 
		cc = "\\1c&H4297EE&"
 
		local l = table.copy(line)
		l.start_time = line.start_time+ syl.start_time
		l.end_time = line.start_time  + syl.start_time + syl.duration +100
		l.text = string.format("{\\be2\\fad(0,100)\\3c&H000000&"..cc.."\\bord2\\an5\\t(\\fscx140\\fscy140)\\move(%d,%d,%d,%d)}", x,y,x,y )..syl.text
		l.layer=3
		subs.append(l)

                                        rn = math.random(90,110)
		local l = table.copy(line)
                                        dr = syl.duration 
                                        for j = 0, 5 do
		l.start_time = line.start_time+ syl.start_time + math.random(-200,200)
		l.end_time = line.start_time  + syl.start_time + 100 + math.random(100,syl.duration)
		l.text = string.format("{\\be2\\fad(50,100)\\bord1"..cc.."\\an5\\fscx40\\fscy40\\t(0,"..dr/(2)..",\\fscx"..rn.."\\fscy"..rn..")\\t("..dr/(2)..","..dr..",\\fscx40\\fscy40)\\pos(%d,%d)}", x+math.random(-35,35),y+math.random(-35,35))..syl.text
		l.layer=0
		subs.append(l)
                                       end
   
------ (Rasen Shurekn Orang)-------
elseif line.actor == "3" then

	 local syllable = syl
                     if syl.text_stripped == " " or syl.text_stripped == ""  then line.comment = false else
                                               posx, posy =  x, y
                                               local x1 = x + syl.width/2
                                               local x2 = x - syl.width/2
                                               local roz =200*(math.floor(syl.duration)*150)


		                     l.start_time = line.start_time  - 290
		                     l.end_time =  line.start_time + syllable.start_time 
		                     l.text = string.format("{\\an5\\bord1.5\\be2.5\\fad(100,0)\\1c&Hffffff&\\3c&H5A5263&\\move(%d,%d,%d,%d,0,280)}",x+math.random(-50,50),posy,x,posy).. syl.text
		                     l.layer=2
		                    subs.append(l) 

		                     l.start_time = line.start_time + syllable.start_time 
		                     l.end_time =  line.start_time + syllable.end_time   
		                     l.text = string.format("{\\an5\\fscx70\\fscy70\\t(\\frz-"..roz..")\\1c&H6CEBF6&\\3c&H15A6F9&\\bord3\\blur4\\3&HCC&\\fnAncient Weapons\\fry180\\move(%d,%d,%d,%d)}h",x1,posy+2,x2,posy+2)
		                     l.layer=2
		                     subs.append(l) 

		                     l.start_time = line.start_time + syllable.start_time 
		                     l.end_time =  line.start_time + syllable.end_time   
		                     l.text = string.format("{\\an5\\fscx70\\fscy70\\frz60\\t(\\frz-"..roz..")\\1c&H6CEBF6&\\3c&H15A6F9&\\bord3\\blur4\\3&HCC&\\fnAncient Weapons\\fry180\\move(%d,%d,%d,%d)}h",x1,posy+2,x2,posy+2)
		                     l.layer=2
		                     subs.append(l) 

                                                               sw = syl.width /2 + 10
                                                               local dist = 1	--|| UP \ Unmove ||--
                                                               j = syl.width + 10  

                                                               for loop =1,  j do 	
		                                       pos_x =  posx  - (loop - sw) 
		                                       l.start_time = line.start_time + syllable.start_time 
		                                       l.end_time =  line.start_time + syllable.end_time + ((loop/j)-1)*syl.duration  
		                                       l.text = string.format("{\\an5\\bord1.5\\be2.5\\1c&Hffffff&\\3c&H5A5263&\\move(%d,%d,%d,%d)\\clip(%d,%d,%d,%d)}",posx,posy,posx,posy,  pos_x, posy-syl.height/2-12, pos_x +dist , posy+(syl.height/6)-(14) ) ..  syl.text_stripped 
		                                       l.layer=2
		                                       subs.append(l) 
                                                                end
 

                                                                                  	--|| UP \ Move ||--	 
                                                                for loop =1,  j   do 		              
		                                       poy = posy -20
		                                       pos_x =  posx  - (loop - sw) 
		                                       l.start_time = line.start_time + syllable.end_time  + ((loop/j)-1)*syl.duration  
		                                       l.end_time =   line.start_time + syllable.end_time + ((loop/j)-1)*syl.duration  +400
                                                                               clp1 = string.format("{\\clip(%d,%d,%d,%d)",pos_x, posy-syl.height/2-(12), pos_x +dist , posy+(syl.height/6)-(14))
                                                                               clp2 = string.format("%s\\t(\\clip(%d,%d,%d,%d)}",clp1, pos_x, posy-syl.height/6-(14)-(20), pos_x +dist , posy+(syl.height/6)-(14)-(20))
		                                       l.text = string.format("{\\an5\\bord1.5\\fad(0,".. ((loop/j))*syl.duration/(1.4)..")\\be2.5\\1c&Hffffff&\\3c&H5A5263&\\t(\\1c&H30CAFD&)\\move(%d,%d,%d,%d)}%s", posx,posy,posx,poy, clp2) .. syllable.text_stripped
		                                       l.layer=2
		                                      subs.append(l) 
                                                                end
 

                                                                ----------------------------------------------------------------------------------
 
                                                                for loop =1,  j do 	
		                                       pos_x =  posx - (loop - sw )
		                                       l.start_time = line.start_time + syllable.start_time 
		                                       l.end_time =  line.start_time + syllable.end_time + ((loop/j)-1)*syl.duration  
		                                       l.text = string.format("{\\an5\\bord1.5\\be2.5\\1c&Hffffff&\\3c&H5A5263&\\move(%d,%d,%d,%d)\\clip(%d,%d,%d,%d)}",posx,posy,posx,posy,  pos_x, posy-(syl.height/20)+(16), pos_x +dist , posy+syl.height) ..  syl.text_stripped 
		                                       l.layer=2
		                                      subs.append(l) 
                                                                end
 	 
                                                                for loop =1, j  do 		              
		                                       poy = posy + 20
		                                       pos_x =  posx  - (loop - sw) 
		                                       l.start_time = line.start_time + syllable.end_time  + ((loop/j)-1)*syl.duration  
		                                       l.end_time =   line.start_time + syllable.end_time +400 + ((loop/j)-1)*syl.duration  
                                                                              clp1 = string.format("{\\clip(%d,%d,%d,%d)",pos_x, posy-(syl.height/20)+(16), pos_x +dist , posy+syl.height)
                                                                              clp2 = string.format("%s\\t(\\clip(%d,%d,%d,%d)}",clp1, pos_x, posy-(syl.height/20)+(16)+(20), pos_x +dist , posy+syl.height+20)
		                                       l.text = string.format("{\\an5\\bord1\\be2\\3c&H5A5263&\\fad(0,".. ((loop/j))*syl.duration/(1.4)..")\\1c&Hffffff&\\t(\\1c&H30CAFD&)\\move(%d,%d,%d,%d)}%s", posx,posy,posx,poy, clp2) .. syllable.text_stripped
		                                       l.layer=2
		                                      subs.append(l) 
                                                                end
                    end

------ (Rasen Blue)-------
elseif line.actor == "4" then

                                               posx, posy =  x, y
                                               local x1 = x + syl.width/2
                                               local x2 = x - syl.width/2
 
		l.start_time = line.start_time + syl.start_time 
		l.end_time =  line.start_time + syl.end_time   
		l.text = string.format("{\\an5\\fscx130\\fscy130\\1a&H60&\\1c&HE5AD60&\\3a&H%02X&\\bord15\\blur7\\shad0\\3c&HBE832B&\\fnCrop Circle Dingbats\\move(%d,%d,%d,%d)}0",150,x1+2,posy,x2+2,posy)
		l.layer=0
		subs.append(l) 


		local l = table.copy(line)
		l.start_time = line.start_time -500 + syl.i*40
		l.end_time =line.end_time   + 150 + syl.i*40
		l.text = string.format("{\\be2\\bord2\\fad(150,150)\\an5\\1c&HF0EFED&\\move(%d,%d,%d,%d,0,450)}", x,y-35,x,y )..syl.text
		l.layer=5
		subs.append(l)


		for start_t, end_t, i, n in frames(line.start_time + syl.start_time, line.start_time + syl.end_time, 31.72 ) do
			l.start_time = start_t
			l.end_time = end_t
			syl.x, syl.y = x+ math.random(-3,3), y +math.random(-3,3)
			l.text = string.format("{\\an5\\fad(0,%d)\\1c&HEECA9E&\\alpha&H30&\\be2\\bord2\\t(\\fscx140\\fscy140)\\move(%d,%d,%d,%d)}",math.random(150,200)/n, x,y, syl.x , syl.y ) .. syl.text
			l.layer=5
			subs.append(l)
		end


		function sil()
			silaba = ""..syl.text_stripped..""
		       return silaba
		end
 
			angulo = 0		
			angulox=math.random(0,20)
			anguloy=math.random(0,20)
			for zz=0,200 do
				local l = table.copy(line)
			
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				inicio=0
				DURACION =syl.duration
				fin=(DURACION)

				Line_Form=''
				angulot=angulo

		 		rr = math.random(100,120)
				textt= string.format("\\frz%d)",angulo) 
				inicio=fin
				fin=fin+(DURACION)
				angulot=angulot+4
				Line_Form=Line_Form..textt
c1 = "\\1c&HFFFFFF&"
				l.text = "{"..an(5)..move(x+syl.width/2, y, x-syl.width/2, y)..shad(0)..alpha('40')..fscxy(rr)..bord(0)..c1..Line_Form.."}"..p(1,'m 0 0 l 50 49 l 100 0 l 51 50 l 100 100 l 50 51 l 0 100 l 49 50  ') 
				l.layer=2
				subs.append(l)
				angulo=angulo+ 4 
			end
		 

			angulo = 0		
			angulox=math.random(0,20)
			anguloy=math.random(0,20)
			for zz=0,200 do
				local l = table.copy(line)
			
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				inicio=0
				DURACION =syl.duration
				fin=(DURACION)

				Line_Form=''
				angulot=angulo

				textt= string.format("\\3c&HE5AD60&\\3a&Hf0&\\bord1\\blur2\\frz%d)",angulo) 
				inicio=fin
				fin=fin+(DURACION)
				angulot=angulot+4
				Line_Form=Line_Form..textt
c1 = "\\1c&HE5AD60&"
				l.text = "{"..an(5)..move(x+syl.width/2, y, x-syl.width/2, y)..shad(0)..fscxy(130)..c1..Line_Form.."}"..p(1,'m 0 0 l 50 49 l 100 0 l 51 50 l 100 100 l 50 51 l 0 100 l 49 50  ') 
				l.layer=1
				subs.append(l)
				angulo=angulo+ 4
		               end
     
------ (Kagi noui)-------
elseif line.actor == "5" then

		local l = table.copy(line)
		l.start_time = line.start_time -500 + syl.i*40
		l.end_time = line.start_time + syl.start_time
		l.text = string.format("{\\be2\\fad(150,0)\\1c&H778E47&\\3c&H000000&\\an5\\move(%d,%d,%d,%d)}", x,y,x,y )..syl.text
		l.layer=3
		subs.append(l)


		local l = table.copy(line)
		l.start_time =line.start_time + syl.start_time
		l.end_time = line.start_time + syl.start_time + syl.duration +50
		l.text = string.format("{\\be2\\fad(0,100)\\1c&H778E47&\\3c&H000000&\\an5\\t(\\fscx140\\fscy140)\\move(%d,%d,%d,%d)}", x,y,x,y )..syl.text
		l.layer=4
		subs.append(l)

		local l = table.copy(line)
		l.start_time =line.start_time + syl.start_time + syl.duration
		l.end_time = line.end_time +120
		l.text = string.format("{\\be2\\fad(0,100)\\1c&H778E47&\\3c&H000000&\\an5\\move(%d,%d,%d,%d)}", x,y,x,y )..syl.text
		l.layer=3
		subs.append(l)


	 	local shap = "{\\p2}m 2 0 b 9 0 9 10 2 10 b -5 10 -5 0 2 0 "		

	  	local y1, y2 = y+syl.height/2, y-syl.height/2
	  	local y3, y4 = y-syl.height/2, y+syl.height/2  
	  	local x1, x2 = x+syl.width/2, x-syl.width/2
	  	local x3, x4 = x+syl.width/2-16, x-syl.width/2+16
	  	loops = syl.height 

	  	local crclx = 360/loops 
	  	local radx = (x2-x1) /2
	  	local rady = (y2-y1) /2 
	  	local radx2 = (x4-x3) /1.8 
	  	local rady2 = (y4-y3) /2 

	  	for j=1, loops do

		     	local l=table.copy(line)
	                      	local csx = math.cos((crclx*j)*(math.pi/360))*radx
	                      	local csx2 = math.cos((crclx*j)*(math.pi/360))*radx2
	                       	local sny = math.sin((crclx*j)*(math.pi*2/360))*rady
	                       	local sny2 = math.sin((crclx*j)*(math.pi*2/360))*rady2
	                       	local posx, posy  = x+csx, y+sny 
	                       	local posx2, posy2  = x+csx2, y+sny2 
	                       	local rand =  math.random(-45,45)
                                         	local alfa =string.format("alpha&H%02X&",30) --#(15/sizft)-1
            	  	     	local sizft = (j/loops)
	  	     	l.start_time=line.start_time+syl.start_time- ((j/loops)-1)*syl.duration 
	  	     	l.end_time=line.start_time+syl.start_time - ((j/loops)-1)*syl.duration + 200
	  	     	tt = l.end_time - l.start_time
                                                      fs1 = 160
                                                      fss = 100
	  	     	local textfx = string.format("{\\an5\\shad1\\fad(0,100)\\bord0\\blur1\\1c&H000000&\\fscx%d\\fscy%d}",fs1,fs1)
	  	     	l.text= string.format("{\\t(\\t(%d,%d,\\fscx%d\\fscy%d)\\move(%f.01,%f.01,%f.01,%f.01,%d,%d)}",0,syl.duration+100,fss,fss,posx,posy,posx,posy, tt-600,tt+600) .. shap
                                         	l.text = textfx .. l.text
            	  	     	l.layer = 0 
	  	     	subs.append(l)
	
	  	     	local textfx = string.format("{\\an5\\shad1\\fad(0,100)\\bord0\\blur1\\1c&H000000&\\fscx%d\\fscy%d}",fs1,fs1)
	  	     	l.text= string.format("{\\t(\\t(%d,%d,\\fscx%d\\fscy%d)\\move(%f.01,%f.01,%f.01,%f.01,%d,%d)}",0,syl.duration+100,fss,fss,posx2,posy2,posx2,posy2, tt-600,tt+600) .. shap
                                         	l.text = textfx .. l.text
            	  	     	l.layer = 0 
	  	     	subs.append(l)
                      	end


---(Tsha Noura - Sakura)----
elseif line.actor == "6" then

		local l = table.copy(line)
		l.start_time = line.start_time -500 + syl.i*40
		l.end_time = line.start_time + syl.start_time
		l.text = string.format("{\\be2\\1c&H4F35B3&\\3c&H000000&\\bord2\\fad(150,0)\\an5\\move(%d,%d,%d,%d,0,450)}", x, y, x, y)..syl.text
		l.layer=3
		subs.append(l)

		px = 4
		for lopx=0, (syl.width/2 ) +20   do
			for lopy=0, (line.height  /2)  do
 
				local l = table.copy(line)
				l.start_time = line.start_time + syl.start_time
				l.end_time = line.start_time + syl.start_time + math.random(300,syl.duration + 300)
				local x =  line.right - syl.center
				local y = line.middle 
				posx = x + (lopx -25)*px
				posy = y + (lopy -20 )*px

                                   local randx  = math.cos(math.rad(lopx*math.random(-10,10) ))*math.random(-30,30) 
                                   local randy  = math.sin(math.rad(lopy*math.random(-10,10) ))*math.random(-30,30) 
                                                                        rand = math.random(-30,30)
				movex = string.format("{\\be2\\1c&H4F35B3&\\3c&H000000&\\bord2\\an5\\fad(0,100)\\move(%d,%d,%d,%d)", x, y,  x+randx,  y+randy)
				clipx = string.format("\\an5\\clip(%d,%d,%d,%d)\\t(\\clip(%d,%d,%d,%d))\\t(\\1c&H9E8CD9&)}" ,posx, posy, posx+px, posy+px,   posx+randx,posy+randy, posx+px+randx,posy+px+randy)
				l.text = movex .. clipx .. syl.text
				l.layer=3
				subs.append(l)
			end
		end


---(GARA)----
elseif line.actor == "7" then


	     l.start_time = line.start_time  -400+syl.i*40
	     l.end_time = line.start_time +syl.start_time
	     local movex = string.format("{\\an5\\fad(150,0)\\be1\\1c&H5D91B2&\\shad1\\4c&Hffffff&\\bord3\\3c&H282890&\\move(%d,%d,%d,%d,0,350)}", x , y+25 , x , y)
                         l.text = movex .. syl.text 
	     l.layer = 1
	     subs.append(l)

	     l.start_time = line.start_time  +syl.start_time
	     l.end_time = line.end_time+ 200 
	     local movex = string.format("{\\an5\\be1\\1c&Hffffff&\\shad1\\4c&Hffffff&\\bord3\\3c&H282890&\\move(%d,%d,%d,%d,0,350)}", x , y , x , y)
                         l.text = movex .. syl.text 
	     l.layer = 1
	     subs.append(l)

	     local dist = 1
	     local loops = (line.width/2)/dist + 5

	     for j =1, loops do
	     local posy = y - 45 + (j)*dist
	     local posx = meta.res_x
	     local dur = syl.duration
	     l.start_time = line.start_time +syl.start_time --+(j/loops)*dur
	     l.end_time = l.start_time +syl.duration +100 --+(j/loops)*dur
	     local linefx = string.format("{\\an5\\fad(0,100)\\bord0\\shad0\\be1\\1c&H5D91B2&}")
	     local movex = string.format("{\\an5\\move(%d,%d,%d,%d)\\clip(%d,%d,%d,%d)\\t(%d,%d,\\fscx100\\blur3)}", x , y , x +math.random(-40,40) , y , 0 , posy , posx+10-2 + (j)*dist , posy+dist ,10,dur )
                         l.text = linefx .. movex .. syl.text_stripped
	     l.layer = 1

	     subs.append(l)
	     end		
 
 	     local dist = 1
	     local loops = (line.width/4)/dist
	     for j =1, loops do

	     local posy = y - 35+ (j)*dist
	     local posx = meta.res_x
	     l.start_time = line.end_time  +200
	     l.end_time = line.end_time  + 650
                         rand = math.random(-40,40)
	     local movex = string.format("{\\fad(0,150)\\an5\\be2\\bord2\\1c&Hffffff&\\3c&H282890&\\move(%d,%d,%d,%d,60,500)\\clip(%d,%d,%d,%d)\\t(\\clip(%d,%d,%d,%d))}", x , y , x+rand ,y, 0 , posy , posx+10-2 + (j)*dist , posy+dist, 0 , posy , posx+10-2 + (j)*dist+rand , posy+dist  )
                         l.text = movex .. syl.text 
	     l.layer = 1
	     subs.append(l)

	     end	


---(Green)----
elseif line.actor == "8" then

		local l = table.copy(line)
		l.start_time = line.start_time -500 + syl.i*40
		l.end_time = line.start_time + syl.start_time
		l.text = string.format("{\\be2\\1c&H95B550&\\3c&H000000&\\bord2\\fad(150,0)\\an5\\move(%d,%d,%d,%d,0,450)}", x, y, x, y)..syl.text
		l.layer=3
		subs.append(l)

		px = 4
		for lopx=0, (syl.width/2 ) +20   do
			for lopy=0, (line.height  /2)  do
 
				local l = table.copy(line)
				l.start_time = line.start_time + syl.start_time
				l.end_time = line.start_time + syl.start_time + math.random(300,syl.duration + 300)
				local x =  line.right - syl.center
				local y = line.middle 
				posx = x + (lopx -25)*px
				posy = y + (lopy -20 )*px

                                   local randx  = math.cos(math.rad(lopx*math.random(-10,10) ))*math.random(-30,30) 
                                   local randy  = math.sin(math.rad(lopy*math.random(-10,10) ))*math.random(-30,30) 
                                                                        rand = math.random(-30,30)
				movex = string.format("{\\be2\\1c&H95B550&\\3c&H000000&\\bord2\\an5\\fad(0,100)\\move(%d,%d,%d,%d)", x, y,  x+randx,  y+randy)
				clipx = string.format("\\an5\\clip(%d,%d,%d,%d)\\t(\\clip(%d,%d,%d,%d))\\t(\\1c&H9E8CD9&)}" ,posx, posy, posx+px, posy+px,   posx+randx,posy+randy, posx+px+randx,posy+px+randy)
				l.text = movex .. clipx .. syl.text
				l.layer=3
				subs.append(l)
			end
		end

------------( Henata)-----------
elseif line.actor == "9" then

             		local pi = math.pi
             		local sin = math.sin
            		local cos = math.cos
 
		 
			sign_x = (-1)^(math.random(2)+syl.i)
			sign_y = (-1)^(math.random(4)-syl.i)
			scale_x = math.random(40,70)*meta.res_x/1280
			scale_y = math.random(20,50)*meta.res_x/1280
			Start = -800
			End = 0
			dur_imagen = 300
			aceleration = math.random(160,260)/100
		                  shape = "m 0 0 l 1 0 l 1 1 l 0 1 l 0 0 "
			angle = math.random(36)*10
			maxj = 4*(scale_x^2+scale_y^2)^0.5
			for j = 1, maxj do
				s_i = -pi/2
				s_f =  pi/2
					
				s = s_i + (s_f-s_i)*(j-1)/(maxj-1)
				x_s = sign_x*cos(3*s)
				y_s = sign_y*(sin(2*s)+cos(s))
					
				x_pos = math.floor((x+scale_x*x_s)*100)/100
				y_pos = math.floor((line.middle-scale_y*y_s)*100)/100
					
				ff = 600	
				rr = math.random(0,0)
				l = table.copy(line)
				l.effect = "curve fx"
				l.start_time = line.start_time + syl.start_time - (End-Start)*((maxj-j)/(maxj-1))^aceleration
				l.end_time = line.start_time + syl.start_time - (End-Start)*((maxj-j)/(maxj-1))^aceleration + dur_imagen
				l.dur = l.end_time - l.start_time
				l.text = string.format("{\\an5\\move(%s,%s,%s,%s)\\bord2\\1c&HEFA4B8&\\3c&HA7305B&\\3a&Hd0&\\shad0\\blur2\\fad(20,200)\\fscx"..ff.."\\fscy"..ff.."\\t(\\frz100)\\t(\\fscx100\\fscy100)\\p1\\org(%s,%s)\\fr%s}%s",x_pos,y_pos,x_pos,y_pos,x,y,angle,shape)
				if j < 0.86*maxj then
					l.layer = 0
				else
					l.layer = 3
				end
				subs.append(l)
			    end

		      if  x <= line.left + line.width/2  then 
		               posx2 = x - 50
		               posy2 = y 
		      elseif x >=  line.left + line.width/2 then
		               posx2 = x + 50
		               posy2 = y 
		      end

	     l.start_time = line.start_time  -300
	     l.end_time = line.start_time  + syl.start_time
	     local movex = string.format("{\\an5\\fad(150,0)\\1c&HE3E3E3&\\move(%d,%d,%d,%d,0,300)}", posx2 , y , x , y)
                         l.text = movex .. syl.text 
	     l.layer = 1
	     subs.append(l)

		for start_t, end_t, i, n in frames(line.start_time + syl.start_time, line.start_time + syl.end_time, 41.72 ) do
			l.start_time = start_t
			l.end_time = end_t
			syl.x, syl.y = x+ math.random(-3,3), y +math.random(-3,3)
			l.text = string.format("{\\an5\\fad(0,%d)\\1c&H8DA9BB&\\alpha&H60&\\be2\\bord2\\t(\\fscx130\\fscy130\\1c&HC1BDC0&)\\pos(%.3f,%.3f)}",math.random(150,200)/n, syl.x , syl.y ) .. syl.text
			l.layer=4
			subs.append(l)
		end

		for start_t, end_t, i, n in frames(line.start_time + syl.start_time, line.start_time + syl.end_time, 50 ) do
			l.start_time = start_t
			l.end_time = end_t
			syl.x, syl.y = x+ math.random(-3,3), y +math.random(-3,3)
			l.text = string.format("{\\an5\\fad(0,%d)\\1c&H8DA9BB&\\bord1\\t(\\fscx130\\fscy130)\\pos(%.3f,%.3f)}",math.random(100,150)/n, syl.x , syl.y ) .. syl.text
			l.layer=1
			subs.append(l)
		end

------------(Tensai)-----------
elseif line.actor == "10" then

                                   local circlx = "{\\1c&Hffffff&}m 5 0 b -2 0 -2 10 5 10 b 12 10 12 0 5 0 "
                                   local sp = "m 13 0 b 0 0 0 18 13 18 b 26 18 26 0 13 0 m 13 1 b 25 1 25 17 13 17 b 1 17 1 1 13 1 "
                                   local spm = "m 4 20 b 4 20 13 0 13 0 b 13 0 25 20 25 20 b 25 20 4 20 4 20 m 6 19 b 6 19 23 19 23 19 b 23 19 14 2 13 3 b 12 2 6 19 6 19  "

                                   local x = x  +13
                                   local y = y +25
                                   local dur = syl.duration


			l.start_time = line.start_time -250 
			l.end_time =  line.start_time+syl.start_time 
			l.text = string.format("{\\an5\\fad(200,0)\\1c&HF3FFCC&\\3c&H95AA57&\\3a&H50&\\be1\\bord2\\blur2\\shad1\\pos(%d,%d)}", x,y) .. syl.text
			l.layer = 3
		 	subs.append(l)

			l.start_time =  line.start_time+syl.start_time 
			l.end_time =  line.start_time+syl.start_time  + syl.duration  + 200
			l.text = string.format("{\\an5\\fad(0,100)\\1c&HF3FFCC&\\3c&H95AA57&\\3a&H50&\\be1\\bord2\\blur2\\shad1\\t(\\frz370)\\pos(%d,%d)}", x,y) .. syl.text
			l.layer = 3
		 	subs.append(l)
 

                                   l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(30,100)\\3a&H60&\\shad0\\blur17\\bord20\\fscx400\\fscy450\\t(\\fscx800\\fscy850)\\1c&HCCF8D0&\\3c&H699E48&\\p1}%s",x,y,x,y, sp)
                                   l.start_time = line.start_time+syl.start_time  
                                   l.end_time = line.start_time+syl.start_time  + dur  
                                   l.layer =0
                                   subs.append(l)
 
                    --# David binida function (Zheox)
                    function Curve(intpol, x_ini, y_ini,  x_int1, y_int1, x_int2, y_int2, x_fin, y_fin)
                    curvx1 = interpolate(intpol, x_ini, x_int1)
                    curvx2 = interpolate(intpol, curvx1, x_int2)
                    curvx3 = interpolate(intpol, curvx2, x_fin)
                    curvy1 = interpolate(intpol, y_ini, y_int1)
                    curvy2 = interpolate(intpol, curvy1, y_int2)
                    curvy3 = interpolate(intpol, curvy2, y_fin)
                    cur_x, cur_y = curvx3, curvy3
                    	return cur_x, cur_y
                    end

                    local circlx = "{\\fscx500\\fscy500}m 0 0 l 1 0 l 1 1 l 0 1 "
                    local x = x
                    local y = y

          local value = 500
          for j = 1, value do

          local pos_x = {}
          pos_x[1] = x  
          pos_x[2] = x  
          pos_x[3] = x   +math.sin(math.rad(j*50))*250
          pos_x[4] = x   

          local pos_y = {}
          pos_y[1] = y    
          pos_y[2] = y  
          pos_y[3] = y   +math.cos(math.rad(j*50))*250
          pos_y[4] = y  

                    tim = 1*(syl.duration/800)
                    tiem_1 = line.start_time+syl.start_time
                    tiem_2 =line.start_time+syl.start_time+ j*1.4
                    timex  = interpolate(j/value,tiem_1,tiem_2)

                    Curve(j/value,pos_x[1], pos_y[1] ,pos_x[2], pos_y[2] ,pos_x[3], pos_y[3] ,pos_x[4], pos_y[4] )
                    color = "&HFFFFFF&"
                    l.text = string.format("{\\an5\\move(%3.f,%3.f,%3.f,%3.f)\\bord3\\blur5\\shad0\\3a&HCC&\\1c&HCCF8D0&\\3c&H2E571B&\\p1}%s",cur_x,cur_y,cur_x,cur_y,circlx)
                    l.start_time = timex
                    l.end_time =  l.start_time+  syl.duration  
                    l.layer = 2
                    subs.append(l)
            end


---------(Rasenningan)-----------
elseif line.actor == "11" then

                                               posx, posy =  x, y
                                               local x1 = x + syl.width/2
                                               local x2 = x - syl.width/2
 
		l.start_time = line.start_time + syl.start_time 
		l.end_time =  line.start_time + syl.end_time   
		l.text = string.format("{\\an5\\fscx120\\fscy120\\1a&H40&\\1c&HBAF4FD&\\3a&H%02X&\\bord15\\blur7\\shad0\\3c&H0676DE&\\fnCrop Circle Dingbats\\move(%d,%d,%d,%d)}0",150,x1+2,posy,x2+2,posy)
		l.layer=0
		subs.append(l) 


		local l = table.copy(line)
		l.start_time = line.start_time -500 + syl.i*40
		l.end_time =line.end_time   + 150 + syl.i*40
		l.text = string.format("{\\be2\\bord3\\fad(150,150)\\an5\\1c&HF0EFED&\\3c&H316FF0&\\move(%d,%d,%d,%d,0,450)}", x,y-35,x,y )..syl.text
		l.layer=5
		subs.append(l)


		for start_t, end_t, i, n in frames(line.start_time + syl.start_time, line.start_time + syl.end_time, 31.72 ) do
			l.start_time = start_t
			l.end_time = end_t
			syl.x, syl.y = x+ math.random(-3,3), y +math.random(-3,3)
			l.text = string.format("{\\an5\\fad(0,%d)\\1c&HC0F1FC&\\3c&H257BF9&\\shad1\\4c&H0467CB&\\3a&H90&\\blur3\\bord3\\t(\\fscx140\\fscy140)\\move(%d,%d,%d,%d)}",math.random(150,200)/n, x,y, syl.x , syl.y ) .. syl.text
			l.layer=5
			subs.append(l)
		end


		function sil()
			silaba = ""..syl.text_stripped..""
		       return silaba
		end
 
			angulo = 0		
			angulox=math.random(0,20)
			anguloy=math.random(0,20)
			for zz=0,200 do
				local l = table.copy(line)
			
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				inicio=0
				DURACION =syl.duration
				fin=(DURACION)

				Line_Form=''
				angulot=angulo

		 		rr = math.random(90,110)
				textt= string.format("\\frz%d)",angulo) 
				inicio=fin
				fin=fin+(DURACION)
				angulot=angulot+4
				Line_Form=Line_Form..textt
c1 = "\\1c&HBAF4FD&"
				l.text = "{"..an(5)..move(x+syl.width/2, y, x-syl.width/2, y)..shad(0)..alpha('40')..fscxy(rr)..bord(0)..c1..Line_Form.."}"..p(1,'m 0 0 l 50 49 l 100 0 l 51 50 l 100 100 l 50 51 l 0 100 l 49 50  ') 
				l.layer=2
				subs.append(l)
				angulo=angulo+ 4 
			end
		 

			angulo = 0		
			angulox=math.random(0,20)
			anguloy=math.random(0,20)
			for zz=0,200 do
				local l = table.copy(line)
			
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time
				inicio=0
				DURACION =syl.duration
				fin=(DURACION)

				Line_Form=''
				angulot=angulo

				textt= string.format("\\3c&H0676DE&\\3a&Hf0&\\bord1\\blur2\\frz%d)",angulo) 
				inicio=fin
				fin=fin+(DURACION)
				angulot=angulot+4
				Line_Form=Line_Form..textt
c1 = "\\1c&H3EA1FC&"
				l.text = "{"..an(5)..move(x+syl.width/2, y, x-syl.width/2, y)..shad(0)..fscxy(120)..c1..Line_Form.."}"..p(1,'m 0 0 l 50 49 l 100 0 l 51 50 l 100 100 l 50 51 l 0 100 l 49 50  ') 
				l.layer=1
				subs.append(l)
				angulo=angulo+ 4
		               end
---------- ( SAI ) ------------
elseif line.actor == "12" then
 

	     l.start_time = line.start_time  -400+syl.i*40
	     l.end_time = line.start_time +syl.start_time
	     local movex = string.format("{\\an5\\fad(150,0)\\be1\\1c&HCBBAAC&\\shad1\\4c&Hffffff&\\bord2\\3c&H000000&\\move(%d,%d,%d,%d,0,350)}", x , y+25 , x , y)
                         l.text = movex .. syl.text 
	     l.layer = 1
	     subs.append(l)

	     l.start_time = line.start_time  +syl.start_time
	     l.end_time = line.end_time+ 200 
	     local movex = string.format("{\\an5\\be1\\1c&Hffffff&\\shad1\\4c&Hffffff&\\bord2\\3c&H000000&\\move(%d,%d,%d,%d,0,350)}", x , y , x , y)
                         l.text = movex .. syl.text 
	     l.layer = 1
	     subs.append(l)

	     local dist = 1
	     local loops = (line.width/2)/dist + 5

	     for j =1, loops do
	     local posy = y - 45 + (j)*dist
	     local posx = meta.res_x
	     local dur = syl.duration
	     l.start_time = line.start_time +syl.start_time --+(j/loops)*dur
	     l.end_time = l.start_time +syl.duration +100 --+(j/loops)*dur
	     local linefx = string.format("{\\an5\\fad(0,100)\\bord1\\shad0\\be1\\1c&HCBBAAC&}")
	     local movex = string.format("{\\an5\\move(%d,%d,%d,%d)\\clip(%d,%d,%d,%d)\\t(%d,%d,\\fscx100\\blur3)}", x , y , x +math.random(-40,40) , y , 0 , posy , posx+10-2 + (j)*dist , posy+dist ,10,dur )
                         l.text = linefx .. movex .. syl.text_stripped
	     l.layer = 1

	     subs.append(l)
	     end		
 
 	     local dist = 1
	     local loops = (line.width/4)/dist
	     for j =1, loops do

	     local posy = y - 35+ (j)*dist
	     local posx = meta.res_x
	     l.start_time = line.end_time  +200
	     l.end_time = line.end_time  + 750
                         rand = math.random(-30,30)
	     local movex = string.format("{\\fad(0,150)\\an5\\be2\\1c&Hffffff&\\3c&H000000&\\move(%d,%d,%d,%d,60,500)\\clip(%d,%d,%d,%d)\\t(\\clip(%d,%d,%d,%d))}", x , y , x ,y+rand, 0 , posy , posx+10-2 + (j)*dist , posy+dist, 0 , posy+rand , posx+10-2 + (j)*dist , posy+dist+rand  )
                         l.text = movex .. syl.text 
	     l.layer = 1
	     subs.append(l)

	     end	


elseif line.actor == "13" then

	
	     l.start_time = line.start_time  -250+syl.i*40
	     l.end_time = line.start_time +syl.start_time
	     local movex = string.format("{\\an5\\fad(100,0)\\be1\\1c&H70629E&\\shad1\\4c&Hffffff&\\bord2\\3c&H000000&\\move(%d,%d,%d,%d,0,240)}", x+math.random(-50,50) , y+math.random(-50,50) , x , y)
                         l.text = movex .. syl.text 
	     l.layer = 1
	     subs.append(l)

	     l.start_time = line.start_time +syl.start_time
	     l.end_time = line.start_time +syl.start_time+ syl.duration 
	     local movex = string.format("{\\an5\\be1\\1c&H70629E&\\t(\\fscx150\\fscy150\\1c&H4B76C5&)\\shad1\\4c&Hffffff&\\bord2\\3c&H000000&\\move(%d,%d,%d,%d)}", x , y , x+50 , y)
                         l.text = movex .. syl.text 
	     l.layer = 1
	     subs.append(l)
 

 	     l.start_time = line.start_time +syl.start_time+ syl.duration 
	     l.end_time = l.start_time  + 300
	     local movex = string.format("{\\an5\\be1\\fad(0,100)\\1c&H4B76C5&\\t(\\fscx50\\fscy50)\\shad1\\4c&Hffffff&\\bord2\\3c&H000000&\\pos(%d,%d)}", x+50 , y)
                         l.text = movex .. syl.text 
	     l.layer = 1
	     subs.append(l)



elseif line.actor == "14" then
 
		local l = table.copy(line)
		l.start_time = line.start_time -400 + syl.i*40
		l.end_time = line.start_time + syl.start_time
		l.text = string.format("{\\be2\\3c&H2A2B9B&\\1c&HBA993D&\\bord1\\fad(150,0)\\an5\\move(%d,%d,%d,%d,0,350)}", x-400, y, x, y)..syl.text
		l.layer=3
		subs.append(l)

	                   local sylx =  math.ceil(line.height + 1*(syl.duration/40))
	                   for lop =0, sylx do
 
		               posx = x 
		               posx1 = x+lop 
		               posy = y 
 
	                   local movex = lop / sylx 
	                   local fsz = line.styleref.fontsize + 35* movex
	                   local alfa = 235+lop*(20/sylx)
	                   local br = lop*(3/sylx)
		 l.start_time = line.start_time + syl.start_time
		 l.end_time = l.start_time + (lop/sylx)*syl.duration + 200
		 l.text = string.format("{\\an5\\bord0.5\\be0\\3c&H2A2B9B&\\1c&HBA993D&\\3a&H%02X&\\1a&H%02X&\\shad0\\t(\\fscy"..fsz..")\\move(%d,%d,%d,%d)}", alfa,alfa,posx, posy, posx1, posy) .. syl.text
                                     subs.append(l)
                                     end


elseif line.actor == "15" then
  
		local l = table.copy(line)
		l.start_time = line.start_time -400 + syl.i*40
		l.end_time = line.start_time + syl.start_time
		l.text = string.format("{\\3c&H1128FC&\\1c&H7E5533&\\bord7\\blur7\\fad(150,0)\\an5\\move(%d,%d,%d,%d,0,350)}", x, y-200, x, y)..syl.text
		l.layer=3
		subs.append(l)
 
		l.start_time = line.start_time -400 + syl.i*40
		l.end_time = line.start_time + syl.start_time
		l.text = string.format("{\\3c&H3F79FD&\\1c&HCEF7FB&\\bord2\\blur2\\fad(150,0)\\an5\\move(%d,%d,%d,%d,0,350)}", x, y-200, x, y)..syl.text
		l.layer=3
		subs.append(l)

		local l = table.copy(line)
		l.start_time = line.start_time + syl.start_time
		l.end_time = line.end_time  +100
		l.text = string.format("{\\3c&H1128FC&\\1c&H7E5533&\\1a&HFF&\\bord6\\blur7\\fad(0,150)\\an5\\move(%d,%d,%d,%d)}", x, y, x, y)..syl.text
		l.layer=3
		subs.append(l)
 
		l.start_time =line.start_time + syl.start_time
		l.end_time = line.end_time +100
		l.text = string.format("{\\3c&H3F79FD&\\1c&HCEF7FB&\\1a&HFF&\\bord2\\blur3\\fad(0,150)\\an5\\move(%d,%d,%d,%d,0,350)}", x, y, x, y)..syl.text
		l.layer=3
		subs.append(l)

	                   local sylx =  math.ceil(line.height + 1*(syl.duration/40))
	                   for lop =0, sylx do
 
		               posx = x 
		               posx1 = x+lop 
		               posy = y 
 
	                   local movex = lop / sylx 
	                   local fsz = line.styleref.fontsize + 35* movex
	                   local alfa = 235+lop*(20/sylx)
	                   local br = lop*(3/sylx)
		 l.start_time = line.start_time + syl.start_time
		 l.end_time = l.start_time + (lop/sylx)*syl.duration + 200
		 l.text = string.format("{\\an5\\bord0.7\\be0\\3c&H2E4BF9&\\1c&HCEF7FB&\\3a&H%02X&\\1a&H%02X&\\shad0\\t(\\fs"..fsz..")\\move(%d,%d,%d,%d)}", alfa,alfa,posx, posy, posx1, posy) .. syl.text
                                     subs.append(l)
                                     end

 
elseif line.actor == "16" then
 

	     l.start_time = line.start_time  -400+syl.i*40
	     l.end_time = line.start_time +syl.start_time
	     local movex = string.format("{\\an5\\fad(150,0)\\be1\\1c&H758B43&\\shad1\\bord1\\3c&H000000&\\move(%d,%d,%d,%d,0,350)}", x , y+25 , x , y)
                         l.text = movex .. syl.text 
	     l.layer = 1
	     subs.append(l)
 

	     local dist = 1
	     local loops = (line.width/2)/dist + 5

	     for j =1, loops do
	     local posy = y - 45 + (j)*dist
	     local posx = meta.res_x
	     local dur = syl.duration
	     l.start_time = line.start_time +syl.start_time  
	     l.end_time = l.start_time +syl.duration +100  
	     local linefx = string.format("{\\an5\\fad(0,100)\\bord1\\shad1\\be1\\1c&H758B43&}")
	     local movex = string.format("{\\an5\\move(%d,%d,%d,%d)\\clip(%d,%d,%d,%d)}", x , y , x +math.random(-40,40) , y , 0 , posy , posx+10-2 + (j)*dist , posy+dist  )
                         l.text = linefx .. movex .. syl.text_stripped
	     l.layer = 1

	     subs.append(l)
	     end	
	 	

end
end
end

 

 
function FX(subs)
	aegisub.progress.title(script_name)
	aegisub.progress.task(script_name)
	local meta, styles = karaskel.collect_head(subs)

	aegisub.progress.task("Applying Script...")
	aegisub.progress.set(0)
	for i = 1, subs.n do
		local sub = subs[i]

		if not sub.comment and sub.class == "dialogue" then
			karaskel.preproc_line(subs, meta, styles, sub)
			do_fx(subs, meta, styles, sub)
			subs[i] = sub
		end
		sub.comment = true
		subs[i] = sub
		aegisub.progress.set(i/subs.n*100)
		if aegisub.progress.is_cancelled() then
			break
		end
	end
	aegisub.progress.task("FX abgeschlossen!")
	aegisub.progress.set(100)
	aegisub.set_undo_point(script_name)
end

 


aegisub.register_macro(script_name,script_description, FX)

