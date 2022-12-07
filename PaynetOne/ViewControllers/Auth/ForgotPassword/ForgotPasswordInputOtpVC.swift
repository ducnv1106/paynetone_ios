//
//  ForgotPasswordInputOtpVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 13/09/2022.
//

import UIKit
import SwiftTheme

class ForgotPasswordInputOtpVC: BaseUI {
    private var lbTitle = POMaker.makeLabel(font: .helvetica.withSize(16), alignment: .center)
    private var otpField :OTPFieldView!
    private var lbNotReceived :UILabel!
    private var btnResendOtp :UIButton!
    private var btnConfirm :UIButton!

    var mobileNumber = "" {
        didSet{
            lbTitle.attributedText = "Nhập mã xác thực\nQuý khách vui lòng nhập mã OTP đã được gửi về Zalo hoặc tin nhắn vào số điện thoại \(mobileNumber).".attributed(location: 11, length: 10)
        }
    }
    private var isTimerRunning = false
    private var timer = Timer()
    lazy var intProdSeconds = 180.0
    var currentBackgroundDate = NSDate()
    var otp = ""
    var hasEntered = false
    var btnBottomConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        title = "Quên mật khẩu"
        setupView()
        if self.isTimerRunning == false {
            self.startTimer()
        }
        lbTitle.attributedText = "Nhập mã xác thực\nQuý khách vui lòng nhập mã OTP đã được gửi về Zalo hoặc tin nhắn vào số điện thoại \(mobileNumber).".attributed(location: 11, length: 10)
        NotificationCenter.default.addObserver(self, selector: #selector(pauseApp), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(inactiveApp), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func initUI(){
        lbTitle = POMaker.makeLabel(font: .helvetica.withSize(16), alignment: .center)
        otpField = OTPFieldView()
         lbNotReceived = POMaker.makeLabel(text: "Bạn không nhận được mã OTP?", font: .helvetica.withSize(16))
         btnResendOtp = POMaker.makeButton(title: "Gửi lại mã sau: 03:00",font: .helvetica.withSize(16), color: .blueColor, backgroundColor: .clear)
         btnConfirm = POMaker.makeButton(title: "Xác nhận", backgroundColor: .gray.withAlphaComponent(0.6))
    }
    
    
    @objc private func pauseApp(){
        stopTimer()
        currentBackgroundDate = NSDate()
    }
    @objc private func inactiveApp(){
        let diff = currentBackgroundDate.timeIntervalSince(NSDate() as Date)
        intProdSeconds += diff
        if isTimerRunning {
            startTimer()
        }
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? NSValue)?.cgRectValue {
            btnBottomConstraint?.constant = -keyboardSize.height+20
            view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? NSValue)?.cgRectValue {
//            guard let safeBottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom else {return}
//            btnBottomConstraint?.constant = 0
//            view.layoutIfNeeded()
//        }
        btnBottomConstraint?.constant = -10
        view.layoutIfNeeded()
    }
    
    private func setupView(){
        view.addSubviews(views: lbTitle, otpField, lbNotReceived, btnResendOtp, btnConfirm)

        lbTitle.safeTop(toView: view, space: 30)
        lbTitle.horizontal(toView: view, space: 20)
        otpField.displayType = .underlinedBottom
        otpField.delegate = self
        otpField.initializeUI()
        otpField.top(toAnchor: lbTitle.bottomAnchor, space: 20)
        otpField.horizontal(toView: view, space: 25)
        otpField.height(100)
        
        lbNotReceived.top(toAnchor: otpField.bottomAnchor, space: 14)
        lbNotReceived.centerX(toView: view)
        
        btnResendOtp.top(toAnchor: lbNotReceived.bottomAnchor)
        btnResendOtp.centerX(toView: view)
        btnResendOtp.height(50)
        
        btnBottomConstraint = btnConfirm.safeBottom(toView: view, space: 10)
        btnConfirm.horizontal(toView: view, space: 14)
        btnConfirm.height(50)
        btnConfirm.isUserInteractionEnabled = false
        
        
        btnResendOtp.addTarget(self, action: #selector(resendOtp_touchUp), for: .touchUpInside)
        btnConfirm.addTarget(self, action: #selector(confirm_touchUp), for: .touchUpInside)
    }
    
    @objc private func resendOtp_touchUp(){
        self.showLoading()
        let rq = RequestOtp()
        rq.mobileNumber = mobileNumber
        rq.isForget = "Y"
        let rqString = Utils.objToString(rq)
        ApiManager.shared.requestCodeMessage(dataRq: rqString, code: "EMP_GET_OTP") { code, message in
            self.hideLoading()
            if code == "00" {
                if self.isTimerRunning == false {
                    self.startTimer()
                }
            } else {
                self.showToast(message: message ?? "", delay: 2)
            }
        }
    }
    @objc private func confirm_touchUp(){
        let rq = ChangePassRequest()
        self.showLoading()
        rq.mobileNumber = mobileNumber
        rq.OTPValue = otp
        let rqString = Utils.objToString(rq)
        ApiManager.shared.requestCodeMessage(dataRq: rqString, code: "EMP_OTP_VERIFY") { code, message in
            self.hideLoading()
            if code == "00" {
                let vc = ForgotPasswordInputNewPassVC()
                vc.mobileNumber = self.mobileNumber
                vc.otp = self.otp
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.showToast(message: message ?? "", delay: 2)
            }
        }
    }
    
    func runProdTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateProdTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    @objc func updateProdTimer() {
        if intProdSeconds < 2 {
            timer.invalidate()
            btnResendOtp.setTitle("Gửi lại mã", for: .normal)
            btnResendOtp.isUserInteractionEnabled = true
            isTimerRunning = false
            intProdSeconds = 180
        } else {
            intProdSeconds -= 1
            btnResendOtp.setTitle("Gửi lại mã sau: \(prodTimeString(time: TimeInterval(intProdSeconds)))", for: .normal)
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
        self.btnResendOtp.isUserInteractionEnabled = false
        runProdTimer()
    }
}
extension ForgotPasswordInputOtpVC: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        btnConfirm.isUserInteractionEnabled = hasEntered
        if hasEntered {
            btnConfirm.backgroundColor = .blueColor
        } else {
            btnConfirm.backgroundColor = .gray.withAlphaComponent(0.6)
        }
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        self.otp = otpString
    }
}
