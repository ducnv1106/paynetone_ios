//
//  BusinessTypeCell.swift
//  PaynetOne
//
//  Created by vinatti on 09/02/2022.
//

import UIKit

class BusinessTypeCell: UITableViewCell {
    static let identifier = "BusinessTypeCell"
    
    let imgLeftIcon = UIImageView()
    let lbTitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imgLeftIcon)
        contentView.addSubview(lbTitle)
        contentView.backgroundColor = .white
        lbTitle.textColor = .black
        imgLeftIcon.image = UIImage(systemName: "circle")
        imgLeftIcon.viewConstraints(left: contentView.leftAnchor, centerY: contentView.centerYAnchor)
        lbTitle.labelConstraints(left: imgLeftIcon.rightAnchor, marginLeft: 10, centerY: contentView.centerYAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
