--Black Bullet Opening
--Karaoke by Amberdrake
--LVS

ass.load("Black Bullet OP.ass")
local function infade_outline(ctx, ms, line)
	if line.infade > 500 then
		line.infade = 500
	end
	for si, syl in ipairs(line.syls) do
		if ms >= line.start_time-line.infade and ms < line.start_time and syl.text ~= "" then
			local pct = math.sin((math.inrange(line.start_time-line.infade, line.start_time, ms) * math.pi)/2)
			local alpha = math.interpolate(0, 1 , pct)
			local bordcolor = g2d.create_color(0, 0, 0, 1)
			text = g2d.create_image("RGBA", syl.width+20, syl.height+20)
			local tctx = text:get_context()
			tctx:path_add_text(5, 0, syl.text, ass.unpack_font(line.styleref))
			tctx:set_line_width(1)
			tctx:set_source(bordcolor)
			tctx:stroke()
			text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(1)))
			text:set_matrix(g2d.create_matrix()
			:translate(syl.x-5, syl.y)
			)
			ctx:set_source(text)
			ctx:masked_paint(alpha)
		end
	end
end
local function infade_L1(ctx, ms, line)
	if line.infade > 250 then
		line.infade = 250
	end
	for si, syl in ipairs(line.syls) do
		if ms >= line.start_time-line.infade and ms < line.start_time and syl.text ~= "" then
			local pct = math.sin((math.inrange(line.start_time-line.infade, line.start_time, ms) * math.pi)/2)
			local alpha = math.interpolate(0, 1 , pct)
			local fill_color = g2d.create_color(math.interpolate((133/255),(242/255),pct), math.interpolate((34/255),(235/255),pct), math.interpolate((47/255),(242/255),pct), 1)
			local pic = g2d.create_image_from_png("pattern.png")
			ctx:path_add_text(syl.x, syl.y, syl.text, ass.unpack_font(line.styleref))
			local text = g2d.create_image("RGBA", syl.width, syl.height)
			local tctx = text:get_context()
			tctx:path_add_text(0, 0, syl.text, ass.unpack_font(line.styleref))
			tctx:set_source(fill_color)
			tctx:fill()
			local img = g2d.create_pattern(pic)
			img:set_matrix(g2d.create_matrix()
			:translate(line.x - syl.x, 0)
			)
			img:set_extender("MIRROR")
			tctx:set_source(img)
			tctx:fill()
			text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(0.2)))
			text:set_matrix(g2d.create_matrix()
			:translate(syl.x, syl.y)
			)
			ctx:set_source(text)
			ctx:masked_paint(alpha)
		end
	end
end
local function infade_L2(ctx, ms, line)
	if line.infade > 250 then
		line.infade = 250
	end
	for si, syl in ipairs(line.syls) do
		if ms >= line.start_time-line.infade and ms < line.start_time and syl.text ~= "" then
			local pct = math.sin((math.inrange(line.start_time-line.infade, line.start_time, ms) * math.pi)/2)
			local alpha = math.interpolate(0, 1 , pct)
			local pic = g2d.create_image_from_png("J:\\AmberdrakeSubs\\Hatsuyuki\\Black Bullet\\pattern.png")
			ctx:path_add_text(syl.x, syl.y, syl.text, ass.unpack_font(line.styleref))
			local text = g2d.create_image("RGBA", syl.width, syl.height)
			local tctx = text:get_context()
			tctx:path_add_text(0, 0, syl.text, ass.unpack_font(line.styleref))
			tctx:set_source(g2d.create_color(0, 0, 0, 0))
			tctx:fill()
			local img = g2d.create_pattern(pic)
			img:set_matrix(g2d.create_matrix()
			:translate(line.x - syl.x, 0)
			)
			img:set_extender("MIRROR")
			tctx:set_source(img)
			tctx:fill()
			text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(0.2)))
			text:set_matrix(g2d.create_matrix()
			:translate(syl.x, syl.y)
			)
			ctx:set_source(text)
			ctx:masked_paint(alpha)
		end
	end
