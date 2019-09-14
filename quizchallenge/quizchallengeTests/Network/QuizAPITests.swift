import XCTest
@testable import quizchallenge

class QuizAPITests: XCTestCase {
    
    func testDefaultAPIValues() {
        let environmentBaseURL = QuizAPI.quiz(id: 1).environmentBaseURL
        let baseURL = QuizAPI.quiz(id: 1).baseURL
        let path = QuizAPI.quiz(id: 1).path
        let httpMethod = QuizAPI.quiz(id: 1).httpMethod
        let task = QuizAPI.quiz(id: 1).task
        let headers = QuizAPI.quiz(id: 1).headers

        let expectedEnvironmentBaseURL = "https://codechallenge.arctouch.com/"
        let expectedBaseURL: URL? = URL(string: "https://codechallenge.arctouch.com/")
        let expectedPath = "quiz/1"
        let expectedHttpMethod: HTTPMethod = .get
        let expectedTask: HTTPTask = .request
        let expectedHeaders: HTTPHeaders? = nil

        XCTAssertEqual(environmentBaseURL, expectedEnvironmentBaseURL)
        XCTAssertEqual(baseURL, expectedBaseURL)
        XCTAssertEqual(path, expectedPath)
        XCTAssertEqual(httpMethod, expectedHttpMethod)
        XCTAssertEqual(task, expectedTask)
        XCTAssertEqual(headers, expectedHeaders)
    }
}
