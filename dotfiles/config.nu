use std/util "path add"

$env.config.show_banner = false

path add "~/Qt/6.11.1/macos/bin"

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