end
local function outline1(ctx, ms, line)
	if line.style=="OP_romanji" or line.style=="OP_kanji" then
		for si, syl in ipairs(line.syls) do
			if ms >= line.start_time and ms < syl.start_time and syl.text ~= "" then
				local bordcolor = g2d.create_color(0, 0, 0, 1)
				text = g2d.create_image("RGBA", syl.width+20, syl.height+20)
				local tctx = text:get_context()
				tctx:path_add_text(5, 0, syl.text, ass.unpack_font(line.styleref))
				tctx:set_line_width(1)
				tctx:set_source(bordcolor)
				tctx:stroke()
				text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(1)))
				text:set_matrix(g2d.create_matrix()
				:translate(syl.x-5, syl.y)
				)
				ctx:set_source(text)
				ctx:paint()
			end
		end
	end
end
local function inactive1(ctx, ms, line)
	if line.style=="OP_romanji" or line.style=="OP_kanji" then
		for si, syl in ipairs(line.syls) do
			if ms >= line.start_time and ms < syl.start_time and syl.text ~= "" then
				local textcolor = g2d.create_color(242/255, 235/255, 242/255, 1)
				local pic = g2d.create_image_from_png("J:\\AmberdrakeSubs\\Hatsuyuki\\Black Bullet\\pattern.png")
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
				text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(0.2)))
				text:set_matrix(g2d.create_matrix()
				:translate(syl.x, syl.y)
				)
				ctx:set_source(text)
				ctx:paint()
			end
		end
	end
end
local function fx_bord(ctx, ms, line)
	if line.style=="OP_romanji" or line.style=="OP_kanji" then
		for si, syl in ipairs(line.syls) do
			if ms >= syl.start_time and ms < syl.end_time and syl.text ~= "" then
				local ang = math.rad(math.interpolate(90, 180, math.inrange(syl.start_time, syl.end_time, ms)))
				local sc = math.sin(ang)/6
				local pct = math.sin((math.inrange(syl.start_time, syl.end_time, ms) * math.pi)/2)
				local blur = 5+4*math.sin(math.rad(math.interpolate(0, 180 , pct)))
				local th = 2+3*math.sin(math.rad(math.interpolate(0, 180 , pct)))
				local bordcolor = g2d.create_color(222/255, 103/255, 123/255, 1)
				text = g2d.create_image("RGBA", syl.width+20, syl.height+20)
				local tctx = text:get_context()
				tctx:path_add_text(5, 0, syl.text, ass.unpack_font(line.styleref))
				tctx:set_line_width(th)
				tctx:set_source(bordcolor)
				tctx:stroke()
				text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(blur)))
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
end
local function fx_main(ctx, ms, line)
	if line.style=="OP_romanji" or line.style=="OP_kanji" then
		for si, syl in ipairs(line.syls) do
			if ms >= syl.start_time and ms < syl.end_time and syl.text ~= "" then
				local ang = math.rad(math.interpolate(90, 180, math.inrange(syl.start_time, syl.end_time, ms)))
				local sc = math.sin(ang)/6
				local textcolor = g2d.create_color(222/255, 103/255, 123/255, 1)
				local pic = g2d.create_image_from_png("J:\\AmberdrakeSubs\\Hatsuyuki\\Black Bullet\\pattern.png")
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
				text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(0.5)))
				text:set_matrix(g2d.create_matrix()
				:translate(syl.width/2 + syl.x, syl.height/2 + syl.y)
				:scale(1+sc, 1+sc)
				:translate(-syl.width/2,-syl.height/2)
				:scale(1, 1)
				)
				ctx:set_source(text)
				ctx:paint()
			end
		end
	end
