import Foundation

extension String {
    func convertDateFormat(from inputFormat: String = "yyyy-MM-dd'T'HH:mm:ss",
                           to outputFormat: String = "dd.MM.yyyy HH:mm") -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        let ruTimeIndentToGMT: Int = 10800
        inputFormatter.timeZone = TimeZone(secondsFromGMT: ruTimeIndentToGMT)

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        outputFormatter.timeZone = TimeZone.current

        // Преобразуем строку в дату
        guard let date = inputFormatter.date(from: self) else {
            return nil
        }

        // Преобразуем дату в строку нужного формата
        return outputFormatter.string(from: date)
    }
}
