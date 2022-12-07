//
//  RechargeLimitVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 17/08/2022.
//

import UIKit
import PopupDialog
import SwiftTheme

class RechargeLimitVC: BaseUI {
    private var limitView: UIView!
    private var lbLimitTitle : UILabel!
    private var lbLimitValue : UILabel!
    private var btnWalletDeposit : MethodDeposit!
    private var btnBankDeposit :MethodDeposit!
    private var btnTutorial : UILabel!
    private var btnHanMucDoiSoat : MethodDeposit!
    
    private var btnNode : UILabel!
    
    var limitAmount = 0
    var storeModel: HanMucCuaHangList?
    
    var code: String = ""
    var provinceCode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "NẠP HẠN MỨC"
        setViewLimit()
        setMethodDepSelect()
        if !Configs.isAdmin() {
            btnHanMucDoiSoat.isHidden = true
            btnHanMucDoiSoat.height(0)
        }
        getAddressByPaynetId()
    }
    
    
    private func setViewLimit(){
        limitView = POMaker.makeView(backgroundColor: .white)
        lbLimitTitle = POMaker.makeLabel(text: "Hạn mức", font: .helvetica.withSize(16))
        lbLimitValue  = POMaker.makeLabel(font: .helvetica.withSize(16).setBold(), color: .red)
        view.addSubview(limitView)
        
        if StoringService.shared.isDarkMode(){
            limitView.applyViewDarkMode()
            limitView.viewConstraints(top: view.safeTopAnchor, left: view.leftAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15))
            lbLimitTitle.textColor = .white
            
        }else{
            limitView.viewConstraints(top: view.safeTopAnchor, left: view.leftAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        }
        
        limitView.addSubview(lbLimitTitle)
        lbLimitTitle.viewConstraints(top: limitView.topAnchor, left: limitView.leftAnchor, bottom: limitView.bottomAnchor, padding: UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 0))
        
        limitView.addSubview(lbLimitValue)
        lbLimitValue.viewConstraints(right: limitView.rightAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 14), centerY: lbLimitTitle.centerYAnchor)
        lbLimitValue.text = Utils.formatCurrency(amount: limitAmount)
    }
    private func setMethodDepSelect(){
        btnWalletDeposit =  MethodDeposit(icon: "wallet_deposit", text: "Nạp hạn mức qua Tài khoản ví điện tử\n(MoMo, Viettel Money, ZaloPay)")
        
        btnBankDeposit = MethodDeposit(icon: "bank_deposit", text: "Nạp hạn mức qua tài khoản ngân hàng Paynet Việt Nam")
        
        btnHanMucDoiSoat = MethodDeposit(icon: "ic_han_muc_doi_soat", text: "Nạp hạn mức từ tiền đã đối soát")
        
        btnTutorial = POMaker.makeLabel(text: "Hướng dẫn nạp tiền", font: .helvetica.setItalic(), color: .darkRed, underLine: true)
        
        btnNode = POMaker.makeLabel(text: "", font: .helvetica.setItalic(), color: .blueColor, alignment: .center, underLine: true)
        
        view.addSubviews(views: btnBankDeposit, btnHanMucDoiSoat, btnWalletDeposit, btnTutorial,btnNode)
        btnBankDeposit.top(toAnchor: limitView.bottomAnchor, space: 14)
        btnBankDeposit.horizontal(toView: view, space: 14)
        btnBankDeposit.action = confirm_bankDeposit
        
        btnHanMucDoiSoat.top(toAnchor: btnBankDeposit.bottomAnchor, space: 10)
        btnHanMucDoiSoat.horizontal(toView: view, space: 14)
        btnHanMucDoiSoat.action = {
            let vc = WithdrawVC()
            vc.isSelectTaiKhoan = true
            vc.isNapHM = true
            if self.storeModel != nil {
                vc.storeModel = self.storeModel
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        btnWalletDeposit.top(toAnchor: btnHanMucDoiSoat.bottomAnchor, space: 10)
        btnWalletDeposit.horizontal(toView: view, space: 14)
        btnWalletDeposit.action = walletDepositTouchUp
        
        btnTutorial.top(toAnchor: btnWalletDeposit.bottomAnchor, space: 18)
        btnTutorial.centerX(toView: view)
        btnTutorial.isUserInteractionEnabled = true
        btnTutorial.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bank_touchup)))
        
        btnNode.top(toAnchor: btnTutorial.bottomAnchor,space: 10)
        btnNode.left(toAnchor: view.leftAnchor,space: 20)
        btnNode.viewConstraints(top: btnTutorial.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15))
        btnNode.centerX(toView: view)
        let htmlText = """
            Trong vòng 24h làm việc nếu không nhận được <br/>hạn mức, quý khách vui lòng liên hệ hotline <br/>+<u>84 93 173 98 89</u> để được hỗ trợ
        """
        btnNode.attributedText = htmlText.htmlToAttributedString
        btnNode.textColor = .blueColor
        btnNode.font = .helvetica.setItalic()
        btnNode.textAlignment = .center
        btnNode.isUserInteractionEnabled = true
        btnNode.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(callPhone)))
        
        
        
    }
    
    private func getAddressByPaynetId(){
        let user = StoringService.shared.getUserData()
        let rq = GetAddressByPaynetIdRq()
        rq.id = user?.paynetId ?? 0
        let rqString = Utils.objToString(rq)
        
        ApiManager.shared.requestObject(dataRq: rqString, code: "DIC_GET_ADDRESS_BY_PAYNETID", returnType: GetAddressByPaynetIdRes.self) { result, err in
            if let result = result {
                let objString = Utils.objToString(result)
                StoringService.shared.saveData(user: objString, key: "ADDRESS_BY_PAYNETID")
            }
        }
    }
    
    @objc private func bank_touchup(){
        let address = StoringService.shared.getAddress()
        if provinceCode.isEmpty {
            self.provinceCode = address?.ProvinceCode.count == 1 ? "0\(address?.ProvinceCode ?? "")" : (address?.ProvinceCode ?? "")
        }else if provinceCode.count < 2 {
            self.provinceCode = "0\(provinceCode)"
        }
        
        var synxNapHanMuc = ""
        if code.isEmpty{
            synxNapHanMuc = "NAPHM <Mã tài khoản hạn mức>"
        }else{
            synxNapHanMuc = "NAPHM \(self.provinceCode)\(code)"
        }
        
        let vc = GuideRechargeVC()
        vc.contentPayment = synxNapHanMuc
        let popup = PopupDialog(viewController: vc,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: false,
                                panGestureDismissal: false)
        self.present(popup, animated: true, completion: nil)
    }
    @objc private func callPhone(){
        callNumber(phoneNumber: "+84931739889")
    }
    private func confirm_bankDeposit(){
        let vc = PaynetBankListVC()
        vc.code = self.code
        vc.provinceCode = self.provinceCode
        navigationController?.pushViewController(vc, animated: true)
    }
    private func walletDepositTouchUp(){
        self.showPopupDevelop()
    }
}
class MethodDeposit: UIButton {
    private let imgIcon = POMaker.makeImage()
    private let lbText = POMaker.makeLabel(alignment: .center)
    private let rightIcon = POMaker.makeImage(image: "arrow-right")
    var action: (() -> ())?
    convenience init(icon: String, text: String){
        self.init()
        backgroundColor = .white
        layer.cornerRadius = 5
        self.buildShadow()
        addSubview(imgIcon)
        imgIcon.viewConstraints(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, padding: UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 0), size: CGSize(width: 50, height: 50))
        addSubview(rightIcon)
        rightIcon.viewConstraints(right: rightAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10), size: CGSize(width: 22, height: 22), centerY: centerYAnchor)
        addSubview(lbText)
        lbText.viewConstraints(left: imgIcon.rightAnchor, right: rightIcon.leftAnchor, padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10), centerY: centerYAnchor)
        imgIcon.image = UIImage(named: icon)
        lbText.text = text
        addTarget(self, action: #selector(button_touchUp), for: .touchUpInside)
        configThemeView()
    }
    
    private func configThemeView(){
        if isDarkMode{
            self.applyViewDarkMode()
        }
    }
    
    @objc private func button_touchUp(){
        if let action = action {
            action()
        }
    }
}
