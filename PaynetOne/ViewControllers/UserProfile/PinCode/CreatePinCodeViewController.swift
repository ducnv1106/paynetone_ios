//
//  CreatePinCodeViewController.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 03/10/2022.
//

import UIKit

class CreatePinCodeViewController: BaseUI {
    private var viewPinCode = POMaker.makeView(backgroundColor: .clear)
    private var lbInputPin = POMaker.makeLabel(text: "Nhập mã PIN", font: .helvetica.withSize(16), alignment: .center)
    private var pinField = PinFieldView()
    private var showHidePinBtn = POMaker.makeButtonIcon(imageName: "eye_showing", tintColor: .black)
    private var lbReInputPin = POMaker.makeLabel(text: "Nhập lại mã PIN", font: .helvetica.withSize(16), alignment: .center)
    private var rePinField = PinFieldView()
    private var showHideRePinBtn = POMaker.makeButtonIcon(imageName: "eye_showing", tintColor: .black)
    private var lbNote = POMaker.makeLabel(text: "Mã PIN là mã để mở khóa trước khi thực hiện các giao dịch với các dịch vụ giá trị gia tăng.", font: .helvetica.withSize(16), alignment: .center)
    private var btnConfirm = POMaker.makeButton(title: "Xác nhận")
    private var showHidePin = true {
        didSet {
            if showHidePin {
                
                if isDarkMode{
                    let image =  UIImage(named: "eye_showing")?.withTintColor(.white, renderingMode: .alwaysTemplate)
                    showHidePinBtn.setImage(image, for: .normal)
                }else{
                    let image =  UIImage(named: "eye_showing")?.withTintColor(.black, renderingMode: .alwaysTemplate)
                    showHidePinBtn.setImage(image, for: .normal)
                }
                
            } else {
                
                if isDarkMode{
                    let image =  UIImage(named: "eye_hidding")?.withTintColor(.white, renderingMode: .alwaysTemplate)
                    showHidePinBtn.setImage(image, for: .normal)
                }else{
                    let image =  UIImage(named: "eye_hidding")?.withTintColor(.black, renderingMode: .alwaysTemplate)
                    showHidePinBtn.setImage(image, for: .normal)
                }
                
            }
            pinField.isSecureTextEntry = showHidePin
        }
    }
    private var showHideRePin = true {
        didSet {
            if showHideRePin {
                
                if isDarkMode{
                    let image =  UIImage(named: "eye_showing")?.withTintColor(.white, renderingMode: .alwaysTemplate)
                    showHideRePinBtn.setImage(image, for: .normal)
                }else{
                    let image =  UIImage(named: "eye_showing")?.withTintColor(.black, renderingMode: .alwaysTemplate)
                    showHideRePinBtn.setImage(image, for: .normal)
                }
                
            } else {
                //                showHideRePinBtn.setImage(UIImage(named: "eye_hidding"), for: .normal)
                
                if isDarkMode{
                    let image =  UIImage(named: "eye_hidding")?.withTintColor(.white, renderingMode: .alwaysTemplate)
                    showHideRePinBtn.setImage(image, for: .normal)
                }else{
                    let image =  UIImage(named: "eye_hidding")?.withTintColor(.black, renderingMode: .alwaysTemplate)
                    showHideRePinBtn.setImage(image, for: .normal)
                }
            }
            rePinField.isSecureTextEntry = showHideRePin
        }
    }
    var password = ""
    private let userData = UserModel(JSONString:StoringService.shared.getData(Constants.userData))
    private var isTimerRunning = false
    private var timer = Timer()
    lazy var intProdSeconds = 180.0
    
    /*
     -- get otp --
     */
    private var viewGetOTP = POMaker.makeView(backgroundColor: .clear)
    
    private var lbMobileNumber = POMaker.makeLabel(text: "Số điện thoại *", font: .helvetica.withSize(15), color: .black, alignment: .left)
    var tfMobileNumber = POMaker.makeTextField(placeholder: "Nhập số điện thoại",font: .helvetica.withSize(15))
    private var lbOTP = POMaker.makeLabel(text: "OTP *", font: .helvetica.withSize(15), color: .black, alignment: .left)
    var tfOTP = POMaker.makeTextField(placeholder: "Nhập mã OTP",font: .helvetica.withSize(15))
    private var getOtpBtn = POMaker.makeButton(title: "Lấy OTP    ", font: .helvetica.withSize(15), color: .blueColor, backgroundColor: .clear )
    private var btnConfirmOtp = POMaker.makeButton(title: "Xác nhận")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (userData?.Pin ?? "").isEmpty {
            title = "TẠO MÃ PIN"
        }else{
            title = "ĐỔI MÃ PIN"
        }
        
