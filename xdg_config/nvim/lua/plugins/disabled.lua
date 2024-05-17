local unwanted = {
  "akinsho/bufferline.nvim",
  "goolord/alpha-nvim",
}

local spec = {}

for i, p in ipairs(unwanted) do
  spec[i] = { p, enabled = false }
end

return spec
