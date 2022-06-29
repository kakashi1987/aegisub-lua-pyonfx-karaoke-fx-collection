--Gekijouban Mahou Shoujo Madoka Magica 3: Hangyaku no Monogatari OP
--Karaoke by Amberdrake
--LVS
ass.load("J:\\AmberdrakeSubs\\Madoka Magica\\03\\madoka_magica_3_[OP][k-timed].ass")
local function bord(ctx, ms, line)
	for si, syl in ipairs(line.syls) do
		if ms >= line.start_time and ms < syl.start_time or ms >= syl.end_time and ms < line.end_time and syl.text ~= "" then
			local bordcolor = g2d.create_color((124*1/255), (117*1/255), (177*1/255), 1)
			text = g2d.create_image("RGBA", syl.width+20, syl.height+20)
			local tctx = text:get_context()
			tctx:path_add_text(5, 0, syl.text, ass.unpack_font(line.styleref))
			tctx:set_line_width(7)
			tctx:set_source(bordcolor)
			tctx:stroke()
			text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(5)))
			text:set_matrix(g2d.create_matrix()
			:translate(syl.x-5, syl.y)
			)
			ctx:set_source(text)
			ctx:paint()
		end
	end
end
local function fill(ctx, ms, line)
	for si, syl in ipairs(line.syls) do
		if ms >= line.start_time and ms < syl.start_time or ms >= syl.end_time and ms < line.end_time and syl.text ~= "" then
			local textcolor = g2d.create_color((253*1/255), (253*1/255), (255*1/255), 1)
			local pic = g2d.create_image_from_png("J:\\AmberdrakeSubs\\Madoka Magica\\03\\feather.png")
			local text = g2d.create_image("RGBA", syl.width, syl.height)
			local tctx = text:get_context()
			tctx:path_add_text(0, 0, syl.text, ass.unpack_font(line.styleref))
			tctx:set_source(textcolor)
			tctx:fill()
			local img = g2d.create_pattern(pic)
			img:set_matrix(g2d.create_matrix()
			:translate(line.x - syl.x, 0)
			)
			img:set_extender("MIRROR")
			tctx:set_source(img)
			tctx:fill()
			text = g2d.create_pattern(text)
			text:set_matrix(g2d.create_matrix()
			:translate(syl.x, syl.y)
			)
			ctx:set_source(text)
			ctx:paint()
		end
	end
end
local function syl_fx_bord(ctx, ms, line)
	for si, syl in ipairs(line.syls) do
		if ms >= syl.start_time and ms < syl.end_time and syl.text ~= "" then
			local bordcolor = g2d.create_color((124*1/255), (117*1/255), (177*1/255), 1)
			local ang = math.rad(math.interpolate(90, 180, math.inrange(syl.start_time, syl.end_time, ms)))
			local sc = math.sin(ang)/4
			text = g2d.create_image("RGBA", syl.width+20, syl.height+20)
			local tctx = text:get_context()
			tctx:path_add_text(5, 0, syl.text, ass.unpack_font(line.styleref))
			tctx:set_line_width(7)
			tctx:set_source(bordcolor)
			tctx:stroke()
			text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(5)))
			text:set_matrix(g2d.create_matrix()
			:translate(syl.width/2 + syl.x-5, syl.height/2 + syl.y)
			:scale(1+sc, 1+sc)
			:translate(-syl.width/2,-syl.height/2)
			:scale(1, 1)
			)
			ctx:set_source(text)
			ctx:paint()
		end
	end
end
local function syl_fx(ctx, ms, line)
	for si, syl in ipairs(line.syls) do
		if ms >= syl.start_time and ms < syl.end_time and syl.text ~= "" then
			local pic = g2d.create_image_from_png("J:\\AmberdrakeSubs\\Madoka Magica\\03\\feather.png")
			local textcolor = g2d.create_color((253*1/255), (253*1/255), (255*1/255), 1)
			local ang = math.rad(math.interpolate(90, 180, math.inrange(syl.start_time, syl.end_time, ms)))
			local sc = math.sin(ang)/4
			local text = g2d.create_image("RGBA", syl.width, syl.height)
			local tctx = text:get_context()
			tctx:path_add_text(0, 0, syl.text, ass.unpack_font(line.styleref))
			tctx:set_source(textcolor)
			tctx:fill()
			local img = g2d.create_pattern(pic)
			local pct = math.sin((math.inrange(syl.start_time, syl.end_time, ms) * math.pi))
			local mov = math.interpolate(0, 10, pct)
			local rot = math.interpolate(0, 45, pct)
			img:set_matrix(g2d.create_matrix()
			:translate(line.x - syl.x+mov, mov)
			:rotate(rot)
			)
			img:set_extender("MIRROR")
			tctx:set_source(img)
			tctx:fill()
			text = g2d.create_pattern(text)
			text:set_matrix(g2d.create_matrix()
			:translate(syl.width/2 + syl.x, syl.height/2 + syl.y)
			:scale(1+sc, 1+sc)
			:translate(-syl.width/2,-syl.height/2)
			:scale(1, 1)
			)
			ctx:set_source(text)
			ctx:masked_paint(text)
		end
	end
