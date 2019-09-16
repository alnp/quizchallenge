import Foundation

public enum QuizAPI {
    case quiz
}

extension QuizAPI: EndpointType {

    var environmentBaseURL : String {
        return "https://codechallenge.arctouch.com/"
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }

    var path: String {
        switch self {
        case .quiz:
            return "quiz/1"
        }
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        return .request
    }

    var headers: HTTPHeaders? {
        return nil
    }
}
