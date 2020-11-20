import Foundation

class DateNow{
    func getDate() -> String{
        let date = Date.init(timeIntervalSinceNow: 86400)

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"

        let dateString = dateFormatter.string(from: date)

        _ = dateFormatter.date(from: dateString)

        return dateString
    }
}
