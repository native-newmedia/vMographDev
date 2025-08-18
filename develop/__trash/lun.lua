--local function create_Images()
-- -----------------------------------------------------------------------
local imgHolder = {}
local emptyImage = nil
--local rel_path = parse_filename(InFile:GetValue(req).Value).FullPath

local image_tbl = tbl[1]

local rel_path = tbl[1].Parent

--for i = 1, #image_tbl do
for i = 1, 10 do
    -- -----------------------------------------------------------------------
    local filename = rel_path .. image_tbl[i].Name
    --image_tbl[i].Name ~= ".DS_Store" and
    -- -----------------------------------------------------------------------
    -- Verify the file exists
    if bmd.fileexists(filename) == true then
        local frame = 0
        local time_mode = 0
        --  local tbl = parse_filename(filename)
        -- Get the image clip
        local clip = Clip(filename, false)
        -- Read the first frame of the image sequence
        clip:Open()
        imgHolder[i] = clip:GetFrame(frame)
        clip:Close()
    else
        -- Fallback to a blank canvas when no image is found
        local compWidth = self.Comp:GetPrefs('Comp.FrameFormat.Width') or 1920
        local compHeight = self.Comp:GetPrefs('Comp.FrameFormat.Height') or 1080

        emptyImage = Image({
            IMG_Width = compWidth,
            IMG_Height = compHeight,
        })

        -- Pixel defaults to black/clear
        imgHolder[i] = emptyImage:Fill(Pixel({ R = 0.5, G = 0.5, B = 0.5, A = 1 }))
    end
end
------------------------------------------------------------------

local sh = Shape()
local shape_texture = {}

-- for i = 1, #image_tbl do
for i = 1, 10 do
    local output_matrix_1 = { 1, 0.1 * i, tbl[2][i][1], tbl[2][i][2] }
    table.insert(shape_texture, { { imgHolder[i], output_matrix_1, sh, sh } })
end
return shape_texture

--end
