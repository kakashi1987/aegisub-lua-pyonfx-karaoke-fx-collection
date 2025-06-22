--[[
]]

include("karaskel.lua");


script_name = "Sakura"
script_author = "Januar C. Andaria"
script_description = "..."
script_version = "1.0"


sakura = {}
sakura.subtitles = nil
sakura.selected_lines = nil
sakura.active_line = nil
sakura.meta = nil
sakura.styles = nil
sakura.line_numbers = {}
sakura.config = {
   corolla_scale = 100 
}
sakura.corollas = {
    "m 14 12 b 14 12 0 -4 12 -9 b 13 -8 13 -7 14 -6 b 15 -7 15 -9 15 -10 b 28 -4 14 12 14 12",
    "m 10 14 b 10 14 20 -4 30 6 b 28 7 27 8 27 9 b 28 9 30 9 31 9 b 29 22 10 14 10 14",
    "m 10 10 b 10 10 30 13 25 25 b 24 24 23 24 23 24 b 23 25 23 26 23 27 b 9 29 10 10 10 10",
    "m 11 9 b 11 9 14 27 0 26 b 0 25 1 24 0 23 b -1 23 -3 24 -3 25 b -8 14 11 9 11 9",
    "m 10 13 b 10 13 -7 21 -10 9 b -9 9 -8 8 -7 8 b -8 7 -9 7 -10 6 b 0 -4 10 13 10 13"
}

sakura.dialog = {
    {
        class = "label",
        x = 0,
        y = 0,
        height = 1,
        width = 5,
        label = "Cofiguration"
    },
    {
        class = "label",
        x = 0,
        y = 1,
        height = 1,
        width = 1,
        label = "Apply to style"
    },
    {
        class = "dropdown",
        x = 1,
        y = 1,
        height = 1,
        width = 4,
        name = "style_name",
        hint = "Pilih style yang akan di apply", 
        items = {},
        value = ""
    },
    {
        class = "label",
        x = 0,
        y = 2,
        height = 1,
        width = 1,
        label = "Corolla scale"
    },
    {
        class = "intedit",
        x = 1,
        y = 2,
        height = 1,
        width = 3,
        name = "corolla_scale",
        hint = "Scale of flower's corrola (0 - 1000)",
        min = 0,
        max = 1000,
        value = 100
    },
    {
        class = "label",
        x = 4,
        y = 2,
        height = 1,
        width = 1,
        label = "%"
    }
}


function sakura:prepare_dialog()
    local conf  = self.config
    local styles = self.styles
    local style_dialog = self.dialog[3]
    
    style_dialog.items = {}
    style_dialog.value = ""
    
    local maxi = #styles
    if maxi > 0 then
        style_dialog.value = styles[1].name
        
        for i = 1, maxi do
            local style_name = styles[i].name
            
            table.insert(style_dialog.items, style_name)
            
            if style_name == conf.style_name then
                style_dialog.value = conf.style_name
            end
        end
    end
    
    
    self.dialog[5].value = conf.corolla_scale
end

function sakura:update_line_info(line)
    local subs = self.subtitles
    local meta = self.meta
    local styles = self.styles
    
    karaskel.preproc_line(subs, meta, styles, line)
    karaskel.preproc_line_size(meta, styles, line)
    karaskel.preproc_line_pos(meta, styles, line)
end

function sakura:process()

    aegisub.progress.task("waiting configuration");
    local btn, conf = aegisub.dialog.display(self.dialog)
    
    if btn then
        self.config = conf
        
        self:prepare_lines()
        
        self:build_kara()
        
        aegisub.progress.task("Finished!")
        aegisub.progress.set(100)
        
        aegisub.set_undo_point("Apply IOPC Automation")
    else
        aegisub.progress.task("Canceled!");
    end
end

function sakura:prepare_lines()
    local conf = self.config
    local meta, styles = self.meta, self.styles
    local subs = self.subtitles;
    local line_numbers = {}
    
    local i = 1
    while i <= #subs do
        local subtitle = subs[i];
        if subtitle.class == "dialogue" and subtitle.style == conf.style_name then
            if subtitle.effect == "fx" then
                subs.delete(i);
                i = i - 1;
            else
                table.insert(line_numbers, i)
            end
        end
        
        i = i + 1;
    end
    
    self.line_numbers = line_numbers
    
end

function sakura:build_kara()
    local line_numbers = self.line_numbers
    local subs = self.subtitles
    
    local maxi = #line_numbers
    for i = 1, maxi do
        local num = line_numbers[i]
        local line = subs[num]
        
        self:update_line_info(line)
        
        self:kara_build_shadow(subs, line, 0, self.config.corolla_scale * 1.25)
        self:kara_build_flower(subs, line, 0, self.config.corolla_scale)
        self:kara_build_pollen(subs, line, 0)
        self:kara_build_syl(subs, line, 0)
        
        line.comment = true
        line.effect = "Karaoke"
        subs[num] = line
    end

end



