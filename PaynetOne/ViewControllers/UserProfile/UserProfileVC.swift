//
//  UserProfileVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 16/08/2022.
//

import UIKit
import SwiftUI
import SwiftTheme

class UserProfileVC: BaseUI {
    private var userView : UIView!
    private var imgUserAvatar : UIImageView!
    private var lbUserFullName : UILabel!
    private var lbUserPhone : UILabel!
    private var lbUserEmail : UILabel!
    private var imgWallet = POMaker.makeImage(image: "wallet_icon")
    private var userBalance = POMaker.makeLabel(text: Utils.formatCurrency(amount: 0), font: .helvetica.setBold().withSize(18), color: .red)
    private var btnDeposit : UIButton!
    private var btnNotification : ProfileItemOne!
    private var btnHistoryTrans : ProfileItemOne!
    private var tableView : UITableView!
    private var lbAppVersion : UILabel!
    private var lbSaleLimit : UILabel!
    
    private var profileFuncList = [ItemModel]()
    var model = MerchantBalance(){
        didSet{
            userBalance.text = Utils.formatCurrency(amount: model.balance)
        }
    }
    
    var merchantFile: MerchantFileModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PAYNET ONE"
        initUI()
        setupUserView()
        setupViewNotiHis()
        setupTableView()
        fillData()
        getMerchantData()
        observerUpdateProfile()
        configBackgorundColor()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    private func initUI(){
        userView  = POMaker.makeView(backgroundColor: .white, radius: 4)
        imgUserAvatar = POMaker.makeImage(image: "user_profile_default")
        lbUserFullName = POMaker.makeLabel(font: .helvetica.setBold().withSize(18), color: .blueColor)
        lbUserPhone = POMaker.makeLabel(font: .helvetica.withSize(16), color: .blueColor)
        lbUserEmail = POMaker.makeLabel( font: .helvetica.withSize(14), color: .blueColor)
        imgWallet = POMaker.makeImage(image: "wallet_icon")
        userBalance = POMaker.makeLabel(text: Utils.formatCurrency(amount: 0), font: .helvetica.setBold().withSize(18), color: .red)
        btnDeposit = POMaker.makeButton(title: "N???P", font: .helvetica.withSize(18), cornerRadius: 5)
        btnNotification = ProfileItemOne(image: "notification", title: "Th??ng b??o")
        btnHistoryTrans = ProfileItemOne(image: "history_transaction", title: "L???ch s??? giao d???ch")
        tableView = POMaker.makeTableView(radius: 5)
        lbAppVersion = POMaker.makeLabel(text: "Phi??n b???n: \(String(describing: UIApplication.appVersion))")
        lbSaleLimit = POMaker.makeLabel(text: "H???n m???c b??n h??ng", font: .helvetica.withSize(16), color: .blueColor)
        
        userBalance.text = Utils.formatCurrency(amount: model.balance)
    }
    private func fillData(){
        profileFuncList = [
            ItemModel(image: "user_profile_default", title: "Th??ng tin c?? nh??n", isShowRightIcon: true, action: profileInfoTouchUp, level: 1),
//            ItemModel(image: "history_blue", title: "L???ch s??? ????n h??ng", isShowRightIcon: true, action: transactionHistory),
            ItemModel(image: "change_password", title: "?????i m???t kh???u", isShowRightIcon: true, action: changePasswordTouchUp),
            ItemModel(image: "pincode", title: "M?? pin", isShowRightIcon: true, action: setupPin, level: 1),
            ItemModel(image: "deposit", title: "H???n m???c c???a h??ng", isShowRightIcon: true, action: limitChargeTouchUp, level: 1),
            ItemModel(image: "term_condition", title: "??i???u kho???n v?? ch??nh s??ch", isShowRightIcon: true, action: termConditionTouchUp),
            ItemModel(image: "news", title: "Tin t???c", isShowRightIcon: true, action: newsTouchUp),
            ItemModel(image: "contact", title: "Li??n h???", isShowRightIcon: true, action: contactTouchUp),
            ItemModel(image: "ic_home", title: "C??i ?????t trang ch???", action: showSettingMain),
            ItemModel(image: "logout", title: "????ng xu???t", action: onLogout)]
        let user = StoringService.shared.getUserData()
        lbUserFullName.text = user?.fullName
        lbUserPhone.text = user?.phoneNumber
        lbUserEmail.text = user?.email
    }
    private func setupPin(){
        let vcPin = CreatePinCodeViewController()
        self.navigationController?.pushViewController(vcPin, animated: true)
    }
    private func profileInfoTouchUp(){
        let vc = RegisterBusinessInfoVC()
//        vc.delegate = self
        vc.merchantFile = self.merchantFile
        vc.isUpdateMerchant = true
        vc.titleBtnUpdate = "C???p nh???t"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getMerchantData(){
        let userString = StoringService.shared.getData(Constants.userData)
        let userData = UserModel(JSONString: userString)
        let data = CheckPhoneRequestModel()
        data.mobileNumber = userData?.phoneNumber
        let dataString = Utils.objToString(data)
        ApiManager.shared.createRequest(data: dataString, code: "MERCHANT_GET_BY_MOBILE_NUMBER") { stt, data in
            if stt == true {
                let dataObj = MerchantFileModel(JSONString: data)
                self.merchantFile = dataObj
            }
        }
    }
    
//    private func transactionHistory(){
//        let vc = TransactionHistoryVC()
//        navigationController?.pushViewController(vc, animated: true)
//    }
    private func changePasswordTouchUp(){
        let vc = ChangePasswordVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func limitChargeTouchUp(){
        let vc = HanMucCuaHangVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func termConditionTouchUp(){
        navigationController?.pushViewController(TermAndConditionVC(), animated: true)
    }
    private func newsTouchUp(){
        self.showPopupDevelop()
    }
    private func contactTouchUp(){
        self.popupWithView(vc: ContactViewController(), okBtnTitle: "Xong")
    }
    private func setupUserView(){
        view.addSubview(userView)
        userView.viewConstraints(top: view.safeTopAnchor, left: view.leftAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 14, left: 14, bottom: 0, right: 14))
        userView.addSubview(imgUserAvatar)
        imgUserAvatar.viewConstraints(top: userView.topAnchor, left: userView.leftAnchor, padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 0), size: CGSize(width: 60, height: 60))
        userView.addSubview(lbUserFullName)
        lbUserFullName.viewConstraints(top: imgUserAvatar.topAnchor, left: imgUserAvatar.rightAnchor, right: userView.rightAnchor, padding: UIEdgeInsets(top: 4, left: 12, bottom: 0, right: 0))
        userView.addSubview(lbUserPhone)
        lbUserPhone.viewConstraints(top: lbUserFullName.bottomAnchor, left: imgUserAvatar.rightAnchor, padding: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0))
        userView.addSubview(lbUserEmail)
        lbUserEmail.viewConstraints(top: lbUserPhone.bottomAnchor, left: imgUserAvatar.rightAnchor, padding: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0))
        
