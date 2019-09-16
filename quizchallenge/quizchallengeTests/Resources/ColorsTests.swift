import XCTest
@testable import quizchallenge

class ColorsTests: XCTestCase {

    func testGreyColor() {
        let expectedColor = UIColor(red: 245.0 / 255.0,
                                    green: 245.0 / 255.0,
                                    blue: 245.0 / 255.0,
                                    alpha: 1.0)
        XCTAssertEqual(expectedColor, UIColor.arcGrey)
    }

    func testOrangeColor() {
        let expectedColor = UIColor(red: 255.0 / 255.0,
                                    green: 131.0 / 255.0,
                                    blue: 0.0 / 255.0,
                                    alpha: 1.0)
        XCTAssertEqual(expectedColor, UIColor.arcOrange)
    }

    func testDarkOrangeColor() {
        let expectedColor = UIColor(red: 200.0 / 255.0,
                                    green: 100.0 / 255.0,
                                    blue: 0.0 / 255.0,
                                    alpha: 1.0)
        XCTAssertEqual(expectedColor, UIColor.darkOrange)
    }
}
