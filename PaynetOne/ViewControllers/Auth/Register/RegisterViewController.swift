//
//  RegisterViewController.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 05/09/2022.
//

import UIKit
import SwiftTheme

class RegisterViewController: BaseUI {
    private var lbTitle : UILabel!
    private var scrollView :UIScrollView!
    private var merNameTitle : UILabel!
    private var merNameField :UITextField!
    private var emailTitle : UILabel!
    private var emailField : UITextField!
    private var passwordTitle : UILabel!
    private var passwordField :UITextField!
    private var confirmPasswordTitle : UILabel!
    private var confirmPasswordField :UITextField!
    private var phoneNumberTitle : UILabel!
    private var phoneNumberField :UITextField!
    private var otpTitle : UILabel!
    private var otpField :UITextField!
    private var checkBox :CheckBox!
    private var termButton : UIButton!
    private var continueButton :UIButton!
    private var getOtpBtn : UIButton!
    
    private var isTimerRunning = false
    private var timer = Timer()
    lazy var intProdSeconds = 180.0
    var currentBackgroundDate = NSDate()
    private var isShowHidePassword: Bool = true
    private var isShowConfirmPassword: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ĐĂNG KÝ TÀI KHOẢN"
        initUI()
        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(pauseApp), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(inactiveApp), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    private func initUI(){
        lbTitle = POMaker.makeLabel(text: "1. Thông tin tài khoản", font: .helvetica.setBold().withSize(16))
        scrollView = POMaker.makeScrollView()
        merNameTitle = POMaker.makeLabel(text: "Tên merchant *", require: true)
        merNameField = POMaker.makeTextField(placeholder: "Nhập tên merchant")
        emailTitle = POMaker.makeLabel(text: "Email *", require: true)
        emailField = POMaker.makeTextField(placeholder: "Nhập email")
        passwordTitle = POMaker.makeLabel(text: "Mật khẩu *", require: true)
        passwordField = POMaker.makeTextField(placeholder: "Nhập mật khẩu",textColor: .white)
        confirmPasswordTitle = POMaker.makeLabel(text: "Xác nhận mật khẩu *", require: true)
        confirmPasswordField = POMaker.makeTextField(placeholder: "Nhập lại mật khẩu",textColor: .white)
        phoneNumberTitle = POMaker.makeLabel(text: "Số điện thoại đăng nhập *", require: true)
        phoneNumberField = POMaker.makeTextField(placeholder: "Nhập số điện thoại")
        otpTitle = POMaker.makeLabel(text: "OTP *", require: true)
        otpField = POMaker.makeTextField(placeholder: "Nhập mã OTP")
        checkBox = CheckBox()
        termButton = POMaker.makeButton(font: .helvetica, color: .textBlack, textAlignment: .left, backgroundColor: .clear)
        continueButton = POMaker.makeButton(title: "Tiếp tục")
        getOtpBtn = POMaker.makeButton(title: "Lấy OTP    ", font: .helvetica.withSize(15), color: .blueColor, backgroundColor: .clear )
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
    
    private func setupView(){
        view.addSubviews(views: lbTitle, scrollView)
        lbTitle.safeTop(toView: view, space: 14)
        lbTitle.left(toView: view, space: 14)
        
        scrollView.top(toAnchor: lbTitle.bottomAnchor, space: 10)
        scrollView.horizontal(toView: view)
        scrollView.bottom(toView: view)
        scrollView.addSubviews(views: merNameTitle, merNameField, emailTitle, emailField, passwordTitle, passwordField, confirmPasswordTitle, confirmPasswordField, phoneNumberTitle, phoneNumberField, otpTitle, otpField, checkBox, termButton, continueButton)
        
        merNameTitle.top(toView: scrollView)
        merNameTitle.left(toView: scrollView, space: 14)
        merNameField.top(toAnchor: merNameTitle.bottomAnchor, space: 6)
        merNameField.horizontal(toView: view, space:  14)
        merNameField.height(50)
        
        emailTitle.top(toAnchor: merNameField.bottomAnchor, space: 14)
        emailTitle.left(toView: view, space: 14)
        emailField.top(toAnchor: emailTitle.bottomAnchor, space: 6)
        emailField.horizontal(toView: view, space: 14)
        emailField.height(50)
        emailField.keyboardType = .emailAddress
        
        passwordTitle.top(toAnchor: emailField.bottomAnchor, space: 14)
        passwordTitle.left(toView: view, space: 14)
        passwordField.top(toAnchor: passwordTitle.bottomAnchor, space: 6)
        passwordField.horizontal(toView: view, space: 14)
        passwordField.height(50)
        passwordField.isSecureTextEntry = true
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let btnShowHide = UIButton()
        btnShowHide.setImage(UIImage(named: "eye_showing")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnShowHide.imageView?.tintColor = .gray
        btnShowHide.addTarget(self, action: #selector(showHidePassword), for: .touchUpInside)
        btnShowHide.frame = CGRect(x: 13, y: 13, width: 24, height: 24)
        emptyView.addSubview(btnShowHide)
        emptyView.contentMode = .left
        passwordField.rightView = emptyView
        passwordField.rightViewMode = .always
        
        confirmPasswordTitle.top(toAnchor: passwordField.bottomAnchor, space: 14)
        confirmPasswordTitle.left(toView: view, space: 14)
        confirmPasswordField.top(toAnchor: confirmPasswordTitle.bottomAnchor, space: 6)
        confirmPasswordField.horizontal(toView: view, space: 14)
        confirmPasswordField.height(50)
        confirmPasswordField.isSecureTextEntry = true
        let emptyViewC = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let btnShowHideC = UIButton()
        btnShowHideC.setImage(UIImage(named: "eye_showing")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnShowHideC.imageView?.tintColor = .gray
        btnShowHideC.addTarget(self, action: #selector(showHideConfirmPassword), for: .touchUpInside)
        btnShowHideC.frame = CGRect(x: 13, y: 13, width: 24, height: 24)
        emptyViewC.addSubview(btnShowHideC)
        emptyViewC.contentMode = .left
        confirmPasswordField.rightView = emptyViewC
        confirmPasswordField.rightViewMode = .always
        
        phoneNumberTitle.top(toAnchor: confirmPasswordField.bottomAnchor, space: 14)
        phoneNumberTitle.left(toView: view, space: 14)
        phoneNumberField.top(toAnchor: phoneNumberTitle.bottomAnchor, space: 6)
        phoneNumberField.horizontal(toView: view, space: 14)
        phoneNumberField.height(50)
        phoneNumberField.keyboardType = .phonePad
        phoneNumberField.delegate = self
        
        otpTitle.top(toAnchor: phoneNumberField.bottomAnchor, space: 14)
        otpTitle.left(toView: view, space: 14)
        otpField.top(toAnchor: otpTitle.bottomAnchor, space: 6)
        otpField.horizontal(toView: view, space: 14)
        otpField.height(50)
        otpField.keyboardType = .numberPad
        otpField.rightViewMode = .always
        otpField.rightView = getOtpBtn
        otpField.delegate = self
        getOtpBtn.addTarget(self, action: #selector(getOTP_TouchUpInside), for: .touchUpInside)
        
        checkBox.top(toAnchor: otpField.bottomAnchor, space: 14)
        checkBox.left(toView: view, space: 16)
        checkBox.size(CGSize(width: 24, height: 24))
        termButton.top(toAnchor: otpField.bottomAnchor, space: 14)
        termButton.left(toAnchor: checkBox.rightAnchor, space: 8)
        termButton.right(toView: view, space: 14)
        let attributedString = NSMutableAttributedString.init(string: "Bằng việc chọn \"Tiếp Tục\", bạn đã đồng ý với Điều khoản và Điều kiện của Paynet")
        let range = NSRange(location: 44, length: 24)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blueColor, range: range)
        termButton.setAttributedTitle(attributedString, for: .normal)
        if isDarkMode{
            checkBox.backgroundColor = .white
            termButton.setTitleColor(.white, for: .normal)
            passwordField.textColor = .white
            confirmPasswordField.textColor = .white
            
        }else{
            termButton.setTitleColor(.black, for: .normal)
            confirmPasswordField.textColor = .black
            passwordField.textColor = .black
        }
        termButton.addTarget(self, action: #selector(termTouchUpInside), for: .touchUpInside)
        
        continueButton.top(toAnchor: termButton.bottomAnchor, space: 18)
        continueButton.horizontal(toView: view, space: 16)
        continueButton.bottom(toView: scrollView, space: 14)
        continueButton.height(50)
        continueButton.addTarget(self, action: #selector(continue_touchUp), for: .touchUpInside)
    }
    @objc func showHidePassword(_ sender: UIButton){
        if(isShowHidePassword == true) {
            passwordField.isSecureTextEntry = false
            sender.setImage(UIImage(named: "eye_hidding")?.withRenderingMode(.alwaysTemplate), for: .normal)
            sender.imageView?.tintColor = .gray
        } else {
            passwordField.isSecureTextEntry = true
            sender.setImage(UIImage(named: "eye_showing")?.withRenderingMode(.alwaysTemplate), for: .normal)
            sender.imageView?.tintColor = .gray
        }
        isShowHidePassword = !isShowHidePassword
    }
    @objc func showHideConfirmPassword(_ sender: UIButton){
        if(isShowConfirmPassword == true) {
            confirmPasswordField.isSecureTextEntry = false
            sender.setImage(UIImage(named: "eye_hidding")?.withRenderingMode(.alwaysTemplate), for: .normal)
            sender.imageView?.tintColor = .gray
        } else {
            confirmPasswordField.isSecureTextEntry = true
            sender.setImage(UIImage(named: "eye_showing")?.withRenderingMode(.alwaysTemplate), for: .normal)
            sender.imageView?.tintColor = .gray
        }
        isShowConfirmPassword = !isShowConfirmPassword
    }
    @objc private func continue_touchUp(){
        dismissKeyboard()
        guard let email = emailField.text?.trimmingCharacters(in: .whitespaces) else {return}
        guard let password = passwordField.text?.trimmingCharacters(in: .whitespaces) else {return}
        guard let confirmPassword = confirmPasswordField.text?.trimmingCharacters(in: .whitespaces) else {return}
        guard let phone = phoneNumberField.text?.trimmingCharacters(in: .whitespaces) else {return}
        guard let otp = otpField.text?.trimmingCharacters(in: .whitespaces) else {return}
        if merNameField.text?.trimmingCharacters(in: .whitespaces) == "" {
            self.showToast(message: "Bạn chưa nhập Tên Merchant", delay: 2)
            return
        }
        if email.isEmpty {
            self.showToast(message: "Bạn chưa nhập Email", delay: 2)
            return
        }
        if !email.emailValidate() {
            self.showToast(message: "Bạn chưa nhập đúng định dạng Email", delay: 2)
            return
        }
        if password.isEmpty {
            self.showToast(message: "Bạn chưa nhập Mật khẩu", delay: 2)
            return
        }
        if password.count < 6 {
            self.showToast(message: "Mật khẩu có độ dài tối thiểu 6 kí tự và tối đa 50 kí tự", delay: 2)
            return
        }
        if !password.checkPass {
            self.showToast(message: "Mật khẩu phải từ 6-50 ký tự, có ít nhất 1 ký tự hoa, 1 ký tự thường, 1 ký tự đặc biệt, 1 ký tự số", delay: 2)
            return
        }
        if confirmPassword.isEmpty {
            self.showToast(message: "Bạn chưa Nhập lại Mật khẩu", delay: 2)
            return
        }
        if confirmPassword != password {
            self.showToast(message: "Mật khẩu không khớp", delay: 2)
            return
        }
        if phone.isEmpty {
            self.showToast(message: "Bạn chưa nhập số điện thoại", delay: 2)
            return
        }
        if !phone.phoneValidate() {
            self.showToast(message: "Bạn chưa nhập đúng số điện thoại", delay: 2)
            return
        }
        if !checkBox.isChecked {
            self.showToast(message: "Vui lòng chọn điều khoản sử dụng", delay: 2)
            return
        }
        if otp.isEmpty {
            self.showToast(message: "Bạn chưa nhập mã OTP", delay: 2)
            return
        }
        if otp.count < 6 {
            self.showToast(message: "OTP tối thiểu 6 kí tự", delay: 2)
            return
        }
        continueRegister()
    }
    
    private func continueRegister(){
        let rq = RequestRegisterAccount()
        rq.fullName = merNameField.text ?? ""
        rq.password = passwordField.text ?? ""
        rq.mobilenumber = phoneNumberField.text ?? ""
        rq.email = emailField.text ?? ""
        rq.otp = otpField.text ?? ""
        let rqString = Utils.objToString(rq)
        self.showLoading()
        ApiManager.shared.requestCodeMessage(dataRq: rqString, code: "EMP_ADD_NEW") { code, message in
            self.hideLoading()
            if code == "00" {
                let vc = RegisterBusinessInfoVC()
                vc.isUpdateMerchant = false
                vc.titleBtnUpdate = "Xác nhận"
                vc.mobileNumber = self.phoneNumberField.text ?? ""
                vc.name = self.merNameField.text ?? ""
                vc.email = self.emailField.text ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.showToast(message: message ?? "", delay: 2)
            }
        }
    }
    
    @objc private func getOTP_TouchUpInside(){
        dismissKeyboard()
        guard let phone = phoneNumberField.text?.trimmingCharacters(in: .whitespaces) else {return}
        if phone.isEmpty {
            self.showToast(message: "Bạn chưa nhập số điện thoại", delay: 2)
            return
        }
        if !phone.phoneValidate() {
            self.showToast(message: "Bạn chưa nhập đúng số điện thoại", delay: 2)
            return
        }
        let rq = RequestOtp()
        rq.mobileNumber = phone
        rq.isForget = "N"
        let rqString = Utils.objToString(rq)
        self.showLoading()
        ApiManager.shared.requestCodeMessage(dataRq: rqString, code: "EMP_GET_OTP") { code, message in
            self.hideLoading()
            if code == "00" {
                if self.isTimerRunning == false {
                    self.runProdTimer()
                }
                self.showToast(message: "Mã xác nhận được gửi đến số điện thoại \(phone) (kiểm tra cuộc gọi và ZALO)", delay: 2)
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
    
    @objc private func termTouchUpInside(){
        navigationController?.pushViewController(TermAndConditionVC(), animated: true)
    }
}
extension RegisterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength = 0
        if textField == passwordField {
            maxLength = 50
        }
        if textField == otpField {
            maxLength = 6
        }
        if textField == phoneNumberField {
            maxLength = 10
        }
        return textField.maxLength(range: range, string: string, max: maxLength)
    }
}