end

local function romanji_bord_infade(ctx, ms, line)
	line.infade=2000
	if line.style == "OP_romanji" then
		for si, syl in ipairs(line.syls) do
			if ms >= line.start_time-line.infade + 50*syl.i and ms < line.start_time and syl.text ~= "" then
				local pct = math.sin((math.inrange(line.start_time-line.infade + 50*syl.i, line.start_time, ms) * math.pi)/2)
				local alpha = math.interpolate(0, 1 , pct)
				local bordcolor = g2d.create_color((124*1/255), (117*1/255), (177*1/255), alpha)
				text = g2d.create_image("RGBA", syl.width+20, syl.height+20)
				local tctx = text:get_context()
				tctx:path_add_text(5, 0, syl.text, ass.unpack_font(line.styleref))
				tctx:set_line_width(7)
				tctx:set_source(bordcolor)
				tctx:stroke()
				text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(5)))
				local xpos = math.interpolate(syl.x-3*syl.i-250, syl.x, pct)
				local ang = math.rad(math.interpolate(0, 360, math.inrange(line.start_time-line.infade + 50*syl.i, line.start_time, ms)))
				local ypos = math.sin(ang)*20
				text:set_matrix(g2d.create_matrix()
				:translate(xpos-5, ypos)
				)
				ctx:set_source(text)
				ctx:paint()
			end
		end
	end
end
local function kanji_bord_infade(ctx, ms, line)
	line.infade=2000
	if line.style == "OP_kanji" then
		for si, syl in ipairs(line.syls) do
			if ms >= line.start_time-line.infade + 50*syl.i and ms < line.start_time and syl.text ~= "" then
				local pct = math.sin((math.inrange(line.start_time-line.infade + 50*syl.i, line.start_time, ms) * math.pi)/2)
				local alpha = math.interpolate(0, 1 , pct)
				local bordcolor = g2d.create_color((124*1/255), (117*1/255), (177*1/255), alpha)
				text = g2d.create_image("RGBA", syl.width+20, syl.height+20)
				local tctx = text:get_context()
				tctx:path_add_text(5, 0, syl.text, ass.unpack_font(line.styleref))
				tctx:set_line_width(7)
				tctx:set_source(bordcolor)
				tctx:stroke()
				text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(5)))
				local xpos = math.interpolate(syl.x-3*syl.i-250, syl.x, pct)
				local ang = math.rad(math.interpolate(180, 540, math.inrange(line.start_time-line.infade + 50*syl.i, line.start_time, ms)))
				local ypos = math.sin(ang)*20
				text:set_matrix(g2d.create_matrix()
				:translate(xpos-5, ypos+55)
				)
				ctx:set_source(text)
				ctx:paint()
			end
		end
	end
end
local function romanji_fill_infade(ctx, ms, line)
	line.infade=2000
	if line.style == "OP_romanji" then
		for si, syl in ipairs(line.syls) do
			if ms >= line.start_time-line.infade + 50*syl.i and ms < line.start_time and syl.text ~= "" then
				local pct = math.sin((math.inrange(line.start_time-line.infade + 50*syl.i, line.start_time, ms) * math.pi)/2)
				local alpha = math.interpolate(0, 1 , pct)
				local textcolor = g2d.create_color((253*1/255), (253*1/255), (255*1/255), 1)
				local pic = g2d.create_image_from_png("J:\\AmberdrakeSubs\\Madoka Magica\\03\\feather.png")
				local text = g2d.create_image("RGBA", syl.width, syl.height)
				local tctx = text:get_context()
				tctx:path_add_text(0, 0, syl.text, ass.unpack_font(line.styleref))
				tctx:set_source(textcolor)
				tctx:fill()
				local img = g2d.create_pattern(pic)
				img:set_matrix(g2d.create_matrix()
				:translate(line.x - syl.x, 0)
				)
				img:set_extender("MIRROR")
				tctx:set_source(img)
				tctx:fill()
				text = g2d.create_pattern(text)
				local xpos = math.interpolate(syl.x-3*syl.i-250, syl.x, pct)
				local ang = math.rad(math.interpolate(0, 360, math.inrange(line.start_time-line.infade + 50*syl.i, line.start_time, ms)))
				local ypos = math.sin(ang)*20
				text:set_matrix(g2d.create_matrix()
				:translate(xpos, ypos)
				)
				ctx:set_source(text)
				ctx:masked_paint(alpha)
			end
		end
	end
