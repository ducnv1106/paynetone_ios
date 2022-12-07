//
//  ToastVC.swift
//  PaynetOne
//
//  Created by vinatti on 09/02/2022.
//

import UIKit

class ToastVC: UIViewController {
    private let toastView = POMaker.makeView(backgroundColor: .borderColor, radius: 10)
    let lbMessage = POMaker.makeLabel(color: .white, alignment: .center)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(toastView)
        toastView.viewConstraints(bottom: view.safeBottomAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0), centerX: view.centerXAnchor)
        toastView.addSubview(lbMessage)
        lbMessage.viewConstraints(top: toastView.topAnchor, left: toastView.leftAnchor, bottom: toastView.bottomAnchor, right: toastView.rightAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
}
