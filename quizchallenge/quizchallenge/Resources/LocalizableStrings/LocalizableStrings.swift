import Foundation

public struct LocalizedStrings {

    private static let tableName = "Localizable"
    private static let bundleIdentifier = "com.alnp.quizchallenge"

    public static let error = localized(forKey: "error")
    public static let tryAgain = localized(forKey: "tryAgain")
    public static let timeFinished = localized(forKey: "timeFinished")
    public static let congratulations = localized(forKey: "congratulations")
    public static let goodJob = localized(forKey: "goodJob")
    public static let timeUp = localized(forKey: "timeUp")
    public static let playAgain = localized(forKey: "playAgain")
    public static let insertWord = localized(forKey: "insertWord")
    public static let start = localized(forKey: "start")
    public static let reset = localized(forKey: "reset")
    public static let loading = localized(forKey: "loading")

}

private extension LocalizedStrings {
    static func localized(forKey key: String) -> String {
        let bundle = Bundle(identifier: bundleIdentifier)
        return NSLocalizedString(key, tableName: tableName, bundle: bundle!, value: "", comment: "")
    }
}
