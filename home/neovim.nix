{
  pkgs,
  ...
}:
{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    withNodeJs = true;
    withRuby = false;
    withPython3 = false;

    sideloadInitLua = true;

    extraPackages = with pkgs; [
      astro-language-server
      clang-tools
      cmake-language-server
      vscode-langservers-extracted
      golangci-lint-langserver
      gopls
      lua-language-server
      prettier
      prettierd
      pyright
      ruff
      spectral-language-server
      tailwindcss-language-server
      taplo
      tree-sitter
      typescript
      yaml-language-server
      nil
    ];
  };
}
