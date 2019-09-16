import UIKit

public class TableViewDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {

    var items: [String]
    private let reuseIdentifier: ReusableIdentifier

    init(items: [String],
                reuseIdentifier: ReusableIdentifier) {
        self.items = items
        self.reuseIdentifier = reuseIdentifier
    }

    public func update(with items: [String]) {
        self.items = items
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier.rawValue,
            for: indexPath
        )

        cell.textLabel?.text = item
        return cell
    }
}
