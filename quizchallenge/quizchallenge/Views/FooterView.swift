import UIKit

protocol FooterDelegate: class {
    func wantsToStartOrRestart()
}

class FooterView: UIView {

    var delegate: FooterDelegate?
    private let buttonHeight: CGFloat = 48.0

    private var infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 16.0
        stack.translatesAutoresizingMaskIntoConstraints = false

        return stack
    }()

    private var counterLabel: UILabel = {
        let label = UILabel()
        label.font = .largeTitle
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.text = "00/00"

        return label
    }()

    private var timerLabel: UILabel = {
        let label = UILabel()
        label.font = .largeTitle
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = .black
        label.text = "05:00"

        return label
    }()

    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 16.0
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stack.translatesAutoresizingMaskIntoConstraints = false

        return stack
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = CGFloat(buttonHeight / 4.0)
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.darkOrange, for: .highlighted)
        button.titleLabel?.font = .button
        button.backgroundColor = .arcOrange

        return button
    }()


    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = UIColor.arcGrey
        buildViewHierarchy()
        addConstraints()
        bindLayoutEvents()
    }

    private func buildViewHierarchy() {
        infoStackView.addArrangedSubview(counterLabel)
        infoStackView.addArrangedSubview(timerLabel)
        stackView.addArrangedSubview(infoStackView)
        stackView.addArrangedSubview(button)
        addSubview(stackView)
    }

    private func addConstraints() {
        translatesAutoresizingMaskIntoConstraints = false

        button.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true

        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }

    private func bindLayoutEvents() {
        button.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
    }

    @objc func buttonHandler() {
        let title = button.titleLabel?.text == "Start" ? "Reset" : "Start"
        button.setTitle(title, for: .normal)
        self.delegate?.wantsToStartOrRestart()
    }

    func show(words: String, timer: String) {
        counterLabel.text = words
        timerLabel.text = timer
    }
}
