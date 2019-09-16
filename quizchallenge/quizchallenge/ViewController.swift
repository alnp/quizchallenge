import UIKit

class ViewController: UIViewController {

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.requestForQuiz()
    }

    func showQuiz(with model: QuizModel) {
        quizView.show(question: model.question)
    }

    func showLoadingAlert(_ title: String = "Loading...", completion: (() -> Void)?) {
        loadingAlertController = AlertHelper.createLoadingAlert(title: title)
        DispatchQueue.main.async {
            self.present(self.loadingAlertController, animated: true, completion: completion)
        }
    }

    func dismissLoadingAlert() {
        loadingAlertController.dismiss(animated: true)
    }

    func showErrorAlert(message: String) {
        alertController = AlertHelper
            .createAlert(title: "Error",
                         message: message,
                         buttonTitle: "Retry") { [weak self] in
            self?.dismissAlert()
            self?.viewModel.requestForQuiz()
        }
        DispatchQueue.main.async {
            self.present(self.alertController, animated: true)
        }
    }

    func dismissAlert() {
        alertController.dismiss(animated: false)
    }
}

