import UIKit

class MainViewController: UIViewController {

    private var viewModel: QuizViewModelType
    private var quizView = QuizView()
    private var loadingAlertController: UIAlertController = AlertHelper.createLoadingAlert(title: "")
    private var alertController: UIAlertController = AlertHelper.createAlert(title: "",
                                                                             message: nil,
                                                                             buttonTitle: "",
                                                                             handler: { })

    init(viewModel: QuizViewModelType = QuizViewModel(),
         quizView: QuizView = QuizView()) {
        self.viewModel = viewModel
        self.quizView = quizView
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = quizView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        quizView.textField.delegate = self
        quizView.footerView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.requestForQuiz()
    }

    func showQuiz(with model: QuizModel, secondsToDisplay: Int) {
        quizView.show(question: model.question, words: model.answer.count, seconds: secondsToDisplay)
    }

    func updateTableView(with items: [String]) {
        quizView.reloadTableView(with: items)

    }
}

extension MainViewController {
    func showLoadingAlert(_ title: String = LocalizedStrings.loading, completion: (() -> Void)?) {
        loadingAlertController = AlertHelper.createLoadingAlert(title: title)
        DispatchQueue.main.async {
            self.present(self.loadingAlertController, animated: true, completion: completion)
        }
    }

    func dismissLoadingAlert() {
        DispatchQueue.main.async {
            self.loadingAlertController.dismiss(animated: true)
        }
    }

    func showAlert(title:String, message: String, buttonTitle: String) {
        alertController = AlertHelper.createAlert(title: title,
                                                  message: message,
                                                  buttonTitle: buttonTitle) { [weak self] in
                                                    guard let self = self else { return }
                                                    self.viewModel.requestForQuiz()
        }
        DispatchQueue.main.async {
            self.present(self.alertController, animated: true)
        }
    }

    func dismissAlert() {
        alertController.dismiss(animated: true)
    }

    func finishGame(timeout: Bool, wordsFound: Int = 0, words: Int = 0) {
        quizView.footerView.stopTimer()
        let title = timeout ? LocalizedStrings.timeFinished : LocalizedStrings.congratulations
        let congratulationsMsg = LocalizedStrings.goodJob
        let timeMsg = String(format: LocalizedStrings.timeUp, wordsFound, words)
        let message = timeout ? timeMsg : congratulationsMsg
        let buttonTitle = timeout ? LocalizedStrings.tryAgain : LocalizedStrings.playAgain

        alertController = AlertHelper.createAlert(title: title,
                                                  message: message,
                                                  buttonTitle: buttonTitle) { [weak self] in
                                                    guard let self = self else { return }
                                                    self.viewModel.restartQuiz()
        }
        DispatchQueue.main.async {
            self.present(self.alertController, animated: true)
        }
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            if viewModel.checkAnswerFor(word: updatedText) {
                textField.text = ""
                return false
            }
        }
        return true
    }
}

extension MainViewController: TimerDelegate {
    func wantsToStart() {
        quizView.textField.isEnabled = true
        quizView.textField.becomeFirstResponder()
    }

    func wantsToRestart() {
        quizView.textField.isEnabled = false
    }
    
    func timerIsOver() {
        quizView.textField.isEnabled = false
        finishGame(timeout: true, wordsFound: viewModel.wordsFound ?? 0, words: viewModel.words ?? 0)
    }

}
