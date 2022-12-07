//
//  Login.swift
//  PaynetOne
//
//  Created by vinatti on 30/12/2021.
//

import Foundation
import UIKit
import Security
import CommonCrypto
import SwiftyRSA
import FirebaseMessaging
import SwiftTheme

class LoginViewController: BaseUI {
    var stackView :UIStackView!
    var tfPhoneNumber: TintTextField!
    var tfPassword: UITextField!
    var btnLogin = UIButton()
    
    var isShowHidePassword: Bool = true
    var lbDontAccount : UILabel!
    let imgLogoView = UIView()
    let imgLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo_paynet_one")
        image.contentMode = .scaleAspectFit
        return image
    }()
    private var forgotPassButton: UIButton!
    var fcmToken: String?
    
    let sessionAccountPhone = StoringService.shared.getData("PHONE_NUMBER_LOGIN")
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white
//        configThemeView()
        initUI()
        hideKeyboardWhenTappedOutside()
        setupStackView()
        setupInputPhoneNumber()
        setupInputPassword()
        setupButtonLogin()
        navigationItem.backButtonTitle = ""
        [tfPhoneNumber,tfPassword].forEach({
            $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        })
        setupLogo()
        getFCMToken()
        configBackgorundColor() 
        
        SwiftEventBus.onMainThread(self, name: "UpdateMerchantSuccess") { _ in
            self.view.makeToast("Cập nhật thành công!", duration: 3, position: .bottom)
        }
        SwiftEventBus.onMainThread(self, name: "RegisterMerchantSuccess") { _ in
            self.view.makeToast("Đăng ký thành công!", duration: 3, position: .bottom)
        }
        
        if !sessionAccountPhone.isEmpty{
            tfPhoneNumber.text = sessionAccountPhone
        }
        
   
    }
    
    override func configBackgorundColor() {
        super.configBackgorundColor()
        if isDarkMode{
            tfPhoneNumber.textColor = .white
            tfPhoneNumber.textColor = .white
            tfPassword.textColor = .white
            tfPassword.textColor = .white
        }else{
            tfPhoneNumber.textColor = .black
            tfPhoneNumber.textColor = .black
            tfPassword.textColor = .black
            tfPassword.textColor = .black
        }
    }
    
    private func initUI(){
         stackView = UIStackView()
         tfPhoneNumber = {
            let input = TintTextField()
            input.placeholder = "Số điện thoại"
            input.setupPrimaryTextField()
            input.keyboardType = .phonePad
            input.clearButtonMode = .whileEditing
            return input
        }()
         tfPassword = {
            let input = UITextField()
            let placeholderText = NSAttributedString(string: "Mật khẩu", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.7)])
            input.attributedPlaceholder = placeholderText
            input.setupPrimaryTextField()
            input.isSecureTextEntry = true
            let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            input.rightView = emptyView
            input.rightViewMode = .always
            input.textColor = .black
            let btnShowHide = UIButton()
            btnShowHide.setImage(UIImage(named: "eye_showing")?.withRenderingMode(.alwaysTemplate), for: .normal)
            btnShowHide.imageView?.tintColor = .gray
            btnShowHide.addTarget(self, action: #selector(showHidePassword), for: .touchUpInside)
            btnShowHide.frame = CGRect(x: 13, y: 13, width: 24, height: 24)
            emptyView.addSubview(btnShowHide)
            emptyView.contentMode = .left
            return input
        }()
         btnLogin = UIButton()
        
       forgotPassButton = {
            let button = UIButton()
            let attributedString = NSAttributedString(string: NSLocalizedString("Quên mật khẩu?", comment: ""), attributes:[
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0),
    //            NSAttributedString.Key.foregroundColor : UIColor.gray,
                NSAttributedString.Key.underlineStyle:1.0
            ])
            button.setAttributedTitle(attributedString, for: .normal)
            return button
        }()
        
        lbDontAccount = UILabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
        super.viewWillDisappear(animated)
        
        unregisterNotifi()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        registerNotifi()
    }
    
