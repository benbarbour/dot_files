return {
  "https://github.com/tummetott/unimpaired.nvim",
  lazy = false,
  opts = {
    default_keymaps= false,
    keymaps = {
      bprevious = {
        mapping = '[b',
        description = 'Jump to [count] previous buffer',
        dot_repeat = true,
      },
      bnext = {
        mapping = ']b',
        description = 'Jump to [count] next buffer',
        dot_repeat = true
      },
      lprevious = {
        mapping = '[l',
        description = 'Jump to [count] previous entry in loclist',
        dot_repeat = true,
      },
      lnext = {
        mapping = ']l',
        description = 'Jump to [count] next entry in loclist',
        dot_repeat = true,
      },
      lfirst = {
        mapping = '[L',
        description = 'Jump to first entry in loclist',
        dot_repeat = false,
      },
      llast = {
        mapping = ']L',
        description = 'Jump to last entry in loclist',
        dot_repeat = false,
      },
      cprevious = {
        mapping = '[q',
        description = 'Jump to [count] previous entry in qflist',
        dot_repeat = true,
      },
      cnext = {
        mapping = ']q',
        description = 'Jump to [count] next entry in qflist',
        dot_repeat = true,
      },
      cfirst = {
        mapping = '[Q',
        description = 'Jump to first entry in qflist',
        dot_repeat = false,
      },
      clast = {
        mapping = ']Q',
        description = 'Jump to last entry in qflist',
        dot_repeat = false,
      },
      blank_above = {
        mapping = '[<Space>',
        description = 'Add [count] blank lines above',
        dot_repeat = true,
      },
      blank_below = {
        mapping = ']<Space>',
        description = 'Add [count] blank lines below',
        dot_repeat = true,
      },
      exchange_above = {
        mapping = '[e',
        description = 'Exchange line with [count] lines above',
        dot_repeat = true,
      },
      exchange_below = {
        mapping = ']e',
        description = 'Exchange line with [count] lines below',
        dot_repeat = true,
      },
      exchange_section_above = {
        mapping = '[e',
        description = 'Move section [count] lines up',
        dot_repeat = true,
      },
      exchange_section_below = {
        mapping = ']e',
        description = 'Move section [count] lines down',
        dot_repeat = true,
      },
      enable_hlsearch = {
        mapping = '[oh',
        description = 'Enable hlsearch',
        dot_repeat = false,
      },
      disable_hlsearch = {
        mapping = ']oh',
        description = 'Disable hlsearch',
        dot_repeat = false,
      },
      enable_list = {
        mapping = '[ol',
        description = 'Show invisible characters (listchars)',
        dot_repeat = false,
      },
      disable_list = {
        mapping = ']ol',
        description = 'Hide invisible characters (listchars)',
        dot_repeat = false,
      },
      enable_number = {
        mapping = '[on',
        description = 'Enable line numbers',
        dot_repeat = false,
      },
      disable_number = {
        mapping = ']on',
        description = 'Disable line numbers',
        dot_repeat = false,
      },
      enable_relativenumber = {
        mapping = '[or',
        description = 'Enable relative numbers',
        dot_repeat = false,
      },
      disable_relativenumber = {
        mapping = ']or',
        description = 'Disable relative numbers',
        dot_repeat = false,
      },
      enable_spell = {
        mapping = '[os',
        description = 'Enable spell check',
        dot_repeat = false,
      },
      disable_spell = {
        mapping = ']os',
        description = 'Disable spell check',
        dot_repeat = false,
      },
      enable_colorcolumn = {
        mapping = '[ot',
        description = 'Enable colorcolumn',
        dot_repeat = false,
      },
      disable_colorcolumn = {
        mapping = ']ot',
        description = 'Disable colorcolumn',
        dot_repeat = false,
      },
      enable_wrap = {
        mapping = '[ow',
        description = 'Enable line wrapping',
        dot_repeat = false,
      },
      disable_wrap = {
        mapping = ']ow',
        description = 'Disable line wrapping',
        dot_repeat = false,
      },
      enable_cursorcross = {
        mapping = '[ox',
        description = 'Enable cursorcross',
        dot_repeat = false,
      },
      disable_cursorcross = {
        mapping = ']ox',
        description = 'Disable cursorcross',
        dot_repeat = false,
      },
    }
  }
}
