//
//  InfoQRCreatedVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 15/08/2022.
//

import UIKit
import PopupDialog

class InfoQRCreatedVC: BaseViewController {
    private var lbTopTitle :UILabel!
    private var btnAppsSupport : UIButton!
    private var lbOrderCode :UILabel!
    private var qrCodeBackground :UIImageView!
    private var imgLogoProvider :UIImageView!
    private var lbAmountPayment :UILabel!
    private var logoNameView :UIView!
    private var bottomLogoView :UIView!
    private var bottomLogo :UIImageView!
    private var bottomName :UILabel!
    private var imgQrCode : UIImageView!
    private var scrollView :UIScrollView!
    private var checkStatusButton : UIButton!
    
    var model = ProviderLocal()
    var amount = 0
    var qrCode = CreateQRCodeResponse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgTabbar.kfImage(urlStr: model.icon)
        self.lbTitleTabbar.text = model.name
        self.isShowIcon = true
        view.backgroundColor = .white
        self.titleView.backgroundColor = .blueColor
        
        let rightBar = UIBarButtonItem(image: UIImage(named: "close_icon")?.resized(to: CGSize(width: 20, height: 20)), style: .plain, target: self, action: #selector(goToHome_TouchUP))
        navigationItem.rightBarButtonItem = rightBar
        initUI()
        setupInfoView()
        setupQrCodeView()
        SwiftEventBus.onMainThread(self, name: "PAYMENT_SUCCESS") { result in
            let message  = result==nil ? "" : result!.object as? String
            
            let vc = PaymentQRSuccessVC()
            vc.message = message ?? ""
            print("PaymentQRSuccessVC",message)
//            let popup = PopupDialog(viewController: vc,
//                                    buttonAlignment: .horizontal,
//                                    transitionStyle: .fadeIn,
//                                    tapGestureDismissal: true,
//                                    panGestureDismissal: true)
//
//            self.present(popup, animated: true, completion: nil)
            
            
            
            self.popupWithView(vc: vc, okBtnTitle: "Đóng")
        }
//        SwiftEventBus.onMainThread(<#T##target: AnyObject##AnyObject#>, name: <#T##String#>, handler: <#T##((Notification?) -> Void)##((Notification?) -> Void)##(Notification?) -> Void#>)
        configBackgorundColor()
    }
    
    override func configBackgorundColor() {
        if isDarkMode{
            self.view.backgroundColor = .black
        }else{
            self.view.backgroundColor = .white
        }
    }
    
    private func initUI(){
        lbTopTitle = POMaker.makeLabel(font: .helvetica.setBold().withSize(18), color: .textBlack, alignment: .center)
        btnAppsSupport = POMaker.makeButton(font: .helvetica.setItalic(), textAlignment: .center, backgroundColor: .white.withAlphaComponent(0))
        lbOrderCode = POMaker.makeLabel(font: .helvetica.withSize(16),color: .textColor, alignment: .center)
        qrCodeBackground = POMaker.makeImageView(image: UIImage(named: "qrcode_border"))
        imgLogoProvider = POMaker.makeImageView(contentMode: .scaleAspectFit)
        lbAmountPayment = POMaker.makeLabel(font: .helvetica.withSize(22).setBold(), color: .textBlack, alignment: .center)
        logoNameView = POMaker.makeView()
        bottomLogoView = POMaker.makeView(borderWidth: 0.8, borderColor: .blueColor, radius: 10)
        bottomLogo = POMaker.makeImageView(contentMode: .scaleAspectFit)
        bottomName = POMaker.makeLabel()
        imgQrCode = POMaker.makeImageView(contentMode: .scaleAspectFit)
        scrollView = POMaker.makeScrollView()
        checkStatusButton = POMaker.makeButton(title: "Trạng thái thanh toán", color: .white, textAlignment: .center)
    }
    @objc private func goToHome_TouchUP(){
        popToViewController(navigationController: navigationController!, className: DashboardVC.self)
    }
    private func setupInfoView(){
        view.addSubview(scrollView)
        scrollView.viewConstraints(top: view.safeTopAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        scrollView.addSubview(lbTopTitle)
        lbTopTitle.viewConstraints(top: scrollView.topAnchor, left: view.leftAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 24, left: 14, bottom: 0, right: 14))
        lbTopTitle.text = "Sử dụng ứng dụng \(model.name) để thanh toán"
        
        scrollView.addSubview(btnAppsSupport)
        btnAppsSupport.viewConstraints(top: lbTopTitle.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14))
        
