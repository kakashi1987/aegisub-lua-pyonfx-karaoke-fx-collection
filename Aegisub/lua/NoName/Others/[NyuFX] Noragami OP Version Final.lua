-- Karaoke Effect by Spyne21 - Vsfiltermod

-- Stores the given value with the given name for later reference. Returns the value stored.
temp = {} 
function set_temp(ref,val) 
	temp[ref] = val 
	return val 
end

-- Function which return the number of character for the first and last syllable in array
function number_character_syl(line, l)	
	local number={}
	local count=1
	for si, syl in ipairs(line.syls) do
		if syl.i==1 or syl.i==#line.syls then
			number[count]=string.ulen(syl.text)
			count=count+1
		end
	end
	return number
end

-- Function which divide the duration by div and add tags into \t tag.
function tags_duration_div(duration,add_dur,div)  	
	local result=""
	for i = 1, div do 
		if i~=div then
			tags="fscx"..math.random(75,150).."\\fscy"..math.random(75,150).."\\frx"..math.random(-10,10).."\\frz"..math.random(-10,10)
			result = result.."\\t("..((i-1)*(duration/div))..","..(i*(duration/div))..",\\"..tags..")"..""  
		else
			tags="fscx100\\fscy100\\frx0\\frz0"
			result = result.."\\t("..((i-1)*(duration/div))..","..((i*(duration/div))+add_dur)..",\\"..tags..")"..""  
		end	
	end  	
	return result  
end

-- Syllabe effect under the main syllabe
function under_main_syl(line,l)
	l.layer=1
	if line.style=="Chikutaku_romanji" or  line.style=="Chikutaku_kanji" then
		for si,syl in ipairs(line.syls) do	
			if syl.text~="" then
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time+100
				fad=""
				csn=string.ulen(syl.text)
				local left, width = syl.left, 0
				for csi, char in string.uchars(syl.text) do
					l.start_time=line.start_time+syl.start_time
					l.end_time=line.start_time+syl.end_time+100
					width = utils.text_extents(char,line.styleref)
					cleft = left
					ccenter = left + width/2
					cright = left + width
					t1=set_temp("dur",(csi-1==0) and 0 or temp.dur+(syl.duration/csn))
					t2=temp.dur+(syl.duration/(csn*2))+50
					t3=temp.dur+(syl.duration/(csn*2))+50
					t4=temp.dur+(syl.duration/csn)+100
					array_color={"&HF1FF37&","&H00FF00&","&HEB121C&","&HE000EF&","&H2D02E2&","&H1EFFF5&"}
					color=utils.distributor(array_color)
					maxj=6
					for j=1,maxj do
						jitter="\\jitter("..math.random(2,5)..","..math.random(2,5)..","..math.random(2,5)..","..math.random(2,5)..")"
						if j<=(maxj/2) then
							add_x=-(maxj-(2*j)+2)*2
						else
							add_x=(j-(maxj-j))*2
						end
						if si==#line.syls then
							fad="\\fad(0,300)"
						end
						l.text = string.format("{\\an5\\bord0\\shad0\\blur0\\1c%s\\3c&HFFFFFF&\\alpha%s\\fscx100\\fscy100\\move(%.3f,%.3f,%.3f,%.3f,0,%d)\\t(0,%d,\\alpha&HFF&)\\t(%.3f,%.3f,\\fscx150\\fscy150)\\t(%.3f,%.3f,\\fscx100\\fscy100)%s%s}%s"
						,color:get(),convert.a_to_ass((255/2)+25),ccenter+add_x,syl.middle+math.random(-8,8),ccenter,syl.middle,syl.duration+100,syl.duration+100,t1,t2,t3,t4,jitter,fad,char)
						io.write_line(l)
					end
					left = left + width
				end
			end
		end
	else
		for ci,char in ipairs(line.chars) do
			if char.text~=" " then
				if line.actor=="first_effect" then 
					add_tags=string.format("\\fscx100\\fscy100\\t(0,50,\\fscx140\\fscy140)\\t(50,%d,\\fscx100\\fscy100)",char.duration+100) 
					jitter="\\jitter(2,2,2,2)"
				else
					add_tags=tags_duration_div(char.duration,100,12) 
					jitter="\\jitter("..math.random(2,5)..","..math.random(2,5)..","..math.random(2,5)..","..math.random(2,5)..")"
				end
				array_color={"&HF1FF37&","&H00FF00&","&HEB121C&","&HE000EF&","&H2D02E2&","&H1EFFF5&"}
				color=utils.distributor(array_color)
				maxj=6
				for j=1,maxj do
					l.start_time=line.start_time+char.start_time
					l.end_time=line.start_time+char.end_time+100
					if j<=(maxj/2) then
						add_x=-(maxj-(2*j)+2)*2
					else
						add_x=(j-(maxj-j))*2
					end
					l.text=string.format("{\\an5\\bord0\\shad0\\blur0\\1c%s\\3c&HFFFFFF&\\alpha%s\\fscx100\\fscy100\\move(%.3f,%.3f,%.3f,%.3f,0,%d)\\t(0,%d,\\alpha&HFF&)%s%s}%s"
					,color:get(),convert.a_to_ass((255/2)+25),char.center+add_x,char.middle+math.random(-8,8),char.center,char.middle,char.duration+100,char.duration+100,add_tags,jitter,char.text)
					io.write_line(l)
				end
			end
		end
	end
