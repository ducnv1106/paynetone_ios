//
//  UIImage.swift
//  PaynetOne
//
//  Created by vinatti on 30/12/2021.
//

import Foundation
import UIKit
extension UIImage {
    public func resized(to target: CGSize) -> UIImage {
            let ratio = min(
                target.height / size.height, target.width / size.width
            )
            let new = CGSize(
                width: size.width * ratio, height: size.height * ratio
            )
            let renderer = UIGraphicsImageRenderer(size: new)
            return renderer.image { _ in
                self.draw(in: CGRect(origin: .zero, size: new))
            }
        }
}
