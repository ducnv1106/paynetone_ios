//
//  Dashboard.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 09/08/2022.
//

import UIKit
import ObjectMapper
import PopupDialog
import SwiftTheme
class DashboardVC: BaseUI {
    private var tabbar : CustomTabController!
    private var headerView : UIView!
    private var imgUserAvatar : UIImageView!
    private var lbSaleLimit : UILabel!
    private var lbSaleLimitValue : UILabel!
    
    private var qrPaymentList = [Provider]()
    private var serviceList = [Provider]()
    private var balances = [MerchantBalance]()
    private var headerViewHeightConstraint: NSLayoutConstraint?
    var tab: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setupHeaderViewAdmin()
        if Configs.isAdmin() {
            self.setupTabbar()
        } else {
            self.setupTabbarNoAdmin()
        }
        getAddressByPaynetId()
        getPayNetHasChildren()
        let config = StoringService.shared.getConfigData()
        self.lbSaleLimit.text = config?.name
        configBackgorundColor()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(observerUserInterfaceStyle(_:)), name: .userInterfaceStyle, object: nil)
    }
    
    
    @objc private func observerUserInterfaceStyle(_ notification: Notification) {
        let type = notification.object as? UserInterfaceStyle
        switch type {
        case .DARKMOD:
            DispatchQueue.main.async {
                let isLogin = StoringService.shared.checkLogin()
                if isLogin {
                    SceneDelegate.shared.rootViewController.switchToMain()
                }
               
                NotificationCenter.default.post(name: .userInterfaceStyle, object: UserInterfaceStyle.NOTHING)
            }
       
        case .LIGHT:
            DispatchQueue.main.async {
                let isLogin = StoringService.shared.checkLogin()
                if isLogin {
                    SceneDelegate.shared.rootViewController.switchToMain()
                }

                NotificationCenter.default.post(name: .userInterfaceStyle, object: UserInterfaceStyle.NOTHING)
            }
        case .NOTHING:
            break
        case .none:
            break
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .userInterfaceStyle, object: nil)
    }
    
    private func initUI(){
         tabbar = CustomTabController()
         headerView = POMaker.makeView(backgroundColor: .blueColor)
         imgUserAvatar = POMaker.makeImageView(image: UIImage(named: "user_default"))
         lbSaleLimit = POMaker.makeLabel(text: "Hạn mức bán hàng", font: .helvetica.withSize(16), color: .white)
         lbSaleLimitValue = POMaker.makeLabel(text: Utils.formatCurrency(amount: 0), font: .helvetica.withSize(18).setBold(), color: .white)
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
    private func getBalanceMerchant(){
        let rq = BalanceMerchantRequest()
        let user = StoringService.shared.getUserData()
        rq.paynetID = user?.paynetId
        let rqString = Utils.objToString(rq)
        self.showLoading()
        ApiManager.shared.requestObject(dataRq: rqString, code: "MERCHANT_GET_BALANCE", returnType: Balance.self) { result, err in
            self.hideLoading()
            if let result = result {
                self.balances = result.MerchantBalance
                for item in result.MerchantBalance {
                    if item.accountType == "S" {//hạn mức bán hàng
                        self.lbSaleLimitValue.text = Utils.formatCurrency(amount: item.balance)
                    }
                }
            } else {
//                self.showToast(message: err ?? "", delay: 2)
            }
        }
    }
    
    private func getPayNetHasChildren(){
        let user = StoringService.shared.getUserData()
        let rq = PayNetHasChildrenRq()
        rq.paynetId = user?.paynetId ?? 0
        let rqString = Utils.objToString(rq)
        
        ApiManager.shared.requestObject(dataRq: rqString, code: "PAYNET_CHECK_IF_HAS_CHILDREN", returnType: PayNetHasChildrenRes.self) { result, err in
            if let result = result {
                let objString = Utils.objToString(result)
                StoringService.shared.saveData(user: objString, key: "KEY_PAYNET_HAS_CHILDREN")
            }
        }
    }
    
    //hide navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        getBalanceMerchant()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
//    override func configNavigation() {
//        navigationController?.setNavigationBarHidden(true, animated: true)
//    }
    private func setupHeaderViewAdmin (){
        view.addSubviews(views: headerView, imgUserAvatar, lbSaleLimit, lbSaleLimitValue)
        headerView.top(toView: view)
        headerView.horizontal(toView: view)
        headerViewHeightConstraint = headerView.height(70+topInset)

        imgUserAvatar.safeTop(toView: view, space: 10)
        imgUserAvatar.left(toView: view, space: 14)
        imgUserAvatar.size(CGSize(width: 50, height: 50))
        imgUserAvatar.isUserInteractionEnabled = true
        imgUserAvatar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(avatar_touchUp)))

        lbSaleLimit.top(toView: imgUserAvatar, space: 2)
        lbSaleLimit.left(toAnchor: imgUserAvatar.rightAnchor, space: 14)

        lbSaleLimitValue.top(toAnchor: lbSaleLimit.bottomAnchor, space: 4)
        lbSaleLimitValue.left(toAnchor: imgUserAvatar.rightAnchor, space: 14)