end
local function fx_outline(ctx, ms, line)
	if line.style=="OP_romanji" or line.style=="OP_kanji" then
		for si, syl in ipairs(line.syls) do
			if ms >= syl.start_time and ms < syl.end_time and syl.text ~= "" then
				local ang = math.rad(math.interpolate(90, 180, math.inrange(syl.start_time, syl.end_time, ms)))
				local sc = math.sin(ang)/6
				local bordcolor = g2d.create_color(0, 0, 0, 1)
				text = g2d.create_image("RGBA", syl.width+20, syl.height+20)
				local tctx = text:get_context()
				tctx:path_add_text(5, 0, syl.text, ass.unpack_font(line.styleref))
				tctx:set_line_width(1)
				tctx:set_source(bordcolor)
				tctx:stroke()
				text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(0.8)))
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
end
local function outline2(ctx, ms, line)
	if line.style=="OP_romanji" or line.style=="OP_kanji" then
		for si, syl in ipairs(line.syls) do
			if ms >= syl.end_time and ms < line.end_time and syl.text ~= "" then
				local bordcolor = g2d.create_color(0, 0, 0, 1)
				text = g2d.create_image("RGBA", syl.width+20, syl.height+20)
				local tctx = text:get_context()
				tctx:path_add_text(5, 0, syl.text, ass.unpack_font(line.styleref))
				tctx:set_line_width(1)
				tctx:set_source(bordcolor)
				tctx:stroke()
				text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(1)))
				text:set_matrix(g2d.create_matrix()
				:translate(syl.x-5, syl.y)
				)
				ctx:set_source(text)
				ctx:paint()
			end
		end
	end
end
local function inactive2(ctx, ms, line)
	if line.style=="OP_romanji" or line.style=="OP_kanji" then
		for si, syl in ipairs(line.syls) do
			if ms >= syl.end_time and ms < line.end_time and syl.text ~= "" then
				local textcolor = g2d.create_color(242/255, 235/255, 242/255, 1)
				local pic = g2d.create_image_from_png("J:\\AmberdrakeSubs\\Hatsuyuki\\Black Bullet\\pattern.png")
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
				text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(0.2)))
				text:set_matrix(g2d.create_matrix()
				:translate(syl.x, syl.y)
				)
				ctx:set_source(text)
				ctx:paint()
			end
		end
	end
end
local function TL_outline(ctx, ms, line)
	if line.style=="OP_TL" then
		for si, syl in ipairs(line.syls) do
			if ms >= line.start_time and ms < line.end_time and syl.text ~= "" then
				local bordcolor = g2d.create_color(0, 0, 0, 1)
				text = g2d.create_image("RGBA", syl.width+20, syl.height+20)
				local tctx = text:get_context()
				tctx:path_add_text(5, 0, syl.text, ass.unpack_font(line.styleref))
				tctx:set_line_width(1)
				tctx:set_source(bordcolor)
				tctx:stroke()
				text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(0.1)))
				text:set_matrix(g2d.create_matrix()
				:translate(syl.x-5, syl.y)
				)
				ctx:set_source(text)
				ctx:paint()
			end
		end
	end
end
local function TL_main(ctx, ms, line)
	if line.style=="OP_TL" then
		for si, syl in ipairs(line.syls) do
			if ms >= line.start_time and ms < line.end_time and syl.text ~= "" then
				local textcolor = g2d.create_color(242/255, 235/255, 242/255, 1)
				local pic = g2d.create_image_from_png("J:\\AmberdrakeSubs\\Hatsuyuki\\Black Bullet\\pattern.png")
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
				text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(0.2)))
				text:set_matrix(g2d.create_matrix()
				:translate(syl.x, syl.y)
				)
				ctx:set_source(text)
				ctx:paint()
			end
		end
	end
end
local function outfade_outline(ctx, ms, line)
	if line.outfade > 250 then
		line.outfade = 250
	end
	for si, syl in ipairs(line.syls) do
		if ms >= line.end_time and ms < line.end_time+line.outfade and syl.text ~= "" then
			local pct = math.sin((math.inrange(line.end_time, line.end_time+line.outfade, ms) * math.pi)/2)
			local alpha = math.interpolate(1, 0 , pct)
			local bordcolor = g2d.create_color(0, 0, 0, 1)
			text = g2d.create_image("RGBA", syl.width+20, syl.height+20)
			local tctx = text:get_context()
			tctx:path_add_text(5, 0, syl.text, ass.unpack_font(line.styleref))
			tctx:set_line_width(1)
			tctx:set_source(bordcolor)
			tctx:stroke()
			text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(1)))
			text:set_matrix(g2d.create_matrix()
			:translate(syl.x-5, syl.y)
			)
			ctx:set_source(text)
			ctx:masked_paint(alpha)
		end
	end
