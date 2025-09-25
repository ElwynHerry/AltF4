import SwiftUI

struct Jeu_2_View: View {
    @State private var questions: [TrueFalseQuestion] = []
    @State private var currentQuestionIndex = 0
    @State private var isLoading = true
    @State private var errorMessage: String? = nil
    @State private var score = 0
    @State private var showScore = false
    @State private var feedbackMessage: String? = nil
    @State private var showFeedback = false

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            if isLoading {
                ProgressView("Chargement...")
                    .foregroundColor(.white)
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                if showScore {
                    ScoreView(score: score, totalQuestions: questions.count, onReplay: restartQuiz)
                } else if currentQuestionIndex < questions.count {
                    let question = questions[currentQuestionIndex]

                    VStack(spacing: 20) {
                        if let feedbackMessage = feedbackMessage, showFeedback {
                            Text(feedbackMessage)
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.gray.opacity(0.8))
                                .cornerRadius(10)
                                .transition(.opacity)
                        }

                        Text("Question \(currentQuestionIndex + 1) / \(questions.count)")
                            .font(.headline)
                            .foregroundColor(.white)

                        AsyncImage(url: URL(string: question.image)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                        } placeholder: {
                            ProgressView()
                        }

                        Text(question.question)
                            .font(.title2)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()

                        HStack(spacing: 20) {
                            Button(action: {
                                handleAnswer(isTrue: true)
                            }) {
                                Text("Vrai")
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }

                            Button(action: {
                                handleAnswer(isTrue: false)
                            }) {
                                Text("Faux")
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            fetchQuestions()
        }
    }

    private func fetchQuestions() {
        APIService.shared.fetchTrueFalseQuiz { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let questions):
                    self.questions = questions
                    self.isLoading = false
                case .failure(let error):
                    self.errorMessage = "Erreur : \(error.localizedDescription)"
                    self.isLoading = false
                }
            }
        }
    }

    private func handleAnswer(isTrue: Bool) {
        let question = questions[currentQuestionIndex]
        if isTrue == question.answer {
            score += 1
            feedbackMessage = "Bonne réponse !"
        } else {
            feedbackMessage = "Mauvaise réponse."
        }
        showFeedback = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            showFeedback = false
            if currentQuestionIndex < questions.count - 1 {
                currentQuestionIndex += 1
            } else {
                showScore = true
            }
        }
    }

    private func restartQuiz() {
        currentQuestionIndex = 0
        score = 0
        showScore = false
        feedbackMessage = nil
        showFeedback = false
        fetchQuestions()
    }
}

#Preview {
    Jeu_2_View()
}
