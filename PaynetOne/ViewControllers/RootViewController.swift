//
//  RootViewController.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 07/07/2022.
//

import UIKit

class RootViewController: UIViewController {
    var navController = UINavigationController(rootViewController: DashboardVC())
    private var current: UIViewController
    
    init() {
        self.current = SplashViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }
    
    func switchToMain() {
        navController = UINavigationController(rootViewController: DashboardVC())
        animateFadeTransition(to: navController)
    }
    
    func switchToSplash() {
        animateDismissTransition(to: SplashViewController())
    }
    
    func switchToRegister() {
        navController = UINavigationController(rootViewController: LoginViewController())
        animateDismissTransition(to: navController)
    }
    
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
//        current.willMove(toParent: nil)
        addChild(new)
        transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {}) { _ in
            self.current.removeFromParent()
            self.view.addSubview(new.view)
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
    
    private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        let initialFrame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
        new.view.frame = initialFrame
        current.willMove(toParent: nil)
        addChild(new)
        transition(from: current, to: new, duration: 0.3, options: [], animations: {
            new.view.frame = self.view.bounds
        }) { _ in
            self.current.removeFromParent()
            self.view.addSubview(new.view)
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
    

}
