import Foundation

class ResultsManager {
    
    private let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    private let resultsFileName = "Results"
    private var savedResults: [GameResult] {
        guard let resultsURL = documentsURL?.appendingPathComponent(resultsFileName),
              let resultsData = try? Data(contentsOf: resultsURL),
              let results = try? JSONDecoder().decode([GameResult].self, from: resultsData) else { return [] }
        return results
    }

    func save(_ score: Int, _ startDate: Date, _ endDate: Date) {
        let result = GameResult(score: score,
                                startDate: startDate,
                                endDate: endDate)
        
        var updateSavedResults = savedResults
        updateSavedResults.append(result)
        updateSavedResults.sort { $0.startDate > $1.startDate }
        
        guard let resultsURL = documentsURL?.appendingPathComponent(resultsFileName),
              let updateResultsData = try? JSONEncoder().encode(updateSavedResults) else { return }
        
        try? updateResultsData.write(to: resultsURL)
    }
    
    func load() -> [GameResult] { savedResults }
    
    func remove(_ result: GameResult) {
        var updateResults = savedResults
        updateResults.removeAll { $0 == result }
        
        guard let resultsURL = documentsURL?.appendingPathComponent(resultsFileName),
              let updateResultsData = try? JSONEncoder().encode(updateResults) else { return }
        try? updateResultsData.write(to: resultsURL)
    }
    
    func removeAll() {
        guard let resultsURL = documentsURL?.appendingPathComponent(resultsFileName) else { return }
        try? FileManager.default.removeItem(at: resultsURL)
    }
    
}
