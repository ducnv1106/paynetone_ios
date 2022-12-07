//
//  UITableView.swift
//  PaynetOne
//
//  Created by vinatti on 11/01/2022.
//

import Foundation
import UIKit
extension UITableView {
    func tableConstraints(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero, centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil, centerXOffset: CGFloat = 0, centerYOffset: CGFloat = 0){
        self.translatesAutoresizingMaskIntoConstraints = false
        var anchored = AnchorConstrain()
        if let top = top {
            anchored.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }

        if let left = left {
            anchored.left = leftAnchor.constraint(equalTo: left, constant: padding.left)
        }

        if let bottom = bottom {
            anchored.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }

        if let right = right {
            anchored.right = rightAnchor.constraint(equalTo: right, constant: -padding.right)
        }

        if size.width != 0 {
            anchored.width = widthAnchor.constraint(equalToConstant: size.width)
        }

        if size.height != 0 {
            anchored.height = heightAnchor.constraint(equalToConstant: size.height)
        }

        if let centerX = centerX {
            anchored.centerX = centerXAnchor.constraint(equalTo: centerX, constant: centerXOffset)
        }

        if let centerY = centerY {
            anchored.centerY = centerYAnchor.constraint(equalTo: centerY, constant: centerYOffset)
        }
        [anchored.top, anchored.left, anchored.bottom, anchored.right, anchored.width, anchored.height, anchored.centerX, anchored.centerY].forEach { $0?.isActive = true }
    }
}
