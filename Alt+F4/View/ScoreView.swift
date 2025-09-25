import SwiftUI

struct ScoreView: View {
    let score: Int
    let totalQuestions: Int
    let onReplay: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Votre score : \(score) / \(totalQuestions)")
                .font(.largeTitle)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()

            Button("Rejouer") {
                onReplay()
            }
            .font(.headline)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    ScoreView(score: 7, totalQuestions: 10, onReplay: {})
}