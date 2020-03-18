# Configurar temas
# Ivo   - Facilitar configuração
# Erick - Projeto base

function Editar-Json {
    param (
        $tema
    )

    # Configuracoes gerais
    $pastaAtual = Split-Path $script:MyInvocation.MyCommand.Path
    $arquivoJson = "$pastaAtual\Profile\profiles.json"
    # Verifica se ja tem um configurado
    $existe = Test-Path $arquivoJson
    if ($existe) {
        Remove-Item $arquivoJson -Force
    }
    # Recebe o texto do JSON padrao
    
    $json = Get-Content "$pastaAtual\Profile\profilesPadrao.json"
    # Faz a troca
    $json = $json -replace "#tema#", "$tema"
    # Salva o conteudo
    Add-Content -Path "$pastaAtual\Profile\profiles.json" -Value $json
}

# Faz o procedimento com retornor em PTBR
function Set-ConfiguracaoBR {
    # Variaveis de ambiente
    $pastaAtual = Split-Path $script:MyInvocation.MyCommand.Path
    $pastaDestino = "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\"

    # Escolha um tema
    $tema = "Nao escolheu"
    while ($tema -eq "Nao escolheu") {
        Write-Host "Atualmente temos os tres temas que voce viu na postagem"
        Write-Host "Escolha um informando o respectivo numero: "
        Write-host "1 - Star Wars"
        Write-host "2 - Balmer e Ninja Cat"
        Write-host "3 - Unicornio"
        $opcao = Read-Host "Qual vai ser"
        # Valida com um if do povo
        if ($opcao -eq "1") { 
            $tema = "starwars.gif"
            break
        }
        if ($opcao -eq "2") { 
            $tema = "ninjacatballmer.jpg"
            break
        }
        if ($opcao -eq "3") { 
            $tema = "unicorn.gif"
            break
        }
        else { 
            $tema = "Nao escolheu"
            Clear-Host
            Write-Host "Vamos tentar novamente..."
        }
    }
    # Faz a alteracao no arquivo
    Editar-Json $tema

    # Verifica se tem instalado o Windows Terminal
    $winTerminal = Test-Path "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe"
    if ($winTerminal) {
        # Copia os arquivos
        Write-Host "Copiando os arquivos necessarios"
        try{
            Copy-Item -Path "$pastaAtual\Profile\*.*" -Destination "$pastaDestino" -Force
            Write-Host "Procedimento concluido"
        } catch {
            Write-host "Deu ruim"
            Write-host "Erro: $_.Exception.Message"
        }
    } else {
        Write-Host "Favor instalar o Windows Terminal Preview"
        Write-Host "Ao continuar, vamos abrir a tela de download"
        Write-Host "Faça a instalação e use novamente o script"
        pause
        $url = "https://www.microsoft.com/pt-br/p/windows-terminal-preview/9n0dx20hk701?activetab=pivot:overviewtab"
        Start-Process "$url"
    }
}

# Faz o procedimento com retornor em EN
function Set-ConfiguracaoEN {
    # Variaveis de ambiente
    $pastaAtual = Split-Path $script:MyInvocation.MyCommand.Path
    $pastaDestino = "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\"

    # Escolha um tema
    $tema = "Nao escolheu"
    while ($tema -eq "Nao escolheu") {
        Write-Host "We currently have the three themes you saw in the post"
        Write-Host "Choose one by informing the respective number: "
        Write-host "1 - Star Wars"
        Write-host "2 - Balmer and Ninja Cat"
        Write-host "3 - Unicorn"
        $opcao = Read-Host "Which will be"
        # Valida com um if do povo
        if ($opcao -eq "1") { 
            $tema = "starwars.gif"
            break
        }
        if ($opcao -eq "2") { 
            $tema = "ninjacatballmer.jpg"
            break
        }
        if ($opcao -eq "3") { 
            $tema = "unicorn.gif"
            break
        }
        else { 
            $tema = "Nao escolheu"
            Clear-Host
            Write-Host "Let's try again..."
        }
    }
    # Faz a alteracao no arquivo
    Editar-Json $tema

    # Verifica se tem instalado o Windows Terminal
    $winTerminal = Test-Path "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe"
    if ($winTerminal) {
        # Copia os arquivos
        Write-Host "Copying the necessary files"
        try{
            Copy-Item -Path "$pastaAtual\Profile\*.*" -Destination "$pastaDestino" -Force
            Write-Host "Completed"
        } catch {
            Write-host "It was bad"
            Write-host "Error: $_.Exception.Message"
        }
    } else {
        Write-Host "Please install Windows Terminal Preview"
        Write-Host "When continuing, we will open the download screen"
        Write-Host "Install and use the script again"
        pause
        $url = "https://www.microsoft.com/pt-br/p/windows-terminal-preview/9n0dx20hk701?activetab=pivot:overviewtab"
        Start-Process "$url"
    }
}

# Verifica qual o idioma
$idioma = (GET-WinSystemLocale).name
if ($idioma -eq "pt-BR") {
    Set-ConfiguracaoBR
} else {
    Set-ConfiguracaoEN
}