function sakura:kara_build_shadow(subs, line, layer, scale)
    
    local text_format = table.concat({
        "{\\an5\\1a&HFF&\\3c%s",
        "\\bord4\\be1\\3a&H99&",
        "\\pos(%f,%f)",
        "\\t(%d,%d,\\alpha&HFF&)",
        "\\fscx%d\\fscy%d",
        "\\p1}%s{\\p0}"
    }, "")
    
    for i, syl in ipairs(line.kara) do
        local l = table.copy(line)
        
        l.effect = "fx"
        l.comment = false
        l.layer = layer
        l.start_time = line.start_time + syl.start_time
        l.end_time = l.start_time + syl.duration + 750
        l.duration = l.end_time - l.start_time
        
        local pos_x = line.left + syl.center
        local pos_y = line.middle
        
        for i, corolla in ipairs(self.corollas) do
            
            l.text = text_format:format(
                color_from_style(syl.style.color4),
                pos_x, pos_y,
                l.duration - 150*i,  l.duration,
                scale, scale,
                corolla
            )
            
            subs.append(l)
        end
    end
    
end


function sakura:kara_build_flower(subs, line, layer, scale)
    
    local text_format = table.concat({
        "{\\an5\\be1\\bord0.1\\3c&H000000&\\3a&HAA&\\fscx%d\\fscy%d\\1c%s",
        "\\move(%d,%d,%d,%d,%d,%d)",
        "\\t(%d,%d,\\frx%d\\fry%d\\frz%d)",
        "\\t(%d,%d,\\alpha&HFF&)",
        "\\p1}%s{\\p0}"
    }, "")
    
    
    for i, syl in ipairs(line.kara) do
        local l = table.copy(line)
        l.effect = "fx"
        l.comment = false
        l.layer = layer
        
        for i, corolla in ipairs(self.corollas) do
            
            l.start_time = line.start_time + syl.start_time - 10 * i
            l.end_time = l.start_time + syl.duration + 750
            l.duration = l.end_time - l.start_time
            
            local movex1 = line.left + syl.center
            local movey1 = line.middle
            local movex2 = math.random(line.left + syl.left, line.left + syl.right)
            local movey2 = movey1 - line.height
            
            
            local movet1 = l.duration - 750
            local movet2 = l.duration
            
            l.text = text_format:format(
                scale, scale, color_from_style(syl.style.color2),
                movex1, movey1, movex2, movey2, l.duration - 750, l.duration,
                movet1, movet2, math.random(-120,120), math.random(-180,180), math.random(-180,180),
                l.duration - 200, movet2,
                corolla
            )
            
            subs.append(l)
        end
    end
end

function sakura:kara_build_pollen(subs, line, layer)
    
    local vector = "m 0 0 l 0 1 l 1 1 l 1 0 l 0 0"
    local text_format = table.concat({
        "{\\an5\\shad0\\bord%f\\be1\\1c%s\\3c%s\\3a&H55&",
        "\\move(%d,%d,%d,%d,%d,%d)",
        "\\fscx%d\\fscx%d",
        "\\p1}%s{\\p0}"
    }, "")

    for i, syl in ipairs(line.kara) do
        local l = table.copy(line)
        l.effect = "fx"
        l.comment = false
        l.layer = layer
        l.start_time = line.start_time + syl.start_time
        l.end_time = l.start_time + syl.duration + 750
        l.duration = l.end_time - l.start_time
        
        local fsc = math.random(100,500)
        local color = color_from_style(syl.style.color1)
        
        for j = 1, math.random(4,8) do
            
            local movex1 = line.left + syl.center + math.random(-1,1)
            local movey1 = line.middle + math.random(-1,1)
            
            local movex2 = math.random(line.left + syl.left, line.left + syl.right)
            local movey2 = movey1 - line.height * 0.5
            
            
            l.text = text_format:format(
                math.random(0.1,1), color, color,
                movex1, movey1, movex2, movey2, l.duration - 750, l.duration,
                fsc, fsc,
                vector
            )
            subs.append(l)
        end
    end
    
end

function sakura:kara_build_syl(subs, line, layer)
    
    local text_format = table.concat({
        "{\\an5\\pos(%d,%d)\\1c%s",
        "\\t(%d,%d,\\1c%s\\3c%s\\3a&H10&\\bord3\\be1)",
        "\\t(%d,%d,\\1a&HFF&\\bord1\\be0\\3c%s)",
        "}%s"
    }, "")
    
    for i, syl in ipairs(line.kara) do
        local l = table.copy(line)
        l.effect = "fx"
        l.comment = false
        l.layer = layer
        
        local pos_x = line.left + syl.center
        local pos_y = line.middle
        
        local smid = syl.duration * 0.5
        
        local st1 = syl.start_time
        local st2 = st1 + smid
        
        local et1 = st2
        local et2 = st2 + smid
        
        
        l.text = text_format:format(
            pos_x, pos_y, color_from_style(syl.style.color2),
            st1, st2, color_from_style(syl.style.color1), color_from_style(syl.style.color3),
            et1, et2,
            color_from_style(syl.style.color1),
            syl.text)
        subs.append(l)
    end

end


function sakura:initialize(subtitles, selected_lines, active_line)
    
    self.subtitles = subtitles
    self.selected_lines = selected_lines
    self.active_line = active_line
    
    self.meta, self.styles = karaskel.collect_head(subtitles)
    
    
    self:prepare_dialog()
end


function sakura_process_macro(subtitles, selected_lines, active_line)
    sakura:initialize(subtitles, selected_lines, active_line)
    sakura:process()
end


aegisub.register_macro("Sakura", "bla bla bla...", sakura_process_macro)