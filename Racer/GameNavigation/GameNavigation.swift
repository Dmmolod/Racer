import UIKit

class GameNavigation: UINavigationController {

    init() {
        let menuVC = MenuController()
        super.init(rootViewController: menuVC)
        menuVC.navController = self
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toGame() {
        pushViewController(GameViewController(), animated: true)
    }
    
    func toResults() {
        pushViewController(ResultsViewController(), animated: false)
        navigationBar.prefersLargeTitles = true
    }
    
    func toSettings() {
        pushViewController(SettingsViewController(), animated: true)
    }
    
}

extension GameNavigation: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController == viewControllers.first {
            navigationBar.isHidden = true
            navigationBar.prefersLargeTitles = false
        } else { navigationBar.isHidden = false }
    }
}
