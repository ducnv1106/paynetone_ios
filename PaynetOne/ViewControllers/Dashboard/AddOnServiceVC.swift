//
//  AddOnServiceVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 13/08/2022.
//

import UIKit
import FSPagerView
import PopupDialog
import Lottie
import SwiftTheme

class AddOnServiceVC: BaseViewController {
    private var collectionView : UICollectionView!
    private var scrollView :UIScrollView!
    private var balanceView :UIView!
    private var viewChoDoiSoat :DoiSoatView!
    private var viewDaDoiSoat :DoiSoatView!
    private var balanceBackground :UIView!
    private var pagerView :FSPagerView!
    private var lbPromotionTitle : UILabel!
    
    var serviceProvider = [ProviderLocal]()
    var hideTabBar: (() -> ())?
    var showTabBar: (() -> ())?
    private var startContentOffset: CGFloat!
    private var lastContentOffset: CGFloat!
    private var banner = [BannerModel]()
    
    private var position = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setupBottomBanner()
        setupCollectionView()
        getProvider()
        getBanner()
        if Configs.isAdmin() {
            balanceBackground.isHidden = false
            balanceView.isHidden = false
        } else {
            balanceBackground.isHidden = true
            balanceView.isHidden = true
            balanceView.height(0)
        }
        configBackgorundColor()
        
    }
    
    private func initUI(){
        collectionView = POMaker.makeCollectionView(screenWidth - 50, itemSpacing: 4, itemsInLine: 4, itemHeight: (screenWidth - 70)/4+30)
        scrollView = UIScrollView()
        balanceView = POMaker.makeView(borderWidth: 1, borderColor: .blueColor, radius: 10)
        viewChoDoiSoat = DoiSoatView(icon: "cho-doi-soat", title: "Hoa hồng chờ đối soát")
        viewDaDoiSoat = DoiSoatView(icon: "da-doi-soat", title: "Hoa hồng đã đối soát")
        balanceBackground = POMaker.makeView(backgroundColor: .blueColor)
        pagerView = FSPagerView()
        lbPromotionTitle = POMaker.makeLabel(text: "Ưu đãi & khuyến mại",font: .helvetica.withSize(16).setBold(), color: .textGray2)
    }
    
    override func configBackgorundColor() {
        if isDarkMode{
            view.backgroundColor = .black
            collectionView.backgroundColor = .black
        }else{
            view.backgroundColor = .backgroundColor
            collectionView.backgroundColor = .backgroundColor
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBalanceMerchant()
    }
    
    private func getProvider(){
        ApiManager.shared.requestList(code: "DIC_GET_PROVIDERS", returnType: Provider.self) { [self] result, err in
            guard let result = result, !result.isEmpty else {
                self.showToast(message: err ?? "Lỗi lấy danh sách dịch vụ", delay: 2)
                return
            }
            var providerList = [ProviderLocal]()
            for item in result {
                let provider = ProviderLocal()
                provider.id = item.id
                provider.code = item.code
                provider.name = item.name
                provider.type = item.type
                provider.category = item.category
                provider.icon = item.icon
                provider.paymentType = item.paymentType
                provider.isActive = item.isActive
                provider.providerACNTCode = item.providerACNTCode
                if item.category == ProviderCate.service.rawValue{
                    providerList.append(provider)
                }
              
            }
            self.serviceProvider = providerList
          
            var numberOfRow = 0
            if !self.serviceProvider.isEmpty {
                numberOfRow = self.serviceProvider.count / 4 + (self.serviceProvider.count%4 > 0 ? 1 : 0)
            }
            let itemHeight = (screenWidth - 70)/4+28
            let qrHeight = (40 + CGFloat(numberOfRow)*(itemHeight+4))
            self.collectionView.size(CGSize(width: 0, height: qrHeight))
            self.collectionView.reloadData()
    
        }
    }
    private func getBalanceMerchant(){
        let rq = BalanceMerchantRequest()
        let user = StoringService.shared.getUserData()
        rq.paynetID = user?.paynetId
        let rqString = Utils.objToString(rq)
        ApiManager.shared.requestObject(dataRq: rqString, code: "MERCHANT_GET_BALANCE", returnType: Balance.self) { result, err in
            if let result = result {
                for item in result.MerchantBalance {
                    if item.accountType == "H" {//số tiền chờ đối soát tab GTGT
                        self.viewChoDoiSoat.value = Utils.formatCurrency(amount: item.balance)
                    } else if item.accountType == "C" {//số tiền đã đối soát tab GTGT
                        self.viewDaDoiSoat.value = Utils.formatCurrency(amount: item.balance)
                    }
                }
            }
        }
    }
    private func getBanner(){
        ApiManager.shared.requestList(code: "DIC_GET_APP_BANNER", returnType: BannerModel.self) { result, err in
            if let result = result {
                self.banner = result
                self.pagerView.reloadData()
            } else {
                
            }
        }
    }
    private func setupCollectionView() {
        view.addSubview(scrollView)
        scrollView.top(toView: view)
        scrollView.bottom(toAnchor: lbPromotionTitle.topAnchor, space: 10)
        scrollView.horizontal(toView: view)
        
        scrollView.addSubviews(views: balanceBackground, balanceView, collectionView)
        
        balanceBackground.top(toView: scrollView, space: -500)
        balanceBackground.horizontal(toView: view)
        
        balanceView.top(toView: scrollView)
        balanceView.horizontal(toView: view, space: 14)
        balanceView.addSubviews(views: viewChoDoiSoat, viewDaDoiSoat)
        
        balanceBackground.bottom(toView: balanceView, space: 26)
        
        viewChoDoiSoat.top(toView: balanceView, space: 12)
        viewChoDoiSoat.horizontal(toView: balanceView, space: 12)
        viewChoDoiSoat.addTarget(self, action: #selector(toWaitDS), for: .touchUpInside)
        
        viewDaDoiSoat.top(toAnchor: viewChoDoiSoat.bottomAnchor, space: 12)
        viewDaDoiSoat.horizontal(toView: balanceView, space: 12)
        viewDaDoiSoat.bottom(toView: balanceView, space: 12)
        viewDaDoiSoat.addTarget(self, action: #selector(goToWithdraw_touchUp), for: .touchUpInside)
        
        collectionView.top(toAnchor: balanceView.bottomAnchor)
        collectionView.horizontal(toView: view, space: 14)
        collectionView.bottom(toView: scrollView, space: 14)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .backgroundColor
        collectionView.register(AddOnServiceCollectionViewCell.self, forCellWithReuseIdentifier: "AddOnServiceCollectionViewCell")
        collectionView.register(ProviderSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProviderHeader")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        
//        var numberOfRow = 0
//        if !self.serviceProvider.isEmpty {
//            numberOfRow = self.serviceProvider.count / 4 + (self.serviceProvider.count%4 > 0 ? 1 : 0)
//        }
//        let itemHeight = (screenWidth - 70)/4+28
//        let qrHeight = (40 + CGFloat(numberOfRow)*(itemHeight+4))
//        self.collectionView.size(CGSize(width: 0, height: qrHeight))
//        self.collectionView.reloadData()
    }
    private func setupBottomBanner(){
        view.addSubviews(views: pagerView, lbPromotionTitle)
        pagerView.safeBottom(toView: view, space: 54)
        pagerView.horizontal(toView: view)
        pagerView.height(150)
        pagerView.dataSource = self
        
        lbPromotionTitle.bottom(toAnchor: pagerView.topAnchor, space: 8)
        lbPromotionTitle.left(toView: view, space: 24)
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.itemSize = CGSize(width: screenWidth - 70, height: 150)
        pagerView.interitemSpacing = 14
        pagerView.automaticSlidingInterval = 5.0
        pagerView.isInfinite = true
    }
    private func selectedService(item: ProviderLocal){
        switch item.id {
        case 77: //nạp tiền điện thoại
            let vc = MobileRechargeVC()
            vc.model = item
            self.navigationController?.pushViewController(vc, animated: true)
        case 20: //tiền điện
            getPartnerAddress(item: item)
        case 21: //tiền nước
            getPartnerAddress(item: item)
        case 22: //internet
            getPartnerAddress(item: item)
        case 23: //truyen hinh
            getPartnerAddress(item: item)
        case 26: //tai chinh
            getPartnerAddress(item: item)
        case 27: //bao hiem
            getPartnerAddress(item: item)
        case 18, 19:
            let vc = MobileRechargeVC()
            vc.model = item
            vc.isNapDienThoai = false
            self.navigationController?.pushViewController(vc, animated: true)
        case 78:
            getVBookingAddress(item: item)//mua ve may bay
        default:
            //            self.buildPopup(title: "Thông báo", msg: "Chức năng đang phát triển!", okBtnTitle: "Đóng")
            self.showPopupDevelop()
        }
    }
    
    private func getVBookingAddress(item: ProviderLocal){
        let config = StoringService.shared.getConfigData()
        let rq = OrderGetByCodeModel()
        rq.code = config?.code
        let rqString = Utils.objToString(rq)
        self.showLoading()
        ApiManager.shared.requestObject(dataRq: rqString, code: "DIC_GET_VBOOKING_ADDRESS", returnType: UrlWebView.self) { result, err in
            self.hideLoading()
            if let result = result {
                let vc = PartnerWebviewVC()
                vc.urlWebview = result.ReturnUrl
                vc.title = item.name.uppercased()
                vc.isMayBay = true
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.showToast(message: err ?? "", delay: 2, position: .center)
            }
        }
    }
    
    private func getPartnerAddress(item: ProviderLocal, isHideHeader: Bool = false){
        let config = StoringService.shared.getConfigData()
        let address = StoringService.shared.getAddress()
        let rq = DictPartnerAddressRq()
        rq.channel = "IOS"
        rq.providerACNTCode = item.providerACNTCode
        rq.counterCode = config?.code ?? ""
        rq.provinceCode = address?.ProvinceCode ?? ""
        rq.districtCode = address?.DistrictCode ?? ""
        rq.wardCode = address?.WardCode ?? ""
        let rqString = Utils.objToString(rq)
        self.showLoading()
        ApiManager.shared.requestObject(dataRq: rqString, code: "DIC_GET_PARTNER_ADDRESS", returnType: UrlWebView.self) { result, err in
            self.hideLoading()
            if let result = result {
                let vc = PartnerWebviewVC()
                vc.hideHeader = isHideHeader
                vc.urlWebview = result.ReturnUrl
                vc.title = item.name.uppercased()
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.showToast(message: err ?? "", delay: 2, position: .center)
            }
        }
    }
    @objc private func toWaitDS(){
        let vc = TransactionWaitDSVC()
        vc.balanceType = "H"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func goToWithdraw_touchUp(){
        let vc = WithdrawVC()
        vc.balanceType = "C"
        vc.tkIndex = 1
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension AddOnServiceVC: FSPagerViewDataSource {
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return banner.count
    }
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let bannerPath = self.banner[index].BannerValue.replacingOccurrences(of: "\\", with: "/")
        cell.imageView?.kfImage(urlStr: bannerPath)
        cell.contentView.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        return cell
    }
}
extension AddOnServiceVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serviceProvider.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddOnServiceCollectionViewCell", for: indexPath) as! AddOnServiceCollectionViewCell
        cell.model = serviceProvider[indexPath.row]
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ProviderHeader", for: indexPath) as! ProviderSectionHeader
            sectionHeader.lbSectionHeader.text = "Dịch vụ gia tăng"
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.position = indexPath.row
        let modal = PopupEnterPin()
        modal.delegate = self
        let isActive = serviceProvider[indexPath.row].isActive
        if isActive == "N" || isActive.isEmpty{
            //            let vc = PopupDevelopVC()
            //            let popup = PopupDialog(viewController: vc,
            //                                    buttonAlignment: .horizontal,
            //                                    transitionStyle: .fadeIn,
            //                                    tapGestureDismissal: true,
            //                                    panGestureDismissal: true)
            //            self.present(popup, animated: true, completion: nil)
            self.showPopupDevelop()
            //            self.buildPopup(title: "Thông báo", msg: "Chức năng đang phát triển!", okBtnTitle: "Đóng")
            return
        }// 78:vmb 17:thue bao ts| 18:ntgame | 19; topupdata | 24: nap rut mobile
        guard StoringService.shared.getUserData() != nil else {
            self.showToast(message: "Không lấy được thông tin người dùng", delay: 2)
            return
        }
        
        if !StoringService.shared.isExistPinCode() {
            self.buildPopup(title: "", msg: "Quý khách chưa cài đặt mã PIN, vui lòng tạo mã PIN để sử dụng dịch vụ gia tăng", okBtnTitle: "Đóng")
            return
        }
        let popup = PopupDialog(viewController: modal,
                                buttonAlignment: .horizontal,
                                transitionStyle: .fadeIn,
                                tapGestureDismissal: true,
                                panGestureDismissal: true)
        self.present(popup, animated: true)
    }
    
    func requestVerifyPinCode(pincode:String){
        self.dismiss(animated: true)
        self.showLoading()
        let user = StoringService.shared.getUserData()
        let rq = PinVerifyRequest()
        rq.password = ""
        rq.pIN = pincode
        rq.empID = user?.IDMerAdmin ?? 0
        rq.mobileNumber = user?.phoneNumber ?? ""
        let rqString = Utils.objToString(rq)
        ApiManager.shared.requestCodeMessage(dataRq: rqString, code: "EMP_PIN_VERIFY") { code, message in
            self.hideLoading()
            if code == "00" {
                self.selectedService(item: self.serviceProvider[self.position])
            } else {
                self.showToast(message: message ?? "", delay: 2, position: .center)
            }
        }
    }
}
class PopupEnterPin: UIViewController, OTPFieldViewDelegate {
    private let headerView = POMaker.makeView(backgroundColor: .blueColor)
    private let titleHeader = POMaker.makeLabel(text: "Nhập mã PIN để mở khóa", font: .helvetica.withSize(16), color: .white)
    private let pinField = OTPFieldView()
    let alertEmpty = POMaker.makeLabel(text: "Vui lòng nhập mã PIN", font: .helvetica.withSize(14), color: .darkRed, alignment: .center)
    var pinCode = ""
    
    weak var delegate: AddOnServiceVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(views: headerView, pinField, alertEmpty)
        headerView.top(toView: view)
        headerView.horizontal(toView: view)
        headerView.height(48)
        headerView.addSubview(titleHeader)
        titleHeader.center(toView: headerView)
        pinField.top(toAnchor: headerView.bottomAnchor, space: 16)
        pinField.horizontal(toView: view, space: 70)
        pinField.bottom(toView: view, space: 20)
        pinField.height(80)
        
        pinField.secureEntry = true
        pinField.secureEntryFont = .helvetica.withSize(40)
        pinField.displayType = .underlinedBottom
        pinField.fieldsCount = 4
        pinField.fieldBorderWidth = 1
        pinField.otpViewHeight = 80
        pinField.otpViewWidth = 200
        pinField.filledBorderColor = .blueColor
        pinField.defaultBorderColor = .gray
        pinField.fieldSize = 30
        pinField.separatorSpace = 13
        pinField.delegate = self
        pinField.initializeUI()
        
        alertEmpty.top(toAnchor: pinField.bottomAnchor)
        alertEmpty.horizontal(toView: view)
        alertEmpty.isHidden = true
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp: String) {
        delegate.requestVerifyPinCode(pincode: otp)
        pinCode = otp
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        print("------hasEnteredAllOTP", hasEnteredAll)
        if !hasEnteredAll {
            alertEmpty.isHidden = false
        } else {
            alertEmpty.isHidden = true
        }
        return true
    }
}

class PopupDevelopVC : BaseUI {
    
    private var animationView: LottieAnimationView!
    private var viewContent : UIView!
    private var lbTitle :UILabel!
    private var lbMessage : UILabel!
    private var btnClose : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        configUI()
        configBackgorundColor()
        
        
    }
    
    private func initUI(){
        viewContent = POMaker.makeView()
        lbTitle = POMaker.makeLabel(text: "Thông báo", font: .helvetica.withSize(18), color: .blueColor, alignment: .center)
        lbMessage = POMaker.makeLabel(text: "Chức năng đang trong quá trình phát triển.Vui lòng chọn chức năng khác", font: .helvetica.withSize(15), color: .black, alignment: .center)
        btnClose = POMaker.makeButton(title: "ĐÓNG", font: .helvetica.withSize(15), color: .white, textAlignment: .center, backgroundColor: .blueColor, cornerRadius: 5)
        
    }
    
    
    
    private func configUI(){
        view.addSubview(viewContent)
        configAnimationView()
        
        viewContent.viewConstraints(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, padding: UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15))
        
        viewContent.addSubviews(views: lbTitle,lbMessage,btnClose,animationView)
        
        animationView.viewConstraints(top: viewContent.topAnchor, left: viewContent.leftAnchor, bottom: nil, right: viewContent.rightAnchor,padding: UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0))
        
        lbTitle.viewConstraints(top: animationView.bottomAnchor, left: viewContent.leftAnchor, bottom: nil, right: viewContent.rightAnchor,padding: UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0))
        
        lbMessage.viewConstraints(top: lbTitle.bottomAnchor, left: viewContent.leftAnchor, bottom: nil, right: viewContent.rightAnchor,padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        
        btnClose.viewConstraints(top: lbMessage.bottomAnchor, left: viewContent.leftAnchor, bottom: viewContent.bottomAnchor, right: viewContent.rightAnchor,padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
        btnClose.addTarget(self, action: #selector(onDissmiss), for: .touchUpInside)
        
        btnClose.height(40)
    }
    
    private func configAnimationView(){
        // 2. Start AnimationView with animation name (without extension)
        
        animationView = .init(name: "develop")
        
        animationView.height(120)
        animationView.width(120)
        
        // 3. Set animation content mode
        
        animationView!.contentMode = .scaleAspectFit
        
        // 4. Set animation loop mode
        
        animationView!.loopMode = .loop
        
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
        self.dismiss(animated: true)
    }
}
