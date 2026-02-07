local M = {}

-- Safely get tools
local tools = _G.tools or { ui = { icons = {} }, hl_str = function(_, s) return s end }
local api, fn, bo = vim.api, vim.fn, vim.bo
local get_opt = api.nvim_get_option_value

-- 1. DEFINE ICONS & HIGHLIGHTS
local icons = tools.ui.icons or {}
local HL = {
    branch       = { "DiagnosticOk", icons.branch or "" },
    file         = { "NonText", icons.node or "󰈔" },
    fileinfo     = { "Function", icons.document or "≡" },
    nomodifiable = { "DiagnosticWarn", icons.bullet or "•" },
    modified     = { "DiagnosticError", icons.bullet or "•" },
    readonly     = { "DiagnosticWarn", icons.lock or "" },
    error        = { "DiagnosticError", icons.error or "E" },
    warn         = { "DiagnosticWarn", icons.warning or "W" },
}

local ICON = {}
for k, v in pairs(HL) do
    ICON[k] = tools.hl_str(v[1], v[2])
end

-- 2. ORDER OF WIDGETS
local ORDER = {
    "mode", -- Mode first (Colored)
    "branch",
    "path",
    "mod",
    "sep",
    "diag",
    "fileinfo",
    "cursor",
    "pad",
    "scrollbar",
    "pad",
}

local PAD = " "
local SEP = "%="

-- 3. UTILITIES
local function concat(parts)
    local out, i = {}, 1
    for _, k in ipairs(ORDER) do
        local v = parts[k]
        if v and v ~= "" then
            out[i] = v
            i = i + 1
        end
    end
    return table.concat(out, " ")
end

-- 4. WIDGET FUNCTIONS

-- COLORED MODE INDICATOR
local function mode_widget()
    local modes = {
        ["n"]   = "NORMAL",
        ["no"]  = "O-PENDING",
        ["v"]   = "VISUAL",
        ["V"]   = "V-LINE",
        ["\22"] = "V-BLOCK",
        ["s"]   = "SELECT",
        ["S"]   = "S-LINE",
        ["\19"] = "S-BLOCK",
        ["i"]   = "INSERT",
        ["R"]   = "REPLACE",
        ["c"]   = "COMMAND",
        ["r"]   = "PROMPT",
        ["t"]   = "TERMINAL",
        ["!"]   = "SHELL",
    }

    local current_mode = api.nvim_get_mode().mode
    local label = modes[current_mode] or current_mode:upper()

    -- COLOR LOGIC
    local color = "StatusLineBold" -- Default (White/Bold)

    -- Insert = Green
    if current_mode == "i" then
        color = "DiagnosticOk"
    end

    -- Visual = Orange
    if current_mode == "v" or current_mode == "V" or current_mode == "\22" then
        color = "DiagnosticWarn"
    end

    -- Replace = Red
    if current_mode == "R" then
        color = "DiagnosticError"
    end

    -- Command = Blue (Info)
    if current_mode == "c" then
        color = "DiagnosticInfo"
    end

    return tools.hl_str(color, " " .. label .. " ")
end

local function branch_widget(root)
    if not root then return "" end
    local branch = tools.get_git_branch(root)
    if branch and branch ~= "" then
        return string.format("%s %s ", ICON.branch, branch)
    end
    return ""
end

local function path_widget(fname)
    if fname == "" then return "[No Name]" end
    local tail = fn.fnamemodify(fname, ":t")
    local parent = fn.fnamemodify(fname, ":h:t")
    local path_str = tail
    if parent ~= "." and parent ~= "/" then
        path_str = parent .. "/" .. tail
    end
    local ft = bo.filetype
    local ft_icon = ""
    if tools.ui.icons and tools.ui.icons[ft] then
        ft_icon = tools.hl_str("Special", tools.ui.icons[ft])
    elseif ft ~= "" then
        ft_icon = tools.hl_str("NonText", "[" .. ft:upper() .. "]")
    end
    return string.format("%s %s %s", ICON.file, path_str, ft_icon)
end

local function diagnostics_widget()
    if not tools.diagnostics_available or not tools.diagnostics_available() then return "" end
    local count = vim.diagnostic.count and vim.diagnostic.count(0) or { 0, 0, 0, 0 }
    local err = count[vim.diagnostic.severity.ERROR] or 0
    local warn = count[vim.diagnostic.severity.WARN] or 0
    local parts = ""
    if err > 0 then
        parts = parts .. string.format("%s %s ", ICON.error, tools.hl_str("DiagnosticError", err))
    end
    if warn > 0 then
        parts = parts .. string.format("%s %s ", ICON.warn, tools.hl_str("DiagnosticWarn", warn))
    end
    return parts
end

local function cursor_widget()
    local line = fn.line(".")
    local col = fn.col(".")
    return string.format("%3d:%-2d %3s", line, col, "%P")
end

-- 5. RENDER FUNCTION
function M.render()
    local buf = api.nvim_win_get_buf(vim.g.statusline_winid or 0)
    local fname = api.nvim_buf_get_name(buf)
    local root = tools.get_path_root and tools.get_path_root(fname) or nil

    if get_opt("buftype", { buf = buf }) == "help" then
        return "  Help: " .. fn.fnamemodify(fname, ":t")
    end

    local parts = {
        pad      = PAD,
        mode     = mode_widget(),
        branch   = branch_widget(root),
        path     = path_widget(fname),
        mod      = get_opt("modified", { buf = buf }) and ICON.modified or
            (get_opt("modifiable", { buf = buf }) and "" or ICON.nomodifiable),
        sep      = SEP,
        diag     = diagnostics_widget(),
        fileinfo = "",
        cursor   = cursor_widget(),
    }

    return concat(parts)
end

vim.o.statusline = "%!v:lua.require('statusline').render()"

-- Force Highlight Groups (just in case)
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        local hl = vim.api.nvim_get_hl(0, { name = "StatusLine", link = false })
        hl.bold = true
        vim.api.nvim_set_hl(0, "StatusLineBold", hl)
    end,
})

return M
