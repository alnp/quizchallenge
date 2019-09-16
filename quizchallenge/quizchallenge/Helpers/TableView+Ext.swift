import UIKit

enum ReusableIdentifier: String {
    case label = "LabelCell"
}

extension UITableView {
    func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: ReusableIdentifier) {
        register(cellClass, forCellReuseIdentifier: identifier.rawValue)
    }
}
