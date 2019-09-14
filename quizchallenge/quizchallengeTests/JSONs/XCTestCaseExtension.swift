import XCTest
@testable import quizchallenge

extension XCTestCase {

    func loadJSONFixture<T: Decodable>(_ fileName: String) -> T? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            XCTFail("Missing file: \(fileName).json")
            return nil
        }
        do {
            let jsonData = try Data(contentsOf: url)
            let model = try JSONDecoder().decode(T.self, from: jsonData)
            return model
        } catch {
            XCTFail("Could not decode json")
            return nil
        }
    }
}
