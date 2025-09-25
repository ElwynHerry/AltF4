import Foundation

class APIService {
    static let shared = APIService()
    private let baseURL = "http://localhost:8080" // Mise à jour de l'URL pour pointer vers localhost

    // Blind Test Playlist
    func fetchBlindTest(completion: @escaping (Result<[BlindTestQuestion], Error>) -> Void) {
        let url = URL(string: "\(baseURL)/blindtest/playlist")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }
            do {
                let response = try JSONDecoder().decode(BlindTestResponse.self, from: data)
                completion(.success(response.questions))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // Quiz Vrai/Faux
    func fetchTrueFalseQuiz(completion: @escaping (Result<[TrueFalseQuestion], Error>) -> Void) {
        let url = URL(string: "\(baseURL)/quiz/truefalse")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }
            do {
                let questions = try JSONDecoder().decode([TrueFalseQuestion].self, from: data)
                completion(.success(questions))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // Quiz Indices
    func fetchGuessGame(completion: @escaping (Result<[GuessGameQuestion], Error>) -> Void) {
        let url = URL(string: "\(baseURL)/quiz/guessgame")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }
            do {
                let questions = try JSONDecoder().decode([GuessGameQuestion].self, from: data)
                completion(.success(questions))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

// Modèles de données à adapter selon la structure JSON reçue
struct BlindTestQuestion: Codable {
    let image: String
    let correct_answer: String
    let fake_answers: [String]
}

struct TrueFalseQuestion: Codable {
    let image: String
    let question: String
    let answer: Bool
    let game_name: String
}

struct GuessGameQuestion: Codable {
    let hints: GuessGameHints
    let answer: String
}

struct GuessGameHints: Codable {
    let image: String?
    let released: String?
    let genres: [String]?
}

// Add a new struct to handle the top-level JSON object
struct BlindTestResponse: Codable {
    let questions: [BlindTestQuestion]
}
