//
//  SelectBankTVC.swift
//  PaynetOne
//
//  Created by Ngo Duy Nhat on 18/02/2022.
//

import UIKit

class SelectBankTVC: UITableViewCell {
    static let identifier = "SelectBankCell"
    
    let lbShortName = UILabel()
    let lbName: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.textColor = Colors.textGray
        return lb
    }()
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
        contentView.addSubview(lbShortName)
        contentView.addSubview(imgArrowRight)
        contentView.addSubview(lbName)
        lbShortName.labelConstraints(top: contentView.topAnchor, marginTop: 12, left: contentView.leftAnchor, marginLeft: 20)
        imgArrowRight.viewConstraints(top: contentView.topAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20))
        lbName.labelConstraints(top: lbShortName.bottomAnchor, marginTop: 6, left: contentView.leftAnchor, marginLeft: 20, bottom: contentView.bottomAnchor, marginBottom: -12, right: imgArrowRight.leftAnchor, marginRight: -10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
