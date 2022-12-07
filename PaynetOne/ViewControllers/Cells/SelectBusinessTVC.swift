//
//  SelectBusinessTVC.swift
//  PaynetOne
//
//  Created by Ngo Duy Nhat on 16/02/2022.
//

import UIKit

class SelectBusinessTVC: UITableViewCell {
    static let identifier = "SelectBusinessCell"
    
    let lbTitle = UILabel()
    let imgArrowRight: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "chevron.right")
        img.contentMode = .scaleAspectFit
        img.tintColor = .black
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func setupView(){
        contentView.addSubview(lbTitle)
        lbTitle.labelConstraints(top: contentView.topAnchor, marginTop: 12, left: contentView.leftAnchor, marginLeft: 20, bottom: contentView.bottomAnchor, marginBottom: -12)
        
        contentView.addSubview(imgArrowRight)
        imgArrowRight.viewConstraints(top: contentView.topAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
