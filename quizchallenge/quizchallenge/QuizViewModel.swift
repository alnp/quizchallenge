import Foundation

protocol QuizViewModelType {
    func requestForQuiz()
}

final class QuizViewModel: QuizViewModelType {

    weak var controller: ViewController?
    private var networkManager: NetworkManagerType
    internal var model: QuizModel {
        didSet {
            self.controller?.showQuiz(with: model)
        }
    }

    init(networkManager: NetworkManagerType = NetworkManager(),
         model: QuizModel = QuizModel()) {
        self.networkManager = networkManager
        self.model = model
    }

    func requestForQuiz() {
        self.controller?.showLoadingAlert(completion: {
            self.networkManager.getQuiz() { result in
                self.controller?.dismissLoadingAlert()
                switch result {
                case .success(let response):
                    self.model = response
                case .failure(let error as NetworkErrorRequest):
                    self.controller?.showErrorAlert(message: error.rawValue)
                case .failure(let error as NetworkErrorResponse):
                    self.controller?.showErrorAlert(message: error.rawValue)
                case .failure(let error):
                    self.controller?.showErrorAlert(message: error.localizedDescription)
                }
            }
        })
    }
}
