import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                // 1. Logo
                Image("images")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.top, 0)
                
                // 2. Nom de l'application
                Text("ALT+F4")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.bottom, 30)
                
                // 3. Boutons (NavigationLink au lieu de Button)
                VStack(spacing: 20) {
                    NavigationLink(destination: JouerView()) {
                        Text("Jouer")
                            .font(.title)
                            .fontWeight(.medium)
                            .frame(width: 250, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                    
                    NavigationLink(destination: OptionsView()) {
                        Text("Options")
                            .font(.title)
                            .fontWeight(.medium)
                            .frame(width: 250, height: 50)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                    
                    NavigationLink(destination: CreditsView()) {
                        Text("Crédits")
                            .font(.title)
                            .fontWeight(.medium)
                            .frame(width: 250, height: 50)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                }
                .padding(.bottom, 100)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
    }
}

#Preview {
    ContentView()
}
