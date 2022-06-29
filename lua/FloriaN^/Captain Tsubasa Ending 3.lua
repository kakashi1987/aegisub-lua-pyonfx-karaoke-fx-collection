include("karaskel.lua")

script_name = "Cpt. Tsubasa Ending"

script_description = ""

script_author = "FloriaN"

script_version = "beta v2"

function tsubasa(subs)
	local meta, styles = karaskel.collect_head(subs)
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and l.style ~= "eng" and
				not l.comment then
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

function do_fx(subs, meta, line, styles)

chari = 0
transform = ""

   for i = 1, line.kara.n do
   
	 local syl = line.kara[i]
     local x = syl.center+line.left 
     local y = line.middle
	 if i == 1 then BB = 0 end
	 local l = table.copy(line)
	 local t_op = -500
	 local fr = 3600,4500,5400
	 local color = "&H5E1300&","&H5E0050&","&H97458B&","&H975945&","&H4D1117&","&HAB8D9B&","&H8675AB&","&H395BA7&"
     local fry_endt = syl.start_time-400
	 local move_x1 = 0
	 
	 --# Start
	 l.start_time = line.start_time + -600 + BB  
     l.end_time = line.start_time + BB
     l.layer = 5
     l.text = string.format("{\\an5\\be2\\3a&H55&\\move(%d,%d,%d,%d)\\fad(200,0)\\fscx60\\fscy60\\t(20,400,\\fscx100\\fscy100)\\t(\\frz!math.random(-360,360)!)\\blur2\\3c&H844000&\\bord2.5}%s",x+150,y-40,x,y,syl.text)
     subs.append(l)

	 
	 --# Start to Syl
	 l.start_time = line.start_time  + BB 
     l.end_time = line.start_time+ syl.start_time 
     l.layer = 4
     l.text = string.format("{\\an5\\move(%d,%d,%d,%d)\\fad(0,0)\\1c&HFFFFFF&\\bord1}%s",x,y,x,y,syl.text)
     subs.append(l)
     
	 --# Syl
	 local l = table.copy(line)
	 l.start_time = line.start_time + syl.start_time
	 l.end_time = l.start_time + syl.duration
     l.text = string.format("{\\shad1.5\\an5\\pos(%d,%d)\\fay0.01\\blur5\\4a&HAA&\\3c&H2A55E1&\\3a&H77&\\t($start,$mid,\\fscy400)\\t($mid,$end,\\fscy100)\\1c&HFFFFFF&\\bord2.5)}%s",x,y,syl.text)
     l.layer = 3
	 subs.append(l)
--# Syl #2
 local l = table.copy(line)
	 l.start_time = line.start_time + syl.start_time
	 l.end_time = l.start_time + 30 + syl.duration 
     l.text = string.format("{\\shad0\\an5\\pos(%d,%d)\\be5\\t($start,$mid,\\fscy150)\\t($mid,$end,\\fscx150\\fscy450)\\t(!$end-80!,$end,\\alpha&HFF&)\\1c&HFFFFFF&\\bord0)}%s",x,y,syl.text)
     l.layer = 2
	 subs.append(l)
	 
	 	 
	 --# Syl 2 End
	l.start_time =  l.start_time + syl.duration
l.end_time =  line.end_time-200
l.text = string.format("{\\an5\\pos(%d,%d)}%s",x,y,syl.text)
l.layer = 1   
subs.append(l)

--# Post Line 1
l.start_time = line.end_time - 300
l.end_time = line.end_time + BB/2
l.text =string.format("{\\an5\\pos(%d,%d)\\fad(0,500)}%s",x,y,syl.text)
l.layer = 0
subs.append(l)
	 
	 
BB = BB+(1500/line.kara.n)
end
end
function macro_MF(subs, sel)

	aegisub.set_undo_point("before run macro")

	tsubasa(subs, {ismacro=true, sel=sel})

end	

aegisub.register_macro("Cpt. Tsubasa ED","", macro_MF)

aegisub.register_filter("Cpt. Tsubasa ED","",2000,tsubasa)