        let saleLimitView = UIView()
        userView.addSubviews(views: saleLimitView)
        saleLimitView.top(toAnchor: imgUserAvatar.bottomAnchor, space: 20)
        saleLimitView.horizontal(toView: userView)
        saleLimitView.bottom(toView: userView, space: 16)
        saleLimitView.addSubviews(views: imgWallet, lbSaleLimit, userBalance, btnDeposit)
        imgWallet.left(toView: saleLimitView, space: 14)
        imgWallet.centerY(toView: saleLimitView)
        imgWallet.size(CGSize(width: 30, height: 30))
        
        lbSaleLimit.top(toView: saleLimitView)
        lbSaleLimit.left(toAnchor: imgWallet.rightAnchor, space: 10)
        userBalance.top(toAnchor: lbSaleLimit.bottomAnchor)
        userBalance.left(toAnchor: imgWallet.rightAnchor, space: 10)
        userBalance.bottom(toView: saleLimitView)
        btnDeposit.size(CGSize(width: 60, height: 30))
        btnDeposit.right(toView: saleLimitView, space: 12)
        btnDeposit.centerY(toView: saleLimitView)
        btnDeposit.addTarget(self, action: #selector(btnDeposit_touchUp), for: .touchUpInside)
        btnDeposit.isHidden = !Configs.isAdmin() && !Configs.isQLCH()
            
    }
    override func configBackgorundColor() {
        super.configBackgorundColor()
        if isDarkMode {
            userView.applyViewDarkMode()
        }else{
            userView.buildShadow(radius: 1)
        }
    }
    private func setupViewNotiHis(){
        view.addSubview(btnNotification)
        btnNotification.viewConstraints(top: userView.bottomAnchor, left: view.leftAnchor, padding: UIEdgeInsets(top: 8, left: 14, bottom: 0, right: 0), size: CGSize(width: (screenWidth-36)/2, height: 0))
        btnNotification.action = notification_tap
        view.addSubview(btnHistoryTrans)
        btnHistoryTrans.viewConstraints(top: userView.bottomAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 14), size: CGSize(width: (screenWidth-36)/2, height: 0))
        btnHistoryTrans.action = transHistoryTopup_touchUp
    }
    private func transHistoryTopup_touchUp(){
//        let vc = TransactionHistoryTopupVC()
//        navigationController?.pushViewController(vc, animated: true)
        let vc = HistoryVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    private func notification_tap(){
        self.showPopupDevelop()
    }
    private func setupTableView(){
        view.addSubview(lbAppVersion)
        lbAppVersion.viewConstraints(bottom: view.safeBottomAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 14))
        view.addSubview(tableView)
        tableView.viewConstraints(top: btnNotification.bottomAnchor, left: view.leftAnchor, bottom: lbAppVersion.topAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 8, left: 14, bottom: 10, right: 14))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileFuncTableViewCell.self, forCellReuseIdentifier: "ProfileFuncTableViewCell")
        tableView.showsVerticalScrollIndicator = false
