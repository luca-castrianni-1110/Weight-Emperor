import SwiftUI

struct SchedeAllenamentoView: View {
    @StateObject private var viewModel = SchedeViewModel()
    @State private var nuovoNome: String = ""

    var body: some View {
        NavigationView {
            VStack {

                if viewModel.schede.isEmpty {
                    Spacer()
                    VStack(spacing: 16) {
                        Image(systemName: "doc.plaintext")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray.opacity(0.5))
                        Text("Nessuna scheda disponibile")
                            .font(.title3)
                            .foregroundColor(.gray)
                        Text("Crea o importa una nuova scheda per iniziare")
                            .font(.subheadline)
                            .foregroundColor(.gray.opacity(0.7))
                    }
                    Spacer()
                } else {
                    List {
                        ForEach(viewModel.schede) { scheda in
                            NavigationLink(destination: DettaglioSchedaView(scheda: scheda)) {
                                VStack(alignment: .leading) {
                                    Text(scheda.nome)
                                        .font(.headline)
                                    Text("\(scheda.giorni.count) giorni")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                .padding(.vertical, 8)
                            }
                        }
                        .onDelete(perform: viewModel.eliminaScheda)
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .navigationTitle("Le tue schede")
            .toolbar {
                EditButton()
            }
        }
        .onAppear {
            viewModel.caricaSchede()
        }
    }
}


#Preview{
    SchedeAllenamentoView()
}
