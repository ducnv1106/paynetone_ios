//
//  SuggestMoneyCell.swift
//  PaynetOne
//
//  Created by vinatti on 07/01/2022.
//

import UIKit

class SuggestMoneyCell: UICollectionViewCell {
    static let identifier = "SuggestMoneyCell"
    let cellItem: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = false
        return view
    }()
    let cellLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionItem(){
        cellItem.addSubview(cellLabel)
        contentView.addSubview(cellItem)
        cellItem.viewConstraints(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
        cellLabel.labelConstraints(centerX: cellItem.centerXAnchor, centerY: cellItem.centerYAnchor)
    }
}