//        tableView.buildShadow(color: .gray, radius: 1)
//        tableView.separatorColor = .backgroundColor
    }
    
    @objc private func btnDeposit_touchUp(){
        let payNetHasChildrenRes = StoringService.shared.getPayNetHasChildren()
        var code = ""
        let vc = RechargeLimitVC()
        let paynetConfig = StoringService.shared.getConfigData()
        if (paynetConfig?.businessType == Constants.BUSINESS_TYPE_PERSONAL ||
            paynetConfig?.businessType == Constants.BUSINESS_TYPE_VIETLOTT ||
            paynetConfig?.businessType == Constants.BUSINESS_TYPE_SYNTHETIC) && payNetHasChildrenRes?.hasChildren == "N"{
            code = paynetConfig?.code ?? ""
        }
        if !Configs.isAdmin() {
            code = paynetConfig?.code ?? ""
        }
        vc.limitAmount = model.balance
        vc.code = code
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showSettingMain(){
        let vcPin = SettingMainVC()
        self.navigationController?.pushViewController(vcPin, animated: true)
        
    }
    
    private func onLogout() {
        
        let modal = ConfirmModalView()
        modal.message = "B???n c?? ch???c ch???n mu???n ????ng xu???t?"
        modal.messgeTitle = "????ng xu???t"
        self.popupWithView(vc: modal,cancelBtnTitle: "Hu??? b???", cancelAction:{
        }, okBtnTitle: "????ng xu???t", okAction: {
            StoringService.shared.removeData(Constants.userData)
            StoringService.shared.removeData(Constants.configData)
            StoringService.shared.removeData("ADDRESS_BY_PAYNETID")
            StoringService.shared.removeData("KEY_IS_EXST_PIN_CODE")
            StoringService.shared.removeData("KEY_PAYNET_HAS_CHILDREN")
//            DBManager.realmDeleteAllClassObjects()
            SceneDelegate.shared.rootViewController.switchToRegister()
        })
    }
    
    private func observerUpdateProfile(){
        SwiftEventBus.onMainThread(self, name: "UpdateMerchantSuccess") { _ in
            self.getMerchantData()
        }
    }
}
extension UserProfileVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let list = Configs.isAdmin() ? profileFuncList : profileFuncList.filter({$0.level == 0})
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileFuncTableViewCell") as! ProfileFuncTableViewCell
        let list = Configs.isAdmin() ? profileFuncList : profileFuncList.filter({$0.level == 0})
        cell.model = list[indexPath.row]
        cell.separatorInset = .zero
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let list = Configs.isAdmin() ? profileFuncList : profileFuncList.filter({$0.level == 0})
        if let touchUp = list[indexPath.row].action {
            touchUp()
        }
    }
}

