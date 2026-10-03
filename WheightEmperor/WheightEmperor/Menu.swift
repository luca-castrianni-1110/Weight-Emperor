import SwiftUI

struct MenuPrincipale: View {
    
    @State var crea: Bool = false
    @State var allenamento: Bool = false
    
    
    var body: some View {
        
        NavigationView{
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 1.0, green: 0.85, blue: 0.4),
                        Color(red: 1.0, green: 0.65, blue: 0.2),
                        Color.black
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                
                
                VStack {
                    ZStack {
                        testo
                    }
                    .shadow(color: .black.opacity(0.6), radius: 4, x: 2, y: 2)
                    
                    
                }
                .padding(.top, -360)
                
                VStack(spacing: 40) {
                    bottoni
                }
            }//Fine Vstack Pulsanti
        }
    }//Fine Var body
    
    
    var testo: some View {
        Text("Menu Principale")
            .font(.largeTitle)
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .shadow(color: Color(red: 139/255, green: 1/255, blue: 20/255), radius: 2)
    }
    
    
    
    var bottoni: some View {
        Group{
            Button(action: {
                crea = true
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                        .shadow(color: .black.opacity(0.5), radius: 2, x: 1, y: 1)
                    Text("Crea Scheda")
                        .fontWeight(.bold)
                        .font(.title3)
                        .shadow(color: .black.opacity(0.5), radius: 2, x: 1, y: 1)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .cornerRadius(14)
                .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)
            }
            NavigationLink(
                destination: CreaScheda(),
                isActive: $crea,){EmptyView()}
            
            Button(action: {
                allenamento = true
            }) {
                HStack(spacing: 12) {
                    Image(systemName: "dumbbell")
                        .font(.title)
                        .shadow(color: .black.opacity(0.5), radius: 2, x: 1, y: 1)
                    
                    Text("Schede Allenamento")
                        .fontWeight(.bold)
                        .font(.title3)
                        .shadow(color: .black.opacity(0.5), radius: 2, x: 1, y: 1)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .cornerRadius(14)
                .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5) 
            }
            NavigationLink(
                destination: SchedeAllenamentoView(),
                isActive: $allenamento,){EmptyView()}
            
        }
    }//Fine Var Bottoni
    
    
    
}//Fine Struct

#Preview {
    MenuPrincipale()
}
