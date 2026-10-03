# Weight-Emperor

# Weight Emperor (iOS Workout Manager)

**Weight Emperor** è un'applicazione iOS sviluppata nativamente in **SwiftUI** per la gestione personalizzata di schede di allenamento per la palestra. L'app consente di creare programmi di workout su misura, organizzare i giorni di esercizio, gestire i gruppi muscolari e tracciare serie, ripetizioni e carichi.

## Funzionalità Principali
* **Autenticazione Semplificata:** Accesso tramite schermata di login dedicata.
* **Creazione Dinamica delle Schede (`CreaScheda`):** Possibilità di configurare il numero di giorni di allenamento, aggiungere gruppi muscolari (Petto, Gambe, Dorso, Spalle, ecc.) e inserire esercizi dettagliati.
* **Tracciamento Avanzato:** Gestione puntuale per ciascun esercizio di **Serie**, **Ripetizioni**, **Peso** e annotazioni/commenti personali.
* **Persistenza dei Dati:** Salvataggio automatico e locale delle schede tramite `UserDefaults` e codifica `JSON`.
* **Visualizzazione e Modifica:** Esplorazione delle schede salvate (`SchedeAllenamentoView`) con aggiornamento e salvataggio in tempo reale delle modifiche.

## Tecnologie e Framework Utilizzati
* **Linguaggio:** Swift
* **UI Framework:** SwiftUI
* **Architettura & Pattern:** ObservableObject, State/Environment Management, MVVM-light
* **Persistenza:** Foundation (`UserDefaults`, `JSONEncoder`, `JSONDecoder`)

---

## Istruzioni d'Uso e Installazione

1. **Requisiti:** 
   * Xcode (versione recente)
   * Dispositivo iOS o simulatore con supporto a SwiftUI.
2. **Configurazione:**
   * Clonare o scaricare la repository sul proprio Mac.
   * Aprire il file di progetto principale (`.xcodeproj` o `.swiftpm`) all'interno di Xcode.
   * Compilare ed eseguire l'applicazione sul simulatore o su un dispositivo fisico tramite `WheightEmperorApp.swift`.
