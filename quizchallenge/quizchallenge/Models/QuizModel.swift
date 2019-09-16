import Foundation

struct QuizModel {
    var question: String = ""
    var answer: [String] = []
}

extension QuizModel: Decodable {
    private enum QuizApiResponseCodingKeys: String, CodingKey {
        case question
        case answer
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QuizApiResponseCodingKeys.self)

        question = try container.decode(String.self, forKey: .question)
        answer = try container.decode([String].self, forKey: .answer)
    }
}
