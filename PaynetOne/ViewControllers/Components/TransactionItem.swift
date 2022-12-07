//
//  TransactionItem.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 19/09/2022.
//

import UIKit
import SwiftTheme

class TransactionItem: UIView {
    private let lbTitle = POMaker.makeLabel(font: .helvetica.withSize(15).setBold())
    private let imgSoLuongGd = POMaker.makeImage(image: "cho-doi-soat")
    private let lbSoluongTitle = POMaker.makeLabel(text: "Số lượng giao dịch")
    private let lbSoluongValue = POMaker.makeLabel(font: .helvetica.withSize(14).setBold())
    private let imgAmount = POMaker.makeImage(image: "da-doi-soat")
    private let lbAmountTitle = POMaker.makeLabel(text: "Tổng số tiền")
    private let lbAmountValue = POMaker.makeLabel(font: .helvetica.withSize(14).setBold())
    
    public var title = "" {
        didSet {
            self.lbTitle.text = title
        }
    }
    public var quantity = 0 {
        didSet {
            self.lbSoluongValue.text = String(quantity)
        }
    }
    public var amount = 0 {
        didSet {
            self.lbAmountValue.text = Utils.currencyFormatter(amount: amount)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.5
        
        addSubviews(views: lbTitle, imgSoLuongGd, lbSoluongTitle, lbSoluongValue, imgAmount, lbAmountTitle, lbAmountValue)
        lbTitle.top(toView: self, space: 8)
        lbTitle.left(toView: self, space: 8)
        
        imgSoLuongGd.top(toAnchor: lbTitle.bottomAnchor, space: 6)
        imgSoLuongGd.left(toView: self, space: 8)
        imgSoLuongGd.size(CGSize(width: 30, height: 30))
        
        lbSoluongTitle.centerY(toView: imgSoLuongGd)
        lbSoluongTitle.left(toAnchor: imgSoLuongGd.rightAnchor, space: 6)
        
        lbSoluongValue.right(toView: self, space: 8)
        lbSoluongValue.centerY(toView: imgSoLuongGd)
        
        imgAmount.top(toAnchor: imgSoLuongGd.bottomAnchor, space: 8)
        imgAmount.left(toView: self, space: 8)
        imgAmount.size(CGSize(width: 30, height: 30))
        imgAmount.bottom(toView: self, space: 8)
        
        lbAmountTitle.centerY(toView: imgAmount)
        lbAmountTitle.left(toAnchor: imgAmount.rightAnchor, space: 6)
        
        lbAmountValue.right(toView: self, space: 8)
        lbAmountValue.centerY(toView: imgAmount)
        
        if isDarkMode {
            self.applyViewDarkMode()
            lbTitle.textColor = .white
            lbSoluongTitle.textColor = .white
            lbSoluongValue.textColor = .white
            lbAmountTitle.textColor = .white
            lbAmountValue.textColor = .white
         
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
