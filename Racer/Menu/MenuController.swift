import UIKit

class MenuController: UIViewController {

    var navController: GameNavigation?
    let menuView = MenuView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView.delegate = self
        self.view = menuView
        title = "Меню"
    }
    
}

extension MenuController: MenuViewDelegate {
    func startGameButtonPressed() {
        navController?.toGame()
    }
    
    func resultsGameButtonPressed() {
        navController?.toResults()
    }
    
    func settingsButtonPressed() {
        navController?.toSettings()
    }
}
