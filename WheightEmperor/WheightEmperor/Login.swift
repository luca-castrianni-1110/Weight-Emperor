
import SwiftUI

struct Login: View {
    
    @State  var username: String = ""
    @State  var password: String = ""
    @State  var MostraPassword: Bool = false
    @State  var registrazione: Bool = false
    @State  var login: Bool = false
    @State  var errore: Bool = false
    
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                Image("baki")
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    Testo
                    Spacer()
                }//FineVStackTesto
                VStack {
                    User
                    HStack{
                        Pass
                        MostraPasswordButton
                    }//Fine HStack
                    .padding()
                    LogIn
                }//Fine Vstack
                NavigationLink(
                    destination: MenuPrincipale(),
                    isActive: $login,
                    label:{
                        EmptyView()
                    }
                )
            }//FineZStack
        }//FineNavigation
    }//Fine Body
    
    
    var Testo: some View {
        Text("Weight Emperor")
            .font(.system(size: 35, weight: .bold, design: .rounded))
            .foregroundColor(.black)
            .frame(width: 300, height: 100, alignment: .center)
            .shadow(color: .white.opacity(1), radius: 4, x: -3, y: 3)
            .shadow(color: .black.opacity(0.9), radius: 4, x: 3, y: 3)
    }//FineTesto
    
    
    
    var User: some View {
        TextField("Username", text: $username)
            .autocapitalization(.none)
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .padding()
            .background(Color.white)
            .cornerRadius(20)
    }//Fine User
    
    
    
    
    var Pass: some View {
        Group{
            if MostraPassword {
                TextField("Password", text: $password)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
            }else {
                SecureField("Password", text: $password)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
            }
        }
    }//Fine Pass
    
    
    var MostraPasswordButton: some View {
        Button(action: {
            self.MostraPassword.toggle()
        }) {
            Image(systemName: self.MostraPassword ? "eye.slash" : "eye")
                .foregroundColor(.white)
        }
    }
    
    
    var LogIn: some View {
        Group{
            Button("Login"){
                if username == "Weight" && password == "emperor" {
                    login = true
                    errore = false
                }else{
                    errore = true
                }
            }
            .foregroundColor(.white)
            .padding()
            .frame(width: 100, height: 50, alignment: .center)
            .background(Color.blue)
            .cornerRadius(20)
            
            if errore{
                Text("Credenziali Errate")
                    .foregroundColor(.red)
                    .font(.system(size: 14, weight: .bold, design: .default))
                    .padding()
            }
        }
    }
}
#Preview ("Default"){
    Login()
}

#Preview ("Custom"){
    Login(username: "Weight", password: "emperor")
}
