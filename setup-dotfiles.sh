#!/bin/sh

Principal() {
  echo   
  echo "     SeraphyBR DotFiles "
  echo "---------------------------------"
  echo "Opções:"
  echo
  echo "1. Copiar arquivos para o sistema."
  echo "2. Copiar os arquivos para o repositorio. (não implementado)"
  echo "3. Instalar backup dos programas."
  echo "4. Sair do programa. "
  echo
  echo -n "Qual a opção desejada? "
  read opcao
  case $opcao in
    1) op1  ;;
    2) exit ;;
    3) install  ;;
    4) exit ;;
    *) echo "Opção desconhecida." ; echo ; Principal ;;
  esac
}


op1() {

if [ -e -d ~/DotFiles ]
    then 
        echo 'A pasta DotFiles já  existe, copiando arquivos.... '
        copy 
    else    
        echo 'Clonando repositorio....'
        git clone https://github.com/SeraphyBR/DotFiles.git
        echo 'Iniciando cópia...'
        copy 
fi

}

copy() {
    cp -Rpv  ~/DotFiles/.config/     ~/.config
    cp -Rv ~/DotFiles/.vim/        ~/.vim
    cp -v  ~/DotFiles/.vimrc         ~/.vimrc
    cp -v  ~/DotFiles/.zshrc         ~/.zshrc 
    cp -v  ~/DotFiles/.Xresources    ~/.Xresources 
    cp -v  ~/DotFiles/pacman.conf     /etc/pacman.conf 
    sudo cp -v  ~/DotFiles/Rofi/Themes/flat-green.rasi     /usr/share/rofi/themes/flat-green.rasi
    cp -Rv  ~/DotFiles/Wallpapers/  ~/Imagens/Wallpapers 
}    

install() {
    cd ~/DotFiles
    echo 'Iniciando instalação dos programas usados por seraphybr.....'
    yaourt -S --needed  installed_programs.txt
}

Principal 
