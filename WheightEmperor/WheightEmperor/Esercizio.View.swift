import SwiftUI

struct EsercizioView: View {
    @ObservedObject var esercizio: Esercizio

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Nome dell'esercizio
            Text(esercizio.nome)
                .font(.title2)
                .bold()

            // Campi per serie, ripetizioni, peso
            HStack(spacing: 16) {
                VStack(alignment: .leading) {
                    Text("Serie")
                        .font(.headline)
                    TextField("Serie", text: $esercizio.serie)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 70)
                }

                VStack(alignment: .leading) {
                    Text("Ripetizioni")
                        .font(.headline)
                    TextField("Rip", text: $esercizio.ripetizioni)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 90)
                }

                VStack(alignment: .leading) {
                    Text("Peso")
                        .font(.headline)
                    TextField("Peso", text: $esercizio.peso)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 70)
                }
            }

            // Campo per annotazioni
            TextField("Annotazioni", text: Binding(
                get: { esercizio.commento ?? "" },
                set: { esercizio.commento = $0 }
            ))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.top, 5)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
