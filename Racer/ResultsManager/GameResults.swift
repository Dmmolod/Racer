import Foundation

struct GameResult: Codable, Equatable {
    private var id = UUID().uuidString
    
    let score: Int
    let startDate: Date
    let endDate: Date
    
    init(score: Int, startDate: Date, endDate: Date) {
        self.score = score
        self.startDate = startDate
        self.endDate = endDate
    }
    
    static func == (lhs: GameResult, rhs: GameResult) -> Bool {
        lhs.id == rhs.id
    }
}
