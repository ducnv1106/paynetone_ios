//
//  SelectTrueFalse.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 07/09/2022.
//

import UIKit

class SelectTruFalse: UIView {
    var isSelected = true {
        didSet {
            if isSelected {
                yesButtonImage.image = iconChoose
                yesButtonImage.tintColor = .blueColor
                noButtonImage.image = iconNoChoose
                noButtonImage.tintColor = .blueColor
            } else {
                yesButtonImage.image = iconNoChoose
                noButtonImage.image = iconChoose
                yesButtonImage.tintColor = .blueColor
                noButtonImage.tintColor = .blueColor
            }
        }
    }
    private let stackView = POMaker.makeStackView(axis: .horizontal, distri: .fillEqually)
    private let iconChoose = UIImage(named: "radio_checked")?.withRenderingMode(.alwaysTemplate)
    private let iconNoChoose = UIImage(named: "radio_uncheck")?.withRenderingMode(.alwaysTemplate)
    private let yesButton = UIButton()
    private let yesButtonImage = POMaker.makeImage(image: "radio_checked", tintColor: .blueColor)
    private let yesButtonTitle = POMaker.makeLabel(text: "Có", font: .helvetica.withSize(16), color: .blueColor)
    
    private let noButton = UIButton()
    private let noButtonImage = POMaker.makeImage(image: "radio_uncheck", tintColor: .blueColor)
    private let noButtonTitle = POMaker.makeLabel(text: "Không", font: .helvetica.withSize(16), color: .blueColor)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews(views: stackView)
        stackView.vertical(toView: self)
        stackView.horizontal(toView: self)

        yesButton.addSubviews(views: yesButtonImage, yesButtonTitle)
        yesButtonImage.vertical(toView: yesButton, space: 10)
        yesButtonImage.left(toView: yesButton)
        yesButtonTitle.centerY(toView: yesButton)
        yesButtonTitle.left(toAnchor: yesButtonImage.rightAnchor)
        yesButton.addTarget(self, action: #selector(yesButton_TouchUp), for: .touchUpInside)
        
        noButton.addSubviews(views: noButtonImage, noButtonTitle)
        noButtonImage.vertical(toView: noButton, space: 10)
        noButtonImage.left(toView: noButton)
        noButtonTitle.centerY(toView: noButton)
        noButtonTitle.left(toAnchor: noButtonImage.rightAnchor)
        noButton.addTarget(self, action: #selector(noButton_TouchUp), for: .touchUpInside)
        
        stackView.addArrangedSubview(yesButton)
        stackView.addArrangedSubview(noButton)
    }
    
    @objc private func yesButton_TouchUp(){
        isSelected = true
    }
    
    @objc private func noButton_TouchUp(){
        isSelected = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VerticalAlignedLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        var newRect = rect
        switch contentMode {
        case .top:
            newRect.size.height = sizeThatFits(rect.size).height
        case .bottom:
            let height = sizeThatFits(rect.size).height
            newRect.origin.y += rect.size.height - height
            newRect.size.height = height
        default:
            ()
        }
        
        super.drawText(in: newRect)
    }
}
