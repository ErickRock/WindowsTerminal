# Configurar temas
# Ivo   - Facilitar configuração
# Erick - Projeto base

# Variaveis de ambiente
$pastaAtual = Split-Path $script:MyInvocation.MyCommand.Path
$pastaDestino = "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\"

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