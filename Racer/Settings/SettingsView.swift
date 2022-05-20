import Foundation
import UIKit

protocol SettingsViewDelegate: AnyObject {
    func carDidChange(_ index: Int)
    func roadDidChange(_ index: Int)
    func difficultyDidChange(_ index: Int)
}

class SettingsView: UIView {
    
    weak var delegate: SettingsViewDelegate?
    
    private let difficultTitle = UILabel()
    private let carTitle = UILabel()
    private let roadTitle = UILabel()
    private let cars: UISegmentedControl
    private let roads: UISegmentedControl
    private let difficulty: UISegmentedControl
    private let carImages: [UIImage?]
    private let roadImages: [UIImage?]
    private let carImageView = UIImageView()
    private let roadImageView = UIImageView()
    
    init(carNames: [String],
         carImages: [UIImage?],
         roadNames: [String],
         roadImages: [UIImage?],
         difficultys: [String])
    {
        
        cars = UISegmentedControl(items: carNames)
        roads = UISegmentedControl(items: roadNames)
        difficulty = UISegmentedControl(items: difficultys)
        
        self.carImages = carImages
        self.roadImages = roadImages
        
        super.init(frame: .zero)
        
        setupUI()
        setupElements()
        addActionForSegments()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addActionForSegments() {
       
        cars.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.carImageView.image = self.carImages[self.cars.selectedSegmentIndex]
            self.delegate?.carDidChange(self.cars.selectedSegmentIndex)
        }), for: .valueChanged)
        
        roads.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.roadImageView.image = self.roadImages[self.roads.selectedSegmentIndex]
            self.delegate?.roadDidChange(self.roads.selectedSegmentIndex)
        }), for: .valueChanged)
        
        difficulty.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.difficultyDidChange(self.difficulty.selectedSegmentIndex)
        }), for: .valueChanged)
    }
    
    func setupSegmentsChoices(carIndex: Int, roadIndex: Int, difficultyIndex: Int) {
        cars.selectedSegmentIndex = carIndex
        roads.selectedSegmentIndex = roadIndex
        difficulty.selectedSegmentIndex = difficultyIndex
        
        carImageView.image = carImages[cars.selectedSegmentIndex]
        roadImageView.image = roadImages[roads.selectedSegmentIndex]
    }
    
    private func setupUI() {
        backgroundColor = .systemPink
        [difficultTitle, carTitle, roadTitle, cars, roads, difficulty, carImageView, roadImageView].forEach { addSubview($0) }
        
        difficultTitle.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, paddingTop: 20, paddingLeading: 20)
        difficulty.anchor(top: difficultTitle.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 10, height: 50)
        
        carTitle.anchor(top: difficulty.bottomAnchor, leading: leadingAnchor, paddingTop: 20, paddingLeading: 20)
        cars.anchor(top: carTitle.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 10, height: 50)
        carImageView.anchor(top: cars.bottomAnchor, leading: leadingAnchor, trailing: centerXAnchor, paddingTop: 10, paddingLeading: 20, paddingTrailing: 20, height: 100)
        
        roadTitle.anchor(top: carImageView.bottomAnchor, leading:  leadingAnchor, paddingTop: 20, paddingLeading: 20)
        roads.anchor(top: roadTitle.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 10, height: 50)
        roadImageView.anchor(top: cars.bottomAnchor, leading: centerXAnchor, trailing: trailingAnchor, paddingTop: 10, paddingLeading: 20, paddingTrailing: 20, height:  100)
    }
    
    private func setupElements() {
        difficultTitle.text = "Cложность"
        carTitle.text = "Ваша машина"
        roadTitle.text = "Трасса"
        
        carImageView.transform = carImageView.transform.rotated(by: .pi)
        carImageView.contentMode = .scaleAspectFit
        
        roadImageView.clipsToBounds = true
        roadImageView.contentMode = .scaleAspectFill
    }
}
