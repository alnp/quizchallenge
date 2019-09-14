import XCTest
@testable import quizchallenge

class QuizModelTests: XCTestCase {

    func testQuizModelDecode() {
        guard let model: QuizModel = loadJSONFixture("QuizModel") else {
            XCTFail()
            return
        }
        XCTAssertEqual("What are all the java keywords?", model.question)
        XCTAssertEqual(["abstract", "assert", "boolean", "break", "byte", "case", "catch", "char", "class", "const", "continue", "default", "do", "double", "else", "enum", "extends", "final", "finally", "float", "for", "goto", "if", "implements", "import", "instanceof", "int", "interface", "long", "native", "new", "package", "private", "protected", "public", "return", "short", "static", "strictfp", "super", "switch", "synchronized", "this", "throw", "throws", "transient", "try", "void", "volatile", "while"], model.answer)
    }
}
