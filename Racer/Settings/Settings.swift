import Foundation
import UIKit

class Settings {
    
    var userChoiceRoadStyle: GameRoads {
        guard let userChoice: GameRoads = UserDefaults.standard.value(GameRoads.self, forKey: GameRoads.key) else { return .road }
        return userChoice
    }
    
    var userChoiceCarStyle: GameCars {
        guard let userChoice: GameCars = UserDefaults.standard.value(GameCars.self, forKey: GameCars.key) else { return .car }
        return userChoice
    }
    
    var userChoicegameDifficulty: GameDifficulty {
        guard let userChoice: GameDifficulty = UserDefaults.standard.value(GameDifficulty.self, forKey: GameDifficulty.key) else { return .easy }
        return userChoice
    }
    
    func setDifficult(_ difficult: GameDifficulty) {
        UserDefaults.standard.setValue(difficult, forKey: GameDifficulty.key)
    }
    
    func setCarStyle(_ style: GameCars) {
        UserDefaults.standard.setValue(style, forKey: GameCars.key)
    }
    
    func setRoadStyle(_ style: GameRoads) {
        UserDefaults.standard.setValue(style, forKey: GameRoads.key)
    }
}

extension Settings {
    
    enum GameDifficulty: String, Codable, CaseIterable {
        static var key: String { "GameDifficultyKey" }

        case easy, average, hard
        
        var correctName: String {
            switch self {
            case .easy: return "Легко"
            case .average: return "Средне"
            case .hard: return "Тяжело"
            }
        }
    }
    
    enum GameRoads: String, Codable, CaseIterable {
        static var key: String { "GameRoadStyleKey" }
        
        case road, desertRoad
        
        var correctName: String {
            switch self {
            case .road: return "Городская дорога"
            case .desertRoad: return "Дорога в пустыне"
            }
        }
                
        func getRoadImage() -> UIImage? {
            return UIImage(named: self.rawValue)
        }
    }
    
    enum GameCars: String, Codable, CaseIterable {
        static var key: String { "GameUserCarStyleKey" }
        
        case car, silverCar, blackCar, cabrioCar
        
        var correctName: String {
            switch self {
            case .car: return "Стандарт"
            case .silverCar: return "Серебренная"
            case .blackCar: return "Черная"
            case .cabrioCar: return "Кабриолет"
            }
        }
        
        func getCarImage() -> UIImage? {
            return UIImage(named: self.rawValue)
        }
    }
}
