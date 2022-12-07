//
//  ProviderCollectionViewCell.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 12/08/2022.
//

import UIKit

class QRPaymentCollectionViewCell: UICollectionViewCell {
    private let logoView = POMaker.makeView(backgroundColor: .white, borderWidth: 0.5, borderColor: .blueColor, radius: 14)
    private let imgLogo = POMaker.makeImageView(contentMode: .scaleAspectFit)
    private let lbName = POMaker.makeLabel(font: .helvetica.withSize(12),color: .textColor, alignment: .center, line: 2)
    
    var model = ProviderLocal(){
        didSet{
            if model.id == 51094 {
                imgLogo.image = UIImage(named: model.icon)
            } else {
                imgLogo.kfImage(urlStr: model.icon)
            }
            
            if model.isActive == "N"{
                if isDarkMode{
                    logoView.backgroundColor = .grey
                    logoView.alpha = 0.45
                    imgLogo.addoverlay(color: .grey, alpha: 0.45)
                    lbName.textColor = .white
                    lbName.alpha = 0.45
                }else{
//                    logoView.backgroundColor = .grey
//                    logoView.alpha = 0.15
                    logoView.addoverlay(color: .grey, alpha: 0.45)
                    lbName.textColor = .grey
//                    lbName.alpha = 0.15
                }
             
            }
            lbName.text = model.name
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(logoView)
        logoView.viewConstraints(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, padding: UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6), size: CGSize(width: 0, height: contentView.bounds.width-12))
        
        logoView.addSubview(imgLogo)
        imgLogo.viewConstraints(top: logoView.topAnchor, left: logoView.leftAnchor, bottom: logoView.bottomAnchor, right: logoView.rightAnchor, padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        contentView.addSubview(lbName)
        lbName.viewConstraints(top: logoView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, padding: UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ProviderSectionHeader: UICollectionReusableView {
    let lbSectionHeader = POMaker.makeLabel(font: .helvetica.withSize(16).setBold(), color: .textGray2)
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(lbSectionHeader)
        lbSectionHeader.viewConstraints(top: topAnchor, left: leftAnchor, padding: UIEdgeInsets(top: 12, left: 10, bottom: 4, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AddOnServiceCollectionViewCell: UICollectionViewCell {
    private let imgLogo = POMaker.makeImageView(contentMode: .scaleAspectFit)
    private let lbName = POMaker.makeLabel(font: .helvetica.withSize(12),color: .textColor, alignment: .center)
    
    var model = ProviderLocal(){
        didSet{
            imgLogo.kfImage(urlStr: model.icon)
            lbName.text = model.name
            
            if model.isActive == "N"{
                if isDarkMode{
                    imgLogo.addoverlay(color: .black, alpha: 0.65)
                    lbName.textColor = .white
                    lbName.alpha = 0.65
                }else{
                    imgLogo.addoverlay(color: .grey, alpha: 0.45)
                    lbName.textColor = .grey
                }
               
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imgLogo)
        imgLogo.viewConstraints(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, padding: UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6), size: CGSize(width: 0, height: contentView.bounds.width-12))
        
        contentView.addSubview(lbName)
        lbName.viewConstraints(top: imgLogo.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, padding: UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
