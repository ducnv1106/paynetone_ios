//
//  BannerPromotionCVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 30/08/2022.
//

import UIKit

class BannerPromotionCVC: UICollectionViewCell {
    private let viewTest = POMaker.makeView(backgroundColor: .red)
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(viewTest)
        viewTest.vertical(toView: contentView)
        viewTest.horizontal(toView: contentView)
        viewTest.size(CGSize(width: 0, height: 300))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
