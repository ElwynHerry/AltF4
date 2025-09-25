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

            // Log the raw API response for debugging
            if let rawResponse = String(data: data, encoding: .utf8) {
                print("Raw API Response: \(rawResponse)")
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // Handle snake_case keys
                let response = try decoder.decode(TrueFalseResponse.self, from: data)
                completion(.success(response.questions))
            } catch let decodingError as DecodingError {
                switch decodingError {
                case .typeMismatch(let type, let context):
                    print("Type mismatch for type \(type): \(context.debugDescription)")
                case .valueNotFound(let value, let context):
                    print("Value not found for value \(value): \(context.debugDescription)")
                case .keyNotFound(let key, let context):
                    print("Key not found: \(key.stringValue) - \(context.debugDescription)")
                case .dataCorrupted(let context):
                    print("Data corrupted: \(context.debugDescription)")
                @unknown default:
                    print("Unknown decoding error: \(decodingError)")
                }
                completion(.failure(decodingError))
            } catch {
                print("Unexpected error: \(error.localizedDescription)")
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
    let game_name: String? // Made optional to handle missing keys
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

struct TrueFalseResponse: Codable {
    let questions: [TrueFalseQuestion]
}
