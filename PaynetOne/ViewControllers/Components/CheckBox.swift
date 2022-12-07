//
//  CheckBox.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 05/09/2022.
//

import UIKit

class CheckBox: UIButton {
    let checkedImage = UIImage(named: "checked")
    let uncheckedImage = UIImage(named: "uncheck")
    
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: .touchUpInside)
        self.setImage(uncheckedImage, for: .normal)
    }
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
