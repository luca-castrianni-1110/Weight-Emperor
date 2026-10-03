import SwiftUI

struct DettaglioSchedaView: View {
    @ObservedObject var scheda: SchedaAllenamentoModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(scheda.nome)
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)

                ForEach(scheda.giorni) { giorno in
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Giorno: \(giorno.giorno)")
                            .font(.title)
                            .foregroundColor(Color(red: 0.9, green: 0.7, blue: 0.25))
                            .bold()
                            .padding(.vertical)

                        ForEach(giorno.muscoli) { muscolo in
                            VStack(alignment: .leading, spacing: 10) {
                                Text(muscolo.nome)
                                    .font(.title)
                                    .bold()
                                    .frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 10)

                                ForEach(muscolo.esercizi) { esercizio in
                                    EsercizioView(esercizio: esercizio)
                                }
                            }
                        }
                    }
                    .padding(.vertical)
                }

                Button("Salva") {
                    salvaModifiche()
                }
                .font(.title2)
                .shadow(color: .black.opacity(0.5), radius: 2, x: 1, y: 1)
                .padding(.vertical, 12)
                .padding(.horizontal, 32)
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.9, green: 0.7, blue: 0.25))
                .foregroundColor(.white)
                .cornerRadius(14)
                .shadow(color: .black.opacity(0.4), radius: 8, x: 0, y: 4)
                .multilineTextAlignment(.center)
            }
            .padding()
        }
        // SALVATAGGIO AUTOMATICO AL CHIUDERE LA SCHERMATA
        .onDisappear {
            salvaModifiche()
        }
    }

    // MARK: - Salvataggio
    func salvaModifiche() {
        var tutte = caricaTutteLeSchede()
        if let index = tutte.firstIndex(where: { $0.id == scheda.id }) {
            tutte[index] = scheda
        } else {
            tutte.append(scheda)
        }

        if let data = try? JSONEncoder().encode(tutte) {
            UserDefaults.standard.set(data, forKey: "tutteLeSchede")
            print("✅ Scheda salvata correttamente.")
        } else {
            print("❌ Errore nella codifica JSON.")
        }
    }

    func caricaTutteLeSchede() -> [SchedaAllenamentoModel] {
        if let data = UserDefaults.standard.data(forKey: "tutteLeSchede"),
           let decoded = try? JSONDecoder().decode([SchedaAllenamentoModel].self, from: data) {
            return decoded
        }
        return []
    }
}