end

-- Function roumajis and kanjis
function roumaji_kanji(line, l)
	local bord=1.8
	local blur=3.3
	if line.infade>500 then
		line.infade=150
	end
	if line.outfade>500 then
		line.outfade=150
	end
	if line.style=="OP_Kanji" or line.style=="OP_Kanji_right" or line.style=="Chikutaku_kanji" then
		bord=1.3
		blur=1.8
	end
	-- Infade effect
	for ci,char in ipairs(line.chars) do
		if char.text~=" " then
			array_color={"&HF1FF37&","&H00FF00&","&HEB121C&","&HE000EF&","&H2D02E2&","&H1EFFF5&"}
			color=utils.distributor(array_color)
			maxj=6
			for j=1,maxj do
				l.start_time=line.start_time-line.infade/2-200
				l.end_time=line.start_time+300
				if j<=(maxj/2) then
					add_x=-(maxj-(2*j)+2)*2
				else
					add_x=(j-(maxj-j))*2
				end
				l.text=string.format("{\\an5\\bord0\\shad0\\blur0\\1c%s\\3c&HFFFFFF&\\alpha%s\\fscx100\\fscy100\\move(%.3f,%.3f,%.3f,%.3f,0,500)\\t(0,500,\\alpha&HFF&)}%s"
				,color:get(),convert.a_to_ass((255/2)+12.5),char.center+add_x,char.middle,char.center,char.middle,char.text)
				l.layer=2
				io.write_line(l)
			end
			l.start_time=line.start_time-line.infade/2
			l.end_time=line.start_time+char.start_time
			l.text=string.format("{\\an5\\bord%.3f\\shad0\\blur%.3f\\1c&H070090&\\3c&HFFFFFF&\\fscx100\\fscy100\\pos(%.3f,%.3f)\\fad(300,0)}%s"
			,bord,blur,char.center,char.middle,char.text)
			l.layer=1
			io.write_line(l)
		end
	end
	-- Syllabe effect
	l.layer=2
	if line.style=="Chikutaku_romanji" or  line.style=="Chikutaku_kanji" then
		for si,syl in ipairs(line.syls) do	
			if syl.text~="" then
				l.layer=2
				l.start_time=line.start_time+syl.start_time
				l.end_time=line.start_time+syl.end_time+100
				fad=""
				csn=string.ulen(syl.text)
				local left, width = syl.left, 0
				for csi, char in string.uchars(syl.text) do
					width = utils.text_extents(char,line.styleref)
					cleft = left
					ccenter = left + width/2
					cright = left + width
					t1=set_temp("dur",(csi-1==0) and 0 or temp.dur+(syl.duration/csn))
					t2=temp.dur+(syl.duration/(csn*2))+50
					t3=temp.dur+(syl.duration/(csn*2))+50
					t4=temp.dur+(syl.duration/csn)+100
					if si==#line.syls then
						fad="\\fad(0,300)"
					end
					l.text = string.format("{\\an5\\bord%.3f\\shad0\\blur%.3f\\1c&H070090&\\3c&HFFFFFF&\\pos(%.3f,%.3f)\\t(%.3f,%.3f,\\fscx150\\fscy150)\\t(%.3f,%.3f,\\fscx100\\fscy100)\\jitter(%d,%d,%d,%d)%s}%s"
					,bord,blur,ccenter,syl.middle,t1,t2,t3,t4,math.random(1,3),math.random(1,3),math.random(1,3),math.random(1,3),fad,char)
					io.write_line(l)
					left = left + width
				end
			end
		end
	elseif line.style=="OP_Hey" then
		for ci,char in ipairs(line.chars) do
			if char.text~=" " then
				maxj=4
				for j=0, maxj do
					l.start_time=line.start_time+char.start_time+(j/maxj)*char.duration
					l.end_time=line.start_time+char.start_time+char.duration-(j/maxj)*char.duration
					l.text=string.format("{\\an5\\bord%.3f\\shad0\\blur%.3f\\1c&H070090&\\3c&HFFFFFF&\\fscx100\\fscy100\\move(%.3f,%.3f,%.3f,%.3f,0,%d)\\t(0,%d,\\fscx200\\fscy200\\alpha&HFF&)\\jitter(%d,%d,%d,%d)}%s"
					,bord/2,blur,char.center,char.middle,char.center+math.random(-10,10),char.middle+math.random(-10,10),char.duration/2,char.duration,math.random(2,5),math.random(2,5),math.random(2,5),math.random(2,5),char.text)
					io.write_line(l)	
				end
			end
		end
	else
		for ci,char in ipairs(line.chars) do
			if char.text~=" " then
				l.start_time=line.start_time+char.start_time
				l.end_time=line.start_time+char.end_time+100
				fad=""
				if line.actor=="first_effect" then 
					add_tags=string.format("\\fscx100\\fscy100\\t(0,50,\\fscx140\\fscy140)\\t(50,%d,\\fscx100\\fscy100)",char.duration+100) 
					jitter="\\jitter(2,2,2,2)"
				else
					add_tags=tags_duration_div(char.duration,100,12) 
					jitter="\\jitter("..math.random(2,5)..","..math.random(2,5)..","..math.random(2,5)..","..math.random(2,5)..")"
				end
				if line.style=="OP_Romanji" or line.style=="OP_Romanji_right" then
					characters=number_character_syl(line, l)
					if char.i>string.len(line.text)-characters[2] then
						l.end_time=line.end_time+line.outfade/2
						fad="\\fad(0,300)"
					end
				end
				if line.style=="OP_Kanji" or line.style=="OP_Kanji_right" then
					characters=number_character_syl(line, l)
					if char.i>string.ulen(line.text)-characters[2] then
						l.end_time=line.end_time+line.outfade/2
						fad="\\fad(0,300)"
					end
				end
				l.text=string.format("{\\an5\\bord%.3f\\shad0\\blur%.3f\\1c&H070090&\\3c&HFFFFFF&\\fscx125\\fscy125\\pos(%.3f,%.3f)%s%s%s}%s"
				,bord,blur,char.center,char.middle,add_tags,jitter,fad,char.text)
				io.write_line(l)	
			end
		end
	end
	-- Outfade effect
	if line.style~="OP_Hey" then
		for ci,char in ipairs(line.chars) do
			if char.text~=" " then
				l.start_time=line.start_time+char.end_time+100
				l.end_time=line.end_time+line.outfade/2
				l.text=string.format("{\\an5\\bord%.3f\\shad0\\blur%.3f\\1c&H070090&\\3c&HFFFFFF&\\fscx100\\fscy100\\pos(%.3f,%.3f)\\fad(0,300)}%s"
				,bord,blur,char.center,char.middle,char.text)
				l.layer=0
				io.write_line(l)
			end
		end
	end
