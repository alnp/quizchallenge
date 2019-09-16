import UIKit

class AlertHelper {
    static func createLoadingAlert(title: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.view.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        let activityIndicator = UIActivityIndicatorView(frame: alertController.view.bounds)
        activityIndicator.style = .whiteLarge
        activityIndicator.color = .black
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        alertController.view.addSubview(activityIndicator)

        activityIndicator.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: alertController.view.centerYAnchor,
                                                   constant: 20).isActive = true

        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()

        return alertController
    }

    static func createAlert(title: String, message: String?,
                            buttonTitle: String,
                            handler: @escaping () -> Void ) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: buttonTitle, style: .default) { UIAlertAction in
            handler()
        }
        alertController.addAction(alertAction)
        return alertController
    }
}
