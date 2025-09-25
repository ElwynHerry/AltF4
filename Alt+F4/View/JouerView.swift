import SwiftUI

struct JouerView: View {
    var body: some View {
        ZStack {
            // Updated background gradient for better contrast with navigation bar
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Spacer()

                Image("images.png")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)

                Text("Choisissez un mode de jeu")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                Spacer()

                Button(action: {
                    // Action for Blind Test Playlist
                }) {
                    Text("Blind Test Playlist")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.8))
                        .foregroundColor(.purple)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                }
                .padding(.horizontal, 20)

                Button(action: {
                    // Action for Quiz Vrai/Faux
                }) {
                    Text("Quiz Vrai/Faux")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.8))
                        .foregroundColor(.purple)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                }
                .padding(.horizontal, 20)

                Button(action: {
                    // Action for Trouve le jeu
                }) {
                    Text("Trouve le jeu")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.8))
                        .foregroundColor(.purple)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                }
                .padding(.horizontal, 20)

                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(false)
        .toolbarColorScheme(.dark, for: .navigationBar) // Ensures the back button and text are white
        .toolbarBackground(Color.clear, for: .navigationBar) // Keeps the background transparent
    }
}