end

-- Function subtitle
function sub(line, l)
	local bord=1.5
	local blur=3.0
	if line.infade>500 then
		line.infade=150
	end
	if line.outfade>500 then
		line.outfade=150
	end
	for ci,char in ipairs(line.chars) do
		if char.text~=" " then
			array_color={"&HF1FF37&","&H00FF00&","&HEB121C&","&HE000EF&","&H2D02E2&","&H1EFFF5&"}
			color=utils.distributor(array_color)
			maxj=6
			for j=1,maxj do
				l.start_time=line.start_time-line.infade/2-200
				l.end_time=line.start_time+300
				if j<=(maxj/2) then
					add_x=-(maxj-(2*j)+2)*2
				else
					add_x=(j-(maxj-j))*2
				end
				l.text=string.format("{\\an5\\bord0\\shad0\\blur0\\1c%s\\3c&HFFFFFF&\\alpha%s\\fscx100\\fscy100\\move(%.3f,%.3f,%.3f,%.3f,0,500)\\t(0,500,\\alpha&HFF&)}%s"
				,color:get(),convert.a_to_ass((255/2)+12.5),char.center+add_x,char.middle,char.center,char.middle,char.text)
				l.layer=2
				io.write_line(l)
			end
			l.start_time=line.start_time-line.infade/2
			l.end_time=line.end_time+line.outfade/2
			l.text=string.format("{\\an5\\bord%.3f\\shad0\\blur%.3f\\1c&H070090&\\3c&HFFFFFF&\\fscx100\\fscy100\\pos(%.3f,%.3f)\\fad(300,300)}%s"
			,bord,blur,char.center,char.middle,char.text)
			l.layer=1
			io.write_line(l)
		end
	end
end

for li, line in ipairs(lines) do
	l=table.copy(line)
	if line.styleref.alignment <=3 then
		sub(line, l)
	else
		roumaji_kanji(line,l)
		under_main_syl(line,l)
	end
	io.progressbar(li / #lines)
end