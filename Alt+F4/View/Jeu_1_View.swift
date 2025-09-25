import SwiftUI

struct Jeu_1_View: View {
    @State private var questions: [BlindTestQuestion] = []
    @State private var currentQuestionIndex = 0
    @State private var isLoading = true
    @State private var errorMessage: String? = nil
    @State private var score = 0
    @State private var showScore = false
    @State private var feedbackMessage: String? = nil
    @State private var showFeedback = false
    @State private var shuffledAnswers: [String] = []

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

                        VStack(spacing: 10) {
                            ForEach(shuffledAnswers, id: \ .self) { answer in
                                Button(action: {
                                    handleAnswer(selectedAnswer: answer)
                                }) {
                                    Text(answer)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                                }
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
        APIService.shared.fetchBlindTest { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let questions):
                    self.questions = questions
                    self.isLoading = false
                    if !questions.isEmpty {
                        shuffleAnswers(for: questions[currentQuestionIndex]) // Shuffle answers after fetching questions
                    }
                case .failure(let error):
                    self.errorMessage = "Erreur : \(error.localizedDescription)"
                    self.isLoading = false
                }
            }
        }
    }

    private func handleAnswer(selectedAnswer: String) {
        let question = questions[currentQuestionIndex]
        if selectedAnswer == question.correct_answer {
            score += 1
            showFeedbackMessage("Vrai")
        } else {
            showFeedbackMessage("Faux: la bonne réponse était : \(question.correct_answer)")
        }
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            shuffleAnswers(for: questions[currentQuestionIndex]) // Shuffle answers for the next question
        } else {
            showScore = true
        }
    }

    private func showFeedbackMessage(_ message: String) {
        feedbackMessage = message
        showFeedback = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                showFeedback = false
            }
        }
    }

    private func restartQuiz() {
        currentQuestionIndex = 0
        score = 0
        showScore = false
        fetchQuestions()
    }

    private func shuffleAnswers(for question: BlindTestQuestion) {
        shuffledAnswers = ([question.correct_answer] + question.fake_answers).shuffled()
    }
}

#Preview {
    Jeu_1_View()
}
