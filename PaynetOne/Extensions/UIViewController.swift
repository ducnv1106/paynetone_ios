//
//  UIViewController.swift
//  PaynetOne
//
//  Created by vinatti on 27/12/2021.
//

import UIKit
import PopupDialog
import Toast_Swift

fileprivate var thisView: UIView?

extension UIViewController {
    
    func hideKeyboardWhenTappedOutside(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func showToast(message: String, delay: Double, position: ToastPosition = .bottom) {
//        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//        alert.view.backgroundColor = .black
//        alert.view.alpha = 0.5
//        alert.view?.layer.cornerRadius = 12
//        self.present(alert, animated: true)
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
//            alert.dismiss(animated: true)
//        }
//        let alertView = ToastVC()
//        alertView.lbMessage.text = message
//        alertView.modalPresentationStyle = .overCurrentContext
////        alertView.modalTransitionStyle = .crossDissolve
//        self.present(alertView, animated: true, completion: nil)
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
//            alertView.dismiss(animated: true)
//        }
        self.view.makeToast(message, duration: delay, position: position)
    }
    
    func buildButtonFirst(image: String, title: String){
        let imageBtn = UIImageView()
        let lblBtn = UILabel()
        let view = self.view!
        
        imageBtn.translatesAutoresizingMaskIntoConstraints = false
        lblBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageBtn)
        imageBtn.image = UIImage(named: image)
        imageBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        
        view.addSubview(lblBtn)
        lblBtn.text = title
        lblBtn.topAnchor.constraint(equalTo: imageBtn.bottomAnchor, constant: 10).isActive = true
    }
    
    func showLoading(){
        thisView = UIView(frame: self.view.bounds)
        thisView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activity.center = thisView!.center
        activity.startAnimating()
        thisView?.addSubview(activity)
        self.view.addSubview(thisView!)
    }
    
    func hideLoading(){
        thisView?.removeFromSuperview()
    }
        func buildPopup(title: String, msg: String, btnAxis: NSLayoutConstraint.Axis = .horizontal, trans: PopupDialogTransitionStyle = .zoomIn, cancelBtnTitle: String = "", cancelAction: (() -> ())? = nil, okBtnTitle: String = "", okAction: (() -> ())? = nil, msgAlign: NSTextAlignment = .center) {
            let popup = PopupDialog(title: title, message: msg, buttonAlignment: btnAxis, transitionStyle: trans)
            let dialogAppearance = PopupDialogDefaultView.appearance()
            dialogAppearance.messageFont = .helvetica
            dialogAppearance.messageColor = .textBlack
            dialogAppearance.messageTextAlignment = msgAlign
            dialogAppearance.titleFont = .helvetica
            dialogAppearance.titleColor = .black
            let buttonAppearance = DefaultButton.appearance()
            buttonAppearance.titleFont = .helvetica
            buttonAppearance.buttonColor = .blueColor
            buttonAppearance.titleColor = .white
            let cancelButtonApp = CancelButton.appearance()
            cancelButtonApp.titleFont = .helvetica
            cancelButtonApp.buttonColor = .red
            cancelButtonApp.titleColor = .white
            let btnCancel = CancelButton(title: cancelBtnTitle){
                if let cancelAction = cancelAction {
                    cancelAction()
                }
            }
            let btnConfirm = DefaultButton(title: okBtnTitle) {
                if let okAction = okAction {
                    okAction()
                }
            }
            if cancelBtnTitle == "" {
                popup.addButtons([btnConfirm])
            } else if okBtnTitle == "" {
                popup.addButtons([btnCancel])
            } else {
                popup.addButtons([btnCancel, btnConfirm])
            }
            self.present(popup, animated: true, completion: nil)
        }
    func popupWithView(vc: UIViewController, btnAxis: NSLayoutConstraint.Axis = .horizontal, trans: PopupDialogTransitionStyle = .zoomIn, tapDismiss: Bool = true, panDismiss: Bool = true, cancelBtnTitle: String = "", cancelAction: (() -> ())? = nil, okBtnTitle: String = "", okAction: (() -> ())? = nil, okActionIsDismiss: Bool = true) {
        let popup = PopupDialog(viewController: vc, buttonAlignment: btnAxis, transitionStyle: trans, tapGestureDismissal: tapDismiss, panGestureDismissal: panDismiss)
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.messageFont = .helvetica
        dialogAppearance.messageColor = .gray
        dialogAppearance.titleFont = .helvetica
        dialogAppearance.titleColor = .black
        let buttonAppearance = DefaultButton.appearance()
        buttonAppearance.titleFont = .helvetica.setBold().withSize(16)
        buttonAppearance.buttonColor = .blueColor
        buttonAppearance.titleColor = .white
        let cancelButtonApp = CancelButton.appearance()
        cancelButtonApp.titleFont = .helvetica.setBold().withSize(16)
        cancelButtonApp.buttonColor = .red
        cancelButtonApp.titleColor = .white
        let btnCancel = CancelButton(title: cancelBtnTitle){
            if let cancelAction = cancelAction {
                cancelAction()
            }
        }
        let btnConfirm = DefaultButton(title: okBtnTitle) {
            
            if let okAction = okAction {
                okAction()
            }
        }
        btnConfirm.dismissOnTap = okActionIsDismiss
        if cancelBtnTitle == "" {
            popup.addButtons([btnConfirm])
        } else if okBtnTitle == "" {
            popup.addButtons([btnCancel])
        } else {
            popup.addButtons([btnConfirm, btnCancel])
        }
        self.present(popup, animated: true, completion: nil)
    }
    func takeAndShareScreenshot(view:UIView){
//        let keyWindow = UIApplication.shared.connectedScenes
//                .filter({$0.activationState == .foregroundActive})
//                .compactMap({$0 as? UIWindowScene})
//                .first?.windows
//                .filter({$0.isKeyWindow}).first
//        guard let window = keyWindow else { return }
//        let bounds = UIScreen.main.bounds
//        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
//        window.drawHierarchy(in: bounds, afterScreenUpdates: true)
//        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        let image = view.asImage()
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
}
