import SwiftUI

struct Jeu_3_View: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.orange, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Trouve le jeu")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                // Ajoutez ici le contenu du jeu 3
            }
        }
    }
}

#Preview {
    Jeu_3_View()
}
