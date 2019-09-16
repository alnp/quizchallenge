import XCTest
@testable import quizchallenge

class QuizAPITests: XCTestCase {
    
    func testDefaultAPIValues() {
        let environmentBaseURL = QuizAPI.quiz.environmentBaseURL
        let baseURL = QuizAPI.quiz.baseURL
        let path = QuizAPI.quiz.path
        let httpMethod = QuizAPI.quiz.httpMethod
        let task = QuizAPI.quiz.task
        let headers = QuizAPI.quiz.headers

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
