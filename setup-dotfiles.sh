#!/bin/sh

Principal() {
  echo   
  echo "     SeraphyBR DotFiles "
  echo "---------------------------------"
  echo "Opções:"
  echo
  echo "1. Copiar arquivos para o sistema."
  echo "2. Copiar os arquivos para o repositorio. (não implementado)"
  echo "3. Instalar backup dos programas e configurar ambiente. (Manjaro Only)  "
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

if [ -d ~/DotFiles ]
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
    cp -Rpv  ~/DotFiles/.config/     ~/
    cp -Rv ~/DotFiles/.vim/        ~/
    cp -v  ~/DotFiles/.vimrc         ~/.vimrc
    cp -v  ~/DotFiles/.zshrc         ~/.zshrc 
    cp -v  ~/DotFiles/.Xresources    ~/.Xresources 
    sudo cp -v  ~/DotFiles/pacman.conf     /etc/pacman.conf 
    sudo cp -v  ~/DotFiles/Rofi/Themes/flat-green.rasi     /usr/share/rofi/themes/flat-green.rasi
    cp -Rv  ~/DotFiles/Wallpapers/  ~/Imagens/ 
    echo 'Arquivos já foram copiados...'
    echo 
    if [ ! -e ~/.config/polybar/gmail/credentials.json ] 
    then 
        echo "Deseja configurar o modulo gmail para o polybar?"
        echo
        echo "Digite: 1 - Sim (recomendado) ou 2 - Não "
        read opcao2 
        case opcao2 in 
            1) gmail_module ;; 
            2) echo ; Principal ;; 
        esac 
    fi 
    } 


gmail_module(){ 
 if [ -e ~/.config/polybar/gmail/auth.py ] 
 then 
    if [ -e /bin/firefox ] 
    then 
        echo "Em seguida será aberto uma chave de autenticação do gmail no navegador, copie o código
        para o terminal e de um enter."
        sleep 10
        python  ~/.config/polybar/gmail/auth.py
        echo "Pronto"
        echo 
        sleep 2 
        Principal 
    else 
        echo "Navegador Firefox não encontrado, ele será instalado a seguir."
        sudo pacman -S firefox 
        echo 
        echo "Em seguida será aberto uma chave de autenticação do gmail no navegador, copie o código
        para o terminal e de um enter."
        sleep 10
        python  ~/.config/polybar/gmail/auth.py 
        echo "Pronto"
        sleep 2
        Principal 
    fi
else 
    echo "Arquivo não encontrado, faça a copia dos arquivos para proceder." 
    echo 
    sleep 2
    Principal 
fi 
}    

install() {
    cd ~/DotFiles
    echo 'Iniciando instalação dos programas usados por seraphybr.....'
    echo
    echo 'Adicionando key para instalação do linux-steam-integration...'
    gpg --recv-keys 8876CC8EDAEC52CEAB7742E778E2387015C1205F 
    yaourt -S --needed --noconfirm  installed_programs.txt
    sudo pip install --upgrade google-api-python-client 
    if [ -e /bin/atom ] 
    then 
        apm install sync-settings
        echo "O plugin sync-settings do editor Atom foi instalado, use-o para restaurar um backup
        dos arquivos do Atom."
    fi
    echo "Instalando PowerLevel9K theme for Zsh"
    echo 
    sudo git clone https://github.com/bhilburn/powerlevel9k.git /usr/share/oh-my-zsh/themes/powerlevel9k
    echo
    if [ $(cat /etc/profile.d/jre.sh | grep JAVA) -eq 1  ]
    then
        echo "Adicionando opção de execução java para melhor exibição de programas no Bspwm, como o
        JGRASP. "
        echo 
        sleep 2
        echo "Por favor digite sua senha para proceder..."
        sleep 2 
        echo "export _JAVA_AWT_WM_NONREPARENTING=1" | sudo tee -a /etc/profile.d/jre.sh
        echo 
    fi 
    echo "instalação concluida.."
    echo 
    echo "Deseja copiar os arquivos de configuração?"
    echo 
    echo "Digite:   1 - Sim ; 2 - Não "
    echo 
    read opcao1 
    case opcao1 in 
        1) op1 ;;
        2) echo ; Principal ;; 
    esac

}

Principal 
