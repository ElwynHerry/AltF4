import SwiftUI

struct Jeu_3_View: View {
    @State private var currentGame: GuessGameQuestion? = nil
    @State private var userGuess: String = ""
    @State private var feedbackMessage: String? = nil
    @State private var isLoading = true
    @State private var errorMessage: String? = nil
    @State private var suggestions: [String] = []

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.orange, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            if isLoading {
                ProgressView("Chargement...")
                    .foregroundColor(.white)
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else if let currentGame = currentGame {
                VStack(spacing: 20) {
                    Text("Trouve le jeu")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()

                    if let imageUrl = currentGame.hints.image, let url = URL(string: imageUrl) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                        } placeholder: {
                            ProgressView()
                        }
                    }

                    if let released = currentGame.hints.released {
                        Text("Année de sortie : \(released)")
                            .font(.title2)
                            .foregroundColor(.white)
                    }

                    if let genres = currentGame.hints.genres, !genres.isEmpty {
                        Text("Genres : \(genres.joined(separator: ", "))")
                            .font(.title2)
                            .foregroundColor(.white)
                    }

                    TextField("Entrez le nom du jeu", text: $userGuess)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .onChange(of: userGuess) { _ in
                            updateSuggestions()
                        }

                    if !suggestions.isEmpty {
                        VStack(alignment: .leading, spacing: 5) {
                            ForEach(suggestions, id: \.self) { suggestion in
                                Text(suggestion)
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .padding(5)
                                    .background(Color.gray.opacity(0.8))
                                    .cornerRadius(5)
                                    .onTapGesture {
                                        userGuess = suggestion
                                        suggestions = []
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }

                    Button(action: validateGuess) {
                        Text("Valider")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    if let feedbackMessage = feedbackMessage {
                        Text(feedbackMessage)
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray.opacity(0.8))
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            fetchRandomGame()
        }
    }

    private func fetchRandomGame() {
        isLoading = true
        APIService.shared.fetchGuessGame { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let games):
                    if let randomGame = games.randomElement() {
                        self.currentGame = randomGame
                    } else {
                        self.errorMessage = "Aucun jeu disponible."
                    }
                case .failure(let error):
                    self.errorMessage = "Erreur : \(error.localizedDescription)"
                }
                self.isLoading = false
            }
        }
    }

    private func validateGuess() {
        guard let currentGame = currentGame else { return }
        if userGuess.lowercased() == currentGame.correctAnswer.lowercased() {
            feedbackMessage = "Bonne réponse !"
        } else {
            feedbackMessage = "Mauvaise réponse. Le jeu était : \(currentGame.correctAnswer)"
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            feedbackMessage = nil
            userGuess = ""
            fetchRandomGame()
        }
    }

    private func updateSuggestions() {
        guard let currentGame = currentGame else { return }
        let possibleAnswers = [currentGame.correctAnswer] // Add more possible answers if available
        suggestions = possibleAnswers.filter { $0.lowercased().contains(userGuess.lowercased()) }
    }
}

#Preview {
    Jeu_3_View()
}
