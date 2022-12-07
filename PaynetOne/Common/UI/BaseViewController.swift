//
//  BaseViewController.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 10/08/2022.
//

import UIKit
import SwiftTheme

class BaseViewController: UIViewController {
    var titleView :UIView!
    private var imageView :UIView!
    var imgTabbar :UIImageView!
    var lbTitleTabbar :UILabel!
    var isShowIcon = false
    var rightIcon = ""
    var rightBarAction:(() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isDarkMode{
            view.backgroundColor = .black
        }else{
            view.backgroundColor = .backgroundColor
            
        }
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.tintColor = .white
        initUITabBar()
        setupTabBar()
        
    }
    
     func initUITabBar(){
        titleView = POMaker.makeView(backgroundColor: .white.withAlphaComponent(0.0))
        imageView = POMaker.makeView(radius: 6)
        imgTabbar = POMaker.makeImageView(contentMode: .scaleAspectFit,backgroundColor: .white)
        lbTitleTabbar = POMaker.makeLabel(font: .helvetica.setBold().withSize(18),color: .white)
    }
    
     func setupTabBar(){
        
        titleView.addSubview(imageView)
        imageView.viewConstraints(top: titleView.topAnchor, left: titleView.leftAnchor, bottom: titleView.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0), size: CGSize(width: 30, height: 30))
        imageView.addSubview(imgTabbar)
        imgTabbar.viewConstraints(top: imageView.topAnchor, left: imageView.leftAnchor, bottom: imageView.bottomAnchor, right: imageView.rightAnchor)
        titleView.addSubview(lbTitleTabbar)
        lbTitleTabbar.viewConstraints(left: imageView.rightAnchor, right: titleView.rightAnchor, padding: UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0), centerY: titleView.centerYAnchor)
        navigationItem.titleView = titleView
        
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "nav-bar-back"), style: .plain, target: self, action: #selector(leftBarButtonTouchUpInside))
        leftBarButton.customView?.viewConstraints(size: CGSize(width: 22, height: 22))
        navigationItem.leftBarButtonItem = leftBarButton
        
    }
    @objc private func leftBarButtonTouchUpInside() {
        navigationController?.popViewController(animated: true)
    }
    
      
    
    func configBackgorundColor(){
        if isDarkMode {
            self.view.backgroundColor = .black
        }else{
            self.view.backgroundColor = .backgroundColor
        }
    }
}
