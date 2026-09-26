# 初回switch用。(最初はhome-managerが入ってない状態なので、home-managerでhome-managerをapt-install的なことをする)
nix run home-manager/master -- switch --flake ~/.config/home-manager#mtugb