        self.initUI()
        self.configUI()
        
        
        
    }
    
    
    private func initUI(){
        viewPinCode = POMaker.makeView(backgroundColor: .clear)
        lbInputPin = POMaker.makeLabel(text: "Nhập mã PIN", font: .helvetica.withSize(16), alignment: .center)
        pinField = PinFieldView()
        showHidePinBtn = POMaker.makeButtonIcon(imageName: "eye_showing", tintColor: .black)
        lbReInputPin = POMaker.makeLabel(text: "Nhập lại mã PIN", font: .helvetica.withSize(16), alignment: .center)
        rePinField = PinFieldView()
        showHideRePinBtn = POMaker.makeButtonIcon(imageName: "eye_showing", tintColor: .black)
        lbNote = POMaker.makeLabel(text: "Mã PIN là mã để mở khóa trước khi thực hiện các giao dịch với các dịch vụ giá trị gia tăng.", font: .helvetica.withSize(16), alignment: .center)
        btnConfirm = POMaker.makeButton(title: "Xác nhận")
        
        viewGetOTP = POMaker.makeView(backgroundColor: .clear)
        
        lbMobileNumber = POMaker.makeLabel(text: "Số điện thoại *", font: .helvetica.withSize(15), color: .black, alignment: .left)
        tfMobileNumber = POMaker.makeTextField(placeholder: "Nhập số điện thoại",font: .helvetica.withSize(15))
        lbOTP = POMaker.makeLabel(text: "OTP *", font: .helvetica.withSize(15), color: .black, alignment: .left)
        tfOTP = POMaker.makeTextField(placeholder: "Nhập mã OTP",font: .helvetica.withSize(15))
        getOtpBtn = POMaker.makeButton(title: "Lấy OTP    ", font: .helvetica.withSize(15), color: .blueColor, backgroundColor: .clear )
        btnConfirmOtp = POMaker.makeButton(title: "Xác nhận")
    }
    
    private func configUI(){
        view.addSubviews(views: viewPinCode,btnConfirm,viewGetOTP,btnConfirmOtp)
        viewPinCode.viewConstraints(top: view.safeTopAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor,padding: UIEdgeInsets(top: 20, left: 10, bottom:0, right: 10))
        
        viewPinCode.addSubviews(views: lbInputPin, pinField, lbReInputPin, rePinField, showHidePinBtn, showHideRePinBtn, lbNote)
        
        lbInputPin.safeTop(toView: viewPinCode, space: 30)
        lbInputPin.horizontal(toView: view)
        
        pinField.top(toAnchor: lbInputPin.bottomAnchor, space: 20)
        pinField.height(50)
        pinField.horizontal(toView: view, space: (screenWidth-250)/2)
        showHidePin = true
        pinField.font = .helvetica.withSize(28)
        pinField.count = 4
        pinField.digitBorderColorFocused = .borderColor
        
        lbReInputPin.top(toAnchor: pinField.bottomAnchor, space: 30)
        lbReInputPin.horizontal(toView: view)
        
        rePinField.top(toAnchor: lbReInputPin.bottomAnchor, space: 20)
        rePinField.horizontal(toView: view, space: (screenWidth-250)/2)
        rePinField.height(50)
        rePinField.count = 4
        showHideRePin = true
        rePinField.font = .helvetica.withSize(28)
        rePinField.count = 4
        rePinField.digitBorderColorFocused = .borderColor
        
        showHidePinBtn.left(toAnchor: pinField.rightAnchor, space: 10)
        showHidePinBtn.centerY(toView: pinField)
        showHidePinBtn.size(CGSize(width: 20, height: 20))
        showHidePinBtn.addTarget(self, action: #selector(showHidePin_touchUp), for: .touchUpInside)
        
        showHideRePinBtn.left(toAnchor: rePinField.rightAnchor, space: 10)
        showHideRePinBtn.centerY(toView: rePinField)
        showHideRePinBtn.size(CGSize(width: 20, height: 20))
        showHideRePinBtn.addTarget(self, action: #selector(showHideRePin_touchUp), for: .touchUpInside)
        
        lbNote.top(toAnchor: rePinField.bottomAnchor, space: 40)
        lbNote.horizontal(toView: view, space: 25)
        lbNote.bottom(toView: viewPinCode,space: 10)
        
        btnConfirm.horizontal(toView: view, space: 20)
        btnConfirm.safeBottom(toView: view, space: 10)
        btnConfirm.height(50)
        btnConfirm.addTarget(self, action: #selector(btnConfirm_touchUp), for: .touchUpInside)
        
        // view OTP
        viewGetOTP.viewConstraints(top: view.safeTopAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: UIEdgeInsets(top: 20, left: 10, bottom:0, right: 10))
        viewGetOTP.height(200)
        
        viewGetOTP.addSubview(lbMobileNumber)
        lbMobileNumber.viewConstraints(top: viewGetOTP.topAnchor, left: viewGetOTP.leftAnchor, bottom: nil, right: viewGetOTP.rightAnchor)
        lbMobileNumber.attributedText = "Số điện thoại *".attributedLastString()
        
        viewGetOTP.addSubview(tfMobileNumber)
        tfMobileNumber.viewConstraints(top: lbMobileNumber.bottomAnchor, left: viewGetOTP.leftAnchor, bottom: nil, right: viewGetOTP.rightAnchor,padding: UIEdgeInsets(top: 5, left: 0, bottom:0, right: 0))
        tfMobileNumber.height(35)
        tfMobileNumber.text = userData?.phoneNumber ?? ""
        tfMobileNumber.isUserInteractionEnabled = false
        tfMobileNumber.backgroundColor = .lightGray
        
        viewGetOTP.addSubview(lbOTP)
        lbOTP.viewConstraints(top: tfMobileNumber.bottomAnchor, left: viewGetOTP.leftAnchor, bottom: nil, right: viewGetOTP.rightAnchor,padding: UIEdgeInsets(top: 10, left: 0, bottom:0, right: 0))
        lbOTP.attributedText = "OTP *".attributedLastString()
        
        viewGetOTP.addSubview(tfOTP)
        tfOTP.viewConstraints(top: lbOTP.bottomAnchor, left: viewGetOTP.leftAnchor, bottom: nil, right: viewGetOTP.rightAnchor,padding: UIEdgeInsets(top: 5, left: 0, bottom:0, right: 0))
        tfOTP.height(35)
        tfOTP.keyboardType = .numberPad
        tfOTP.rightViewMode = .always
        tfOTP.delegate = self
        tfOTP.rightView = getOtpBtn
        getOtpBtn.addTarget(self, action: #selector(getOTP_TouchUpInside), for: .touchUpInside)
        
        btnConfirmOtp.viewConstraints(top: nil, left: view.leftAnchor, bottom: view.safeBottomAnchor, right: view.rightAnchor,padding: UIEdgeInsets(top: 0, left: 10, bottom:30, right: 10))
        btnConfirmOtp.height(50)
        btnConfirmOtp.addTarget(self, action: #selector(requestVerifyOtp), for: .touchUpInside)
        
        viewPinCode.isHidden = true
        btnConfirm.isHidden = true
        
    }
    @objc private func btnConfirm_touchUp(){
        if let pinText = pinField.text, let rePin = rePinField.text {
            if pinText.isEmpty {
                self.showToast(message: "Bạn chưa nhập mã PIN", delay: 2)
                return
            }
            if rePin.isEmpty {
                self.showToast(message: "Bạn chưa nhập lại mã PIN", delay: 2)
                return
            }
            if pinText != rePin {
                self.showToast(message: "mã PIN và nhập lại mã PIN không khớp", delay: 2)
                return
            }
            let rq = LoginCreatePinRequest()
            guard let user = StoringService.shared.getUserData() else {return}
            rq.pIN = pinText
            rq.empID = user.id ?? 0
            rq.mobileNumber = user.phoneNumber ?? ""
            rq.password = password
            let rqString = Utils.objToString(rq)
            self.showLoading()
            ApiManager.shared.requestObject(dataRq: rqString, code: "EMP_PIN_ADD", returnType: LoginCreatePinRes.self) { result, err in
                self.hideLoading()
                if result != nil {
                    StoringService.shared.saveData(user: "Y", key: "KEY_IS_EXST_PIN_CODE")
                    let vc = SuccessModalView()
                    self.popupWithView(vc: vc, okBtnTitle: "Đóng", okAction: {
                        self.navigationController?.popViewController(animated: true)
                    })
                } else {
                    self.showToast(message: err ?? "", delay: 2)
                }
            }
        }
    }
    @objc private func showHidePin_touchUp(){
        self.showHidePin = !showHidePin
    }
    @objc private func showHideRePin_touchUp(){
        self.showHideRePin = !showHideRePin
    }
    
    @objc private func getOTP_TouchUpInside(){
        dismissKeyboard()
        let rq = RequestOtp()
        let mobileNumber = userData?.phoneNumber ?? ""
        rq.mobileNumber = mobileNumber
        rq.otpType = "P"
        let rqString = Utils.objToString(rq)
        self.showLoading()
        ApiManager.shared.requestCodeMessage(dataRq: rqString, code: "EMP_GET_OTP") { code, message in
            self.hideLoading()
            if code == "00" {
                if self.isTimerRunning == false {
                    self.runProdTimer()
                }
                self.showToast(message: "Mã xác nhận được gửi đến số điện thoại \(mobileNumber) (kiểm tra cuộc gọi và ZALO)", delay: 2)
            } else {
                self.showToast(message: message ?? "", delay: 2)
            }
        }
    }
    
    @objc private func requestVerifyOtp(){
        let otp = tfOTP.text ?? ""
        if otp.isEmpty {
            self.showToast(message: "Vui lòng nhập mã OTP!", delay: 2)
            return
        }
        if otp.count < 6 {
            self.showToast(message: "OTP không hợp lệ, Vui lòng nhập lại!", delay: 2)
            return
        }
        
        dismissKeyboard()
        let rq = RequestVerifyOtp(mobileNumber: userData?.phoneNumber ?? "", otpValue: otp, otpType: "P")
        let rqString = Utils.objToString(rq)
        self.showLoading()
        ApiManager.shared.requestCodeMessage(dataRq: rqString, code: "EMP_OTP_VERIFY") { code, message in
            self.hideLoading()
            if code == "00" {
                self.viewGetOTP.isHidden = true
                self.btnConfirmOtp.isHidden = true
                self.viewPinCode.isHidden = false
                self.btnConfirm.isHidden = false
                
            } else {
                self.showToast(message: message ?? "", delay: 2)
            }
        }
        
        
    }
    
    //MARK: countdown OTP
    func runProdTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateProdTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    @objc func updateProdTimer() {
        if intProdSeconds < 2 {
            timer.invalidate()
            getOtpBtn.setTitle("Gửi lại mã OTP    ", for: .normal)
            
            isTimerRunning = false
            intProdSeconds = 180
        }
        else {
            intProdSeconds -= 1
            getOtpBtn.setTitle("\(prodTimeString(time: TimeInterval(intProdSeconds)))    ", for: .normal)
        }
    }
    func prodTimeString(time: TimeInterval) -> String {
        let prodMinutes = Int(time) / 60 % 60
        let prodSeconds = Int(time) % 60
        
        return String(format: "%02d:%02d", prodMinutes, prodSeconds)
    }
    func stopTimer(){
        timer.invalidate()
    }
    @objc func startTimer(){
        runProdTimer()
    }
}
class SuccessModalView: UIViewController {
    private let imgSuccess = POMaker.makeImage(image: "checked_success")
    private let titleSuccess = POMaker.makeLabel(text: "Thành công", font: .helvetica.withSize(18), color: .blueColor, alignment: .center)
    private let lbMessage = POMaker.makeLabel(text: "Bạn đã cài đặt mã PIN thành công!", font: .helvetica.withSize(16), alignment: .center)
    var message = "" {
        didSet {
            lbMessage.text = message
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(views: imgSuccess, titleSuccess, lbMessage)
        imgSuccess.top(toView: view, space: 30)
        imgSuccess.centerX(toView: view)
        imgSuccess.size(CGSize(width: 60, height: 60))
        
        titleSuccess.top(toAnchor: imgSuccess.bottomAnchor, space: 20)
        titleSuccess.horizontal(toView: view)
        
        lbMessage.top(toAnchor: titleSuccess.bottomAnchor, space: 16)
        lbMessage.horizontal(toView: view, space: 14)
        lbMessage.bottom(toView: view, space: 20)
        
        titleSuccess.textColor = .blueColor
        if isDarkMode{
            self.view.applyViewDarkMode()
        }else{
            self.view.backgroundColor = .white
        }
    }
}

extension CreatePinCodeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength = 0
        if textField == tfOTP {
            maxLength = 6
        }
        return textField.maxLength(range: range, string: string, max: maxLength)
    }
}
