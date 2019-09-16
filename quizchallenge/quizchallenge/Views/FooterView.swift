import UIKit

protocol TimerDelegate: class {
    func wantsToStart()
    func wantsToRestart()
    func timerIsOver()
}

class FooterView: UIView {

    public var counter: Int = 0 {
        didSet {
            let counterText = "\(counter)".numberFormatted()
            let totalText = "\(total)".numberFormatted()
            counterLabel.text = counterText + "/" + totalText
        }
    }

    public var total: Int = 0 {
        didSet {
            let totalText = "\(total)".numberFormatted()
            counterLabel.text = "00/\(totalText)"
        }
    }

    public var timerSeconds: Int = 5 {
        didSet{
            timerLabel.text = "\(totalSeconds)".timeFormatted()
        }
    }

    public var totalSeconds: Int = 0 {
        didSet{
            timerLabel.text = "\(totalSeconds)".timeFormatted()
        }
    }

    var delegate: TimerDelegate?
    private var timer = Timer()
    private var isTimerRunning: Bool = false
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
        label.text = "0".numberFormatted()

        return label
    }()

    private var timerLabel: UILabel = {
        let label = UILabel()
        label.font = .largeTitle
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = .black
        label.text = "300".timeFormatted()

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
        button.setTitle(LocalizedStrings.start, for: .normal)
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

    @objc private func buttonHandler() {
        !isTimerRunning ? startTimer() : restartTimer()
    }

    private func startTimer() {
        self.delegate?.wantsToStart()
        button.setTitle(LocalizedStrings.reset, for: .normal)
        totalSeconds = timerSeconds
        self.timer = Timer.scheduledTimer(timeInterval: 1,
                                          target: self,
                                          selector: #selector(updateTime),
                                          userInfo: nil,
                                          repeats: true)
        isTimerRunning = true
    }

    private func restartTimer() {
        self.delegate?.wantsToRestart()
        button.setTitle(LocalizedStrings.start, for: .normal)
        timer.invalidate()
        isTimerRunning = false
        totalSeconds = timerSeconds
    }

    @objc private func updateTime() {
        guard totalSeconds > 0 else {
            timer.invalidate()
            delegate?.timerIsOver()
            return
        }
        totalSeconds -= 1
    }

    func stopTimer() {
        timer.invalidate()
    }

    func show(words: Int, timer: Int) {
        total = words
        timerSeconds = timer
        restartTimer()
    }
}
