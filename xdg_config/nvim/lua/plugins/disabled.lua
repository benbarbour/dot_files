local unwanted = {
  "akinsho/bufferline.nvim",
}

local spec = {}

for i, p in ipairs(unwanted) do
  spec[i] = { p, enabled = false }
end

return spec
