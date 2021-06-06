local home = "/home/seraphybr/"
local scripts = home .. "Git/dotfiles/scripts/"
local wallpapers = home .. "Git/dotfiles/images/wallpapers"

return {
  -- List of apps to start by default on some actions
    default = {
        browser = "qutebrowser",
        terminal = "kitty",
        editor = os.getenv("EDITOR") or "nvim",
        editor_cmd = "kitty -e nvim",
        rofi = "rofi -show drun ",
        lock = "betterlockscreen -l",
        filemanager_cmd = "kitty -e ranger"
    },

    -- List of apps to start once on start-up
    run_on_start_up = {
        "mpd",
        "picom -b",
        "systemctl --user start redshift",
        "caffeine",
        "/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1 &",
        "udiskie --smart-tray",
        -- scripts .. "wallblur/wallblur.sh -o " .. wallpapers,
        scripts .. "mpd_notify.sh"
    }
}
