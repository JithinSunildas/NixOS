local M = {}

-- Safely get tools or empty table to prevent crashes
local tools = _G.tools or { ui = { icons = {} }, hl_str = function(_, s) return s end }
local api, fn, bo = vim.api, vim.fn, vim.bo
local get_opt = api.nvim_get_option_value

-- 1. DEFINE ICONS & HIGHLIGHTS
-- We define them manually here so we don't rely on complex external tables
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
    "pad",
    "branch",   -- Changed: Branch first
    "path",     -- Path (dir/file)
    "mod",      -- Modified/ReadOnly status
    "sep",      -- Spacer (%=)
    "diag",     -- Diagnostics
    "fileinfo", -- Filetype info
    "cursor",   -- NEW: Line/Col/Percentage
    "pad",
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

-- GIT BRANCH (No Repo Name)
local function branch_widget(root)
    if not root then return "" end
    local branch = tools.get_git_branch(root)

    if branch and branch ~= "" then
        return string.format("%s %s ", ICON.branch, branch)
    end
    return ""
end

-- PATH (parent_dir/filename [FT])
local function path_widget(fname)
    if fname == "" then return "[No Name]" end

    -- Get only the tail (filename) and head (directory)
    local tail = fn.fnamemodify(fname, ":t")
    local parent = fn.fnamemodify(fname, ":h:t")

    local path_str = tail
    if parent ~= "." and parent ~= "/" then
        path_str = parent .. "/" .. tail
    end

    -- Icon Logic (Filetype AFTER name)
    local ft = bo.filetype
    local ft_icon = ""
    if tools.ui.icons and tools.ui.icons[ft] then
        ft_icon = tools.hl_str("Special", tools.ui.icons[ft])
    elseif ft ~= "" then
        ft_icon = tools.hl_str("NonText", "[" .. ft:upper() .. "]")
    end

    return string.format("%s %s %s", ICON.file, path_str, ft_icon)
end

-- DIAGNOSTICS (Errors/Warnings)
local function diagnostics_widget()
    if not tools.diagnostics_available or not tools.diagnostics_available() then return "" end

    -- Check for native diagnostic count (Neovim 0.10+) or fallback
    local count = vim.diagnostic.count and vim.diagnostic.count(0) or { 0, 0, 0, 0 }
    -- count table: 1=Error, 2=Warn, 3=Info, 4=Hint

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

-- CURSOR POSITION (Ln:Col %%)
local function cursor_widget()
    local line = fn.line(".")
    local col = fn.col(".")
    -- %P is native vim statusline code for Percentage
    return string.format("%3d:%-2d %3s", line, col, "%P")
end

-- 5. RENDER FUNCTION
function M.render()
    -- Get buffer info
    local buf = api.nvim_win_get_buf(vim.g.statusline_winid or 0)
    local fname = api.nvim_buf_get_name(buf)

    -- Get root for Git info
    local root = tools.get_path_root and tools.get_path_root(fname) or nil

    -- Handle special buffers (Help, Terminal, etc.)
    if get_opt("buftype", { buf = buf }) == "help" then
        return "  Help: " .. fn.fnamemodify(fname, ":t")
    end

    local parts = {
        pad      = PAD,
        branch   = branch_widget(root),
        path     = path_widget(fname),
        mod      = get_opt("modified", { buf = buf }) and ICON.modified or
            (get_opt("modifiable", { buf = buf }) and "" or ICON.nomodifiable),
        sep      = SEP,
        diag     = diagnostics_widget(),
        fileinfo = "", -- Removed detailed word count per your request (kept simplified)
        cursor   = cursor_widget(),
    }

    return concat(parts)
end

-- 6. SET STATUSLINE
vim.o.statusline = "%!v:lua.require('statusline').render()"

return M
