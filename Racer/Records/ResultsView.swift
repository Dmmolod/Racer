import UIKit

class ResultsView: UIView {
    
    private let background = UIImageView(image: UIImage(named: "raceBackground"))
    let resultsTable = UITableView(frame: .zero, style: .insetGrouped)
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        background.alpha = 0.6
        backgroundColor = .systemBackground
        resultsTable.backgroundColor = .clear
        addSubview(background)
        addSubview(resultsTable)
        resultsTable.register(ResultsTableCell.self, forCellReuseIdentifier: ResultsTableCell.identifier)
        resultsTable.anchor(top: self.safeAreaLayoutGuide.topAnchor,
                           bottom: self.bottomAnchor,
                           leading: self.leadingAnchor,
                           trailing: self.trailingAnchor)
    }
    
    func reload() {
        resultsTable.reloadData()
    }
    
    func injectTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        resultsTable.dataSource = dataSource
        resultsTable.delegate = delegate
    }
}
