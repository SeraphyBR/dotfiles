#!/bin/sh

Principal() {
  echo   
  echo "     SeraphyBR DotFiles "
  echo "---------------------------------"
  echo "Opções:"
  echo
  echo "1. Copiar arquivos para o sistema."
  echo "2. Copiar os arquivos para o repositorio. (não implementado)"
  echo "3. Instalar backup dos programas e configurar ambiente. (Demorado)"
  echo "4. Remover programas não listados em installed_programs.txt (Faça por sua conta e risco!)"
  echo "5. Sair do programa. "
  echo
  echo -n "Qual a opção desejada? "
  read opcao
  case $opcao in
    1) op1  ;;
    2) exit ;;
    3) install  ;;
    4) remove ;;
    5) exit ;;
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

    cp -Rpv     ~/DotFiles/.config/                    ~/
    cp -Rv      ~/DotFiles/.vim/                       ~/
    sudo cp -v  ~/DotFiles/.vimrc                      ~/.vimrc
    cp -v       ~/DotFiles/.zshrc                      ~/.zshrc 
    sudo cp -v  ~/.zshrc                                /root/.zshrc
    cp -v       ~/DotFiles/.Xresources                 ~/.Xresources 
    sudo cp -v  ~/DotFiles/pacman.conf                  /etc/pacman.conf 
    sudo cp -v  ~/DotFiles/Rofi/Themes/flat-green.rasi  /usr/share/rofi/themes/flat-green.rasi
    cp -Rv      ~/DotFiles/Wallpapers/                 ~/Imagens/ 
    sudo cp -Rv ~/DotFiles/Wallpapers/*                 /usr/share/backgrounds

    echo 'Arquivos já foram copiados...'
    echo

    if [ ! -e ~/.config/polybar/gmail/credentials.json ] 
    then 
        echo "Deseja configurar o modulo gmail para o polybar?"
        echo
        echo "Digite: 1 - Sim (recomendado) ou 2 - Não "
        read opcao2 
        case $opcao2 in 
            1) gmail_module ;; 
            2) echo ; Principal ;; 
            *) echo "Opção desconhecida." ; echo ; Principal ;; 
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
        echo "Em seguida será aberto uma chave de autenticação do gmail no navegador, copie o código para o terminal e de um enter."
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

remove() {
    cd ~/DotFiles 


    pacman -Qqe > currently_installed.txt                  
                                                        
    for R in $( <installed_programs.txt )                  
    do                                                     
        sed -i "/\b\(${R}\)\b/d" currently_installed.txt        
    done                                                   
                                                        
    sudo pacman -R $( <currently_installed.txt) 
    echo
    echo "Finalizado a remoção."
    rm currently_installed.txt 

}

install() {
     
    if [ -d ~/DotFiles ]
        then 
            cd ~/DotFiles 
        else    
            echo 'Clonando repositorio....'
            git clone https://github.com/SeraphyBR/DotFiles.git
            cd ~/DotFiles 
    fi
 
    echo 
    echo 
    echo "Iniciando instalação dos programas usados por seraphybr....."
    echo
    echo "Adicionando key para instalação do linux-steam-integration..."
    gpg --recv-keys 8876CC8EDAEC52CEAB7742E778E2387015C1205F 

    echo "Atualizando sistema para proceder com a instalação dos demais programas.... "
    sudo pacman -Syu --noconfirm 
    echo 
    # This topic solved my problem, to be able to run the same script in archlinux,
    # ignoring the installation of manjaro packages that were not found by pacman. https://bbs.archlinux.org/viewtopic.php?id=169480
    echo "Iniciando verificação dos programas presentes em installed_programs.txt, o que não estiver no sistema será instalado..."
    echo 
    sleep 4 
    for P in $( <installed_programs.txt )
    do 
        if ! ( yaourt -Q | grep ${P} > /dev/null ) 
        then 
             echo
             echo "Verificando ${P} "
             yaourt -S --needed --noconfirm ${P} 
             echo 
             echo
         else 
             echo "Verificando ${P}... "
         fi
    done

    sudo pip install --upgrade google-api-python-client 
    echo
    echo

    if [  !  -e ~/.atom/packages/sync-settings  ] 
    then 
        apm install sync-settings
        echo "O plugin sync-settings do editor Atom foi instalado, use-o para restaurar um backup dos arquivos do Atom."
    fi

    if [ ! -d /usr/share/oh-my-zsh/themes/powerlevel9k ]
    then 
        echo "Instalando PowerLevel9K theme for Zsh"
        echo
        sudo git clone https://github.com/bhilburn/powerlevel9k.git /usr/share/oh-my-zsh/themes/powerlevel9k
        echo
    fi 

    echo "Instalando o oh-my-zsh e setando o zsh como padrão no usuario root..."
    sudo -H -u root sh -c "$(wget  https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -) ; exit "
    echo
    echo


    if [ -e /usr/share/xgreeters/lightdm-webkit2-greeter.desktop ]
    then 
        echo "Setando o lightdm-webkit-greeter...."
        if [ "$(grep '#greeter-session=' /etc/lightdm/lightdm.conf)" ]
        then  
            sudo sed -i "s|^#greeter-session=.*|greeter-session=lightdm-webkit2-greeter|g" /etc/lightdm/lightdm.conf
        else 
            sudo sed -i "s|^greeter-session=.*|greeter-session=lightdm-webkit2-greeter|g" /etc/lightdm/lightdm.conf

        fi 

        echo
    fi

    echo "Setando tema de cursor default do X"
    echo
    echo -e  "[Icon Theme]\nInherits=Breese_Obsidian" | sudo tee /usr/share/icons/default/index.theme 
    echo

    echo
    echo "Definindo imagem padrão de lockscreen e wallpaper... "
    betterlockscreen -u Wallpapers/road_trees_top_view_119030_1920x1080.jpg 
    nitrogen --set-scaled Wallpapers/road_trees_top_view_119030_1920x1080.jpg 


    echo "instalação concluida.."
    echo 
    echo
    echo "Deseja copiar os arquivos de configuração?"
    echo 
    echo "Digite:   1 - Sim ; 2 - Não "
    echo 
    read opcao1 

    case $opcao1 in 
        1) copy ;;
        2) echo ; Principal ;; 
        *) echo "Opção desconhecida." ; echo ; Principal ;; 
    esac

}

Principal    
