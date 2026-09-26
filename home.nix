# programs.bash = {
#   enable = true;
#   shellAliases = {
#     apt-list = ''zgrep -hE "Commandline: apt(-get)? install" /var/log/apt/history.log*'';
#   };
# };

# コメントはずんだもんの提供でお送りするのだ
{ pkgs, ... }: # 引数にはnixpkgsのパッケージ集pkgsを受け取るのだ。余分な引数を許容するため、明示的に...をかくのだ
{
  home = {
    username = "mtugb";
    homeDirectory = "/home/mtugb";
    stateVersion = "26.05";
    packages = with pkgs; [
      nixd # 上にwith pkgs;が書かれていなかったらpkgs.nixd
      nixfmt # ここはpkgs.nixfmtになるのだ。以降も同じ感じで変わるのだ。
      lua-language-server
      stylua
    ];
  };
  targets.genericLinux.enable = true; # nixOsじゃない環境でNixを使うための調整をオンにしてるのだ
  programs.home-manager.enable = true; # nivコマンドには、色んな人がPRを通して必要そうなアプリ一覧を登録してくれてるのだ。

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    initLua = builtins.readFile ./nvim/init.lua;
  };
  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
    escapeTime = 10; # Neovimでエスケープキーの反応が遅くなるのを防ぐ
    extraConfig = ''
      # optionにない設定は、ここに .tmux.conf の書き方でそのまま書ける
    '';
  };
	programs.gh = {
	  enable = true;
	  settings = {
	    git_protocol = "ssh";   # または "https"
	    editor = "nvim";
	  };
	};
}

# neovimは色んな人が使うので、普通にhome.packagesに書く以外にも、programs.neovim = { enable = true } という入れ方ができるのだ。