end
local function kanji_fill_infade(ctx, ms, line)
	line.infade=2000
	if line.style == "OP_kanji" then
		for si, syl in ipairs(line.syls) do
			if ms >= line.start_time-line.infade + 50*syl.i and ms < line.start_time and syl.text ~= "" then
				local pct = math.sin((math.inrange(line.start_time-line.infade + 50*syl.i, line.start_time, ms) * math.pi)/2)
				local alpha = math.interpolate(0, 1 , pct)
				local textcolor = g2d.create_color((253*1/255), (253*1/255), (255*1/255), 1)
				local pic = g2d.create_image_from_png("J:\\AmberdrakeSubs\\Madoka Magica\\03\\feather.png")
				local text = g2d.create_image("RGBA", syl.width, syl.height)
				local tctx = text:get_context()
				tctx:path_add_text(0, 0, syl.text, ass.unpack_font(line.styleref))
				tctx:set_source(textcolor)
				tctx:fill()
				local img = g2d.create_pattern(pic)
				img:set_matrix(g2d.create_matrix()
				:translate(line.x - syl.x, 0)
				)
				img:set_extender("MIRROR")
				tctx:set_source(img)
				tctx:fill()
				text = g2d.create_pattern(text)
				local xpos = math.interpolate(syl.x-3*syl.i-250, syl.x, pct)
				local ang = math.rad(math.interpolate(180, 540, math.inrange(line.start_time-line.infade + 50*syl.i, line.start_time, ms)))
				local ypos = math.sin(ang)*20
				text:set_matrix(g2d.create_matrix()
				:translate(xpos, ypos+55)
				)
				ctx:set_source(text)
				ctx:masked_paint(alpha)
			end
		end
	end
end
local function romanji_bord_outfade(ctx, ms, line)
	line.outfade=2000
	if line.style == "OP_romanji" then
		for si, syl in ipairs(line.syls) do
			if ms >= line.end_time and ms < line.end_time + line.outfade - 50*syl.i and syl.text ~= "" then
				local pct = math.sin((math.inrange(line.end_time, line.end_time + line.outfade - 50*syl.i, ms) * math.pi)/2)
				local alpha = math.interpolate(1, 0 , pct)
				local bordcolor = g2d.create_color((124*1/255), (117*1/255), (177*1/255), alpha)
				text = g2d.create_image("RGBA", syl.width+20, syl.height+20)
				local tctx = text:get_context()
				tctx:path_add_text(5, 0, syl.text, ass.unpack_font(line.styleref))
				tctx:set_line_width(7)
				tctx:set_source(bordcolor)
				tctx:stroke()
				text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(5)))
				local xpos = math.interpolate(syl.x, syl.x+3*syl.i+250, pct)
				local ang = math.rad(math.interpolate(180, 540, math.inrange(line.end_time, line.end_time + line.outfade - 50*syl.i, ms)))
				local ypos = math.sin(ang)*20
				text:set_matrix(g2d.create_matrix()
				:translate(xpos-5, ypos)
				)
				ctx:set_source(text)
				ctx:paint()
			end
		end
	end
end
local function kanji_bord_outfade(ctx, ms, line)
	line.outfade=2000
	if line.style == "OP_kanji" then
		for si, syl in ipairs(line.syls) do
			if ms >= line.end_time and ms < line.end_time + line.outfade - 50*syl.i and syl.text ~= "" then
				local pct = math.sin((math.inrange(line.end_time, line.end_time + line.outfade - 50*syl.i, ms) * math.pi)/2)
				local alpha = math.interpolate(1, 0 , pct)
				local bordcolor = g2d.create_color((124*1/255), (117*1/255), (177*1/255), alpha)
				text = g2d.create_image("RGBA", syl.width+20, syl.height+20)
				local tctx = text:get_context()
				tctx:path_add_text(5, 0, syl.text, ass.unpack_font(line.styleref))
				tctx:set_line_width(7)
				tctx:set_source(bordcolor)
				tctx:stroke()
				text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(5)))
				local xpos = math.interpolate(syl.x, syl.x+3*syl.i+250, pct)
				local ang = math.rad(math.interpolate(0, 360, math.inrange(line.end_time, line.end_time + line.outfade - 50*syl.i, ms)))
				local ypos = math.sin(ang)*20
				text:set_matrix(g2d.create_matrix()
				:translate(xpos-5, ypos+55)
				)
				ctx:set_source(text)
				ctx:paint()
			end
		end
	end
