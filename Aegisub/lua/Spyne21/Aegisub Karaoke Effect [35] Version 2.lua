include("karaskel.lua")

xres, yres = aegisub.video_size()	--get video resolution 
if xres == nil  then 
	ratio = 1 
else 
	ratio = yres/576 
end

msa = aegisub.ms_from_frame(1)		--get frame duration 
msb = aegisub.ms_from_frame(100) 
if msa == nil and msb == nil then 
	frame_dur = 33  
else 
	frame_dur = (msb-msa)/100 
end

function do_fx(subs, meta, line)
	local maxj=5
	for j = 1, maxj do 
		for i = 1, line.kara.n do 
			local syl = line.kara[i]
			local charx = table.copy(syl)	
			local pos_x = 0
			for c in unicode.chars(syl.text_stripped) do 
				charx.text = c
				if syl.duration > 0 then
					local l = table.copy(line)
					x_width = aegisub.text_extents(line.styleref, charx.text)
					l.start_time = line.start_time-50*line.kara.n+50*syl.i
					l.end_time = line.start_time + syl.start_time
					l.text=string.format("{\\an5\\1vc(&HCB372D&,&HCB372D&,&HFFFFFF&,&HFFFFFF&)\\3c&HCB372D&\\alpha&H55&\\bord%d\\shad0\\blur%d\\fscx0\\fscy0\\frz%d\\move(%d,%d,%d,%d,0,500)\\t(0,500,\\frz0\\fscx100\\fscy100)\\fad(500,0)}%s",1*ratio,2*ratio,360+50*j,line.left+syl.left+x_width/2+pos_x,line.middle-j*5,line.left+syl.left+x_width/2+pos_x,line.middle,charx.text)
					l.layer=1
					subs.append(l)
					pos_x=pos_x+x_width
				end
			end
		end
	end
	

	for i = 1, line.kara.n do --text hilight char 1
		local syl = line.kara[i]
		local charx = table.copy(syl)	
		local pos_x = 0
		for c in unicode.chars(syl.text_stripped) do 
			charx.text = c
			if syl.duration > 0 then
				local l = table.copy(line)
				x_width = aegisub.text_extents(line.styleref, charx.text)
				l.start_time = line.start_time + syl.start_time
				l.end_time = l.start_time + syl.duration+syl.duration/10
				l.text=string.format("{\\an5\\1vc(&HCB372D&,&HCB372D&,&HFFFFFF&,&HFFFFFF&)\\3c&HCB372D&\\alpha&H55&\\bord%d\\shad0\\blur%d\\fscx100\\fscy100\\pos(%d,%d)\\t(0,%d,\\fscx%d\\fscy%d)\\t(%d,%d,\\fscx100\\fscy100)\\%s\\%s}%s",1*ratio,2*ratio,line.left+syl.left+x_width/2+pos_x,line.middle,syl.duration/2,100*ratio,100*ratio,syl.duration/2,syl.duration,autotags(200,'rndx4','rndx8',syl.duration),autotags(100,'rnd4','rnd8',syl.duration),charx.text)
				l.layer=1
				subs.append(l)
				pos_x=pos_x+x_width
			end
		end
	end

	for i = 1, line.kara.n do --text hilight syl 2
		local syl = line.kara[i]
		if syl.duration > 0 then
			local l = table.copy(line)
			l.start_time = line.start_time + syl.start_time
			l.end_time = l.start_time + syl.duration+syl.duration/10
			l.text=string.format("{\\an5\\1vc(&HCB372D&,&HCB372D&,&HFFFFFF&,&HFFFFFF&)\\3c&HCB372D&\\bord%d\\shad0\\blur%d\\fscx%d\\fscy%d\\pos(%d,%d)\\t(0,%d,\\fscx100\\fscy100\\1vc(&HFFFFFF&,&HFFFFFF&,&HFFFFFF&,&HFFFFFF&))\\%s\\%s\\jitter(2,2,3,3,100)}%s",1.6*ratio,3*ratio,120*ratio,120*ratio,syl.center+line.left,line.middle,syl.duration,autotags(200,'rndx4','rndx8',syl.duration),autotags(100,'rnd4','rnd8',syl.duration),syl.text_stripped)
			l.layer=2
			subs.append(l)
		end
	end



	for j = 1, maxj do --text lead-out
		for i = 1, line.kara.n do 
			local syl = line.kara[i]
			local charx = table.copy(syl)	
			local pos_x = 0
			for c in unicode.chars(syl.text_stripped) do 
				charx.text = c
				if syl.duration > 0 then
					local l = table.copy(line)
					x_width = aegisub.text_extents(line.styleref, charx.text)
					l.start_time = line.start_time + syl.end_time+syl.duration/10
					l.end_time = l.end_time-50*line.kara.n+50*syl.i+800
					l.dur=l.end_time-l.start_time
					l.text=string.format("{\\an5\\1vc(&HCB372D&,&HCB372D&,&HFFFFFF&,&HFFFFFF&)\\3c&HCB372D&\\alpha&H55&\\bord%d\\shad0\\blur%d\\fscx100\\fscy100\\move(%d,%d,%d,%d,%d,%d)\\t(%d,%d,\\frz%d\\fscx0\\fscy0)\\fad(0,500)}%s",1*ratio,2*ratio,line.left+syl.left+x_width/2+pos_x,line.middle,line.left+syl.left+x_width/2+pos_x,line.middle+j*5,l.dur-800,l.dur,l.dur-800,l.dur,360+50*j,charx.text)
					l.layer=1
					subs.append(l)
					pos_x=pos_x+x_width
				end
			end
		end
	end
end

--Functions for effect--
function char_count(str)
	local count = 0
	if str then
		for i = 1, #str do
			count = count + 1
		end
    end
    return count
end

function autotags(interval,param1,param2,lduration) 
	local result="" 
	local tag = 0 
	local new_str=""
	local last_str=""
	local new_tag=""
	local count = math.ceil(lduration/interval) 
	local tab = {param1,param2} 
	local count_last_i=0
	local count_cond=1
	for i = 1, count do
		if param1 and param2 then 
			if  i%2 ==0 then 
				tag = tab[1] 
			else 
				tag = tab[2] 
			end
			new_tag=tag
			if i>1 then
				new_str=string.sub(tag,0,char_count(tag)-1)
				last_str=string.sub(tag,char_count(tag)) 
				if i<count/2 then
					last_str=last_str+i
					count_last_i=i
				else
					last_str=(last_str+count_last_i-count_cond)
					count_cond=count_cond+1
				end
				if i==count then
					last_str=0
				end
				new_tag=new_str..last_str
			end
		end
		result = result.."\\t("..(i-1)*interval..","..i*interval..",\\"..new_tag..")".."" 
	end 
	return result 
end

function fx35(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)
	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying Script Lua (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and not l.comment then
		karaskel.preproc_line(subs, meta, styles, l)
		do_fx(subs, meta, l)
		maxi = maxi - 1
		l.comment = true
		subs[i] = l
		else
		i = i + 1
		end
		ai = ai + 1
	end
      aegisub.progress.task("Finished Apply")
      aegisub.progress.set(100)
end

script_name = "Aegisub Karaoke Effect [35] Version 2"
script_author = "Spyne21"  
script_version = "1.0"
aegisub.register_macro(script_name,"",fx35)