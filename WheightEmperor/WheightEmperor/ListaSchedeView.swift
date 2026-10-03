import SwiftUI

struct ListaSchedeView: View {
    @StateObject private var viewModel = SchedeViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.schede) { scheda in
                    VStack(alignment: .leading) {
                        Text(scheda.nome)
                            .font(.headline)
                        Text("Giorni: \(scheda.giorni.count)")
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Le tue schede")
            .onAppear {
                print("👀 ListaSchedeView apparso. Schede attuali: \(viewModel.schede.count)")
            }
        }
    }
}
