include("karaskel.lua")

script_name = "Dragon ball Kai Ending 2"

script_description = "#taka@irc.rizon.net ; #sd@irc.rizon.net"

script_author = "FloriaN"

script_version = "1"
-- progressing the subs
function main(subs)



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



	for i = 0, line.kara.n do

  	local syl = line.kara[i]

  	if syl.duration > 0 then

	local l = table.copy(line)

    	local x = line.left+syl.center

    	local y = line.styleref.margin_t


-- do not fx empty shit
	if syl.text_stripped ~= "" then

-- only apply to this style
if line.style == "ROMAJI" then
-- intro
	l.layer = 1
	l.text = string.format("{\\an5\\pos(%d,%d)\\bord1.5\\frx-90\\alpha&HFF&\\fscx120\\fscy120\\1c%s\\t(0,%d,\\fscx100\\fscy100\\frx0\\alpha&H00&)\\t(%d,%d,\\1c&HF6E9F5&)}%s",x,y, line.styleref.color2, syl.i*150, syl.start_time+400, syl.end_time+600, syl.text_stripped)
	l.start_time = line.start_time - 600
	l.end_time = line.start_time + syl.start_time
	subs.append(l)
--syl
	l.layer = 3
	for i = 0, 9 do
	l.text = string.format("{\\relayer(%d)\\fad(0,2000)\\bord0\\an5\\shad0\\pos(%d,%d)\\t(0,%d,\\alpha&HCC&\\fscx1%d\\fscy1%d\\be2}%s",line.layer+20,x,y,syl.duration+700,i*10,i*10,syl.text_stripped)
	l.start_time = line.start_time + syl.start_time
	l.end_time = line.start_time + syl.end_time + 700
	subs.append(l)
	end
end
	end

   end

  end

end

function macro_MF(subs, sel)

	aegisub.set_undo_point("before run macro")

	main(subs, {ismacro=true, sel=sel})

end	



aegisub.register_macro("Dragon ball Kai Ending 2 FX", "", macro_MF)

aegisub.register_filter("Dragon ball Kai Ending 2 FX", "", 2000, main)