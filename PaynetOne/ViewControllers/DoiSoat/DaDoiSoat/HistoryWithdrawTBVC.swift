//
//  HistoryWithdrawTBVC.swift
//  PaynetOne
//
//  Created by on 24/02/2022.
//

import UIKit

class HistoryWithdrawTBVC: UITableViewCell {
    static let identifier = "HistoryWithdrawCell"
    
    private let lbId = POMaker.makeLabel()
    private let amount = POMaker.makeLabel()
    private let lbBank = POMaker.makeLabel()
    private let lbTransDate = POMaker.makeLabel()
    private let lbBankNumber = POMaker.makeLabel()
    private let lbFullName = POMaker.makeLabel()
    private let statusWithdraw = StatusView()
    
    var data = WithdrawHistoryResponse(){
        didSet {
            lbId.text = data.retRefNumber
            amount.text = data.amount == 0 ? "0 đ" : "\(Utils.currencyFormatter(amount: data.amount ?? 0))"
            lbBank.text = WithdrawStt.category(data.withDrawCatefory, walletName: data.walletName, bankname: data.bankShortName)
            lbTransDate.text = data.transDate
            lbFullName.text = data.fullName
            if data.withDrawCatefory == 4 {
                if data.ShopCode.isEmpty{
                    lbBankNumber.text = ""
                }else{
                    lbBankNumber.text = "Mã cửa hàng: \(data.ShopCode)"
                }
                lbFullName.text = data.ShopName
            } else if data.withDrawCatefory == 1 {
                lbBankNumber.text = data.accountNumber
            } else if data.withDrawCatefory == 2 {
                lbBankNumber.text = data.posID
            } else if data.withDrawCatefory == 3 {
                lbBankNumber.text = data.mobileNumber
            }
            statusWithdraw.label.text = WithdrawStt.status(data.returnCode ?? 0)
            statusWithdraw.backgroundColor = WithdrawStt.color(data.returnCode ?? 0)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
       
    }
    
    func setupView(){
        lbId.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        contentView.addSubviews(views: lbId, amount, lbBank, lbTransDate, lbBankNumber, lbFullName, statusWithdraw)
        amount.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        lbId.labelConstraints(top: contentView.topAnchor, marginTop: 15, left: contentView.leftAnchor, marginLeft: 15)
        amount.labelConstraints(right: contentView.rightAnchor, marginRight: -15, centerY: lbId.centerYAnchor)
        lbBank.labelConstraints(top: lbId.bottomAnchor, marginTop: 7, left: contentView.leftAnchor, marginLeft: 15)
        lbTransDate.labelConstraints(top: amount.bottomAnchor, marginTop: 7, right: contentView.rightAnchor, marginRight: -15)
        lbBankNumber.labelConstraints(top: lbBank.bottomAnchor, marginTop: 7, left: contentView.leftAnchor, marginLeft: 15)
        lbFullName.labelConstraints(top: lbBankNumber.bottomAnchor, marginTop: 7, left: contentView.leftAnchor, marginLeft: 15, bottom: contentView.bottomAnchor, marginBottom: -15)
        statusWithdraw.top(toAnchor: lbTransDate.bottomAnchor, space: 6)
        statusWithdraw.bottom(toView: contentView, space: 14)
        statusWithdraw.right(toView: contentView, space: 14)
        statusWithdraw.height(30)
        
        configTheme()
    }
    
    private func configTheme() {
        if isDarkMode{
            contentView.backgroundColor = .black
        }else{
            backgroundColor = .white
        }
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
