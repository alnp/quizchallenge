import Foundation

public enum QuizAPI {
    case quiz(id:Int)
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
        case .quiz(let id):
            return "quiz/\(id)"
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
