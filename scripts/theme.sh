#!/usr/bin/env bash

THEME="$1"

if [[ -z "$THEME" ]]; then
    echo "Usage: theme-switch.sh <theme>"
    exit 1
fi

THEMES_DIR="$HOME/.config/quickshell/styles/themes"
THEME_DIR="$THEMES_DIR/$THEME"

if [[ ! -d "$THEME_DIR" ]]; then
    echo "Theme '$THEME' not found."
    exit 1
fi

link_if_exists() {
    local source="$1"
    local target="$2"

    if [[ -f "$source" ]]; then
        mkdir -p "$(dirname "$target")"
        ln -sf "$source" "$target"
        echo "✓ $(basename "$target")"
    else
        echo "✗ Missing: $source"
    fi
}

# -------------------------
# Wallpapers
# -------------------------

case "$THEME" in
    monochrome)
        WP="art11.png"
        SpotifyTheme="ultrablack"
        ;;

    githublight)
        WP="Totoro.png"
        SpotifyTheme="ultrablack"
        ;;

    gruvbox)
        WP="gruvbox_astro.jpg"
        SpotifyTheme="bladerunner"
        ;;

    gruvboxlight)
        WP="anime-girl3.jpg"
        SpotifyTheme="ultrablack"
        ;;

    dracula)
        WP="art13.jpeg"
        SpotifyTheme="dracula"
        ;;

    everforest)
        WP="foggy_valley_2.png"
        SpotifyTheme="futura"
        ;;

    catppuccin)
        WP="arch-black-4k.png"
        SpotifyTheme="catppuccin"
        ;;

    catppuccinlatte)
        WP="7.jpg"
        SpotifyTheme="ultrablack"
        ;;

    nord)
        WP="chainsaw-man.png"
        SpotifyTheme="nord"
        ;;

    rosepine)
        WP="dark-fantasy.jpg"
        SpotifyTheme="rosepine"
        ;;

    solarized)
        WP="sleeping.jpg"
        SpotifyTheme="ultrablack"
        ;;

    tokyonight)
        WP="aesthetic-anime2.jpg"
        SpotifyTheme="tokyonight"
        ;;

    *)
        WP="default.jpg"
        SpotifyTheme="ultrablack"
        ;;
esac

# -------------------------
# Wallpaper
# -------------------------

awww img \
"$HOME/Pictures/wallpapers/$WP" \
--transition-type grow

# -------------------------
# Kitty
# -------------------------

if [[ -f "$THEME_DIR/kitty.conf" ]]; then
    cp -f \
        "$THEME_DIR/kitty.conf" \
        "$HOME/.config/kitty/kitty.conf"

    echo "✓ kitty"
fi

# -------------------------
# Hyprland
# -------------------------

link_if_exists \
    "$THEME_DIR/HyprTheme.lua" \
    "$HOME/.config/quickshell/config/hypr/current-theme/theme.lua"

echo "✓ hyprland"

# -------------------------
# Starship
# -------------------------

if [[ -f "$THEME_DIR/starship.toml" ]]; then
    cp -f \
        "$THEME_DIR/starship.toml" \
        "$HOME/.config/starship.toml"

    echo "✓ starship"
fi

# -------------------------
# Zen
# -------------------------

if [[ -f "$THEME_DIR/user.js" ]]; then
    cp -f \
        "$THEME_DIR/user.js" \
        "$HOME/.config/zen/p6h4p02e.Default (release)/user.js"

    echo "✓ zen"
fi

# -------------------------
# Spotify
# -------------------------

spicetify config current_theme Sleek color_scheme $SpotifyTheme
spicetify refresh

echo "✓ spotify"

echo "$THEME" > "$HOME/.config/quickshell/.current_theme"

