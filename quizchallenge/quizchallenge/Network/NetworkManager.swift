import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

struct NetworkManager {
    private let router = Router<QuizAPI>()

    func getQuiz(number: Int = 1, completion: @escaping (_ result: Result<QuizModel>) -> ()) {
        router.request(.quiz(id: number), completion: { data, response, error in
            if error != nil {
                completion(.failure(NetworkErrorRequest.noConnection))
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(.failure(NetworkErrorResponse.noData))
                        return
                    }
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print("REMOVER: " + "\(jsonData)")
                        let apiResponse = try JSONDecoder().decode(QuizModel.self, from: responseData)
                        completion(.success(apiResponse))
                    }catch {
                        print("REMOVER: " + "\(error)")
                        completion(.failure(NetworkErrorResponse.unableToDecode))
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
        case 501...599: return .failure(NetworkErrorResponse.badRequest)
        default: return .failure(NetworkErrorResponse.failed)
        }
    }
}
