import SwiftUI

struct Jeu_1_View: View {
    var body: some View {
        ZStack {
            // Changed background to black for better contrast with navigation bar
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Blind Test Playlist")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                // Ajoutez ici le contenu du jeu 1
            }
        }
    }
}

#Preview {
    Jeu_1_View()
}
