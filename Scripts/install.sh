#!/bin/sh

dotfiles="$HOME/Git/DotFiles"

install_rust(){
    echo "Installing rust toolchain, using the recommended method with rustup"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

install_cargo_programs(){
    # https://the.exa.website
    cargo install exa
    # https://github.com/neXromancers/shotgun
    cargo install shotgun
    # https://github.com/neXromancers/hacksaw
    cargo install --git https://github.com/neXromancers/hacksaw
}

is_program_installed(){
    if [ -x "$(command -v "$1")" ]; then
        echo "$1 is installed"
        return 0
    else
        echo "$1 is missing"
        return 1
    fi
}

fonts() {
    #TODO
    foo
}

check_programs(){
    is_program_installed qutebrowser
    
    is_program_installed nvim

    if is_program_installed cargo; then
        install_cargo_programs
    else
        install_rust
        install_cargo_programs
    fi

}

install_dotfiles() {
    if [ ! -d "$dotfiles" ]; then
        git clone git@gitlab.com:SeraphyBR/DotFiles.git "$dotfiles"
    fi

    cp -b "$dotfiles/.zshrc" "$HOME"
    cp -b "$dotfiles/.zlogin" "$HOME"
    cp -b "$dotfiles/.zprofile" "$HOME"
    cp -b "$dotfiles/.zshenv" "$HOME"
    cp -b "$dotfiles/.p10k.zsh" "$HOME"
    cp -b "$dotfiles/.xinitrc" "$HOME"

    cp -b -r "$dotfiles/.config" "$HOME"
}

main() {

    install_dotfiles
}


main || exit 1
