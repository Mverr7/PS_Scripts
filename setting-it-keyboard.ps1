# Funzione per cambiare il layout della tastiera
function Set-KeyboardLayout {
    param (
        [string]$layout
    )
    $key = "HKCU:\Keyboard Layout\Preload"
    Remove-ItemProperty -Path $key -Name 1 -ErrorAction SilentlyContinue
    New-ItemProperty -Path $key -Name 1 -Value $layout -PropertyType String
}

# Imposta la lingua di visualizzazione su inglese (Stati Uniti) ed i parametri per l' ora e fuso orario
Set-WinUILanguageOverride -Language en-US
Set-WinUserLanguageList -LanguageList en-US -Force
Set-WinSystemLocale -SystemLocale it-IT
Set-Winhomelocation -GeoId 106
Set-TimeZone -Id "W. Europe Standard Time"

# Imposta il layout della tastiera su italiano
Set-KeyboardLayout -layout "00000410"
Write-Host "La lingua di visualizzazione è stata impostata su inglese (Stati Uniti) e il layout della tastiera su italiano."

$restart = Read-Host "Vuoi riavviare ora per applicare le modifiche? (s/n)"

if ($restart -eq 's') {
    # Riavvia il computer
    Restart-Computer -Force
} else {
    Write-Host "Le modifiche saranno applicate al prossimo riavvio."
}