class ProfileItemOne: UIButton {
    private let imgButton = POMaker.makeImage()
    private let lbTitle = POMaker.makeLabel(font: .helvetica.withSize(16).setBold(), color: .textGray2)
    var action: (() -> ())?
    convenience init(image: String, title: String){
        self.init()
        if isDarkMode{
            self.backgroundColor = .black
        }else{
            self.backgroundColor = .white
            self.buildShadow(radius: 1)
        }
        
        self.layer.cornerRadius = 5
        addSubview(imgButton)
        imgButton.viewConstraints(top: topAnchor, left: leftAnchor, padding: UIEdgeInsets(top: 14, left: 14, bottom: 0, right: 0), size: CGSize(width: 40, height: 40))
        addSubview(lbTitle)
        lbTitle.viewConstraints(top: imgButton.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, padding: UIEdgeInsets(top: 6, left: 14, bottom: 14, right: 10))
        imgButton.image = UIImage(named: image)
        lbTitle.text = title
        addTarget(self, action: #selector(button_Touchup), for: .touchUpInside)
        
        if StoringService.shared.isDarkMode(){
            self.layer.borderWidth = 0.5
            self.layer.borderColor = UIColor.white.cgColor
            lbTitle.textColor = .white
        }
        
    }
    @objc private func button_Touchup(){
        if let action = action {
            action()
        }
    }
}

class ProfileFuncTableViewCell: UITableViewCell {
    private let imgLeftIcon = POMaker.makeImage()
    private let lbTitle = POMaker.makeLabel()
    private let imgRightIcon = POMaker.makeImage(image: "arrow-right")
    var model = ItemModel(){
        didSet{
            imgLeftIcon.image = UIImage(named: model.image)?.withRenderingMode(.alwaysTemplate)
            lbTitle.text = model.title
            imgRightIcon.isHidden = !model.isShowRightIcon
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imgLeftIcon)
        imgLeftIcon.viewConstraints(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0), size: CGSize(width: 30, height: 30))
        imgLeftIcon.tintColor = .blueColor
        
        contentView.addSubview(lbTitle)
        lbTitle.viewConstraints(left: imgLeftIcon.rightAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0), centerY: imgLeftIcon.centerYAnchor)
        
        if isDarkMode{
            lbTitle.textColor = .white
        }else{
            lbTitle.textColor = .black
        }
            
        
        contentView.addSubview(imgRightIcon)
        imgRightIcon.viewConstraints(right: contentView.rightAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10), size: CGSize(width: 16, height: 16), centerY: imgLeftIcon.centerYAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//extension UserProfileVC: MakeToastSuccessDelegate {
//    func showToastSuccesss(message: String) {
//        self.view.makeToast(message, duration: 2, position: .bottom)
//        self.getMerchantData()
//    }
//}
class InputPasswordSetupPin: UIViewController, UITextFieldDelegate {
    private let headerView = POMaker.makeView(backgroundColor: .blueColor)
    private let titleHeader = POMaker.makeLabel(text: "Nh???p m???t kh???u", color: .white)
    private let titlePopup = POMaker.makeLabel(text: "????? th???c hi???n t???o m?? PIN, Qu?? kh??ch vui l??ng nh???p m???t kh???u ????ng nh???p", alignment: .center)
    let tfPassword = POMaker.makeTextField(placeholder: "Nh???p m???t kh???u ????ng nh???p", borderWidth: 0.5, borderColor: .blueColor, cornerRadius: 10, isPass: true)
    let alertPasswordEmpty = POMaker.makeLabel(text: "Vui l??ng nh???p m???t kh???u", font: .helvetica.withSize(12), color: .darkRed)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(views: headerView, titlePopup, tfPassword, alertPasswordEmpty)
        headerView.top(toView: view)
        headerView.horizontal(toView: view)
        headerView.height(48)
        headerView.addSubview(titleHeader)
        titleHeader.center(toView: headerView)
        
        titlePopup.top(toAnchor: headerView.bottomAnchor, space: 20)
        titlePopup.horizontal(toView: view, space: 20)
        
        tfPassword.top(toAnchor: titlePopup.bottomAnchor, space: 20)
        tfPassword.horizontal(toView: view, space: 14)
        tfPassword.height(50)
        tfPassword.bottom(toView: view, space: 30)
        tfPassword.delegate = self
        
        alertPasswordEmpty.top(toAnchor: tfPassword.bottomAnchor)
        alertPasswordEmpty.left(toView: tfPassword)
        alertPasswordEmpty.isHidden = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !string.isEmpty {
            alertPasswordEmpty.isHidden = true
        } else {
            alertPasswordEmpty.isHidden = false
        }
        return true
    }
}
