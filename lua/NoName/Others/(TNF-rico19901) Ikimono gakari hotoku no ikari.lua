
include("karaskel.lua")                                                                                      
include("zheolib.lua")
include("formaslib.lua")


script_name = "Tenshi no fansub"
script_description = "Script Lua"
script_author = "rico"
script_version = "1"

function rico_Fx(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and
				not l.comment then
				--(l.style == "Romanji") then
			karaskel.preproc_line(subs, meta, styles, l)
			do_fx(subs, meta, l)
			maxi = maxi - 1
			subs.delete(i)
		else
			i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("Finished!")
	aegisub.progress.set(100)
end
	
	
	
	function do_fx(subs, meta, line)
	for i = 1, line.kara.n do
		local syl = line.kara[i]
		local x=syl.center + line.left
		local y=line.margin_v + 40 
		if i == 1 then
			tempo=0
		end
		
		--Syl--
		
		function sil()
			silaba = ""..syl.text_stripped..""
			return silaba
		end

		if syl.inline_fx == "" then
		
	
l = table.copy(line)
l.text = "{"..fad(300,0)..an(5)..move(x,y+30,x,y)..bord(0)..color(1,'ffffff')..t(frz(360)..blur(3)..estilo(1,line.styleref.color1)..bord(1)).."}"..sil() --Aqui são os efeitos
l.start_time = line.start_time -800 
l.end_time = line.start_time 
l.layer=0 
subs.append(l) 

l = table.copy(line)
l.text = "{"..fad(300,0)..an(5)..move(x,y-30,x,y)..bord(0)..color(1,'ffffff')..t(frz(360)..blur(3)..estilo(1,line.styleref.color1)..bord(1)).."}"..sil() --Aqui são os efeitos
l.start_time = line.start_time -800 
l.end_time = line.start_time 
l.layer=0 
subs.append(l)




			l = table.copy(line)
			l.text = "{"..an(5)..pos(x,y)..estilo(1,line.styleref.color2).."}"..sil()
			l.start_time = line.start_time
			l.end_time = line.start_time+syl.start_time
			l.layer=0
			subs.append(l)
			
			
			l = table.copy(line)
			l.text = "{"..an(5)..move(x+10,y,x,y-30)..color(2,'HFDF3B8')..blur(5)..t(frx(360)..frz(360)..blur(3)..bord(1)).."}"..sil()
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration
			l.layer =3
			subs.append(l)
			
			l = table.copy(line)
			l.text = "{"..an(5)..move(x+10,y,x,y+30)..color(2,'HFDF3B8')..blur(5)..t(frx(360)..frz(360)..blur(3)..bord(1)).."}"..sil()
			l.start_time=line.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration
			l.layer =3
			subs.append(l)
			
			
			--FX DA SILABA DEPOIS DE CANTADA
			l = table.copy(line)
			frand=rand(10)
			l.text = "{"..fad(400,0)..an(5)..pos(x,y)..estilo(1,line.styleref.color2)..t(fr(frand)..frz(360)..bord(1)..fscxy(150,150)..alpha('ff')..estilo(1,line.styleref.color1)..color(2,'HCBAB96&')..blur(5)..bord(0)).."}"..sil()
			l.start_time=l.start_time+syl.start_time+100
			l.end_time=l.start_time+syl.duration+1000
			l.layer = 0
			subs.append(l)
			
			l = table.copy(line)
			frand=rand(10)
			l.text = "{"..fad(400,0)..an(5)..pos(x,y)..estilo(1,line.styleref.color2)..t(fr(frand)..frz(-360)..bord(1)..fscxy(150,150)..alpha('ff')..estilo(1,line.styleref.color1)..color(2,'HCBAB96&')..blur(5)..bord(0)).."}"..sil()
			l.start_time=l.start_time+syl.start_time+100
			l.end_time=l.start_time+syl.duration+1000
			l.layer = 0
			subs.append(l)
			

		elseif syl.inline_fx == "white" then  

			
			l = table.copy(line)
			frand=rand(10)
			l.text = "{"..fad(400,0)..an(5)..move(x,y+50,x,y)..estilo(1,'HFFFFFF')..bord(0)..t(fr(frand)..bord(1)..fscxy(150,150)..alpha('ff')..color(3,'HFFFFFF')).."}"..sil()
			l.start_time=l.start_time+syl.start_time
			l.end_time=l.start_time+syl.duration+1000
			l.layer = 0
			subs.append(l)

		end 


		
		if syl.text ~=" " then 
			l = table.copy(line)

			
			for i = 0,100 do
				fsxy=rand(4,20)
				l.text = "{"..bord(0)..an(5)..fad(100,200)..move(x+rand(20),y+rand(50),x-rand(30),y)..fscxy(fsxy)..color(1,line.styleref.color1).."}"..p(1,Formas(4,2))
				l.start_time=line.start_time+syl.start_time+rand(200,400)
				l.end_time=l.start_time+syl.duration+rand(200,400)
				l.layer =2
				subs.append(l)
			end

		end


end
end

aegisub.register_macro("Tenshi no fansub", "APLICAR EFEITO", rico_Fx)
aegisub.register_filter("tenshi no fansub", "APLICAR EFEITO", 2000, rico_Fx)