        scrollView.addSubview(lbOrderCode)
        lbOrderCode.viewConstraints(top: btnAppsSupport.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
        
        var appName = ""
        if model.paymentType == 6 {
            appName = model.name
        } else if model.paymentType == 8 {
            appName = "VietQR"
        } else {
            btnAppsSupport.isHidden = true
            lbOrderCode.viewConstraints(top: lbTopTitle.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
        }
        let text = "Các ứng dụng hỗ trợ \(appName)"
        let attributedString = NSMutableAttributedString.init(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
        btnAppsSupport.setAttributedTitle(attributedString, for: .normal)
        btnAppsSupport.titleLabel?.textColor = .blueColor
        btnAppsSupport.addTarget(self, action: #selector(btnAppsSupport_touchUp), for: .touchUpInside)
        
        lbOrderCode.text = "Mã đơn hàng: \(qrCode.orderCode)"
    }
    
    @objc private func btnAppsSupport_touchUp(){
        let vc = ListAppSupportVC()
        vc.model = model
        self.popupWithView(vc: vc, okBtnTitle: "Đóng")
    }
    
    private func setupQrCodeView(){
        scrollView.addSubview(qrCodeBackground)
        qrCodeBackground.viewConstraints(top: lbOrderCode.bottomAnchor, padding: UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0), size: CGSize(width: screenWidth*0.8, height: screenWidth*0.8), centerX: view.centerXAnchor)
        scrollView.addSubview(imgLogoProvider)
        imgLogoProvider.kfImage(urlStr: model.icon)//downloaded(from: Constants.imageUrl + model.icon)
        imgLogoProvider.viewConstraints(top: qrCodeBackground.topAnchor, padding: UIEdgeInsets(top: -25, left: 0, bottom: 0, right: 0), size: CGSize(width: screenWidth*0.5, height: 50), centerX: qrCodeBackground.centerXAnchor)
        scrollView.addSubview(lbAmountPayment)
        lbAmountPayment.viewConstraints(top: qrCodeBackground.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
        lbAmountPayment.text = Utils.formatCurrency(amount: amount)
        
        scrollView.addSubview(logoNameView)
        logoNameView.viewConstraints(top: lbAmountPayment.bottomAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), centerX: view.centerXAnchor)
        logoNameView.addSubview(bottomLogoView)
        bottomLogoView.viewConstraints(top: logoNameView.topAnchor, left: logoNameView.leftAnchor, bottom: logoNameView.bottomAnchor, size: CGSize(width: 50, height: 50))
        bottomLogoView.addSubview(bottomLogo)
        bottomLogo.viewConstraints(top: bottomLogoView.topAnchor, left: bottomLogoView.leftAnchor, bottom: bottomLogoView.bottomAnchor, right: bottomLogoView.rightAnchor, padding: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        bottomLogo.kfImage(urlStr: model.icon)//downloaded(from: Constants.imageUrl + model.icon)
        logoNameView.addSubview(bottomName)
        bottomName.viewConstraints(left: bottomLogoView.rightAnchor, right: logoNameView.rightAnchor, padding: UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0), centerY: logoNameView.centerYAnchor)
        bottomName.text = model.name
        
        scrollView.addSubview(imgQrCode)
        imgQrCode.viewConstraints(top: imgLogoProvider.bottomAnchor, left: qrCodeBackground.leftAnchor, bottom: qrCodeBackground.bottomAnchor, right: qrCodeBackground.rightAnchor, padding: UIEdgeInsets(top: 10, left: 14, bottom: 14, right: 14))
        
        if qrCode.returnURL.verifyUrl() {
            if model.id == 3 {
                guard let image: UIImage = Utils.generateQRCode(string: qrCode.returnURL) else {return}
                imgQrCode.image = image
            } else {
                imgQrCode.downloaded(from: qrCode.returnURL)
            }
        } else {
            guard let image: UIImage = Utils.generateQRCode(string: qrCode.returnURL) else {return}
            imgQrCode.image = image
        }
        
        scrollView.addSubview(checkStatusButton)
        checkStatusButton.viewConstraints(top: logoNameView.bottomAnchor, left: view.leftAnchor, bottom: scrollView.bottomAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14), size: CGSize(width: 0, height: 50))
        checkStatusButton.addTarget(self, action: #selector(checkStatusOrder_touchUp), for: .touchUpInside)
    }
    
    @objc private func checkStatusOrder_touchUp(){
        let rq = OrderGetByCodeModel()
        rq.code = qrCode.orderCode
        let rqString = Utils.objToString(rq)
        self.showLoading()
        ApiManager.shared.requestObject(dataRq: rqString, code: "ORDER_GET_BY_CODE", returnType: StatusOrderModel.self) { result, err in
            self.hideLoading()
            if let result = result {
                let vc = PaymentStatusQRCodeVC()
                vc.model = result
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: false)
            } else {
                self.showToast(message: err ?? "", delay: 2)
            }
        }
    }
}
class PaymentQRSuccessVC: UIViewController {
    private let imgSuccess = POMaker.makeImage(image: "checked_fill")
    private let lbSuccess = POMaker.makeLabel(text: "Thành công", font: .helvetica.setBold().withSize(18), color: .blueColor, alignment: .center)
    private let lbOrderSuccess = POMaker.makeLabel(font: .helvetica.withSize(16), color: .textColor, alignment: .center)
//    var orderCode = ""
    var message = "" {
        didSet{
            lbOrderSuccess.text = message
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imgSuccess)
        imgSuccess.viewConstraints(top: view.topAnchor, padding: UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0), size: CGSize(width: 50, height: 50), centerX: view.centerXAnchor)
        view.addSubview(lbSuccess)
        lbSuccess.viewConstraints(top: imgSuccess.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
        view.addSubview(lbOrderSuccess)
        lbOrderSuccess.viewConstraints(top: lbSuccess.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14))
        
        lbSuccess.textColor = .blueColor
        if isDarkMode {
            self.view.applyViewDarkMode()
        }else{
            self.view.backgroundColor = .white
        }
        lbOrderSuccess.text = message
      
    }
}
