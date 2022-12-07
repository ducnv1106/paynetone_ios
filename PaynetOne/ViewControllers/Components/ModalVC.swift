//
//  ModalVC.swift
//  PaynetOne
//
//  Created by vinatti on 11/01/2022.
//

import UIKit

class ModalVC: UIViewController {
    let maxDimmedAlpha: CGFloat = 0.6
    let defaultHeight: CGFloat = 300
    var currentContainerHeight: CGFloat = 300
    let dismissibleHeight: CGFloat = 200
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.buildPrimaryButton()
        button.setTitle(Strings.btnClose, for: .normal)
        return button
    }()
    
    var containerViewBottomConstraint: NSLayoutConstraint?
    var containerViewHeightConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupView()
        setupPanGesture()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
    
    func setupView(){
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        view.addSubview(closeButton)
        dimmedView.viewConstraints(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        containerView.viewConstraints(left: view.leftAnchor, right: view.rightAnchor)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    func animatePresentContainer(){
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    func animateShowDimmedView(){
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    func animateDismissView(){
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            self.view.layoutIfNeeded()
        }
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
    func setupPanGesture(){
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: view)
//        print("Pan gesture y offset: \(translation.y)")
        let isDraggingDown = translation.y > 0
//        print("Dragging direction: \(isDraggingDown ? "going down" : "going up")")
        let newHeight = currentContainerHeight + (-translation.y)
        switch gesture.state {
        case .changed:
            if newHeight < maximumContainerHeight {
                containerViewHeightConstraint?.constant = newHeight
                view.layoutIfNeeded()
            }
        case .ended:
            if newHeight < dismissibleHeight {
                self.animateDismissView()
            } else if newHeight < defaultHeight {
                animateContainerHeight(defaultHeight)
            } else if newHeight < maximumContainerHeight && isDraggingDown {
                animateContainerHeight(defaultHeight)
            } else if newHeight > defaultHeight && !isDraggingDown {
                animateContainerHeight(maximumContainerHeight)
            }
        default: break
        }
    }
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        }
        currentContainerHeight = height
    }
}
