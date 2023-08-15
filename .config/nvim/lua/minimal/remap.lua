vim.keymap.set("n", "<leader>nf", vim.cmd.Ex)
vim.keymap.set("n", "<leader>q", vim.cmd.q)
vim.keymap.set("n", "Y", "yg$")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>v", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

local function get_table_len(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

vim.keymap.set("n", "<C-s>", function()
  local len = get_table_len(vim.lsp.buf_get_clients())
  if len ~= 0 then
    vim.lsp.buf.format()
  end
  vim.cmd.w()
end)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<leader>v", 'y:%s/\\V<C-r>+//g<Left><Left>')

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("i", "<C-c>", "<Esc>")
