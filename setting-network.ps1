# Funzione per ottenere l'interfaccia di rete
function Get-NetworkAdapter {
    $adapters = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' }
    switch ($adapters.Length) {
        0 {
            Write-Host "Nessuna scheda di rete attiva trovata."
            return $null
        }
        1 {
            return $adapters[0]
        }
        default {
            Write-Host "Schede di rete trovate:"
            $adapters | ForEach-Object { Write-Host "$($_.InterfaceIndex): $($_.Name)" }
            $index = Read-Host "Inserisci l'indice della scheda di rete che vuoi configurare"
            return $adapters | Where-Object { $_.InterfaceIndex -eq [int]$index }
        }
    }
}

# Ottieni l'interfaccia di rete
$networkAdapter = Get-NetworkAdapter

if ($null -ne $networkAdapter) {
    # Mostra informazioni sull'interfaccia di rete selezionata
    Write-Host "Configurazione della scheda di rete: $($networkAdapter.Name)"

    # Chiedi all'utente i nuovi dettagli della rete
    $newIPAddress = Read-Host "Inserisci il nuovo indirizzo IP"
    $newSubnetMask = Read-Host "Inserisci la nuova subnet mask (es. 24 per 255.255.255.0)"
    $newGateway = Read-Host "Inserisci il nuovo gateway"
    $newDns = Read-Host "Inserisci il nuovo server DNS (separato da virgole per più DNS)"

    # Verifica se l'utente ha inserito tutti i dettagli necessari
    if ($newIPAddress -and $newSubnetMask -and $newGateway -and $newDns) {
        try {
            # Configura la scheda di rete con i nuovi dettagli
            New-NetIPAddress -InterfaceAlias $networkAdapter.Name -IPAddress $newIPAddress -PrefixLength $newSubnetMask -DefaultGateway $newGateway -AddressFamily IPv4 -ErrorAction Stop
            Set-DnsClientServerAddress -InterfaceAlias $networkAdapter.Name -ServerAddresses ($newDns -split ',') -ErrorAction Stop

            # Notifica l'utente che la configurazione è stata aggiornata con successo
            Write-Host "La configurazione della rete è stata aggiornata con successo."
        } catch {
            # Gestisci gli errori e notifica l'utente
            Write-Host "Errore durante il tentativo di aggiornare la configurazione della rete: $_"
        }
    } else {
        Write-Host "Tutti i campi sono obbligatori. Operazione annullata."
    }
} else {
    Write-Host "Nessuna scheda di rete trovata. Verifica che la scheda di rete sia attiva e riprova."
}
