import UIKit
import PopupDialog

extension UIViewController {
    
    var alertController: UIAlertController? {
        guard let alert = UIApplication.topViewController() as? UIAlertController else { return nil }
        return alert
    }
    func showPopupDevelop(){
        let vc = PopupDevelopVC()
        let popup = PopupDialog(viewController: vc,
                                buttonAlignment: .horizontal,
                                transitionStyle: .fadeIn,
                                tapGestureDismissal: true,
                                panGestureDismissal: true)
        self.present(popup, animated: true, completion: nil)
    }
    
}
