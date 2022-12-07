//
//  StatusView.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 24/08/2022.
//

import UIKit

class StatusView: UIView {
    let label = POMaker.makeLabel(color: .white)
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        backgroundColor = .clear
        label.viewConstraints(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, padding: UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10))
        layer.cornerRadius = 5
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
