import UIKit

class ResultsViewController: UIViewController {
    
    private let resultsView = ResultsView()
    private let resultsManager = ResultsManager()
    private var results: [GameResult] {
        resultsManager.load()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = resultsView
        resultsView.injectTableView(delegate: self, dataSource: self)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Результаты"
        addRemoveButton()
    }
    
    private func addRemoveButton() {
        let removeAllButton = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        removeAllButton.setBackgroundImage(UIImage(systemName: "trash.fill"), for: .normal)
        
        removeAllButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.removeWarning(isRemoveAll: true) {
                let allIndexPaths = (0..<self.results.count).map { IndexPath(row: $0, section: 0) }
                self.resultsManager.removeAll()
                self.resultsView.resultsTable.deleteRows(at: allIndexPaths, with: .middle)
            }
        }, for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: removeAllButton)
    }
    

}

extension ResultsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { results.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultsTableCell.identifier) as? ResultsTableCell,
              indexPath.row < results.count else { return UITableViewCell() }
        
        cell.configure(with: results[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { true }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle { .delete }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard indexPath.row < results.count else { return }
        
        removeWarning(isRemoveAll: false) { [weak self] in
            guard let self = self else { return }
                self.resultsManager.remove(self.results[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .right)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 100 }
}
