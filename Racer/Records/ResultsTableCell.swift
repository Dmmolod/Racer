import Foundation
import UIKit

class ResultsTableCell: UITableViewCell {
    
    private let startRaceTimeLable = UILabel()
    private let endRaceTimeLable = UILabel()
    private let finalScoreLable = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        let background = UIView()
        let titleLable = UILabel()
        
        background.backgroundColor = .systemBackground
        background.alpha = 0.6
        titleLable.text = "Получено очков:"
        
        [background, startRaceTimeLable, endRaceTimeLable, finalScoreLable, titleLable].forEach { contentView.addSubview($0) }
        [startRaceTimeLable, endRaceTimeLable].forEach {
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .lightGray
        }
        
        background.anchor(top: contentView.topAnchor,
                          bottom: contentView.bottomAnchor,
                          leading: contentView.leadingAnchor,
                          trailing: contentView.trailingAnchor)
        
        titleLable.anchor(top: contentView.topAnchor,
                          leading: contentView.leadingAnchor,
                          paddingTop: 10,
                          paddingLeading: 10)
        
        startRaceTimeLable.anchor(top: titleLable.bottomAnchor,
                                  leading: titleLable.leadingAnchor,
                                  paddingLeading: 10)
        
        endRaceTimeLable.anchor(top: startRaceTimeLable.bottomAnchor,
                                bottom: contentView.bottomAnchor,
                                leading: startRaceTimeLable.leadingAnchor,
                                paddingBottom: 10)
        
        finalScoreLable.anchor(top: titleLable.topAnchor,
                               bottom: titleLable.bottomAnchor,
                               trailing: contentView.trailingAnchor,
                               paddingTrailing: 10)
    }
    
    func configure(with gameInfo: GameResult) {
        let dateFormat = "dd MMMM в HH:mm:ss"
        startRaceTimeLable.text = "Начало:\t" + gameInfo.startDate.format(with: dateFormat)
        endRaceTimeLable.text = "Конец: \t" + gameInfo.endDate.format(with: dateFormat)
        finalScoreLable.text = String(Int(gameInfo.score))
    }
}
