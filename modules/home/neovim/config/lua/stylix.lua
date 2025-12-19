-- ~/nix-config/modules/home/neovim/config/lua/stylix.lua

local M = {}

-- Function to load JSON file
local function load_json(filepath)
    local file = io.open(filepath, "r")
    if not file then
        return nil
    end

    local content = file:read("*all")
    file:close()

    -- Parse JSON
    local ok, decoded = pcall(vim.json.decode, content)
    if ok then
        return decoded
    end

    return nil
end

-- Convert Stylix JSON format to mini.base16 palette format
local function convert_stylix_to_palette(stylix_json)
    if not stylix_json then
        return nil
    end

    if stylix_json.base00 and stylix_json.base0F then
        return stylix_json
    end

    return nil
end

function M.load_stylix_colors()
    local stylix_file = vim.fn.expand("~/.config/stylix/palette.json")

    if vim.fn.filereadable(stylix_file) == 1 then
        local stylix_data = load_json(stylix_file)
        if stylix_data then
            return convert_stylix_to_palette(stylix_data)
        end
    end

    return nil
end

function M.apply_theme()
    local colors = vim.g.stylix_colors or vim.g.base16_palette

    if not colors then
        colors = M.load_stylix_colors()
    end

    if colors and type(colors) == "table" then
        vim.g.stylix_colors = colors

        local ok, mini = pcall(require, "mini.base16")
        if ok then
            mini.setup({
                palette = colors,
                use_cterm = nil,
                plugins = { default = true },
            })
            print("✓ Stylix theme loaded successfully")
            return true
        else
            print("✗ Failed to load mini.base16 plugin")
        end
    else
        print("✗ Could not load Stylix colors")
    end

    return false
end

-- Debug function to show what colors are available
function M.debug()
    print("=== Stylix Debug Info ===")
    print("")
    print("1. Checking vim.g variables:")
    print("   vim.g.stylix_colors:", vim.g.stylix_colors and "✓ Found" or "✗ Not found")
    print("   vim.g.base16_palette:", vim.g.base16_palette and "✓ Found" or "✗ Not found")
    print("")

    print("2. Checking Stylix files:")
    local json_file = vim.fn.expand("~/.config/stylix/palette.json")
    local json_exists = vim.fn.filereadable(json_file) == 1
    print("   " .. json_file .. ":", json_exists and "✓ Found" or "✗ Not found")
    print("")

    if json_exists then
        print("3. Loading colors from JSON:")
        local colors = M.load_stylix_colors()
        if colors then
            print("   ✓ Successfully loaded colors")
            print("")
            print("4. Color palette preview:")
            for i = 0, 15 do
                local key = string.format("base%02X", i)
                if colors[key] then
                    print(string.format("   %s: %s", key, colors[key]))
                end
            end
        else
            print("   ✗ Failed to load colors from JSON")
        end
    end
    print("")
    print("5. mini.base16 plugin:")
    local ok, _ = pcall(require, "mini.base16")
    print("   Status:", ok and "✓ Installed" or "✗ Not found")
end

return M
