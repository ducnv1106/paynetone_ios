//
//  QRPaymentVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 09/08/2022.
//

import UIKit
import Kingfisher
import FSPagerView
import SwiftTheme

struct BottomBanner {
    var image = ""
}

class QRPaymentVC: BaseViewController {
    private var scrollView : UIScrollView!
    private var collectionView : UICollectionView!
    private var pagerView : FSPagerView!
    private var lbPromotionTitle : UILabel!
    private var balanceView :UIView!
    private var viewChoDoiSoat :DoiSoatView!
    private var viewDaDoiSoat :DoiSoatView!
    private var balanceBackground :UIView!
    
    var providers = [ProviderLocal]()
    var bankProvider = [ProviderLocal]()
    var bankProviderLimit = [ProviderLocal]()
    var walletProvider = [ProviderLocal]()
    var qrProvider = [ProviderLocal]()
    var hideTabBar: (() -> ())?
    var showTabBar: (() -> ())?
    private var startContentOffset: CGFloat!
    private var lastContentOffset: CGFloat!
    private var bannerList = [BottomBanner(image: "Banner_1"), BottomBanner(image: "Banner_2")]
    private var banner = [BannerModel]()
    
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
    override func configBackgorundColor() {
        if isDarkMode{
            view.backgroundColor = .black
            collectionView.backgroundColor = .black
        }else{
            view.backgroundColor = .backgroundColor
            collectionView.backgroundColor = .backgroundColor
        }
    }
    private func initUI(){
        scrollView = UIScrollView()
        collectionView = POMaker.makeCollectionView(screenWidth - 50, itemSpacing: 4, itemsInLine: 4, itemHeight: (screenWidth - 70)/4+30)
        pagerView = FSPagerView()
        lbPromotionTitle = POMaker.makeLabel(text: "Ưu đãi & khuyến mại",font: .helvetica.withSize(16).setBold(), color: .textGray2)
        balanceView = POMaker.makeView(borderWidth: 1, borderColor: .blueColor, radius: 10)
        viewChoDoiSoat = DoiSoatView(icon: "cho-doi-soat", title: "Số tiền chờ đối soát")
        viewDaDoiSoat = DoiSoatView(icon: "da-doi-soat", title: "Số tiền đã đối soát")
        balanceBackground = POMaker.makeView(backgroundColor: .blueColor)
        bannerList = [BottomBanner(image: "Banner_1"), BottomBanner(image: "Banner_2")]
    }
    
    private func getProvider(){
        let providerLocal = DBManager.readData(ProviderLocal.self)
        
        //        if providerLocal.isEmpty {
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
                if item.category == ProviderCate.payment.rawValue{
                    if item.type == QRType.bank.rawValue {
                        self.bankProvider.append(provider)
                    } else if item.type == QRType.qr.rawValue {
                        self.qrProvider.append(provider)
                    } else {
                        self.walletProvider.append(provider)
                    }
                }
                providerList.append(provider)
            }
            
            
            let viewAll = ProviderLocal()
            viewAll.id = 51094
            viewAll.icon = "view_all"
            viewAll.name = "Xem tất cả"
            
            if self.bankProvider.count > 7 {
                self.bankProviderLimit = Array(self.bankProvider[0..<7])
            }
            self.bankProviderLimit.append(viewAll)
            self.providers = providerList
            var qrRow = 0
            var walletRow = 0
            if !self.qrProvider.isEmpty, !self.walletProvider.isEmpty {
                qrRow = self.qrProvider.count / 4 + (self.qrProvider.count%4 > 0 ? 1 : 0)
                walletRow = self.walletProvider.count / 4 + (self.walletProvider.count%4 > 0 ? 1 : 0)
            }
            let itemHeight = (screenWidth - 70)/4+28
            let qrHeight = (40 + CGFloat(qrRow)*(itemHeight+4))
            let walletHeight = (40 + CGFloat(walletRow)*(itemHeight+4))
            self.collectionView.size(CGSize(width: 0, height: (itemHeight*2+52) + qrHeight + walletHeight))
            self.collectionView.reloadData()
        }
