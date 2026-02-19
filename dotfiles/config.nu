$env.config.show_banner = false


$env.config.history.file_format = "sqlite"
$env.config.history.max_size = 1_000_000

$env.config.edit_mode = "vi"
$env.prompt_indicator_vi_insert = ""

$env.config.completions.algorithm = "fuzzy"

$env.config.use_kitty_protocol = true

$env.config.keybindings ++= [
  {
    name: finish_completion
    modifier: control
    keycode: char_u00005d
    mode: ['emacs', 'vi_normal', 'vi_insert']
    event: {
      send: historyhintcomplete
    }
  }
]

