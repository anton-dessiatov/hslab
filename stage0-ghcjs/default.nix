(import ./reflex-platform {}).project ({ pkgs, ... }: {
  packages = {
    chat = ./chat;
  };

  shells = {
    ghcjs = [ "chat" ];
  };
})