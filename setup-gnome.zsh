header "SETUP GNOME"
gsettings set org.gnome.desktop.default-applications.terminal exec alacritty
gsettings set org.gnome.desktop.wm.keybindings maximize "['<Alt>Up']"
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-down "@as []"
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-up "@as []"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "['<Shift><Super>Down']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "['<Shift><Super>Up']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Super>Down']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Super>Up']"
gsettings set org.gnome.desktop.wm.keybindings unmaximize "['<Alt>Down']"
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['<Super>t']"
gsettings set org.gnome.settings-daemon.plugins.media-keys www "['<Super>w']"
gsettings set org.gnome.settings-daemon.plugins.media-keys www "['<Super>w']"
gsettings set org.gnome.shell.app-switcher current-workspace-only true
