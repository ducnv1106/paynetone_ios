//
//  SuggestAmountCollectionViewCell.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 15/08/2022.
//

import UIKit

class SuggestAmountCollectionViewCell: UICollectionViewCell {
    let cellView = POMaker.makeView(borderWidth: 0.8, borderColor: .borderColor, radius: 8)
    let suggestAmount = POMaker.makeLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellView)
        cellView.viewConstraints(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
        cellView.addSubview(suggestAmount)
        suggestAmount.viewConstraints(centerX: cellView.centerXAnchor, centerY: cellView.centerYAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
