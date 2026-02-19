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


$env.config.shell_integration.osc2 = true
$env.config.shell_integration.osc7 = true
$env.config.shell_integration.osc8 = true
$env.config.shell_integration.osc9_9 = true
$env.config.shell_integration.osc133 = true
$env.config.shell_integration.osc633 = true

