//
//  DepositWithWalletVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 18/08/2022.
//

import UIKit

class DepositWithWalletVC: BaseUI {
    private let limitView = POMaker.makeView(backgroundColor: .white)
    private let lbLimitTitle = POMaker.makeLabel(text: "Hạn mức", font: .helvetica.withSize(16), color: .textLightGray)
    private let lbLimitValue = POMaker.makeLabel(font: .helvetica.withSize(16).setBold(), color: .red)

    override func viewDidLoad() {
        super.viewDidLoad()

        setViewLimit()
    }
    private func setViewLimit(){
        view.addSubview(limitView)
        limitView.viewConstraints(top: view.safeTopAnchor, left: view.leftAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        limitView.addSubview(lbLimitTitle)
        lbLimitTitle.viewConstraints(top: limitView.topAnchor, left: limitView.leftAnchor, bottom: limitView.bottomAnchor, padding: UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 0))
        limitView.addSubview(lbLimitValue)
        lbLimitValue.viewConstraints(right: limitView.rightAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 14), centerY: lbLimitTitle.centerYAnchor)
        lbLimitValue.text = Utils.currencyFormatter(amount: 1000000)
    }
}
