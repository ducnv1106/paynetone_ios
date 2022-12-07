//
//  SuccessPaymentVC.swift
//  PaynetOne
//
//  Created by Duoc Nguyen  on 01/12/2022.
//

import Foundation
import UIKit
import Lottie

class SuccessPaymentVC: BaseUI{
    private var animationView: LottieAnimationView!
    private var viewContent : UIView!
    private var lbTitle = POMaker.makeLabel(text: "Thông báo", font: .helvetica.withSize(18), color: .blueColor, alignment: .center)
    private var lbMessage = POMaker.makeLabel(text: "Chức năng đang trong quá trình phát triển.Vui lòng chọn chức năng khác", font: .helvetica.withSize(15), color: .black, alignment: .center)
    private var btnClose : UIButton!
    var callBackListener: CallbackListenerPayment!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        configUI()
        configBackgorundColor()
        
        
    }
    
    var message = "" {
        didSet{
            lbMessage.text = message
        }
    }
    var titile = ""{
        didSet{
            lbTitle.text = titile
        }
    }
    
    private func initUI(){
        viewContent = POMaker.makeView()
        btnClose = POMaker.makeButton(title: "ĐÓNG", font: .helvetica.withSize(15), color: .white, textAlignment: .center, backgroundColor: .blueColor, cornerRadius: 5)
    }
    
    
    
    private func configUI(){
        view.addSubview(viewContent)
        configAnimationView()
        
        viewContent.viewConstraints(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15))
        
        viewContent.addSubviews(views: lbTitle,lbMessage,btnClose,animationView)
        
        animationView.viewConstraints(top: viewContent.topAnchor, left: viewContent.leftAnchor, bottom: nil, right: viewContent.rightAnchor,padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        lbTitle.viewConstraints(top: animationView.bottomAnchor, left: viewContent.leftAnchor, bottom: nil, right: viewContent.rightAnchor,padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        
        lbMessage.viewConstraints(top: lbTitle.bottomAnchor, left: viewContent.leftAnchor, bottom: nil, right: viewContent.rightAnchor,padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        
        btnClose.viewConstraints(top: lbMessage.bottomAnchor, left: viewContent.leftAnchor, bottom: viewContent.bottomAnchor, right: viewContent.rightAnchor,padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
        btnClose.addTarget(self, action: #selector(onDissmiss), for: .touchUpInside)
        
        btnClose.height(40)
    }
    
    private func configAnimationView(){
        // 2. Start AnimationView with animation name (without extension)
        
        animationView = .init(name: "success")
        
        animationView.height(36)
        animationView.width(36)
        
        // 3. Set animation content mode
        
        animationView!.contentMode = .scaleAspectFit
        
        // 4. Set animation loop mode
        
        animationView!.loopMode = .playOnce
        
        // 5. Adjust animation speed
        
        animationView!.animationSpeed = 0.7
        
        // 6. Play animation
        
        animationView!.play()
        
    }
    
    override func configBackgorundColor() {
        if isDarkMode{
            view.applyViewDarkMode()
        }else{
            view.backgroundColor = .white
        }
    }
    
    @objc private func onDissmiss(){
        callBackListener.onClose()
        self.dismiss(animated: true)
        
    }
    

}
protocol CallbackListenerPayment{
    func onClose()
}
