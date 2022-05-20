import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    private let settings = Settings()
    private let settingsView: SettingsView = {
        let cars: (names: [String], images: [UIImage?]) = (Settings.GameCars.allCases.map { $0.correctName }, Settings.GameCars.allCases.map { $0.getCarImage() } )
        let roads: (names: [String], images: [UIImage?]) = (Settings.GameRoads.allCases.map { $0.correctName }, Settings.GameRoads.allCases.map { $0.getRoadImage() } )
        let difficultys = Settings.GameDifficulty.allCases.map { $0.correctName }
        
        return SettingsView(carNames: cars.names,
                            carImages: cars.images,
                            roadNames: roads.names,
                            roadImages: roads.images,
                            difficultys: difficultys)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = settingsView
        settingsView.delegate = self
        setupSegmentsChoices()
    }
    
    private func setupSegmentsChoices() {
        let carChoiceIndex = Settings.GameCars.allCases.firstIndex(of: settings.userChoiceCarStyle) ?? 0
        let roadChoiceIndex = Settings.GameRoads.allCases.firstIndex(of: settings.userChoiceRoadStyle) ?? 0
        let difficultyChoiceIndex = Settings.GameDifficulty.allCases.firstIndex(of: settings.userChoicegameDifficulty) ?? 0
        
        settingsView.setupSegmentsChoices(carIndex: carChoiceIndex,
                                          roadIndex: roadChoiceIndex,
                                          difficultyIndex: difficultyChoiceIndex)
    }
}

extension SettingsViewController: SettingsViewDelegate {
    
    func carDidChange(_ index: Int) {
        guard index < Settings.GameCars.allCases.count else { return }
        let carStyle = Settings.GameCars.allCases[index]
        self.settings.setCarStyle(carStyle)
    }
    func roadDidChange(_ index: Int) {
        guard index < Settings.GameRoads.allCases.count else { return }
        let roadStyle = Settings.GameRoads.allCases[index]
        self.settings.setRoadStyle(roadStyle)
    }
    func difficultyDidChange(_ index: Int) {
        guard index < Settings.GameDifficulty.allCases.count else { return }
        let difficulty = Settings.GameDifficulty.allCases[index]
        self.settings.setDifficult(difficulty)
    }
}
