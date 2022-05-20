import Foundation
import UIKit

extension UIViewController {
    func loseGameAlert(with score: Int) {
        let ac = UIAlertController(title: "Игра окончена!", message: "Ваши очки: \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Меню", style: .destructive, handler: { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        self.present(ac, animated: true)
    }
    
    func removeWarning(isRemoveAll: Bool, acceptedRemove: @escaping () -> Void) {
        let ac = UIAlertController(title: "Удаление", message: "Вы действительно хотите удалить \(isRemoveAll ? "все результаты" : "результат")?\n Это действие будет невозможно отменить.", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { _ in
            acceptedRemove()
        }))
        ac.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        self.present(ac, animated: true)
    }
}
