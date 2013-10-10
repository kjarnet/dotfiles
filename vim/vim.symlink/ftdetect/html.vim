" Override filetype-detection for xhtml-files, as rules for html-files are much better
autocmd BufNewFile,BufRead *.xhtml set filetype=html
autocmd BufNewFile,BufRead *.html set filetype=html
