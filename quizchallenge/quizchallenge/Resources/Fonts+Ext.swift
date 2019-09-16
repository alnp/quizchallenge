import UIKit

extension UIFont {
    static func customFontWithDefault(familyName: String, size: CGFloat) -> UIFont {
        if let font = UIFont(name: familyName, size: size) {
            return font
        }
        return UIFont.systemFont(ofSize: size)
    }
}

extension UIFont {
    static var largeTitle: UIFont {
        return customFontWithDefault(familyName: FontFamily.SFProDisplay.bold, size: 34)
    }

    static var body: UIFont {
        return customFontWithDefault(familyName: FontFamily.SFProDisplay.regular, size: 17)
    }

    static var button: UIFont {
        return customFontWithDefault(familyName: FontFamily.SFProDisplay.semiBold, size: 17)
    }
}
