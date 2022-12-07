//
//  UIStackView.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 08/09/2022.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
