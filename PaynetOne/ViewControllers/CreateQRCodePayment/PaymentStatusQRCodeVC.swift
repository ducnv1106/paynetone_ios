//
//  PaymentStatusQRCodeVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 25/08/2022.
//

import UIKit

class PaymentStatusQRCodeVC: BaseUI {
    
    lazy var dimmedView = POMaker.makeView(backgroundColor: .black.withAlphaComponent(0.6))
    lazy var containerView = POMaker.makeView(backgroundColor: .white, radius: 16, radiusOnly: .top)
    let defaultHeight: CGFloat = 300
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    private var lbTitleOrderDetail :UILabel!
    private var lbPhoneNumberTitle :UILabel!
    private var lbAmountTitle :UILabel!
    private var lbOrderStatusTitle :UILabel!
    private var closeButton :UIButton!
    private var lbPhoneValue :UILabel!
    private var lbAmountValue :UILabel!
    private var lbStatusValue :StatusView!
    
    var model = StatusOrderModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        self.view.backgroundColor = .clear
        setupDimmedViewContainerView()
    }
    private func initUI(){
        dimmedView = POMaker.makeView(backgroundColor: .black.withAlphaComponent(0.6))
        containerView = POMaker.makeView(backgroundColor: .white, radius: 16, radiusOnly: .top)
        
        lbTitleOrderDetail = POMaker.makeLabel(text: "Chi tiết đơn hàng", font: .helvetica.withSize(16), alignment: .center)
        lbPhoneNumberTitle = POMaker.makeLabel(text: "Số điện thoại")
        lbAmountTitle = POMaker.makeLabel(text: "Số tiền")
        lbOrderStatusTitle = POMaker.makeLabel(text: "Trạng thái đơn hàng")
        closeButton = POMaker.makeButton(title: "Đóng", color: .white, textAlignment: .center, cornerRadius: 22)
        lbPhoneValue = POMaker.makeLabel(font: .helvetica.setBold())
        lbAmountValue = POMaker.makeLabel(font: .helvetica.setBold())
        lbStatusValue = StatusView()
    }
    override func configBackgorundColor() {
        self.view.backgroundColor = .clear
        DispatchQueue.main.async {
            self.animateShowDimmedView()
            self.animatePresentContainer()
        }
    }
    
    private func setupDimmedViewContainerView(){
        view.addSubview(dimmedView)
        dimmedView.viewConstraints(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        view.addSubview(containerView)
        containerView.viewConstraints(left: view.leftAnchor, right: view.rightAnchor)
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
        
        containerView.addSubview(lbTitleOrderDetail)
        lbTitleOrderDetail.viewConstraints(top: containerView.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 50))
        containerView.addSubview(lbPhoneNumberTitle)
        lbPhoneNumberTitle.viewConstraints(top: lbTitleOrderDetail.bottomAnchor, left: containerView.leftAnchor, padding: UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 0), size: CGSize(width: 0, height: 50))
        containerView.addSubview(lbAmountTitle)
        lbAmountTitle.viewConstraints(top: lbPhoneNumberTitle.bottomAnchor, left: containerView.leftAnchor, padding: UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 0), size: CGSize(width: 0, height: 50))
        containerView.addSubview(lbOrderStatusTitle)
        lbOrderStatusTitle.viewConstraints(top: lbAmountTitle.bottomAnchor, left: containerView.leftAnchor, padding: UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 0), size: CGSize(width: 0, height: 50))
        containerView.addSubview(closeButton)
        closeButton.viewConstraints(top: lbOrderStatusTitle.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, padding: UIEdgeInsets(top: 14, left: 14, bottom: 0, right: 14), size: CGSize(width: 0, height: 50))
        closeButton.addTarget(self, action: #selector(closePopupTOuchUP), for: .touchUpInside)
        
        containerView.addSubview(lbPhoneValue)
        containerView.addSubview(lbAmountValue)
        containerView.addSubview(lbStatusValue)
        lbPhoneValue.viewConstraints(right: containerView.rightAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 14), centerY: lbPhoneNumberTitle.centerYAnchor)
        lbAmountValue.viewConstraints(right: containerView.rightAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 14), centerY: lbAmountTitle.centerYAnchor)
        lbStatusValue.viewConstraints(right: containerView.rightAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 14), centerY: lbOrderStatusTitle.centerYAnchor)
        lbPhoneValue.text = model.mobileNumber
        lbAmountValue.text = Utils.currencyFormatter(amount: model.amount)
        lbStatusValue.label.text = ProviderType.status(status: model.status)
        lbStatusValue.backgroundColor = ProviderType.color(model.status)
    }
    @objc private func closePopupTOuchUP(){
        animateDismissView()
    }
    private func animatePresentContainer(){
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    private func animateShowDimmedView(){
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0.6
        }
    }
    private func animateDismissView(){
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            self.view.layoutIfNeeded()
        }
        dimmedView.alpha = 0.6
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
}
