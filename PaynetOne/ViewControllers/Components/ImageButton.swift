//
//  ImageButton.swift
//  PaynetOne
//
//  Created by vinatti on 29/12/2021.
//

import Foundation
import UIKit

class ImageButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(title: String, image: String) {
        super.init(frame: .zero)
        let btnImage = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
        setImage(btnImage, for: .normal)
        tintColor = Colors.primaryColor
        setTitle(title, for: .normal)
        
        setTitleColor(UIColor.black, for: .normal)
        backgroundColor = .white
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        layer.shadowOpacity = 2.0
        layer.shadowRadius = 10.0
        layer.masksToBounds = false
        layer.cornerRadius = 10
//        if #available(iOS 15.0, *) {
//            configuration = self.centerVertically()
//        } else {
        alignVertical(spacing: 10, lang: "")
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