//    override func configNavigation() {
//        self.navigationController?.setNavigationBarHidden(true, animated: true);
//    }
    
    @objc private func observerUserInterfaceStyle(_ notification: Notification) {
        let type = notification.object as? UserInterfaceStyle
        switch type {
        case .DARKMOD:
            DispatchQueue.main.async {
                SceneDelegate.shared.rootViewController.switchToRegister()
                NotificationCenter.default.post(name: .userInterfaceStyle, object: UserInterfaceStyle.NOTHING)
            }
       
        case .LIGHT:
            DispatchQueue.main.async {
                SceneDelegate.shared.rootViewController.switchToRegister()

                NotificationCenter.default.post(name: .userInterfaceStyle, object: UserInterfaceStyle.NOTHING)
            }
        case .NOTHING:
            break
        case .none:
            break
        }
    }
    
    
    deinit {
      
    }
    
    private func registerNotifi(){
        NotificationCenter.default.addObserver(self, selector: #selector(observerUserInterfaceStyle(_:)), name: .userInterfaceStyle, object: nil)
    }
    
    private func unregisterNotifi(){
        NotificationCenter.default.removeObserver(self, name: .userInterfaceStyle, object: nil)
    }
    
    private func configThemeView(){
        if isDarkMode{
            tfPhoneNumber.textColor = .white
            tfPhoneNumber.textColor = .white
            tfPassword.textColor = .white
            tfPassword.textColor = .white
            
           
        }else{
            tfPhoneNumber.theme_textColor = ThemeColorPicker(colors: "#FFF")
            tfPhoneNumber.theme_tintColor = ThemeColorPicker(colors: "#FFF")
            tfPassword.theme_textColor = ThemeColorPicker(colors: "#FFF")
            tfPassword.theme_tintColor = ThemeColorPicker(colors: "#FFF")
        }
      
        
        let attributedString = NSAttributedString(string: NSLocalizedString("Quên mật khẩu?", comment: ""), attributes:[
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0),
            NSAttributedString.Key.underlineStyle:1.0
        ])
        forgotPassButton.theme_setAttributedTitle(ThemeAttributedStringPicker(arrayLiteral: attributedString), forState: .normal)
        forgotPassButton.theme_setTitleColor(ThemeColorPicker(colors: "#FFF", "#000"), forState: .normal)
        lbDontAccount.theme_textColor = ThemeColorPicker(colors: "#FFF", "#000")
    }
    
    func setupLogo(){
        view.addSubview(imgLogoView)
        imgLogoView.viewConstraints(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: tfPhoneNumber.topAnchor, right: view.rightAnchor)
        imgLogoView.addSubview(imgLogo)
        imgLogo.viewConstraints(size: CGSize(width: 200, height: 200),centerX: imgLogoView.centerXAnchor ,centerY: imgLogoView.centerYAnchor)
    }
    
    func setupInputPhoneNumber(){
        tfPhoneNumber.delegate = self
        lbDontAccount.text = "Bạn chưa có tài khoản? Đăng ký"
        lbDontAccount.addRangeGesture("Đăng ký", 23, 7)
        lbDontAccount.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dontAccount_tap(_:)))
        lbDontAccount.addGestureRecognizer(tap)
        
        view.addSubview(forgotPassButton)
        forgotPassButton.viewConstraints(top: lbDontAccount.bottomAnchor, padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0), centerX: view.centerXAnchor)
        forgotPassButton.addTarget(self, action: #selector(forgotPassButton_touchup), for: .touchUpInside)
    }
    
    @objc func dontAccount_tap(_ gesture: UITapGestureRecognizer){
        navigationController?.pushViewController(RegisterViewController(), animated: true)
        self.clearInputPassword()
    }
    
    func setupInputPassword(){
        tfPassword.delegate = self
    }
    
    @objc private func forgotPassButton_touchup(){
        let vc = ForgotPasswordGetOTPVC()
        navigationController?.pushViewController(vc, animated: true)
        self.clearInputPassword()
    }
    
    func getFCMToken(){
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else {
                print("fcmToken",token)
                self.fcmToken = token
            }
        }
    }
    
    func setupStackView(){
        let safeArea = view.safeAreaLayoutGuide
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(tfPhoneNumber)
        stackView.addArrangedSubview(tfPassword)
        stackView.addArrangedSubview(btnLogin)
        view.addSubview(stackView)
        view.addSubview(lbDontAccount)
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.spacing = 20
        stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20).isActive = true
        stackView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        lbDontAccount.labelConstraints(top: stackView.bottomAnchor, marginTop: 30, centerX: view.centerXAnchor)
    }
    
    func setupButtonLogin(){
        btnLogin.setTitle("Đăng nhập", for: .normal)
        btnLogin.buildPrimaryButton()
        btnLogin.addTarget(self, action: #selector(btnLogin_touchupInside), for: .touchUpInside)
        if tfPhoneNumber.text!.count == 0 || tfPassword.text!.count == 0 {
            btnLogin.isEnabled = false
            btnLogin.backgroundColor = .gray
        }
    }
    
    @objc func editingChanged(_ textfield: UITextField){
        if textfield.text?.count == 1 {
            if textfield.text?.first == " " {
                textfield.text = ""
                return
            }
        }
        guard
            let _ = tfPhoneNumber.text, !tfPhoneNumber.text!.isEmpty,
            let _ = tfPassword.text, !tfPassword.text!.isEmpty
        else {
            btnLogin.isEnabled = false
            btnLogin.backgroundColor = .gray
            return
        }
        btnLogin.isEnabled = true
        btnLogin.backgroundColor = Colors.primaryColor
    }
    
    @objc func showHidePassword(_ sender: UIButton){
        if(isShowHidePassword == true) {
            tfPassword.isSecureTextEntry = false
            sender.setImage(UIImage(named: "eye_hidding")?.withRenderingMode(.alwaysTemplate), for: .normal)
            sender.imageView?.tintColor = .gray
        } else {
            tfPassword.isSecureTextEntry = true
            sender.setImage(UIImage(named: "eye_showing")?.withRenderingMode(.alwaysTemplate), for: .normal)
            sender.imageView?.tintColor = .gray
        }
        isShowHidePassword = !isShowHidePassword
    }
    
    @objc func btnLogin_touchupInside(){
        if tfPhoneNumber.text == "" {
            self.showToast(message: "Vui lòng nhập số điện thoại", delay: 2)
        } else if tfPassword.text == "" {
            self.showToast(message: "Vui lòng nhập mật khẩu", delay: 2)
        } else if tfPhoneNumber.text?.count < 10 {
            self.showToast(message: "Số điện thoại không hợp lệ", delay: 2)
        } else {
            login()
        }
    }
    
    func login(){
        let objectUser = LoginRequest()
        objectUser.phoneNumber = tfPhoneNumber.text
        objectUser.password = tfPassword.text
        objectUser.FCMToken = fcmToken
        let jsonUser = Utils.objToString(objectUser)
        self.showLoading()
        ApiManager.shared.createRequest(data: jsonUser, code: "EMP_LOGIN") { isSuccess, loginResponse in
            if isSuccess {
                let userData = UserModel(JSONString: loginResponse)
                if userData?.paynetId ?? 0 > 0 {
                    self.checkUserToLogin(loginData: loginResponse)
                }else{
                    let vc = RegisterBusinessInfoVC()
                    vc.isUpdateMerchant = false
                    vc.titleBtnUpdate = "Cập nhật"
                    vc.mobileNumber = userData?.phoneNumber ?? ""
                    vc.name = userData?.fullName ?? ""
                    vc.email = userData?.email ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.clearInputPassword()
                }
                self.hideLoading()
                
            } else {
                self.hideLoading()
                self.view.makeToast(loginResponse, duration: 2, position: .bottom)
            }
        }
    }
    
    func checkUserToLogin(loginData: String) {
        let userData = UserModel(JSONString: loginData)
        let rqConfig = ConfigRequestModel()
        rqConfig.id = userData?.paynetId
        let rqConfigString = Utils.objToString(rqConfig)
        ApiManager.shared.createRequest(data: rqConfigString, code: "PAYNET_GET_BY_ID") { stt, response in
            if stt {
                StoringService.shared.saveData(user: response, key: Constants.configData)
                if let id = userData?.paynetId, id > 0 {
                    StoringService.shared.saveData(user: loginData, key: Constants.userData)
                    StoringService.shared.saveData(user: self.tfPhoneNumber.text ?? "", key: "PHONE_NUMBER_LOGIN")
                    SceneDelegate.shared.rootViewController.switchToMain()
                } else {
                    let vc = RegisterBusinessInfoVC()
                    vc.isUpdateMerchant = false
                    vc.titleBtnUpdate = "Cập nhật"
                    vc.mobileNumber = userData?.phoneNumber ?? ""
                    vc.name = userData?.fullName ?? ""
                    vc.email = userData?.email ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.clearInputPassword()
                }
            }else{
                self.showToast(message: response, delay: 2)
            }
            self.hideLoading()
        }
    }
    
    private func clearInputPassword(){
        tfPassword.text = ""
    }
}
//MARK: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength: Int?
        if textField == tfPhoneNumber {
            maxLength = 10
        } else if textField == tfPassword {
            maxLength = 20
        }
        let currentCharacterCount = textField.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= maxLength!
    }
}

////MARK: Show Toast lấy pass success
//extension LoginViewController: MakeToastChangePasswordSuccessDelegate {
//    func showMsgChangeSuccess() {
//        self.view.makeToast("Mật khẩu đã được thay đổi thành công.", duration: 3, position: .bottom)
//    }
//}
