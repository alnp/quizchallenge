import XCTest
@testable import quizchallenge

class AlertHelperTests: XCTestCase {

    func testLoadingAlert() {
        let title = "title"
        let alertController = AlertHelper.createLoadingAlert(title: title)

        XCTAssertEqual(title, alertController.title)
        XCTAssert((alertController as Any) is UIAlertController)
    }
}
