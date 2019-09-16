extension String {
    func timeFormatted() -> String {
        guard let totalSeconds = Int(self) else { return "" }
        let minutes: Int = totalSeconds / 60
        let seconds: Int = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func numberFormatted() -> String {
        guard let number = Int(self) else { return "" }
        return String(format: "%02d", number)
    }
}