end
local function outfade_L1(ctx, ms, line)
	if line.outfade > 250 then
		line.outfade = 250
	end
	for si, syl in ipairs(line.syls) do
		if ms >= line.end_time and ms < line.end_time+line.outfade and syl.text ~= "" then
			local pct = math.sin((math.inrange(line.end_time, line.end_time+line.outfade, ms) * math.pi)/2)
			local alpha = math.interpolate(1, 0 , pct)
			local fill_color = g2d.create_color(math.interpolate((242/255),(133/255),pct), math.interpolate((235/255),(34/255),pct), math.interpolate((242/255),(47/255),pct), 1)
			local pic = g2d.create_image_from_png("J:\\AmberdrakeSubs\\Hatsuyuki\\Black Bullet\\pattern.png")
			ctx:path_add_text(syl.x, syl.y, syl.text, ass.unpack_font(line.styleref))
			local text = g2d.create_image("RGBA", syl.width, syl.height)
			local tctx = text:get_context()
			tctx:path_add_text(0, 0, syl.text, ass.unpack_font(line.styleref))
			tctx:set_source(fill_color)
			tctx:fill()
			local img = g2d.create_pattern(pic)
			img:set_matrix(g2d.create_matrix()
			:translate(line.x - syl.x, 0)
			)
			img:set_extender("MIRROR")
			tctx:set_source(img)
			tctx:fill()
			text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(0.2)))
			text:set_matrix(g2d.create_matrix()
			:translate(syl.x, syl.y)
			)
			ctx:set_source(text)
			ctx:masked_paint(alpha)
		end
	end
end
local function outfade_L2(ctx, ms, line)
	if line.outfade > 250 then
		line.outfade = 250
	end
	for si, syl in ipairs(line.syls) do
		if ms >= line.end_time and ms < line.end_time+line.outfade and syl.text ~= "" then
			local pct = math.sin((math.inrange(line.end_time, line.end_time+line.outfade, ms) * math.pi)/2)
			local alpha = math.interpolate(1, 0 , pct)
			local pic = g2d.create_image_from_png("J:\\AmberdrakeSubs\\Hatsuyuki\\Black Bullet\\pattern.png")
			ctx:path_add_text(syl.x, syl.y, syl.text, ass.unpack_font(line.styleref))
			local text = g2d.create_image("RGBA", syl.width, syl.height)
			local tctx = text:get_context()
			tctx:path_add_text(0, 0, syl.text, ass.unpack_font(line.styleref))
			tctx:set_source(g2d.create_color(0, 0, 0, 0))
			tctx:fill()
			local img = g2d.create_pattern(pic)
			img:set_matrix(g2d.create_matrix()
			:translate(line.x - syl.x, 0)
			)
			img:set_extender("MIRROR")
			tctx:set_source(img)
			tctx:fill()
			text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(0.2)))
			text:set_matrix(g2d.create_matrix()
			:translate(syl.x, syl.y)
			)
			ctx:set_source(text)
			ctx:masked_paint(alpha)
		end
	end
end
function GetFrame(frame, frame_i)
	local ctx = frame:get_context()
	local ms = frame_i / VIDEO_FPS * 1000
	for li, line in ipairs(lines) do
		infade_outline(ctx, ms, line)
		infade_L1(ctx, ms, line)
		infade_L2(ctx, ms, line)
		outline1(ctx, ms, line)
		inactive1(ctx, ms, line)
		fx_bord(ctx, ms, line)
		fx_main(ctx, ms, line)
		fx_outline(ctx, ms, line)
		outline2(ctx, ms, line)
		inactive2(ctx, ms, line)
		TL_outline(ctx, ms, line)
		TL_main(ctx, ms, line)
		outfade_outline(ctx, ms, line)
		outfade_L1(ctx, ms, line)
		outfade_L2(ctx, ms, line)
	end
end