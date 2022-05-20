import UIKit

class GameView: UIView {

    var carCenterX: CGFloat {
        return car.center.x
    }
    private let car = UIImageView()
    private let road = UIImageView()
    private let secondRoad = UIImageView()
    private let scoreCounter = UILabel()
    private var animateRoadConstraint: NSLayoutConstraint?
    private var animateCarConstraint: NSLayoutConstraint?
    private var spawnedCars = [UIImageView]()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupGameStyle(carStyle: UIImage?, roadStyle: UIImage?) {
        road.image = roadStyle
        secondRoad.image = roadStyle
        car.image = carStyle
    }
    
    private func setupUI() {
        
        car.transform = car.transform.rotated(by: .pi)
        
        [road, secondRoad, car].forEach {
            addSubview($0)
            $0.contentMode = .scaleAspectFill
        }
        addSubview(scoreCounter)
        
        secondRoad.anchor(bottom: road.topAnchor)
        secondRoad.anchor(width: road.widthAnchor, height: road.heightAnchor)
        secondRoad.centerX(inView: self)
        
        road.anchor(width: self.widthAnchor, height: self.heightAnchor)
        road.centerX(inView: self)
        animateRoadConstraint = road.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        animateRoadConstraint?.isActive = true
        
        car.anchor(bottom: self.bottomAnchor, paddingBottom: 40, width: 40, height: 100)
        animateCarConstraint = car.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40)
        animateCarConstraint?.isActive = true
        
        scoreCounter.anchor(top: self.safeAreaLayoutGuide.topAnchor, trailing: self.trailingAnchor, paddingTop: -40, paddingTrailing: 20)
        scoreCounter.textColor = .systemPink
        scoreCounter.font = .systemFont(ofSize: 30, weight: .light)
    }
    
    func startRoadAnimation() {
        
        if road.frame.minY > frame.maxY { animateRoadConstraint?.constant = 0 }
        else { animateRoadConstraint?.constant += 1 }
        
        UIView.animate(withDuration: 5, delay: 0, options: [.repeat, .curveLinear]) {
            self.road.layoutIfNeeded()
            self.secondRoad.layoutIfNeeded()
        }
    }
    
    func stopTurn() {
        UIView.animate(withDuration: 0.2) {
            self.car.transform = CGAffineTransform(rotationAngle: .pi)
        }
    }
    
    func turnCar(to side: GameViewController.Side) {
        let rotateRadian = Double.pi + (5 * Double.pi)/180
        switch side {
        case .left:
            if car.frame.minX > frame.minX {
                animateCarConstraint?.constant -= 0.3
                UIView.animate(withDuration: 0.2) {
                    self.car.transform = CGAffineTransform(rotationAngle: -rotateRadian)
                }
            }
        case .right:
            if car.frame.maxX < frame.maxX {
                animateCarConstraint?.constant += 0.3
                UIView.animate(withDuration: 0.3) {
                    self.car.transform = CGAffineTransform(rotationAngle: rotateRadian)
                }
            }
        }
    }
    func changeScore(with count: Int) {
        scoreCounter.text = "Очки: \(count)"
    }
    
    func spawnCar(on side: GameViewController.Side) -> (((Bool) -> Void) -> Void)? {
        guard let carName = ["cabrioCar", "blackCar", "silverCar"].shuffled().first else { return nil }
        let car = UIImageView(image: UIImage(named: carName))
        car.contentMode = self.car.contentMode
        car.frame.size = CGSize(width: 40, height: 100)
        car.center.y = [-300, -150].shuffled().first!
        insertSubview(car, at: 2)
        
        switch side {
        case .left: car.center.x = [frame.width/5 - 20, frame.width/3 + 10].shuffled().first!
        case .right:
            car.transform = car.transform.rotated(by: .pi)
            car.center.x = [frame.width*2/3 - 10, frame.width*4/5 + 15].shuffled().first!
        }
        
        var isIntersects = false
        spawnedCars.forEach {
            if $0.frame.intersects(car.frame) {
                isIntersects = true
                car.removeFromSuperview()
            }
        }
        
        if !isIntersects { spawnedCars.append(car) }
        
        func moveFunc(_ completion: (Bool) -> Void) {
            spawnedCars.forEach {
                if $0.frame.intersects(self.car.frame) { completion(true) }
            }
            
            if car.frame.minY > frame.maxY {
                completion(false)
                spawnedCars.removeAll { $0 == car }
                car.removeFromSuperview()
                return
            }
            car.center.y += 2
        }
        
        return moveFunc
    }
}
