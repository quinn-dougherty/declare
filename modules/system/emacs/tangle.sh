# for systemd use only.
$EMACS --batch --eval "(require 'org)" --eval "(org-babel-tangle-file \"$XDG_CONFIG_HOME/doom/config.org\")"
