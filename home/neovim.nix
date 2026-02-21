{
  pkgsUnstable,
  ...
}:
{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    withNodeJs = true;

    extraPackages = with pkgsUnstable; [
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
      vtsls
      yaml-language-server
    ];
  };
}
