--Fairy Tail 176+ OP
--Karaoke by Amberdrake
--LVS

ass.load("J:\\AmberdrakeSubs\\Hatsuyuki\\Fairy Tail\\176+\\FT OP.ass")
local function bord(ctx, ms, line)
	for si, syl in ipairs(line.syls) do
		if ms >= line.start_time and ms < line.end_time and syl.text ~= "" then
			if line.i == 1 then
				bordcolor = g2d.create_color((237/255), (216/255), (82/255), 1)
			elseif line.i >= 2 and line.i <= 6 then
				bordcolor = g2d.create_color((244/255), (252/255), (249/255), 1)
			else
				bordcolor = g2d.create_color((75/255), (117/255), (151/255), 1)
			end
			text = g2d.create_image("RGBA", syl.width+20, syl.height+20)
			local tctx = text:get_context()
			tctx:path_add_text(5, 0, syl.text, ass.unpack_font(line.styleref))
			tctx:set_line_width(3)
			tctx:set_source(bordcolor)
			tctx:stroke()
			text = g2d.create_pattern(text:convolute(g2du.create_gaussian_blur_kernel(2)))
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
		if ms >= line.start_time and ms < line.end_time and syl.text ~= "" then
			local textcolor = g2d.create_color((235/255), (251*1/255), (255*1/255), 1)
			if line.i == 1 then
				pic = g2d.create_image_from_png("J:\\AmberdrakeSubs\\Hatsuyuki\\Fairy Tail\\176+\\sparks.png")
			elseif line.i >= 3 and line.i <= 6 then
				pic = g2d.create_image_from_png("J:\\AmberdrakeSubs\\Hatsuyuki\\Fairy Tail\\176+\\stars.png")
			else
				pic = g2d.create_image_from_png("J:\\AmberdrakeSubs\\Hatsuyuki\\Fairy Tail\\176+\\crest.png")
			end
			local text = g2d.create_image("RGBA", syl.width, syl.height)
			local tctx = text:get_context()
			tctx:path_add_text(0, 0, syl.text, ass.unpack_font(line.styleref))
			local gradient_width = syl.height
			tctx:set_source(
			g2d.create_lgradient(syl.x, syl.y, syl.x, syl.y+syl.height)
			:add_color(gradient_width,(221/255), (221/255), (221/255), 1)
			:add_color(-gradient_width,(187/255), 0, (24/255), 1))
			tctx:fill()
			local img = g2d.create_pattern(pic)
			img:set_matrix(g2d.create_matrix()
			:translate(line.x - syl.x, -10)
			)
			img:set_extender("MIRROR")
			tctx:set_source(img)
			tctx:fill()
			text = g2d.create_pattern(text)
			for a = 0 do
				local sc = math.sin(math.rad(a))
				a = a + 10
			end
			text:set_matrix(g2d.create_matrix()
			:translate(syl.x, syl.y)
			:scale(1+sc, 1+sc)
			)
			ctx:set_source(text)
			ctx:paint()
		end
	end
end
function GetFrame(frame, frame_i)
	local ctx = frame:get_context()
	local ms = frame_i / VIDEO_FPS * 1000
	for li, line in ipairs(lines) do
		if ms >= line.start_time-line.infade and ms < line.end_time+line.outfade then
			bord(ctx, ms, line)
			fill(ctx, ms, line)
		end
	end
end