nix-build
nix-shell -A shells.ghcjs --run "closure-compiler --externs result/ghcjs/chat/bin/chat.jsexe/all.js.externs -O ADVANCED --jscomp_warning=checkVars --js_output_file=\"out.js\" result/ghcjs/chat/bin/chat.jsexe/all.js"