//        headerView.addSubview(moneyView)

//        moneyView.viewConstraints(top: imgUserAvatar.bottomAnchor, left: headerView.leftAnchor, bottom: headerView.bottomAnchor, right: headerView.rightAnchor, padding: UIEdgeInsets(top: 14, left: 14, bottom: 0, right: 14))
//        moneyView.addSubview(viewChoDoiSoat)
//        viewChoDoiSoat.viewConstraints(top: moneyView.topAnchor, left: moneyView.leftAnchor, right: moneyView.rightAnchor, padding: UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12))
//
//        moneyView.addSubview(viewDaDoiSoat)
//        viewDaDoiSoat.viewConstraints(top: viewChoDoiSoat.bottomAnchor, left: moneyView.leftAnchor, bottom: moneyView.bottomAnchor, right: moneyView.rightAnchor, padding: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
//        
    }
    
  
//    private func setupHeaderView(){
//        view.addSubview(headerView)
//        headerView.viewConstraints(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor)
//        headerView.backgroundColor = .blueColor
//
//        headerView.addSubview(imgUserAvatar)
//        imgUserAvatar.viewConstraints(top: view.safeTopAnchor, left: view.leftAnchor, bottom: headerView.bottomAnchor, padding: UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 0), size: CGSize(width: 50, height: 50))
//
//        imgUserAvatar.isUserInteractionEnabled = true
//        imgUserAvatar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(avatar_touchUp)))
//
//        headerView.addSubview(lbSaleLimit)
//        lbSaleLimit.viewConstraints(top: imgUserAvatar.topAnchor, left: imgUserAvatar.rightAnchor, padding: UIEdgeInsets(top: 2, left: 14, bottom: 0, right: 0))
//
//        headerView.addSubview(lbSaleLimitValue)
//        lbSaleLimitValue.viewConstraints(top: lbSaleLimit.bottomAnchor, left: imgUserAvatar.rightAnchor, padding: UIEdgeInsets(top: 4, left: 14, bottom: 0, right: 0))
//    }
    
    @objc private func avatar_touchUp(){
        let vc = UserProfileVC()
        let limit = balances.filter({$0.accountType == "S"})
        if !limit.isEmpty {
            vc.model = limit[0]
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func setupTabbarNoAdmin(){
        let qr = TabBarItem(icon: UIImage(named: "qrcode")!, title: "Thanh toán QR")
        let service = TabBarItem(icon: UIImage(named: "add_on_service")!, title: "Dịch vụ gia tăng")
        let qrView = QRPaymentVC()
        let firstTabMain = StoringService.shared.getData("KEY_TAB_MAIN").isEmpty ? "1" : StoringService.shared.getData("KEY_TAB_MAIN")
        qrView.hideTabBar = tabbar.hideTabbar
        qrView.showTabBar = tabbar.showTabbar
        let serviceView = AddOnServiceVC()
        serviceView.hideTabBar = tabbar.hideTabbar
        serviceView.showTabBar = tabbar.showTabbar
        if firstTabMain == "1"{
            tabbar.viewControllers = [qrView, serviceView]
            tabbar.setTabBar(items: [qr, service])
        }else {
            tabbar.viewControllers = [serviceView, qrView]
            tabbar.setTabBar(items: [service, qr])
        }
      
        tabbar.currentTab = { tab in
            self.tab = tab
            self.checkTab0Or1(tab: tab)
        }
        addChild(tabbar)
        view.addSubview(tabbar.view)
        tabbar.view.viewConstraints(top: headerView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    private func setupTabbar(){
        let qr = TabBarItem(icon: UIImage(named: "qrcode")!, title: "Thanh toán QR")
        let service = TabBarItem(icon: UIImage(named: "add_on_service")!, title: "Dịch vụ gia tăng")
        let report = TabBarItem(icon: UIImage(named: "report")!, title: "Báo cáo")
        let firstTabMain = StoringService.shared.getData("KEY_TAB_MAIN").isEmpty ? "1" : StoringService.shared.getData("KEY_TAB_MAIN")
        let qrView = QRPaymentVC()
        qrView.hideTabBar = tabbar.hideTabbar
        qrView.showTabBar = tabbar.showTabbar
        let serviceView = AddOnServiceVC()
        serviceView.hideTabBar = tabbar.hideTabbar
        serviceView.showTabBar = tabbar.showTabbar
        let reportVc = ReportViewController()
        if firstTabMain == "1"{
            tabbar.viewControllers = [qrView, serviceView,reportVc]
            tabbar.setTabBar(items: [qr, service, report])
        }else {
            tabbar.viewControllers = [serviceView, qrView,reportVc]
            tabbar.setTabBar(items: [service, qr, report])
        }
        tabbar.currentTab = { tab in
            self.tab = tab
            if tab == 2 {
                self.headerViewHeightConstraint?.constant = 0
                self.view.layoutIfNeeded()
            } else {
                self.headerViewHeightConstraint?.constant = 70+topInset
                self.view.layoutIfNeeded()
                self.checkTab0Or1(tab: tab)
            }
        }
        addChild(tabbar)
        view.addSubview(tabbar.view)
        tabbar.view.viewConstraints(top: headerView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    private func checkTab0Or1(tab: Int){
//        if tab == 0 {
//            var balanceChoDS = self.balances.filter { $0.accountType == "W" }
//            let balanceDaDS = self.balances.filter { $0.accountType == "P" }
//            self.viewChoDoiSoat.title = "Số tiền chờ đối soát"
//            self.viewDaDoiSoat.title = "Số tiền đã đối soát"
//            if !balanceChoDS.isEmpty {
//                self.viewChoDoiSoat.value = Utils.currencyFormatter(amount: balanceChoDS[0].balance)
//            } else {
//                self.viewChoDoiSoat.value = Utils.currencyFormatter(amount: 0)
//            }
//            if !balanceDaDS.isEmpty {
//                self.viewDaDoiSoat.value = Utils.currencyFormatter(amount: balanceDaDS[0].balance)
//                self.balanceTypeWithdraw = balanceDaDS[0].accountType
//            } else {
//                self.viewDaDoiSoat.value = Utils.currencyFormatter(amount: 0)
//            }
//            balanceChoDSType = "W"
//        } else {
//            let balanceChoDS = self.balances.filter { $0.accountType == "H" }
//            let balanceDaDS = self.balances.filter { $0.accountType == "C" }
//            self.viewChoDoiSoat.title = "Số tiền hoa hồng chờ đối soát"
//            self.viewDaDoiSoat.title = "Số tiền hoa hồng đã đối soát"
//            if !balanceChoDS.isEmpty {
//                self.viewChoDoiSoat.value = Utils.currencyFormatter(amount: balanceChoDS[0].balance)
//            } else {
//                self.viewChoDoiSoat.value = Utils.currencyFormatter(amount: 0)
//            }
//            if !balanceDaDS.isEmpty {
//                self.viewDaDoiSoat.value = Utils.currencyFormatter(amount: balanceDaDS[0].balance)
//                self.balanceTypeWithdraw = balanceDaDS[0].accountType
//            } else {
//                self.viewDaDoiSoat.value = Utils.currencyFormatter(amount: 0)
//            }
//            balanceChoDSType = "H"
//        }
    }
}
class DoiSoatView: UIButton {
    private let imgIcon = POMaker.makeImageView()
    private let lbTitle = POMaker.makeLabel(color: .textGray2)
    private let imgRight = POMaker.makeImageView(image: UIImage(named: "arrow-right"), contentMode: .scaleAspectFit)
    private let lbValue = POMaker.makeLabel(text: Utils.formatCurrency(amount: 0),font: .helvetica.setBold().withSize(15), color: .textGray2, alignment: .right)
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    var value = "" {
        didSet{
            lbValue.text = value
        }
    }
    var title = "" {
        didSet {
            lbTitle.text = title
        }
    }
    convenience init(icon: String, title: String) {
        self.init()
        addSubview(imgIcon)
        imgIcon.viewConstraints(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, size: CGSize(width: 34, height: 34))
        imgIcon.image = UIImage(named: icon)
        addSubview(lbTitle)
        lbTitle.viewConstraints(left: imgIcon.rightAnchor, padding: UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 0), centerY: imgIcon.centerYAnchor)
        lbTitle.text = title
        addSubview(imgRight)
        imgRight.viewConstraints(right: rightAnchor, size: CGSize(width: 14, height: 14), centerY: centerYAnchor)
        addSubview(lbValue)
        lbValue.viewConstraints(left: lbTitle.rightAnchor, right: imgRight.leftAnchor, padding: UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 6), centerY: centerYAnchor)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
