//
//  PassCodeVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 20/08/2022.
//

import UIKit

class PassCodeVC: BaseUI {
    let passCode = PassCode()
    let btnShake = POMaker.makeButton(title: "Shakeeeee")
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI(){
        
        passCode.becomeFirstResponder()
        view.addSubview(passCode)
        passCode.viewConstraints(top: view.safeTopAnchor, left: view.leftAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 100, left: 14, bottom: 0, right: 14), size: CGSize(width: 0, height: 50))
        passCode.didFinishEnterCode = {code in
            print("----->>>>>>", code)
        }
        view.addSubview(btnShake)
        btnShake.viewConstraints(top: passCode.bottomAnchor, left: view.leftAnchor)
        btnShake.addTarget(self, action: #selector(shake), for: .touchUpInside)
    }
    
    @objc private func shake(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: passCode.center.x - 10, y: passCode.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: passCode.center.x + 10, y: passCode.center.y))
        passCode.layer.add(animation, forKey: "position")
    }
}
class PassCode: UIView {
    private let stack = POMaker.makeStackView(axis: .horizontal, spacing: 2)
    var didFinishEnterCode: ((String) -> Void)?
    var code = "" {
        didSet {
            updatePinStack(code)
            if code.count == maxLength, let didFinishEnterCode = didFinishEnterCode {
                self.resignFirstResponder()
                didFinishEnterCode(code)
            }
        }
    }
    var maxLength = 4
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stack)
        backgroundColor = .white
        updatePinStack(code)
        stack.viewConstraints(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        showKeyBoardIfNeeded()
    }
    
    private func emptyPin() -> UIView {
        let pin = PinCode()
        pin.pin.backgroundColor = .black.withAlphaComponent(0.4)
        return pin
    }
    private func pin() -> UIView {
        let pin = PinCode()
        pin.pin.backgroundColor = .green
        return pin
    }
    private func updatePinStack(_ code: String){
        var emptyPins: [UIView] = Array(0..<maxLength).map{_ in emptyPin()}
        let userPinLength = code.count
        let pins:[UIView] = Array(0..<userPinLength).map{_ in pin()}
        for (index, element) in pins.enumerated() {
            emptyPins[index] = element
        }
        stack.removeAllArrangeSubview()
        for view in emptyPins {
            stack.addArrangedSubview(view)
        }
    }
    override var canBecomeFirstResponder: Bool {
        return true
    }
    private func showKeyBoardIfNeeded(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(showKeyboard))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    @objc private func showKeyboard(){
        self.becomeFirstResponder()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PassCode: UIKeyInput {
    var hasText: Bool {
        return code.count > 0
    }
    func insertText(_ text: String) {
        if code.count == maxLength {
            return
        }
        code.append(contentsOf: text)
    }
    func deleteBackward() {
        if hasText {
            code.removeLast()
        }
    }
}
class PinCode: UIView{
    let pin = POMaker.makeView(backgroundColor: .black, radius: 10)
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(pin)
        pin.viewConstraints(size: CGSize(width: 20, height: 20), centerX: self.centerXAnchor, centerY: self.centerYAnchor)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension UIStackView {
    func removeAllArrangeSubview(){
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({$0.constraints}))
        removedSubviews.forEach({$0.removeFromSuperview()})
    }
}
