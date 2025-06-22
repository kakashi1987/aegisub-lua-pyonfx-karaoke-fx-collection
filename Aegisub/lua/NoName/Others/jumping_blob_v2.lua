--[[
Copyright (c) 2008 ai-chan (Aegisub's forum member)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and 
associated documentation files (the "Software"), to deal in the Software without restriction, 
including without limitation the rights to use, copy, modify, merge, publish, distribute, 
sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is 
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial 
portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT 
NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES 
OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN 
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

 Automation script: Jumping blob v2
 New in v2:
 * New "wave movement" mode where if selected, blobs will move in wave-form movement
 * Support for vertical kanji karaoke
 * Lines manually positioned using /pos are OK
 * Automatic positioning of the jumps (i.e either on top or below the lines) based on the location of the rendered 
   line on the screen
 * No more weird looking effect if a blob that does not look the same when rotated 180 degree is used (in other
   words, anything can be a blob now, even a long sentence!)
 * Origin adjustment values in v1.5 are no longer needed
 * Advanced settings open up possibilities on cooler effects (try playing with delay value to add
   trail effect)
 * Blob text can now use variables:
   # $syl$ Syllable text (stripped of tags)
   # $dur$ Duration of the blob / syllable
   # $halfdur$ Half of $dur$
   # $kdur$ /k duration
   ** see version history 2.02 for a cool blob text sample

 Note on configuration "Advanced settings"
 * delay: delay blob movements for some milliseconds
 * acc: acceleration value to use in \t tag for the jump/wave
 * xmod: set non-0 to make the blob 'landing' point a few pixels away from syllable's horizontal center
 * ymod: 
 ** for wave movement mode: y-displacement from syllable middle points
 ** for jumping mode: the higher this value the farther the blobs from the syllables
 * wave_ccw: for wave movement only: if true then the blob will enter from the bottom
 * wave_angle: for wave movement only: the angle of the blobs rotation must be 0 < angle < 360
 
 Some tricks using Advanced settings:
 * Apply wave mode two times, the second time with wave_ccw = true
 * Apply either auto/wave mode 3-4 times, the 2nd time with delay = 50, 3rd time with delay = 100 and so on
 * Apply wave mode with 0 < wave_angle < 10 for linearly moving blobs (instead of wave)
 * Apply wave mode with 250 < wave_angle < 350 for a big wave effect

 Note on configuration "First and last blob"
 - the following tables can be used in the calculations: config, meta, syl, line, linex,
   as well as common libraries (math, string, io etc) and any functions defined in karaskel.lua and utils.lua
 * first = {x, y, sw}
 ** x : the x position of first blob before jumping relative to the horizontal center of first syllable
 ** y: the y position of first blob before jumping relative to the vertical base of the jumping (which depends on the jumping mode)
 ** sw: the 'swing' amount of first blob; accepts any real value between 0 and 1 -> 1 means full-swing (180 degree or wave_angle) while 0 means no swing (0 degree)
 * last = {x, y, sw}
 ** x: the x position of last blob after jumping relative to the horizontal center of last syllable
 ** y: the y position of last blob after jumping relative to the vertical base of the jumping (which depends on the jumping mode)
 ** sw: the 'swing' amount of last blob; accepts any real value between 0 and 1 -> 1 means full-swing (180 degree or wave_angle) while 0 means no swing (0 degree)

 Version history:
 
 2.04
 ====
 - Added: Option to select whether to insert blob lines after/before original line or at the end
 - Added: Option to apply to lines with specific Effect
 - Fixed: Jumping Blob now applies on lines that are commented after applying karatemplater
 - Fixed: Automatically uncomment blob lines that come from a commented line
 - Added: The "First and last blob" advanced option. Here you can adjust the starting and 
 	ending positions of the first and last blobs respectively. Refer to 'Note on configuration "First and last blob"' above

 2.03
 ====
 - Added: Option to apply to lines with specific Actor
 - Fixed: Jumping blobs were created even for comment lines
 - Fixed: 'Apply to' and 'Blob style' config values were not being saved
 - Blob text variables: re-added $kdur$ which was accidentally removed in 2.02

 2.02
 ====
 - Blob text variables:
   - removed $start$, $end$ and $mid$ since they don't make sense in a blob line
   - added:
   # $dur$ : Blob line duration in milliseconds (= syllable(from)) duration)
   # $halfdur$ : half of $dur$ value
   - plus some code rearrangement so that generated blob (after variables substitution) is up-to-date with current syllable;
     now the following blob works: {\t(0,$halfdur$,\fscx50\fscy50)\t($halfdur$,$dur$,\fscx100\fscy100)\p2\shad0}m 23 0 l 15 12 l 0 16 l 10 27 l 9 42 l 23 36 l 37 42 l 36 27 l 46 16 l 31 12{\p0}

 2.01
 ====
 - Added: option to save configuration values after applying the effect
 - Added: the following variables can be used in blob text and will be replaced during execution:
   # $syl$ Syllable text (stripped of tags)
   # $start$ Syllable start time
   # $end$ Syllable end time
   # $mid$ Time between start and end
   # $kdur$ /k duration
 
 2.00
 ====
 Initial auto4 version

]]

script_name = "Jumping blob effect v2"
script_description = ""
script_author = "ai-chan"
script_version = "2.04"
script_modified = "25 March 2009"

include("exxact.lua")

if not jumpblob then jumpblob = {} end

-- Language overkill
jumpblob.lang = "en"
jumpblob.strtable = {
	['en'] = {
		['macrodesc'] = "Blob jumping over syllables. Auto4 version of the Jumping Blob LUA script, now with supports for vertical karaoke plus much more! - by ai-chan",
		['applyto'] = "Apply effect to",
		['selectedlines'] = "-- Selected lines --",
		['toall'] = "-- All lines --",
		['blobstyle'] = "Style of the blobs",
		['samewithline'] = "-- Same with lines ---",
		['theblob'] = "The blob",
		['theblob_hint'] = "The blob. Enter anything: a character, a drawing tag etc",
		['fadein'] = "Fade in",
		['fadeout'] = "Fade out",
		['leadin'] = "Lead in",
		['leadout'] = "Lead out",
		['mode_auto'] = "Auto",
		['mode_forcetop'] = "Force on top",
		['mode_wave'] = "Wave movement",
		['mode'] = "Mode",
		['advancedcfg'] = "Advanced settings",
		['advancedcfg_hint'] = "Modify these settings with care",
		['saveconfig'] = "Save these configuration values (reload lua script to reset)",
		['label'] = "Lines label",
		['label_hint'] = "The label (actor field) for blob lines to make it easy to distinguish generated lines from originals",
		['insertat'] = "Insert blob lines",
		['insertat_after'] = "After original line",
		['insertat_before'] = "Before original line",
		['insertat_end'] = "At the end (after all lines)",
		['firstlast'] = "First and last blob",
		['firstlast_hint'] = "Relative positions of first & last blobs with respect to first & last syllables in the line"
	}
}

-- real stuff (don't edit below this line unless if you know what you are doing)

function jumpblob.str(keyword)
	return jumpblob.strtable[jumpblob.lang][keyword] or jumpblob.strtable['en'][keyword] or keyword
end

script_description = jumpblob.str("macrodesc")

jumpblob.conf = {
	[1] = { name = "mode"; class = "dropdown"; x = 1; y = 1; height = 1; width = 3; 
		items = { 
			jumpblob.str("mode_auto"), 
			jumpblob.str("mode_forcetop"), 
			jumpblob.str("mode_wave") }; 
		value = jumpblob.str("mode_auto") 
	}
	,
	[2] = { name = "applyto"; class = "dropdown"; x = 1; y = 2; height = 1; width = 3; items = { }; value = "" }
	,
	[3] = { name = "blobstyle"; class = "dropdown"; x = 1; y = 3; height = 1; width = 3; items = { }; value = "" }
	,
	[4] = { name = "blob"; class = "textbox"; x = 1; y = 4; height = 3; width = 3; hint = jumpblob.str("theblob_hint");
		text = "{\\p1\\shad0}m 7 14 b 11 14 14 11 14 7 b 14 3 11 0 7 0 b 3 0 0 3 0 7 b 0 11 3 14 7 14{\\p0}"
	}
	,
	[5] = { name = "leadin"; class = "intedit"; x = 1; y = 7; height = 1; width = 1; min = 0; max = 2000; value = 250 }
	,
	[6] = { name = "leadout"; class = "intedit"; x = 3; y = 7; height = 1; width = 1; min = 0; max = 2000; value = 250 }
	,
	[7] = { name = "fadein"; class = "intedit"; x = 1; y = 8; height = 1; width = 1; min = 0; max = 2000; value = 250 }
	,
	[8] = { name = "fadeout"; class = "intedit"; x = 3; y = 8; height = 1; width = 1; min = 0; max = 2000; value = 250 }
	,
	[9] = { name = "advancedcfg"; class = "textbox"; x = 1; y = 11; height = 3; width = 3; 
		text = "delay = 0; acc = 1.0; xmod = 0; ymod = 0; \nwave_ccw = false; wave_angle = 180"; hint = jumpblob.str("advancedcfg_hint")
	}
	,
	[10] = { name = "label"; class = "edit"; x = 1; y = 9; height = 1; width = 3; 
		text = "blob"; hint = jumpblob.str("label_hint")
	}
	,
	[11] = { name = "saveconfig"; class = "checkbox"; x = 0; y = 17; height = 1; width = 4; label = jumpblob.str("saveconfig") }
	,
	[12] = { class = "label"; x = 0; y = 1; height = 1; width = 1; label = jumpblob.str("mode") }
	,
	[13] = { class = "label"; x = 0; y = 2; height = 1; width = 1; label = jumpblob.str("applyto") }
	,
	[14] = { class = "label"; x = 0; y = 3; height = 1; width = 1; label = jumpblob.str("blobstyle") }
	,
	[15] = { class = "label"; x = 0; y = 4; height = 1; width = 1; label = jumpblob.str("theblob") }
	,
	[16] = { class = "label"; x = 0; y = 7; height = 1; width = 1; label = jumpblob.str("leadin") }
	,
	[17] = { class = "label"; x = 2; y = 7; height = 1; width = 1; label = jumpblob.str("leadout") }
	,
	[18] = { class = "label"; x = 0; y = 8; height = 1; width = 1; label = jumpblob.str("fadein") }
	,
	[19] = { class = "label"; x = 2; y = 8; height = 1; width = 1; label = jumpblob.str("fadeout") }
	,
	[20] = { class = "label"; x = 0; y = 11; height = 1; width = 1; label = jumpblob.str("advancedcfg") }
	,
	[21] = { class = "label"; x = 0; y = 9; height = 1; width = 1; label = jumpblob.str("label") }
	,
	[22] = { class = "label"; x = 0; y = 18; height = 2; width = 4; label = "If you use this effect for a fansub, I'd appreciate if you include the phrase \n'jumping blob v2 by ai-chan' in your credit animation :)" }
	,
	[23] = { class = "label"; x = 0; y = 0; height = 1; width = 1; label = "Version" }
	,
	[24] = { class = "label"; x = 1; y = 0; height = 1; width = 3; label = script_version .. " (updated ".. script_modified ..")" }
	,
	[25] = { class = "label"; x = 0; y = 10; height = 1; width = 1; label = jumpblob.str("insertat") }
	,
	[26] = { name = "insertat"; class = "dropdown"; x = 1; y = 10; height = 1; width = 3;
		items = { 
			jumpblob.str("insertat_after"), 
			jumpblob.str("insertat_before"), 
			jumpblob.str("insertat_end") }; 
		value = jumpblob.str("insertat_after") 
 	}
	,
	[27] = { class = "label"; x = 0; y = 14; height = 1; width = 1; label = jumpblob.str("firstlast") }
	,
	[28] = { name = "firstlast"; class = "textbox"; x = 1; y = 14; height = 3; width = 3; 
		text = "first = { -line.height * 2, 0, 0.5 }; \nlast = { line.height * 2, 0, 0.5 };"; hint = jumpblob.str("firstlast_hint")
	}
}

function jumpblob.process(meta, styles, config, subtitles, selected_lines, active_line)	
	-- first figure out which lines to process
	local subtitles2 = {}
	local subs = {}
	if config.applyto == jumpblob.str("toall") then
		for i = 1, #subtitles do 
			if jumpblob.islineapplicable(subtitles[i]) then
				table.insert(subs,i)
			end 
		end
	elseif config.applyto == jumpblob.str("selectedlines") then
		for _, i in ipairs(selected_lines) do
			if jumpblob.islineapplicable(subtitles[i]) then
				table.insert(subs,i)
			end 
		end
	elseif string.sub(config.applyto,1,6) == "Style:" then
		local applytostyle = string.sub(config.applyto,8)
		for i = 1, #subtitles do 
			if jumpblob.islineapplicable(subtitles[i]) and subtitles[i].style == applytostyle then
				table.insert(subs,i)
			end
		end
	elseif string.sub(config.applyto,1,6) == "Actor:" then -- v2.03 apply to actor
		local applytoactor = string.sub(config.applyto,8)
		for i = 1, #subtitles do 
			if jumpblob.islineapplicable(subtitles[i]) and subtitles[i].actor == applytoactor then
				table.insert(subs,i)
			end
		end
	end
	-- mode setting
	config.forcetop, config.wavemode = false, false
	config.baseangle = 180
	if config.mode == jumpblob.str("mode_forcetop") then config.forcetop = true
	elseif config.mode == jumpblob.str("mode_wave") then config.wavemode = true
	end
	-- advanced setting
	local advcfg = loadstring("return {".. config.advancedcfg .."}")
	config.advanced = advcfg()	
	if config.advanced.delay then config.delay = config.advanced.delay else config.delay = 0 end
	if config.advanced.xmod then config.xmod = config.advanced.xmod else config.xmod = 0 end
	if config.advanced.ymod then config.ymod = config.advanced.ymod else config.ymod = 0 end
	if config.advanced.acc then config.acc = config.advanced.acc else config.acc = 1 end
	if config.wavemode and config.advanced.wave_angle and config.advanced.wave_angle > 0 and config.advanced.wave_angle < 360 then 
		config.baseangle = config.advanced.wave_angle
	end

	-- first/last syl setting
	config.firstlastadj = loadstring("return function(config, meta, syl, line, linex) return {".. config.firstlast .."} end")()
	
	-- save config
	if config.saveconfig then
		jumpblob.conf[1].value = config.mode
		jumpblob.conf[2].value = config.applyto
		jumpblob.conf[3].value = config.blobstyle
		jumpblob.conf[4].text = config.blob
		jumpblob.conf[5].value = config.leadin
		jumpblob.conf[6].value = config.leadout
		jumpblob.conf[7].value = config.fadein
		jumpblob.conf[8].value = config.fadeout
		jumpblob.conf[9].text = config.advancedcfg
		jumpblob.conf[26].value = config.insertat
		jumpblob.conf[28].text = config.firstlast
	end
	jumpblob.conf[11].value = config.saveconfig
		
	-- process them
	local lasti = 0
	local count = 0
	local newlines = 0
	local collect = {} -- to use if "insert blob lines at end" mode
	for _, i in pairs(subs) do
		count = count + 1
		aegisub.progress.set(count * 100 / #subs)
		for j = lasti + 1, i - 1 do
			table.insert(subtitles2, subtitles[j])
		end
		local l = subtitles[i]
		local res = jumpblob.do_line(meta, styles, config, subtitles, l)
		local bstyle = config.blobstyle
		if bstyle == jumpblob.str("samewithline") then bstyle = l.style end

		if config.insertat ~= jumpblob.str("insertat_before") then table.insert(subtitles2, l) end
		if config.insertat == jumpblob.str("insertat_end") then
			toinsert = collect
		else
			toinsert = subtitles2
		end
		for j = 1, #res do
			res[j].actor = config.label
			res[j].style = bstyle
			res[j].comment = false -- v2.04: uncomment blob lines should the original line is a comment
			table.insert(toinsert, res[j])
			newlines = newlines + 1
		end
		if config.insertat == jumpblob.str("insertat_before") then table.insert(subtitles2, l) end
		lasti = i
		aegisub.progress.task(count .. " / " .. #subs .. " lines processed, " .. newlines .. " blob lines generated")
	end
	for j = lasti + 1, #subtitles do
		table.insert(subtitles2, subtitles[j])
	end

	-- clear subtitles and rebuild
	subtitles.deleterange(1, #subtitles)
	subtitles.delete(1)
	for j = 1, #subtitles2 do
		subtitles[0] = subtitles2[j]
	end
	for j = 1, #collect do
		subtitles[0] = collect[j]
	end
end

function jumpblob.do_line(meta, styles, config, subtitles, line)
	-- use exxact library
	exxact.calc_syl_pos(meta, styles, subtitles, line)

	-- temp var for blob calculations
	local linex = { 
		bloblines = {}; last = { dur = config.leadin; syl = nil };
		angle = -config.baseangle; odd = false
	}

	local anglemods = { minus_angle = 0; plus_angle = 0 }
	for i = 0, #line.kara do
		if line.kara[i] then jumpblob.pre_do_syl(meta, styles, config, line, line.kara[i], anglemods) end
	end

	-- determine angle
	if config.wavemode then
		if config.advanced.wave_ccw then linex.angle = -linex.angle end
	else
		if (anglemods.plus_angle > anglemods.minus_angle) then
			linex.angle = config.baseangle
		end
	end

	for i = 0, #line.kara do
		if line.kara[i] then jumpblob.do_syl(meta, styles, config, line, line.kara[i], linex) end
	end
	--finishing blob of the line
	if linex.last.syl then
		local syl = linex.last.syl
		local nline = table.copy(line)
		local lastsyldur = linex.last.dur + config.leadout
		nline.start_time = nline.start_time + linex.last.syl.start_time + config.delay
		nline.end_time = nline.start_time + lastsyldur
		linex.dur = nline.end_time - nline.start_time
		local heightplusymod, halfheightplusymod = line.height + config.ymod, line.height / 2 + config.ymod
		local firstlastadj = config.firstlastadj(config, meta, syl, line, linex)
		local lastex = {
			[1] = { x = syl.left + firstlastadj.last[1], y = -config.ymod + firstlastadj.last[2]};
			[2] = { x = syl.center + firstlastadj.last[1], y = -config.ymod + firstlastadj.last[2] };
			[3] = { x = syl.right + firstlastadj.last[1], y = -config.ymod + firstlastadj.last[2] };
			[4] = { x = syl.left + firstlastadj.last[1], y = halfheightplusymod + firstlastadj.last[2] };
			[5] = { x = syl.center + firstlastadj.last[1], y = halfheightplusymod + firstlastadj.last[2] };
			[6] = { x = syl.right + firstlastadj.last[1], y = halfheightplusymod + firstlastadj.last[2] };
			[7] = { x = syl.left + firstlastadj.last[1], y = heightplusymod + firstlastadj.last[2] };
			[8] = { x = syl.center + firstlastadj.last[1], y = heightplusymod + firstlastadj.last[2] };
			[9] = { x = syl.right + firstlastadj.last[1], y = heightplusymod + firstlastadj.last[2] }
		}
		local expos = syl.exxact(syl.start_time)
		for i = 1, 9 do
			lastex[i].x, lastex[i].y = expos(lastex[i].x + config.xmod, lastex[i].y)
		end
		local blob = jumpblob.do_blob(meta, styles, config, line, linex.last.syl, linex)	
		local ex, cntr_base = linex.last.currex, linex.last.cntr_base
		local fromx, fromy = ex[cntr_base].x, ex[cntr_base].y
		local tox, toy = lastex[cntr_base].x, lastex[cntr_base].y
		local orgx, orgy = (fromx + tox) / 2, (fromy + toy) / 2
		local orgdx, orgdy = orgx - fromx, orgy - fromy
		if firstlastadj.last[1] > 0 then diffangle = linex.angle else diffangle = -linex.angle end
		local jump = jumpblob.do_jump(config, linex, orgx, orgy, orgdx, orgdy, tox, toy, fromx, fromy, lastsyldur, -linex.angle, interpolate(firstlastadj.last[3],-linex.angle,-linex.angle+diffangle), 0, interpolate(firstlastadj.last[3],0,diffangle))
		nline.text = string.format("{\\an5\\fad(0,%d)%s}" .. blob, config.fadeout, jump)
		table.insert(linex.bloblines, nline)
	end -- if
	
	return linex.bloblines
end

function jumpblob.pre_do_syl(meta, styles, config, line, syl, anglemods)
	local heightplusymod, halfheightplusymod = line.height + config.ymod, line.height / 2 + config.ymod
	local currex = {
		[1] = { x = syl.left, y = -config.ymod };
		[2] = { x = syl.center, y = -config.ymod };
		[3] = { x = syl.right, y = -config.ymod };
		[4] = { x = syl.left, y = halfheightplusymod };
		[5] = { x = syl.center, y = halfheightplusymod };
		[6] = { x = syl.right, y = halfheightplusymod };
		[7] = { x = syl.left, y = heightplusymod };
		[8] = { x = syl.center, y = heightplusymod };
		[9] = { x = syl.right, y = heightplusymod }
	}

	local expos = syl.exxact(syl.start_time)
	for i = 1, 9 do
		currex[i].x, currex[i].y = expos(currex[i].x + config.xmod, currex[i].y)
	end
	syl.currex = currex
	
	-- new feature in v2: automatically determine whether blob jumps on top or below the syllable (any rotations are also considered)
	local minus_angle = true
	if not config.forcetop then -- well, if user doesn't want jumpblob to determine
		-- first determine slope
		local xdiff = currex[6].x - currex[4].x
		if xdiff ~= 0 then slope = math.abs((currex[6].y - currex[4].y) / xdiff) end
		if xdiff == 0 or slope > 1 then -- more vertical then horizontal
			-- look in x-direction
			if meta.res_x - currex[5].x > currex[5].x then -- near to the left
				minus_angle = true
			else -- near to the right
				minus_angle = false
			end
			-- ohnoes! reverse
			if currex[6].y < currex[4].y then minus_angle = not minus_angle end
		else -- more horizontal than vertical
			-- look in y-direction
			if meta.res_y - currex[5].y > currex[5].y then -- near to the top
				minus_angle = false
			else -- near to the bottom
				minus_angle = true
			end
			-- ohnoes! reverse
			if currex[6].x < currex[4].x then minus_angle = not minus_angle end
		end
	end
	if minus_angle then
		anglemods.minus_angle = anglemods.minus_angle + 1 
	else
		anglemods.plus_angle = anglemods.plus_angle + 1 
	end
end

function jumpblob.do_syl(meta, styles, config, line, syl, linex)
	if syl.duration == 0 then return end

	if string.trim(syl.text_stripped) == "" then
		linex.last.dur = linex.last.dur + syl.duration
		return
	end

	-- index of center base point in the syllable based on rotation
	local cntr_base = 0
	if config.wavemode then
		cntr_base = 5
	else
		-- -180 rotation: blob jumps on top => center base = point 2
		-- 180 rotation: blob jumps below => center base = point 8
		if linex.angle == -config.baseangle then cntr_base = 2 else cntr_base = 8 end
	end
	
	local nline = table.copy(line)
	local currex = syl.currex
	nline.end_time = nline.start_time + syl.start_time + config.delay
	nline.start_time = nline.end_time - linex.last.dur
	if nline.start_time < 0 then nline.start_time = 0 end
	linex.dur = nline.end_time - nline.start_time

	local blob = jumpblob.do_blob(meta, styles, config, line, syl, linex)	
	if linex.last.syl then
		local lastex = linex.last.currex[linex.last.cntr_base]
		local fromx, fromy = lastex.x, lastex.y
		local tox, toy = currex[cntr_base].x, currex[cntr_base].y
		local orgx, orgy = (fromx + tox) / 2, (fromy + toy) / 2
		local orgdx, orgdy = orgx - fromx, orgy - fromy
		local jump = jumpblob.do_jump(config, linex, orgx, orgy, orgdx, orgdy, tox, toy, fromx, fromy, linex.last.dur, -linex.angle, 0, 0, linex.angle)
		nline.text = string.format("{\\an5%s}" .. blob, jump)
	else -- first effective syllable in the line
		local heightplusymod, halfheightplusymod = line.height + config.ymod, line.height / 2 + config.ymod
		local firstlastadj = config.firstlastadj(config, meta, syl, line, linex)
		local firstex = {
			[1] = { x = syl.left + firstlastadj.first[1], y = -config.ymod + firstlastadj.first[2]};
			[2] = { x = syl.center + firstlastadj.first[1], y = -config.ymod + firstlastadj.first[2] };
			[3] = { x = syl.right + firstlastadj.first[1], y = -config.ymod + firstlastadj.first[2] };
			[4] = { x = syl.left + firstlastadj.first[1], y = halfheightplusymod + firstlastadj.first[2] };
			[5] = { x = syl.center + firstlastadj.first[1], y = halfheightplusymod + firstlastadj.first[2] };
			[6] = { x = syl.right + firstlastadj.first[1], y = halfheightplusymod + firstlastadj.first[2] };
			[7] = { x = syl.left + firstlastadj.first[1], y = heightplusymod + firstlastadj.first[2] };
			[8] = { x = syl.center + firstlastadj.first[1], y = heightplusymod + firstlastadj.first[2] };
			[9] = { x = syl.right + firstlastadj.first[1], y = heightplusymod + firstlastadj.first[2] }
		}
		local expos = syl.exxact(syl.start_time)
		for i = 1, 9 do
			firstex[i].x, firstex[i].y = expos(firstex[i].x + config.xmod, firstex[i].y)
		end
		local fromx, fromy = firstex[cntr_base].x, firstex[cntr_base].y
		local orgx, orgy = (fromx + currex[cntr_base].x) / 2, (fromy + currex[cntr_base].y) / 2
		local orgdx, orgdy = orgx - fromx, orgy - fromy
		if firstlastadj.first[1] > 0 then startangle = 2 * linex.angle else startangle = 0 end
		local jump = jumpblob.do_jump(config, linex, orgx, orgy, orgdx, orgdy, nil, nil, fromx, fromy, linex.last.dur, nil, nil, interpolate(firstlastadj.first[3], linex.angle, startangle), linex.angle)
   		nline.text = string.format("{\\an5\\fad(%d,0)%s}" .. blob, config.fadein, jump)
	end
	table.insert(linex.bloblines, nline)
	linex.last = { dur = syl.duration; syl = syl; currex = currex; cntr_base = cntr_base; blob = blob }
	linex.odd = not linex.odd
	if config.wavemode then linex.angle = -linex.angle end
end

function jumpblob.do_jump(config, linex, orgx, orgy, orgdx, orgdy, tox, toy, fromx, fromy, dur, angle0_odd, angle1_odd, angle0_even, angle1_even)
	local jump = ""
	if config.baseangle ~= 0 and config.baseangle ~= 180 then
		local tan_theta, b = math.tan(math.rad(config.baseangle) / 2), math.sqrt(orgdx * orgdx + orgdy * orgdy)
		local a, phi = b / tan_theta, math.atan2(orgdy, orgdx)
		local norgdy, norgdx = -a * math.cos(phi), a * math.sin(phi)		
		if linex.angle < 0 then orgx, orgy = orgx - norgdx, orgy - norgdy else orgx, orgy = orgx + norgdx, orgy + norgdy end
	end
	if linex.odd then 
		jump = jumpblob.jump_string(orgx, orgy, tox, toy, dur, config.acc, angle0_odd, angle1_odd)
	else 
		jump = jumpblob.jump_string(orgx, orgy, fromx, fromy, dur, config.acc, angle0_even, angle1_even)
	end
	return jump
end

function jumpblob.jump_string(xorg, yorg, xblob, yblob, dur, acc, startangle, endangle)
  	return string.format("\\org(%d,%d)\\pos(%d,%d)\\frz%d\\t(0,%d,%f,\\frz%d)", xorg, yorg, xblob, yblob, startangle, dur, acc, endangle)
end

function jumpblob.do_blob(meta, styles, config, line, syl, linex)
	local blob = config.blob
	function round(val) return math.floor(val + 0.5) end
	blob, _ = string.gsub(blob, "%$syl%$", syl.text_stripped)
	blob, _ = string.gsub(blob, "%$halfdur%$", round(linex.dur / 2))	
	blob, _ = string.gsub(blob, "%$dur%$", linex.dur)
	blob, _ = string.gsub(blob, "%$kdur%$", round(linex.dur / 10))	
	return blob
end

function jumpblob.prepareconfig(styles, subtitles, has_selected_lines)
	-- configuration
	oldapplytovalue = jumpblob.conf[2].value
	oldbstylevalue = jumpblob.conf[3].value
	jumpblob.conf[2].items = {}
	jumpblob.conf[2].value = jumpblob.str("toall")
	table.insert(jumpblob.conf[2].items, jumpblob.conf[2].value) 
	jumpblob.conf[3].items = {}
	jumpblob.conf[3].value = jumpblob.str("samewithline")
	table.insert(jumpblob.conf[3].items, jumpblob.conf[3].value) 
	if has_selected_lines then 
		applytoselected = jumpblob.str("selectedlines")
		table.insert(jumpblob.conf[2].items, applytoselected)
		if oldapplytovalue == applytoselected then jumpblob.conf[2].value = applytoselected end
	end
	-- new in 2.03: apply to lines with specific Actor
	-- new in 2.04: apply to lines with specific Effect
	local astyles, actors, effects = {}, {}, {}
	for i = 1, #subtitles do
		if jumpblob.islineapplicable(subtitles[i]) then
			if subtitles[i].style ~= "" and not astyles[subtitles[i].style] then 
				astyles[subtitles[i].style] = true
				applytostyle = "Style: " .. subtitles[i].style
				table.insert(jumpblob.conf[2].items, applytostyle)
				if oldapplytovalue == applytostyle then jumpblob.conf[2].value = applytostyle end
			end
			if subtitles[i].actor ~= "" and not actors[subtitles[i].actor] then 
				actors[subtitles[i].actor] = true
				applytoactor = "Actor: " .. subtitles[i].actor
				table.insert(jumpblob.conf[2].items, applytoactor)
				if oldapplytovalue == applytoactor then jumpblob.conf[2].value = applytoactor end
			end
			if subtitles[i].effect ~= "" and not effects[subtitles[i].effect] then 
				effects[subtitles[i].effect] = true
				applytoeffect = "Effect: " .. subtitles[i].effect
				table.insert(jumpblob.conf[2].items, applytoeffect)
				if oldapplytovalue == applytoeffect then jumpblob.conf[2].value = applytoeffect end
			end
		end 
	end
	-- random label
	math.randomseed(os.time())
	jumpblob.conf[10].text = string.format("blob_%d", math.random(100000,999999))
end

function jumpblob.macro(subtitles, selected_lines, active_line)
	local meta, styles = karaskel.collect_head(subtitles)

	-- configuration
	jumpblob.prepareconfig(styles, subtitles, #selected_lines > 0)
	local cfg_res, config = aegisub.dialog.display(jumpblob.conf)
	
	if cfg_res then
		jumpblob.process(meta, styles, config, subtitles, selected_lines, active_line)
		aegisub.set_undo_point(script_name)
		aegisub.progress.task("Done")
	else
		aegisub.progress.task("Cancelled");	
	end
end

function jumpblob.process_filter(subtitles, config)
	local meta, styles = karaskel.collect_head(subtitles)
	jumpblob.process(meta, styles, config, subtitles, nil, nil)
	aegisub.progress.task("Done")
end

function jumpblob.filter_options_dialog(subtitles, stored_options)
	local meta, styles = karaskel.collect_head(subtitles)
	jumpblob.prepareconfig(styles, subtitles, false)
	return jumpblob.conf
end

function jumpblob.islineapplicable(line)
	if line.class ~= "dialogue" then return false end
	if not line.comment then return true end
	local effect, _ = string.headtail(line.effect)
	return (effect == "karaoke" or effect == "fx")
end	


aegisub.register_macro(script_name, script_description, jumpblob.macro)
aegisub.register_filter(script_name, script_description, 2000, jumpblob.process_filter, jumpblob.filter_options_dialog)
