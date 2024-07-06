# Chiedi all'utente di inserire il nuovo nome per il computer
$newComputerName = Read-Host "Inserisci il nuovo nome del computer"

# Verifica se l'utente ha inserito un nome
if ($newComputerName) {
    try {
        # Rinominare il computer
        Rename-Computer -NewName $newComputerName -Force -PassThru

        # Notifica l'utente che il nome del computer è stato cambiato con successo
        Write-Host "Il nome del computer è stato cambiato con successo a $newComputerName. È necessario riavviare il computer per applicare le modifiche."

        # Chiedi all'utente se vuole riavviare ora
        $restart = Read-Host "Vuoi riavviare ora? (s/n)"

        if ($restart -eq 's') {
            # Riavvia il computer
            Restart-Computer -Force
        }
    } catch {
        # Gestisci gli errori e notifica l'utente
        Write-Host "Errore durante il tentativo di rinominare il computer: $_"
    }
} else {
    Write-Host "Nessun nome inserito. Operazione annullata."
}
