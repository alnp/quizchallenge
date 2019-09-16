import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

protocol NetworkManagerType {
    func getQuiz(completion: @escaping (_ result: Result<QuizModel>) -> ())
}

class NetworkManager: NetworkManagerType {
    private let router = Router<QuizAPI>()

    func getQuiz(completion: @escaping (_ result: Result<QuizModel>) -> ()) {
        router.request(.quiz, completion: { data, response, error in
            if error != nil {
                completion(.failure(NetworkError.noConnection))
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(.failure(NetworkError.noData))
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(QuizModel.self, from: responseData)
                        completion(.success(apiResponse))
                    }catch {
                        completion(.failure(NetworkError.unableToDecode))
                    }
                case .failure(let networkFailureError):
                    completion(.failure(networkFailureError))
                }
            }
        }
    )}
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<URLResponse> {
        switch response.statusCode {
        case 200...299: return .success(response)
        case 501...599: return .failure(NetworkError.badRequest)
        default: return .failure(NetworkError.failed)
        }
    }
}
