//
//  ContactViewController.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 30/08/2022.
//

import UIKit
import SwiftTheme

class ContactViewController: BaseUI {
    private var lbCompanyName : UILabel!
    private var imgMail : UIImageView!
    private var lbMail : UILabel!
    private var imgPhoneCall : UIImageView!
    private var lbPhoneNumber : UILabel!
    private var imgFacebook : UIImageView!
    private var lbFacebookUrl : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        configUI()
        configBackgorundColor()
    }
    
    private func configUI(){
        view.addSubviews(views: lbCompanyName, imgMail, lbMail, imgPhoneCall, lbPhoneNumber, imgFacebook, lbFacebookUrl)
        lbCompanyName.top(toView: view, space: 14)
        lbCompanyName.horizontal(toView: view, space: 14)
        
        imgMail.top(toAnchor: lbCompanyName.bottomAnchor, space: 16)
        imgMail.left(toView: view, space: 14)
        imgMail.size(CGSize(width: 26, height: 26))
        
        lbMail.left(toAnchor: imgMail.rightAnchor, space: 14)
        lbMail.centerY(toView: imgMail)
        
        imgPhoneCall.top(toAnchor: imgMail.bottomAnchor, space: 10)
        imgPhoneCall.left(toView: view, space: 14)
        imgPhoneCall.size(CGSize(width: 26, height: 26))
        lbPhoneNumber.left(toAnchor: imgPhoneCall.rightAnchor, space: 14)
        lbPhoneNumber.centerY(toView: imgPhoneCall)
        
        imgFacebook.top(toAnchor: imgPhoneCall.bottomAnchor, space: 10)
        imgFacebook.bottom(toView: view, space: 16)
        imgFacebook.left(toView: view, space: 14)
        imgFacebook.size(CGSize(width: 26, height: 26))
        lbFacebookUrl.left(toAnchor: imgFacebook.rightAnchor, space: 14)
        lbFacebookUrl.right(toView: view, space: 10)
        lbFacebookUrl.centerY(toView: imgFacebook)
        
        lbPhoneNumber.isUserInteractionEnabled = true
        lbPhoneNumber.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(phoneCall_touchUp)))
        
        lbMail.isUserInteractionEnabled = true
        lbMail.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(email_touchUp)))
        
        lbFacebookUrl.isUserInteractionEnabled = true
        lbFacebookUrl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(facebook_touchUp)))
    }
    
    private func initUI(){
        lbCompanyName = POMaker.makeLabel(text: "CÔNG TY CỔ PHẦN MẠNG THANH TOÁN PAYNET VIỆT NAM", font: .helvetica.desetBold().withSize(16), alignment: .center)
        imgMail = POMaker.makeImage(image: "email_icon", tintColor: .blueColor)
        lbMail = POMaker.makeLabel(text: "hotro@paynetvn.com")
        imgPhoneCall = POMaker.makeImage(image: "call_fill_icon", tintColor: .blueColor)
        lbPhoneNumber = POMaker.makeLabel(text: "+84 93 173 98 89")
        imgFacebook = POMaker.makeImage(image: "facebook_icon", tintColor: .blueColor)
        lbFacebookUrl = POMaker.makeLabel(text: "https://www.facebook.com/paynetvnn")
    }
    override func configBackgorundColor() {
        if isDarkMode{
            view.applyViewDarkMode()
        }else{
            view.backgroundColor = .backgroundColor
        }
    }
    
    
    @objc private func phoneCall_touchUp(){
        callNumber(phoneNumber: "+84931739889")
    }
    
    @objc private func email_touchUp(){
        mailTo(email: "hotro@paynetvn.com")
    }
    
    @objc private func facebook_touchUp(){
        openLink(link: "https://www.facebook.com/paynetvnn")
    }
}
