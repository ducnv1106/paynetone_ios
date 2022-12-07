//
//  ButtonSelector.swift
//  PaynetOne
//
//  Created by vinatti on 11/02/2022.
//

import UIKit

class ButtonSelector: UIView {
    let lbTitle = UILabel()
    let imgRight = UIImageView()
    var tapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(lbTitle)
        lbTitle.textColor = Colors.placeholderColor
        lbTitle.labelConstraints(top: self.topAnchor, marginTop: 8, left: self.leftAnchor)
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: -5, y: 40, width: UIScreen.main.bounds.width - 30, height: 0.5)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        layer.addSublayer(bottomLine)
        imgRight.image = UIImage(systemName: "chevron.down")
        imgRight.tintColor = .gray
        addSubview(imgRight)
        imgRight.viewConstraints(right: self.rightAnchor, centerY: lbTitle.centerYAnchor)
//        imgViewConstraint(right: self.rightAnchor, centerY: lbTitle.centerYAnchor)
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapped))
        addGestureRecognizer(tap)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onTapped(){
        if let tapped = tapped {
            tapped()
        }
    }
}
