import SwiftUI

struct Jeu_2_View: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Quiz Vrai/Faux")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                // Ajoutez ici le contenu du jeu 2
            }
        }
    }
}

#Preview {
    Jeu_2_View()
}
