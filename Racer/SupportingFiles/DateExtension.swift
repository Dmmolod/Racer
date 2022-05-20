import Foundation

extension Date {
    func format(with dateFormat: String) -> String {
        let df = DateFormatter()
        df.locale = .current
        df.dateFormat = dateFormat
        return df.string(from: self)
    }
}
