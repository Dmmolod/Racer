import UIKit

protocol MenuViewDelegate: AnyObject {
    func startGameButtonPressed()
    func resultsGameButtonPressed()
    func settingsButtonPressed()
}

class MenuView: UIView {
    
    weak var delegate: MenuViewDelegate?
    private let background = UIImageView(image: UIImage(named: "raceBackground"))
    private let startGameButton = UIButton()
    private let resultsButton = UIButton()
    private let settingsButton = UIButton()
    private let buttonsHeight: CGFloat = 25
    private let buttonsWidth: CGFloat = 200
    
    init() {
        super.init(frame: .zero)
        setupConstraints()
        setupElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        [background, startGameButton, resultsButton, settingsButton].forEach { self.addSubview($0) }
        
        background.anchor(top: topAnchor,
                          bottom: bottomAnchor,
                          leading: leadingAnchor,
                          trailing: trailingAnchor)
        
        startGameButton.anchor(width: buttonsWidth, height: buttonsHeight)
        startGameButton.centerX(inView: self)
        startGameButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -buttonsHeight/3 - 10).isActive = true
        
        resultsButton.anchor(width: buttonsWidth, height: buttonsHeight)
        resultsButton.centerX(inView: self)
        resultsButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: buttonsHeight/2 + 10).isActive = true
        
        settingsButton.anchor(width: buttonsWidth, height: buttonsHeight)
        settingsButton.centerX(inView: self)
        settingsButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: buttonsHeight*2 + 10).isActive = true

    }
    
    private func setupElements() {
        background.contentMode = .scaleAspectFill
        
        startGameButton.addAction(UIAction(handler: { _ in
            self.delegate?.startGameButtonPressed()
        }), for: .touchUpInside)
        startGameButton.setTitle("Поехали", for: .normal)
        
        resultsButton.addAction(UIAction(handler: { _ in
            self.delegate?.resultsGameButtonPressed()
        }), for: .touchUpInside)
        resultsButton.setTitle("Результаты", for: .normal)
        
        settingsButton.addAction(UIAction(handler: { _ in
            self.delegate?.settingsButtonPressed()
        }), for: .touchUpInside)
        settingsButton.setTitle("Настройки", for: .normal)
        
        [startGameButton, resultsButton, settingsButton].forEach {
            $0.backgroundColor = .systemBlue
            $0.layer.cornerRadius = buttonsHeight/2
        }
    }
}
