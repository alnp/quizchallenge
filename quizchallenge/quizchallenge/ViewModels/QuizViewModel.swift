import Foundation

protocol QuizViewModelType {
    var wordsFound: Int? { get }
    var words: Int? { get }

    func requestForQuiz()
    func restartQuiz()
    func checkAnswerFor(word: String) -> Bool
}

final class QuizViewModel: QuizViewModelType {

    var wordsFound: Int?
    var words: Int?
    let secondsToDisplay: Int = 300

    weak var controller: MainViewController?
    private var networkManager: NetworkManagerType
    internal var model: QuizModel {
        didSet {
            words = model.answer.count
            self.controller?.showQuiz(with: model, secondsToDisplay: secondsToDisplay)
        }
    }
    private var userAnswers = [String]() {
        didSet {
            wordsFound = userAnswers.count
            self.controller?.updateTableView(with: userAnswers)
            if userAnswers.count == model.answer.count, !userAnswers.isEmpty {
                self.controller?.finishGame(timeout: false)
            }
        }
    }

    init(networkManager: NetworkManagerType = NetworkManager(),
         model: QuizModel = QuizModel()) {
        self.networkManager = networkManager
        self.model = model
    }

    func restartQuiz(){
        userAnswers = []
        controller?.showQuiz(with: model, secondsToDisplay: secondsToDisplay)
    }

    func requestForQuiz() {
        userAnswers = []
        self.controller?.showLoadingAlert(completion: {
            self.networkManager.getQuiz() { result in
                let alertTitle = LocalizedStrings.error
                let buttonAlertTitle = LocalizedStrings.tryAgain
                self.controller?.dismissLoadingAlert()
                switch result {
                case .success(let response):
                    self.model = response
                case .failure(let error as NetworkError):
                    self.controller?.showAlert(title: alertTitle,
                                               message: error.rawValue,
                                               buttonTitle: buttonAlertTitle)
                case .failure(let error):
                    self.controller?.showAlert(title: alertTitle,
                                               message: error.localizedDescription,
                                               buttonTitle: buttonAlertTitle)
                }
            }
        })
    }

    func checkAnswerFor(word: String) -> Bool {
        let filtredString = model.answer.filter {
            if $0.lowercased() == word.lowercased(), !userAnswers.contains($0) {
                userAnswers.append($0)
                return true
            }
            return false
        }
        return !filtredString.isEmpty
    }
}
