import UIKit

class GameViewController: UIViewController {
    
    enum Side {
        case left
        case right
    }
    
    private let gameView = GameView()
    private let gameInfo = GameInfo()
    private var otherCarSpawnTimer: Timer?
    private var roadMoveAnimationTimer: Timer?
    private var moveOtherCarsTimers = [Timer]()
    private var isScreenPressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = gameView
        setupRecognizer()
        startMoveRoad()
        gameView.setupGameStyle(carStyle: gameInfo.userChoiceCarStyle.getCarImage(),
                                roadStyle: gameInfo.userChoiceRoadStyle.getRoadImage())
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        spawnOtherCar()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        endGame(isDidDisappear: true)
    }
    
    private func setupRecognizer() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(screenDidPressed(_:)))
        longPressRecognizer.minimumPressDuration = 0
        gameView.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc private func screenDidPressed(_ recognizer: UILongPressGestureRecognizer) {
        let tapLocation = recognizer.location(in: gameView)
        let side: Side = tapLocation.x < gameView.carCenterX ? .left : .right
        
        switch recognizer.state {
        case .began: startTurn(to: side)
        case .ended: isScreenPressed = false
        default: return
        }
    }
    
    private func startTurn(to side: Side) {
        isScreenPressed = true
        
        func turn() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12/gameInfo.fps) {
                self.gameView.turnCar(to: side)
                if self.isScreenPressed { turn() } else { self.gameView.stopTurn() }
            }
        }
        
        turn()
    }
    
    private func startMoveRoad() {
        roadMoveAnimationTimer = Timer.scheduledTimer(withTimeInterval: 0.25/gameInfo.fps, repeats: true, block: { _ in
            self.gameView.startRoadAnimation()
            self.gameInfo.score += 1/100
            self.gameView.changeScore(with: Int(self.gameInfo.score))
        })
    }
    
    private func spawnOtherCar() {
        otherCarSpawnTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            
            let side: Side = [Side.left, Side.right].shuffled().first!
            let moveFunc = self.gameView.spawnCar(on: side)
            
            self.moveOtherCarsTimers.append(Timer.scheduledTimer(withTimeInterval: side == .left ? 0.25/self.gameInfo.fps : 1/self.gameInfo.fps , repeats: true) { timer in
                moveFunc? { isCrach in
                    if isCrach {
                        self.endGame(isDidDisappear: false)
                    } else {
                        timer.invalidate()
                        self.moveOtherCarsTimers.removeAll(where: { $0 == timer })
                    }
                }
            })
        })
    }
    
    private func endGame(isDidDisappear: Bool) {
        isScreenPressed = false
        
        moveOtherCarsTimers.forEach { $0.invalidate() }
        moveOtherCarsTimers = []
        
        [otherCarSpawnTimer, roadMoveAnimationTimer].forEach { $0?.invalidate() }
                
        if isDidDisappear {
            if gameInfo.endRaceDate == nil { gameInfo.endRaceDate = Date() }
            ResultsManager().save(Int(gameInfo.score), gameInfo.startRaceDate, gameInfo.endRaceDate!)
        } else {
            gameInfo.endRaceDate = Date()
            loseGameAlert(with: Int(gameInfo.score))
        }
    }
}
