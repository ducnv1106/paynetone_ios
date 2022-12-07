//
//  UIImageView.swift
//  PaynetOne
//
//  Created by vinatti on 10/01/2022.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
//    func imgViewConstraint(top: NSLayoutYAxisAnchor? = nil, marginTop: CGFloat = 0.0, left: NSLayoutXAxisAnchor? = nil, marginLeft: CGFloat = 0.0, bottom: NSLayoutYAxisAnchor? = nil, marginBottom: CGFloat = 0.0,right: NSLayoutXAxisAnchor? = nil, marginRight: CGFloat = 0.0,size: CGSize = .zero, centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil, centerXOffset: CGFloat = 0, centerYOffset: CGFloat = 0){
//        var anchored = AnchorConstrain()
//        self.translatesAutoresizingMaskIntoConstraints = false
//        if let top = top {
//            anchored.top = topAnchor.constraint(equalTo: top, constant: marginTop)
//        }
//        if let left = left {
//            anchored.left = leftAnchor.constraint(equalTo: left, constant: marginLeft)
//        }
//        if let bottom = bottom {
//            anchored.bottom = bottomAnchor.constraint(equalTo: bottom, constant: marginBottom)
//        }
//        if let right = right {
//            anchored.right = rightAnchor.constraint(equalTo: right, constant: marginRight)
//        }
//        if size.width != 0 {
//            anchored.width = widthAnchor.constraint(equalToConstant: size.width)
//        }
//
//        if size.height != 0 {
//            anchored.height = heightAnchor.constraint(equalToConstant: size.height)
//        }
//        if let centerX = centerX {
//            anchored.centerX = centerXAnchor.constraint(equalTo: centerX, constant: centerXOffset)
//        }
//        if let centerY = centerY {
//            anchored.centerY = centerYAnchor.constraint(equalTo: centerY, constant: centerYOffset)
//        }
//        [anchored.top, anchored.left, anchored.bottom, anchored.right, anchored.width, anchored.height, anchored.centerX, anchored.centerY].forEach { $0?.isActive = true }
//    }
    func kfImage(urlStr: String) {
        var string = ""
        if urlStr.verifyUrl() {
            string = urlStr
        } else {
            string = Constants.imageUrl + urlStr
        }
        let replaceStr = string.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: replaceStr) else {return}
        self.kf.setImage(with: url)
    }
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
            let data = data, error == nil,
            let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