end
local function romanji_fill_outfade(ctx, ms, line)
	line.outfade=2000
	if line.style == "OP_romanji" then
		for si, syl in ipairs(line.syls) do
			if ms >= line.end_time and ms < line.end_time + line.outfade - 50*syl.i and syl.text ~= "" then
				local pct = math.sin((math.inrange(line.end_time, line.end_time + line.outfade - 50*syl.i, ms) * math.pi)/2)
				local alpha = math.interpolate(1, 0 , pct)
				local textcolor = g2d.create_color((253*1/255), (253*1/255), (255*1/255), 1)
				local pic = g2d.create_image_from_png("J:\\AmberdrakeSubs\\Madoka Magica\\03\\feather.png")
				local text = g2d.create_image("RGBA", syl.width, syl.height)
				local tctx = text:get_context()
				tctx:path_add_text(0, 0, syl.text, ass.unpack_font(line.styleref))
				tctx:set_source(textcolor)
				tctx:fill()
				local img = g2d.create_pattern(pic)
				img:set_matrix(g2d.create_matrix()
				:translate(line.x - syl.x, 0)
				)
				img:set_extender("MIRROR")
				tctx:set_source(img)
				tctx:fill()
				text = g2d.create_pattern(text)
				local xpos = math.interpolate(syl.x, syl.x+3*syl.i+250, pct)
				local ang = math.rad(math.interpolate(180, 540, math.inrange(line.end_time, line.end_time + line.outfade - 50*syl.i, ms)))
				local ypos = math.sin(ang)*20
				text:set_matrix(g2d.create_matrix()
				:translate(xpos, ypos)
				)
				ctx:set_source(text)
				ctx:masked_paint(alpha)
			end
		end
	end
end
local function kanji_fill_outfade(ctx, ms, line)
	line.outfade=2000
	if line.style == "OP_kanji" then
		for si, syl in ipairs(line.syls) do
			if ms >= line.end_time and ms < line.end_time + line.outfade - 50*syl.i and syl.text ~= "" then
				local pct = math.sin((math.inrange(line.end_time, line.end_time + line.outfade - 50*syl.i, ms) * math.pi)/2)
				local alpha = math.interpolate(1, 0 , pct)
				local textcolor = g2d.create_color((253*1/255), (253*1/255), (255*1/255), 1)
				local pic = g2d.create_image_from_png("J:\\AmberdrakeSubs\\Madoka Magica\\03\\feather.png")
				local text = g2d.create_image("RGBA", syl.width, syl.height)
				local tctx = text:get_context()
				tctx:path_add_text(0, 0, syl.text, ass.unpack_font(line.styleref))
				tctx:set_source(textcolor)
				tctx:fill()
				local img = g2d.create_pattern(pic)
				img:set_matrix(g2d.create_matrix()
				:translate(line.x - syl.x, 0)
				)
				img:set_extender("MIRROR")
				tctx:set_source(img)
				tctx:fill()
				text = g2d.create_pattern(text)
				local xpos = math.interpolate(syl.x, syl.x+3*syl.i+250, pct)
				local ang = math.rad(math.interpolate(0, 360, math.inrange(line.end_time, line.end_time + line.outfade - 50*syl.i, ms)))
				local ypos = math.sin(ang)*20
				text:set_matrix(g2d.create_matrix()
				:translate(xpos, ypos+55)
				)
				ctx:set_source(text)
				ctx:masked_paint(alpha)
			end
		end
	end
end
function GetFrame(frame, frame_i)
	local ctx = frame:get_context()
	local ms = frame_i / VIDEO_FPS * 1000
	for li, line in ipairs(lines) do
		if ms >= line.start_time-line.infade and ms < line.end_time+line.outfade then
			romanji_bord_infade(ctx, ms, line)
			kanji_bord_infade(ctx, ms, line)
			romanji_fill_infade(ctx, ms, line)
			kanji_fill_infade(ctx, ms, line)
			romanji_bord_outfade(ctx, ms, line)
			kanji_bord_outfade(ctx, ms, line)
			romanji_fill_outfade(ctx, ms, line)
			kanji_fill_outfade(ctx, ms, line)
			bord(ctx, ms, line)
			fill(ctx, ms, line)
			syl_fx_bord(ctx, ms, line)
			syl_fx(ctx, ms, line)
		end
	end
end