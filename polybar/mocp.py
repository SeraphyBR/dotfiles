#!/usr/bin/python3
# Criado por Luiz Junio Veloso Dos Santos - luisjuniorbr@gmail.com
# Para uso em mudulo "custom script" do polybar.
# Mude de acordo com sua realidade.
#
# O script dá preferencia a exibição do nome do artista ou ao que tiver menor
# número de caracteres.
#
# Esse script foi criado com o objetivo de mostrar informações da música
# em execução no programa mocp. Foi realizado o uso de condicionais para que
# o resultado impresso não fosse ocupar espaço o suficiente para que a barra
# vá para alem do limite do monitor e
# verificar se a musíca continha informações sobre album e/ou artista vazios.
# Caso o album estiver sem informações então será exibido o nome do artista;
# Caso o artista estiver sem informações então será exibido o nome do album;
# Caso não ouver informações, apenas o nome da música e o tempo será exibido.
# Contudo, dependendo de onde a música  foi baixada, o mocp pode ter o nome da
# música vazia e apenas o nome da música no nome do arquivo em si. O script
# de forma a sempre fornecer alguma informação (alem do tempo), irá imprimir o
# nome do arquivo da música no lugar.
# Caso o nome do arquivo da música seja maior que o limite, o script irá
# imprimir um nome alternativo que seja válido para as demais músicas.
#
# Atenção... muitos if e else....
# Podem ocorrer bugs dependendo da música, travamentos e etc.
# Caso não ocorra nenhum problema, uma vez que teste a execução em Todas as suas
# Músicas, por favor envie um email dizendo :D.

# Adicione o modulo na config do polybar:
#
#    [module/mocp]
#    type = custom/script
#    interval = 0.56
#    format = " <label> "
#    format-prefix = " "
#    format-underline = ${colors.violet}
#    exec = ~/.config/polybar/mocp.py
#    click-left = mocp -f
#    click-right = mocp -r
#    click-middle = mocp -P





import subprocess

# Abaixo váriaveis definidas pelo usuario:
# A variavel local parte do principio de que todas as músicas "sem nome"
# estejam nesse diretorio, sem subpasta. Se estiver em uma subpasta, pode ocorrer
# do numero de caracteres passar o limite e exibir o nome alternativo no lugar.

limite = 36
local = "/home/seraphybr/Música/"
nome_alternativo = "Music"

filename = stdoutdata = subprocess.getoutput("mocp -Q %file")
song     = stdoutdata = subprocess.getoutput("mocp -Q %song")
album    = stdoutdata = subprocess.getoutput("mocp -Q %album")
artist   = stdoutdata = subprocess.getoutput("mocp -Q %artist")
time     = stdoutdata = subprocess.getoutput("mocp -Q %ct")



def analise():
    if (len(album) > len(artist)) :
        if (artist == ""):
            if(len(album) >= limite) :
                print (song + " - " + time)
            else:
                print( song + " on " + album + " - " + time )
        else:
            if(len(artist) <= limite) :
                print( song + " by " + artist + " - " + time )
    elif (len(artist) > len(album)):
        if (album == "") :
            if(len(artist) >= limite) :
                print (song + " - " + time)
            else:
                print( song + " by " + artist + " - " + time )
        else:
            if(len(album) >= limite) :
                print (song + " - " + time)
            else:
                print( song + " on " + album + " - " + time )
    else :
        if ((album == "") and (artist == "")):
            print (song + " - " + time)

if (filename == ""):
    print( "Nenhuma musica em execução" )
else:
    if (song == ""):
        name = filename.split(local)[1]
        if (len(name) >= limite):
            song = nome_alternativo
            analise()
        else:
            song = name
            analise()
    else:
        analise()
