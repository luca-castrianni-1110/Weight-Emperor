import SwiftUI

struct CreaScheda: View {
    
    @State private var mostraAlert = false
    @State private var messaggioAlert = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var nomeScheda: String = ""
    @State private var numeroGiorni = 1
    @State private var giorni: [GiornoAllenamento] = []
    
    let giorniSettimana = ["1", "2", "3", "4", "5", "6", "7"]
    let muscoliDisponibili = ["Petto", "Gambe", "Spalle", "Bicipiti", "Tricipiti", "Dorsali", "Addominali"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Costruisci la tua scheda")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom)

                TextField("Nome della scheda", text: $nomeScheda)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Stepper("Quanti giorni ti alleni? \(numeroGiorni)", value: $numeroGiorni, in: 1...7)
                    .onChange(of: numeroGiorni) { _ in aggiornaGiorni() }

                Divider()

                ForEach(giorni.indices, id: \.self) { i in
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Giorno: \(giorni[i].giorno)")
                            .font(.headline)

                        ForEach(giorni[i].muscoli.indices, id: \.self) { j in
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Picker("Muscolo", selection: $giorni[i].muscoli[j].nome) {
                                        ForEach(muscoliDisponibili, id: \.self) { m in
                                            Text(m)
                                        }
                                    }
                                    .pickerStyle(MenuPickerStyle())

                                    Spacer()

                                    Button {
                                        rimuoviMuscolo(giornoIndex: i, muscoloIndex: j)
                                    } label: {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundColor(.red)
                                            .font(.system(size: 20))
                                    }
                                }

                                Stepper("Numero esercizi: \(giorni[i].muscoli[j].numeroEsercizi)", value: $giorni[i].muscoli[j].numeroEsercizi, in: 1...10)
                                    .onChange(of: giorni[i].muscoli[j].numeroEsercizi) { _ in
                                        aggiornaEsercizi(giornoIndex: i, muscoloIndex: j)
                                    }

                                ForEach(giorni[i].muscoli[j].esercizi.indices, id: \.self) { k in
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text("Esercizio \(k + 1)").font(.subheadline).bold()

                                        TextField("Nome esercizio", text: $giorni[i].muscoli[j].esercizi[k].nome)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())

                                        HStack {
                                            TextField("Serie", text: $giorni[i].muscoli[j].esercizi[k].serie)
                                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                                .keyboardType(.numberPad)

                                            TextField("Ripetizioni", text: $giorni[i].muscoli[j].esercizi[k].ripetizioni)
                                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                                .keyboardType(.numberPad)

                                            TextField("Peso", text: $giorni[i].muscoli[j].esercizi[k].peso)
                                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                                .keyboardType(.decimalPad)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                        }

                        Button {
                            aggiungiMuscolo(a: i)
                        } label: {
                            Label("Aggiungi muscolo", systemImage: "plus.circle.fill")
                                .font(.system(size: 18))
                                .foregroundColor(Color(red: 0.9, green: 0.7, blue: 0.25))
                        }
                    }
                    .padding(.vertical)
                }

                Button(action: {
                    if let errore = validaCampi() {
                        messaggioAlert = errore
                        mostraAlert = true
                    } else {
                        salvaSchedaNelDatabase(nomeScheda: nomeScheda)
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Salva scheda")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0.9, green: 0.7, blue: 0.25))
                        .foregroundColor(.white)
                        .cornerRadius(14)
                }
                .alert(isPresented: $mostraAlert) {
                    Alert(title: Text("Attenzione"), message: Text(messaggioAlert), dismissButton: .default(Text("OK")))
                }
            }
            .padding()
        }
        .onAppear {
            aggiornaGiorni()
        }
    }

    // MARK: - Funzioni

    func aggiornaGiorni() {
        if numeroGiorni > giorni.count {
            for i in giorni.count..<numeroGiorni {
                giorni.append(GiornoAllenamento(giorno: giorniSettimana[i]))
            }
        } else {
            giorni = Array(giorni.prefix(numeroGiorni))
        }
    }

    func aggiornaEsercizi(giornoIndex: Int, muscoloIndex: Int) {
        let numero = giorni[giornoIndex].muscoli[muscoloIndex].numeroEsercizi
        var esercizi = giorni[giornoIndex].muscoli[muscoloIndex].esercizi

        if numero > esercizi.count {
            esercizi.append(contentsOf: Array(repeating: Esercizio(), count: numero - esercizi.count))
        } else {
            esercizi = Array(esercizi.prefix(numero))
        }

        giorni[giornoIndex].muscoli[muscoloIndex].esercizi = esercizi
    }

    func aggiungiMuscolo(a giornoIndex: Int) {
        var giorno = giorni[giornoIndex]
        giorno.muscoli.append(MuscoloAllenamento(nome: muscoliDisponibili.first ?? ""))
        giorni[giornoIndex] = giorno
    }

    func rimuoviMuscolo(giornoIndex: Int, muscoloIndex: Int) {
        var giorno = giorni[giornoIndex]
        if giorno.muscoli.indices.contains(muscoloIndex) {
            giorno.muscoli.remove(at: muscoloIndex)
            giorni[giornoIndex] = giorno
        }
    }

    func validaCampi() -> String? {
        if nomeScheda.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Il nome della scheda è obbligatorio."
        }

        let haMuscoli = giorni.contains { !$0.muscoli.isEmpty }
        if !haMuscoli {
            return "La scheda non presenta esercizi."
        }

        for giorno in giorni {
            for muscolo in giorno.muscoli {
                if muscolo.nome.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    return "Inserisci il nome di tutti i muscoli."
                }

                for esercizio in muscolo.esercizi {
                    if esercizio.nome.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        return "Inserisci il nome di tutti gli esercizi."
                    }
                    if esercizio.serie.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        return "Inserisci il numero di serie per tutti gli esercizi."
                    }
                    if esercizio.ripetizioni.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        return "Inserisci il numero di ripetizioni per tutti gli esercizi."
                    }
                    if esercizio.peso.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        return "Inserisci il peso per tutti gli esercizi."
                    }
                }
            }
        }

        return nil
    }

    func salvaSchedaNelDatabase(nomeScheda: String) {
        let nuovaScheda = SchedaAllenamentoModel(nome: nomeScheda, giorni: giorni)
        var tutteLeSchede: [SchedaAllenamentoModel] = []

        if let data = UserDefaults.standard.data(forKey: "tutteLeSchede"),
           let decode = try? JSONDecoder().decode([SchedaAllenamentoModel].self, from: data) {
            tutteLeSchede = decode
        }

        tutteLeSchede.append(nuovaScheda)

        if let data = try? JSONEncoder().encode(tutteLeSchede) {
            UserDefaults.standard.set(data, forKey: "tutteLeSchede")
            NotificationCenter.default.post(name: Notification.Name("SchedaSalvata"), object: nil)
            print("✅ Scheda salvata: \(nomeScheda)")
        } else {
            print("❌ Errore nella codifica della scheda.")
        }
    }
}

#Preview {
    CreaScheda()
}
