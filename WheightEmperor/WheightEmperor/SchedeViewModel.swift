import Foundation
import Combine

class SchedeViewModel: ObservableObject {
    @Published var schede: [SchedaAllenamentoModel] = []

    init() {
        caricaSchede()
    }

    func caricaSchede() {
        guard let data = UserDefaults.standard.data(forKey: "tutteLeSchede") else {
            print("⚠️ Nessun dato trovato in UserDefaults")
            schede = []
            return
        }
        do {
            schede = try JSONDecoder().decode([SchedaAllenamentoModel].self, from: data)
            print("✅ Schede caricate: \(schede.count)")
        } catch {
            print("❌ Errore nel decoding: \(error.localizedDescription)")
            schede = []
        }
    }

    func salvaSchede() {
        do {
            let data = try JSONEncoder().encode(schede)
            UserDefaults.standard.set(data, forKey: "tutteLeSchede")
            print("✅ Schede salvate")
        } catch {
            print("❌ Errore nel salvataggio: \(error.localizedDescription)")
        }
    }


    func eliminaScheda(at offsets: IndexSet) {
        schede.remove(atOffsets: offsets)
        salvaSchede()
    }
}
