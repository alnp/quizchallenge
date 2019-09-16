import UIKit

class QuizView: UIView {

    var delegate: UITextFieldDelegate?
    var dataSource: TableViewDataSource?
    var footerBottomConstraint: NSLayoutConstraint?

    private var containerView = UIView()

    private var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.largeTitle
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    var textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = CGFloat(12)
        textField.enablesReturnKeyAutomatically = false
        textField.returnKeyType = .done
        textField.backgroundColor = .arcGrey
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textField.leftViewMode = .always
        textField.placeholder = LocalizedStrings.insertWord
        textField.isEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
        }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReusableIdentifier.label)
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        tableView.tableFooterView = UIView()
        return tableView
    }()

    let footerView = FooterView()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        registerNotifications()
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        containerView.isHidden = true
        backgroundColor = .white
        buildViewHierarchy()
        addConstraints()
        bindLayoutEvents()
    }

    private func buildViewHierarchy() {
        containerView.addSubview(title)
        containerView.addSubview(textField)
        containerView.addSubview(tableView)
        addSubview(containerView)
        addSubview(footerView)
    }

    private func addConstraints() {
        translatesAutoresizingMaskIntoConstraints = false

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: footerView.bottomAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true

        title.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        title.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        title.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 44).isActive = true

        textField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        textField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        textField.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 48).isActive = true

        tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16).isActive = true
        tableView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true

        footerView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        footerView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        footerBottomConstraint = footerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        footerBottomConstraint?.isActive = true
    }

    private func bindLayoutEvents() {
        textField.delegate = delegate
        tableView.dataSource = dataSource
    }

    private func updateCounter(_ number: Int) {
        self.footerView.counter = number
    }

    func show(question: String, words: Int, seconds: Int ) {
        DispatchQueue.main.async {
            self.containerView.isHidden = question.isEmpty
            self.title.text = question
            self.footerView.show(words: words, timer: seconds)
        }
    }

    func reloadTableView(with items: [String]){
        if let datasource = dataSource {
            datasource.update(with: items)
        } else {
            let dataSource = TableViewDataSource(items: items, reuseIdentifier: ReusableIdentifier.label)
            self.dataSource = dataSource
        }

        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.reloadData()
        updateCounter(items.count)
    }
}

extension QuizView {
    func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[
            UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        if textField.isFirstResponder {
            footerBottomConstraint?.isActive = false
            footerBottomConstraint = footerView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                                        constant: -keyboardSize.height)
            footerBottomConstraint?.isActive = true
        }
    }

    @objc func keyboardWillHide() {
        footerBottomConstraint?.isActive = false
        footerBottomConstraint = footerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        footerBottomConstraint?.isActive = true
    }
}
