--
-- ░▀█▀░█▀▀░█▄█░█▀█░█░░░█▀█░▀█▀░█▀▀░█▀▀
-- ░░█░░█▀▀░█░█░█▀▀░█░░░█▀█░░█░░█▀▀░▀▀█
-- ░░▀░░▀▀▀░▀░▀░▀░░░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀
--
vim.cmd([[
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.org 0r ~/.skeletons/file.org
    autocmd BufNewFile *.sh 0r ~/.skeletons/file.sh
    autocmd BufNewFile README.md 0r ~/.skeletons/README.md
  augroup END
endif
]])
