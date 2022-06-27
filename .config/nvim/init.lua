if vim.fn.has('win32')
then
	vim.cmd('source ~/vimfiles/vimrc')
else
	vim.cmd('source ~/.vim/vimrc')
end
