import Foundation

class GameInfo: Settings {
    
    var fps: Double {
        switch userChoicegameDifficulty {
        case .easy: return 80
        case .average: return 120
        case .hard: return 180
        }
    }
    var score: Double = 0
    var startRaceDate = Date()
    var endRaceDate: Date?
}
