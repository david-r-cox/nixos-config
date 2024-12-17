require('trim').setup({
  ft_blocklist = {"markdown"},
  --patterns = {
  --  [[%s/\(\n\n\)\n\+/\1/]],
  --},
  trim_on_write = true,
})