//        } else {
//            for item in providerLocal {
//                if item.category == ProviderCate.payment.rawValue {
//                    providers.append(item)
//                }
//            }
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBalanceMerchant()
    }
    private func getBalanceMerchant(){
        let rq = BalanceMerchantRequest()
        let user = StoringService.shared.getUserData()
        rq.paynetID = user?.paynetId
        let rqString = Utils.objToString(rq)
        ApiManager.shared.requestObject(dataRq: rqString, code: "MERCHANT_GET_BALANCE", returnType: Balance.self) { result, err in
            if let result = result {
                for item in result.MerchantBalance {
                    if item.accountType == "W" {//số tiền chờ đối soát tab QR
                        self.viewChoDoiSoat.value = Utils.formatCurrency(amount: item.balance)
                    } else if item.accountType == "P" {//số tiền đã đối soát tab QR
                        self.viewDaDoiSoat.value = Utils.formatCurrency(amount: item.balance)
                    }
                }
            }
        }
    }
    private func setupCollectionView() {
        view.addSubview(scrollView)
        scrollView.top(toView: view)
        scrollView.bottom(toAnchor: lbPromotionTitle.topAnchor, space: 10)
        scrollView.horizontal(toView: view)
//        scrollView.delegate = self

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
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .backgroundColor
        collectionView.register(QRPaymentCollectionViewCell.self, forCellWithReuseIdentifier: "QRPaymentCollectionViewCell")
        collectionView.register(ProviderSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProviderHeader")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
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
    @objc private func toWaitDS(){
        let vc = TransactionWaitDSVC()
        vc.balanceType = "W"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func goToWithdraw_touchUp(){
        let vc = WithdrawVC()
        vc.balanceType = "P"
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension QRPaymentVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QRPaymentCollectionViewCell", for: indexPath) as! QRPaymentCollectionViewCell
        let model = indexPath.section == 0 ? bankProviderLimit : indexPath.section == 1 ? qrProvider : walletProvider
        cell.model = model[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let model = section == 0 ? bankProviderLimit : section == 1 ? qrProvider : walletProvider
        return model.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ProviderHeader", for: indexPath) as! ProviderSectionHeader
            switch indexPath.section {
            case 0:
                sectionHeader.lbSectionHeader.text = "Ngân hàng"
            case 1:
                sectionHeader.lbSectionHeader.text = "Thanh toán QR"
            case 2:
                sectionHeader.lbSectionHeader.text = "Ví điện tử"
            default:
                break
            }
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = InputInfoCreateQRCodeVC()
        let item = indexPath.section == 0 ? bankProviderLimit[indexPath.row] : indexPath.section == 1 ? qrProvider[indexPath.row] : walletProvider[indexPath.row]
        vc.model = item
        if item.isActive == "N" {
            self.showPopupDevelop()
        } else if item.id == 51094 {
            let allBankVC = AllBankProviderVC()
            allBankVC.bankProvider = bankProvider
            self.navigationController?.pushViewController(allBankVC, animated: true)
        } else {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension QRPaymentVC: FSPagerViewDataSource {
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
//extension QRPaymentVC: UIScrollViewDelegate {
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        let contentOffsetY = scrollView.contentOffset.y
//        self.startContentOffset = contentOffsetY
//        self.lastContentOffset = contentOffsetY
//    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let currentOffset = scrollView.contentOffset.y
//        let differentFromStart = self.startContentOffset - currentOffset
//        let differentFromLast = self.lastContentOffset - currentOffset
//        self.lastContentOffset = currentOffset
//        if (differentFromStart < 0) {
//            if (scrollView.isTracking && abs(differentFromLast) > 1) {
//                self.hideTabBar!()
//            }
//        } else {
//            if (scrollView.isTracking && (abs(differentFromLast) > 1)) {
//                self.showTabBar!()
//            }
//        }
//    }
//
//    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
//        self.showTabBar!()
//        return true
//    }
//}
