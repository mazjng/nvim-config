-- 
-- Modelled after MariaSolOs 
-- @ github.com/MariaSolOs/dotfiles/.config/nvim/lua/statusline.lua
--

local M = {}

-- Show the mode in the status line instead
vim.o.showmode = false

-- Color Palatte: Currently fixed to catpuccin
local palette = require("catppuccin.palettes").get_palette "mocha"

local hl_colors = {
    ['Normal'] = { fg = palette.green },
    ['Pending'] = { fg = palette.flamingo },
    ['Visual'] = { fg = palette.mauve },
    ['Insert'] = { fg = palette.yellow },
    ['Command'] = { fg = palette.blue },
    ['Other'] = { fg = palette.red }
}

-- Pull defaults from existing statusline
local statusline_colors = vim.api.nvim_get_hl(0, { name = 'StatusLine' })
local default_colors = {
    fg = ('#%06x'):format(statusline_colors.fg),
    bg = ('#%06x'):format(statusline_colors.bg)
}

-- Keep track of the highlight groups already created
--- @type table<string, boolean>
local statusline_hls = {}

--- @param hl string
--- @return string
function M.get_or_create_hl(hl)
    local hl_name = 'Statusline' .. hl

    if not statusline_hls[hl] then
        local colors = hl_colors[hl]

        local bg_hl = (colors and colors.bg)
        or default_colors.bg
        local fg_hl = (colors and colors.fg)
        or default_colors.fg

        vim.api.nvim_set_hl(0, hl_name, { 
            bg = bg_hl,
            fg = fg_hl
        })

        statusline_hls[hl] = true
    end

    return hl_name

end

--- @return string
function M.mode_component()
    -- Note that: \19 = CTRL-S and \22 = CTRL-V
    -- see:help mode()

    local mode_to_str = {
        ['n'] = 'NORMAL',
        ['no'] = 'OP-PENDING',
        ['nov'] = 'OP-PENDING',
        ['noV'] = 'OP-PENDING',
        ['no\22'] = 'OP-PENDING',
        ['niI'] = 'NORMAL',
        ['niR'] = 'NORMAL',
        ['niV'] = 'NORMAL',
        ['nt'] = 'NORMAL',
        ['ntT'] = 'NORMAL',
        ['v'] = 'VISUAL',
        ['vs'] = 'VISUAL',
        ['V'] = 'VISUAL L',
        ['Vs'] = 'VISUAL L',
        ['\22'] = 'VISUAL B',
        ['\22s'] = 'VISUAL B',
        ['s'] = 'SELECT',
        ['S'] = 'SELECT',
        ['\19'] = 'SELECT',
        ['i'] = 'INSERT',
        ['ic'] = 'INSERT',
        ['ix'] = 'INSERT',
        ['R'] = 'REPLACE',
        ['Rc'] = 'REPLACE',
        ['Rx'] = 'REPLACE',
        ['Rv'] = 'VIRT REPLACE',
        ['Rvc'] = 'VIRT REPLACE',
        ['Rvx'] = 'VIRT REPLACE',
        ['c'] = 'COMMAND',
        ['cv'] = 'VIM EX',
        ['ce'] = 'EX',
        ['r'] = 'PROMPT',
        ['rm'] = 'MORE',
        ['r?'] = 'CONFIRM',
        ['!'] = 'SHELL',
        ['t'] = 'TERMINAL',
    }

    -- Get the mode string
    local mode_str = mode_to_str[vim.api.nvim_get_mode().mode] or 'UNKOWN'

    -- Set the highlight group
    local hl = 'Other'
    if mode_str:find 'NORMAL' then
        hl = 'Normal'
    elseif mode_str:find 'PENDING' then
        hl = 'Pending'
    elseif mode_str:find 'VISUAL' then
        hl = 'Visual'
    elseif mode_str:find 'INSERT' or mode_str:find 'SELECT' then
        hl = 'Insert'
    elseif mode_str:find 'COMMAND' or mode_str:find 'TERMINAL' or mode_str:find 'EX' then
        hl = 'Command'
    end

    return string.format(
        '%%#%s#%s%%#Statusline#',
        M.get_or_create_hl(hl),
        mode_str
    )

end

--- @return string
function M.file_component()
    return '%t%h%w %m%r'
end

--- @return string
function M.encoding_component()
    local encoding = vim.opt.fileencoding:get()
    return encoding ~= '' and string.format('%s', encoding) or ''
end

-- Get the OS: Win | Mac | Unix
local os_utils = require('marcus.osutils')

--- @return string
function M.os_component()
    local os_str = 'UNKOWN'

    if os_utils.is_windows then
        os_str = 'WIN'
    elseif os_utils.is_mac then
        os_str = 'MAC'
    elseif os_utils.is_linux then
        os_str = 'UNIX'
    end

    return string.format('%s', os_str)
end

--- @return string
function M.git_component()

    -- Pulled from fugitive
    local head = vim.fn.FugitiveHead()
    return head ~= '' and string.format('%s', head) or ''
end

--- @return string
function M.position_component()
    return 'c:%c l:%l/%L'
end

--- @return string
function M.inactive_component()
    return ' %t '
end

-- Render the statusline
function M.render()
    ---@param components string[]
    ---@return string
    local function concat_components(components)
        return vim.iter(components):skip(1):fold(components[1], function(acc, component)
            return #component > 0 and string.format('%s  %s', acc, component) or acc 
        end)
    end

    -- Check active window
    local active = vim.g.statusline_winid == vim.api.nvim_get_current_win()

    if active then
        return table.concat {
            ' ',
            concat_components {
                M.mode_component(),
                M.file_component(),
                M.git_component()
            },
            '%#StatusLine#%=',
            concat_components {
                vim.diagnostic.status(),
                M.os_component(),
                M.encoding_component(),
                M.position_component()
            },
            ' ',
        }
    else
        return table.concat { 
            ' ',
            M.file_component(),
            '%=',
            ' '
        }
    end
end

vim.o.statusline = "%!v:lua.require'marcus.statusline'.render()"

return M
