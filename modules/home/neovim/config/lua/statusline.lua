-- ============================================================================
-- STATUSLINE
-- ============================================================================

-- Git branch function
local function git_branch()
    local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
    if branch ~= "" then
        return "  " .. branch .. " "
    end
    return ""
end

-- Diagnostic counts (Dots + Numbers with COLORS)
local function diagnostic_status()
    local levels = {
        errors = vim.diagnostic.severity.ERROR,
        warnings = vim.diagnostic.severity.WARN,
    }
    local err = #vim.diagnostic.get(0, { severity = levels.errors })
    local warn = #vim.diagnostic.get(0, { severity = levels.warnings })
    local status = ""
    if err > 0 then
        status = status .. "Err ● " .. err .. " "
    end
    if warn > 0 then
        status = status .. "Warn ● " .. warn .. " "
    end
    if status ~= "" then
        return status .. "│ "
    else
        return ""
    end
end

_G.diagnostic_status = diagnostic_status

local function setup_diagnostic_highlights()
    local statusline_bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('StatusLine')), 'bg')
    vim.api.nvim_set_hl(0, "DiagnosticError", {
        fg = "#ff5555",
        bg = statusline_bg ~= "" and statusline_bg or "NONE"
    })
    vim.api.nvim_set_hl(0, "DiagnosticWarn", {
        fg = "#ffb86c",
        bg = statusline_bg ~= "" and statusline_bg or "NONE"
    })
end

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = setup_diagnostic_highlights
})

setup_diagnostic_highlights()
local function file_type()
    local ft = vim.bo.filetype
    local icons = {
        lua = "[LUA]",
        python = "[PY]",
        javascript = "[JS]",
        html = "[HTML]",
        css = "[CSS]",
        json = "[JSON]",
        markdown = "[MD]",
        vim = "[VIM]",
        sh = "[SH]",
    }

    if ft == "" then
        return "  "
    end

    return (icons[ft] or ft)
end

-- Word count for text files
local function word_count()
    local ft = vim.bo.filetype
    if ft == "markdown" or ft == "text" or ft == "tex" then
        local words = vim.fn.wordcount().words
        return "  " .. words .. " words "
    end
    return ""
end

-- File size
local function file_size()
    local size = vim.fn.getfsize(vim.fn.expand('%'))
    if size < 0 then return "" end
    if size < 1024 then
        return size .. "B "
    elseif size < 1024 * 1024 then
        return string.format("%.1fK", size / 1024)
    else
        return string.format("%.1fM", size / 1024 / 1024)
    end
end

-- Mode indicators with icons
local function mode_icon()
    local mode = vim.fn.mode()
    local modes = {
        n = "NORMAL",
        i = "INSERT",
        v = "VISUAL",
        V = "V-LINE",
        ["\22"] = "V-BLOCK", -- Ctrl-V
        c = "COMMAND",
        s = "SELECT",
        S = "S-LINE",
        ["\19"] = "S-BLOCK", -- Ctrl-S
        R = "REPLACE",
        r = "REPLACE",
        ["!"] = "SHELL",
        t = "TERMINAL"
    }
    return modes[mode] or "  " .. mode:upper()
end

local function short_path()
    local path = vim.fn.expand('%:~:.')
    local parts = vim.split(path, '/')
    if #parts <= 2 then
        return path
    else
        return parts[#parts - 1] .. '/' .. parts[#parts]
    end
end

_G.short_path = short_path
_G.mode_icon = mode_icon
_G.git_branch = git_branch
_G.file_type = file_type
_G.file_size = file_size

vim.cmd([[
  highlight StatusLineBold gui=bold cterm=bold
]])

-- Function to change statusline based on window focus
local function setup_dynamic_statusline()
    vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
        callback = function()
            vim.opt_local.statusline = table.concat {
                "  ",
                "%#StatusLineBold#",
                "%{v:lua.mode_icon()}",
                "%#StatusLine#",
                " │ %{v:lua.short_path()} %h%m%r",
                " │ ",
                "%{v:lua.file_type()} ",
                "%{v:lua.file_size()}",
                "%=",         -- Right-align everything after this
                "%{v:lua.diagnostic_status()}",
                "%l:%c  %P ", -- Line:Column and Percentage
            }
        end
    })
    vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })

    vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
        callback = function()
            vim.opt_local.statusline = "  %f %h%m%r │ %{v:lua.file_type()} | %=  %l:%c   %P "
        end
    })
end

setup_dynamic_statusline()
