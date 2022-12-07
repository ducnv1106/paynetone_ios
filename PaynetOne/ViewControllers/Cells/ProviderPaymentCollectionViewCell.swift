//
//  ProviderPaymentCollectionViewCell.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 06/04/2022.
//

import Foundation
import UIKit

class ProviderPaymentCollectionViewCell: UICollectionViewCell {
    
    let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    let title = POMaker.makeLabel()
    let iconChecked: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = .green
        return icon
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(image)
        image.viewConstraints(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0), size: CGSize(width: 55, height: 55))
        contentView.addSubview(title)
        title.viewConstraints(left: image.rightAnchor, right: contentView.rightAnchor, padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10), centerY: image.centerYAnchor)
        contentView.addSubview(iconChecked)
        iconChecked.viewConstraints(bottom: contentView.bottomAnchor, right: contentView.rightAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 20, height: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
