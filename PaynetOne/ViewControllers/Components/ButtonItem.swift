//
//  ButtonItem.swift
//  PaynetOne
//
//  Created by Ngo Duy Nhat on 25/02/2022.
//

import UIKit

class ButtonItem: UIView {

    let image = UIImageView()
    let label = UILabel()
    let rightImage = UIImageView()
    var onTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.addSubview(image)
        self.addSubview(label)
        self.addSubview(rightImage)
        label.textColor = .black

        image.viewConstraints(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, padding: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 0))
        label.labelConstraints(left: image.rightAnchor, marginLeft: 10, centerY: image.centerYAnchor)
        rightImage.image = UIImage(named: "arrow_right.png")
        rightImage.viewConstraints(right: self.rightAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -20), centerY: self.centerYAnchor)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onTappp))
        self.addGestureRecognizer(gesture)
        self.backgroundColor = .white
    }
    
    @objc func onTappp () {
        if let onTapped = onTapped {
            onTapped()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
