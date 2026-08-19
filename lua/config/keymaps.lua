

-- Ctrl + A → Select all
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

vim.keymap.set("i", "<C-a>", "<Esc>ggVG", { desc = "Select all" })


-- Arrow keys in normal mode
vim.keymap.set("n", "<Up>", "k")
vim.keymap.set("n", "<Down>", "j")
vim.keymap.set("n", "<Left>", "h")
vim.keymap.set("n", "<Right>", "l")


-- Shift + Arrow → selection in normal mode
vim.keymap.set("n", "<S-Up>", "Vk")
vim.keymap.set("n", "<S-Down>", "Vj")
vim.keymap.set("n", "<S-Left>", "vh")
vim.keymap.set("n", "<S-Right>", "vl")
vim.keymap.set("n", "<C-b>", "<cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "<C-Tab>", "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>")

vim.keymap.set("n", "<C-w>", "<cmd>bdelete<CR>")
vim.keymap.set("v", "<C-c>", '"+y')
vim.keymap.set("i", "<C-v>", '<C-r>+')
vim.keymap.set("v", "<C-x>", '"+d')
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>")
-- Undo / Redo
vim.keymap.set("n", "<C-z>", "u")
vim.keymap.set("i", "<C-z>", "<C-o>u")
vim.keymap.set("v", "<C-z>", "<Esc>u")

vim.keymap.set("n", "<C-y>", "<C-r>")
vim.keymap.set("i", "<C-y>", "<C-o><C-r>")
vim.keymap.set("v", "<C-y>", "<Esc><C-r>")
-- New file
vim.keymap.set("n", "<C-n>", function()
    local api = require("nvim-tree.api")
    local node = api.tree.get_node_under_cursor()

    local path = node.absolute_path

    if node.type ~= "directory" then
        path = vim.fn.fnamemodify(path, ":h")
    end

    vim.ui.input({ prompt = "New file: " }, function(name)
        if name and name ~= "" then
            local file = path .. "/" .. name
            vim.fn.writefile({}, file)
            vim.cmd("edit " .. vim.fn.fnameescape(file))
        end
    end)
end, { desc = "New file" })


-- New folder
vim.keymap.set("n", "<C-S-n>", function()
    local api = require("nvim-tree.api")
    local node = api.tree.get_node_under_cursor()

    local path = node.absolute_path

    if node.type ~= "directory" then
        path = vim.fn.fnamemodify(path, ":h")
    end

    vim.ui.input({ prompt = "New folder: " }, function(name)
        if name and name ~= "" then
            vim.fn.mkdir(path .. "/" .. name, "p")
            api.tree.reload()
        end
    end)
end, { desc = "New folder" })

vim.keymap.set("n", "<C-A-Space>", function()
    vim.cmd("write")

    local file = vim.fn.expand("%:p")
    local executable = "/tmp/nvim_dsa_program"

    vim.cmd("botright 12split")
    vim.cmd("terminal g++ -std=c++17 -O2 " ..
        vim.fn.shellescape(file) ..
        " -o " ..
        vim.fn.shellescape(executable) ..
        " && " ..
        vim.fn.shellescape(executable))

    vim.cmd("startinsert")
end, { desc = "Compile and Run C++" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {
    desc = "Show diagnostic",
})
-- Ctrl + Backspace → delete previous word
vim.keymap.set("i", "<C-BS>", "<C-W>", {
    desc = "Delete previous word",
})

-- Fallback for terminals that send Ctrl+Backspace as Ctrl-H
vim.keymap.set("i", "<C-H>", "<C-W>", {
    desc = "Delete previous word",
})

