//
//  AdaptableSizeButton.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 06/09/2022.
//

import UIKit

class AdaptableSizeButton: UIButton {
    var title = "" {
        didSet {
             
        }
    }
    override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude)) ?? .zero
        let desiredButtonSize = CGSize(width: labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right, height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)
        return desiredButtonSize
    }
}
