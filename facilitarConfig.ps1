# Configurar temas
# Ivo   - Facilitar configuração
# Erick - Projeto base

function Editar-Json {
    param (
        $tema
    )

    # Configuracoes gerais
    $pastaAtual = Split-Path $script:MyInvocation.MyCommand.Path
    $arquivoJson = "$pastaAtual\Profile\settings.json"
    # Verifica se ja tem um configurado
    $existe = Test-Path $arquivoJson
    if ($existe) {
        Remove-Item $arquivoJson -Force
    }
    # Recebe o texto do JSON padrao
    
    $json = Get-Content "$pastaAtual\Profile\settingsPadrao.json"
    # Faz a troca
    $json = $json -replace "#tema#", "$tema"
    # Salva o conteudo
    Add-Content -Path "$pastaAtual\Profile\settings.json" -Value $json
}

# Variaveis de ambiente
$pastaAtual = Split-Path $script:MyInvocation.MyCommand.Path
$pastaDestino = "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\"

# Escolha um tema
$tema = "Nao escolheu"
while ($tema -eq "Nao escolheu") {
    Write-Host "Atualmente temos os tres temas que você viu na postagem"
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