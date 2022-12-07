//
//  MobileRechargeVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 17/08/2022.
//

import UIKit
import WebKit
import ContactsUI

class MobileRechargeVC: UIViewController {
    
    private var webView = WKWebView()
    var model = ProviderLocal()
    private var urlLoaded = ""
    
    private let balanceView = POMaker.makeView(backgroundColor: .white, borderWidth: 1, borderColor: .blueColor, radius: 8)
    private let headerView = POMaker.makeView(backgroundColor: .blueColor)
    private let lbNameMerchant = POMaker.makeLabel(text: "Tên Merchant:")
    private let lbNameMerValue = POMaker.makeLabel()
    private let lbSoDu = POMaker.makeLabel(text: "Số dư hạn mức:")
    private let lbSoDuValue = POMaker.makeLabel(text:"0 VNĐ")
    private let imgReload = POMaker.makeButtonIcon(imageName: "ic_reload", tintColor: .black)
    
    
    var isNapDienThoai = true

    override func loadView() {
        super.loadView()
        webView = WKWebView()
        webView.navigationDelegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizers()
        title = model.name
        setupNavigationbar()
        view.addSubviews(views: headerView, webView, balanceView)
        headerView.top(toView: view)
        headerView.horizontal(toView: view)
        headerView.height(37 + topInset + 10)
        view.backgroundColor = .white
        webView.top(toAnchor: headerView.bottomAnchor)
        webView.bottom(toView: view)
        webView.horizontal(toView: view)
        
        balanceView.safeTop(toView: view, space: 10)
        balanceView.horizontal(toView: view, space: 14)
        balanceView.height(74)
        
        balanceView.addSubviews(views: lbNameMerchant, lbNameMerValue, lbSoDu, lbSoDuValue, imgReload)
        lbNameMerchant.top(toView: balanceView, space: 14)
        lbNameMerchant.left(toView: balanceView, space: 10)
        lbNameMerValue.top(toView: balanceView, space: 14)
        lbNameMerValue.right(toView: balanceView, space: 10)
        let config = StoringService.shared.getConfigData()
        lbNameMerValue.text = config?.name
        
        lbSoDu.bottom(toView: balanceView, space: 14)
        lbSoDu.left(toView: balanceView, space: 10)
        lbSoDuValue.centerY(toView: lbSoDu)
        lbSoDuValue.right(toView: balanceView, space: 10)
        imgReload.right(toAnchor: lbSoDuValue.leftAnchor, space: 4)
        imgReload.centerY(toView: lbSoDuValue)
        imgReload.size(CGSize(width: 25, height: 25))
        imgReload.addTarget(self, action: #selector(imgReload_touchUp), for: .touchUpInside)
        getBalanceMerchant()
        if isNapDienThoai{
            viTopupAddressRequest()
        }else{
            getPartnerAddress()
        }
   
//        print("viewDidLoad")
    }
    
    @objc private func imgReload_touchUp(){
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
                    if item.accountType == "S" {//hạn mức bán hàng
                        self.lbSoDuValue.text = Utils.formatCurrency(amount: item.balance)
                    }
                }
            }
        }
    }
    //hide navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    private func setupNavigationbar(){
        view.backgroundColor = .backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.helvetica.setBold().withSize(16)]
        navigationController?.navigationBar.tintColor = .white
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "nav-bar-back"), style: .plain, target: self, action: #selector(leftBarButtonTouchUpInside))
        leftBarButton.customView?.viewConstraints(size: CGSize(width: 22, height: 22))
        navigationItem.leftBarButtonItem = leftBarButton
    }
    @objc private func leftBarButtonTouchUpInside() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    private func viTopupAddressRequest(){
        let rq = MobileRechargeUrlWebViewRequest()
        let config = StoringService.shared.getConfigData()
        rq.Code = config?.code ?? ""
        let rqString = Utils.objToString(rq)
        self.showLoading()
        ApiManager.shared.createRequest(data: rqString, code: "DIC_GET_VI_TOPUP_ADDRESS") { stt, result in
            self.hideLoading()
            if stt {
                let data = UrlWebView(JSONString: result)
                guard let urlString = data?.ReturnUrl, let urlAppend = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                    self.showToast(message: "Url không đúng", delay: 2)
                    return
                }
                guard let url = URL(string: urlAppend) else {
                    self.showToast(message: "Url không convert được", delay: 2)
                    return
                }
                self.webView.navigationDelegate = self
                self.webView.load(URLRequest(url: url))
            }
        }
       addJSToWebView()
    }
    
    
    private func getPartnerAddress(){
        let config = StoringService.shared.getConfigData()
        let address = StoringService.shared.getAddress()
        let rq = DictPartnerAddressRq()
        rq.channel = "IOS"
        rq.providerACNTCode = model.providerACNTCode
        rq.counterCode = config?.code ?? ""
        rq.provinceCode = address?.ProvinceCode ?? ""
        rq.districtCode = address?.DistrictCode ?? ""
        rq.wardCode = address?.WardCode ?? ""
        let rqString = Utils.objToString(rq)
        self.showLoading()
        
        ApiManager.shared.createRequest(data: rqString, code: "DIC_GET_PARTNER_ADDRESS") { stt, result in
            self.hideLoading()
            if stt {
                let data = UrlWebView(JSONString: result)
                guard let urlString = data?.ReturnUrl, let urlAppend = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                    self.showToast(message: "Url không đúng", delay: 2)
                    return
                }
                guard let url = URL(string: urlAppend) else {
                    self.showToast(message: "Url không convert được", delay: 2)
                    return
                }
                self.webView.navigationDelegate = self
                self.webView.load(URLRequest(url: url))
            }
        }
        
        addJSToWebView()
        
    }
    
    private func setupGestureRecognizers() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeAction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.right
        view.addGestureRecognizer(leftSwipe)
    }
    
    @objc func swipeAction(swipe: UISwipeGestureRecognizer) {
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    private func addJSToWebView(){
        let contentController = webView.configuration.userContentController
        contentController.add(self, name: "toggleMessageHandler")
        let js = """
        var _selector = document.querySelector('div[id=getcontactlist]');
        _selector.addEventListener('click', function(event) {
                if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.toggleMessageHandler) {
                    window.webkit.messageHandlers.toggleMessageHandler.postMessage('Tap_to_contact');
                }
            });
        var btnGoback = document.querySelector('div[id=btn-header-left]');
        btnGoback.addEventListener('click', function(event) {
            if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.toggleMessageHandler) {
                window.webkit.messageHandlers.toggleMessageHandler.postMessage('GOBACK');
            }
        });
        """
        let jsHotline = """
                    var _selector = document.querySelector('a[id=clickHotline]');
                    _selector.addEventListener('click', function(event) {
                            if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.toggleMessageHandler) {
                                window.webkit.messageHandlers.toggleMessageHandler.postMessage('Tap_to_hotline');
                            }
                        });
            """
        let scriptString = """
            var Android = {
                onBackPressedWebView: function() {
                    window.webkit.messageHandlers.toggleMessageHandler.postMessage('onBackPressedWebView');
                                        
                },
            };
        """
        let script = WKUserScript(source: js, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        let tapHotline = WKUserScript(source: jsHotline, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        let scriptBackPress = WKUserScript(source: scriptString, injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: true)
        contentController.addUserScript(script)
        contentController.addUserScript(tapHotline)
        contentController.addUserScript(scriptBackPress)
    }
}
extension MobileRechargeVC: WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let mess = message.body as? String else {return}
        if mess == "Tap_to_contact" {
            let cnPicker = CNContactPickerViewController()
            cnPicker.delegate = self
            self.present(cnPicker, animated: true)
        }
        if mess == "Tap_to_hotline" {
            self.webView.evaluateJavaScript("document.querySelector('a[id=clickHotline]').attributes.tel.value"){(result, error) in
                if let result = result {
                    callNumber(phoneNumber: result as! String)
                }
            }
        } else if mess == "GOBACK" {
            guard let currentUrl = webView.backForwardList.currentItem?.url else {return}
            if currentUrl.absoluteString.range(of: urlLoaded) != nil {
                navigationController?.popViewController(animated: true)
            } else {
                webView.goBack()
            }
        } else if mess == "onBackPressedWebView"{
            self.navigationController?.popViewController(animated: true)
        }
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let url = webView.url?.absoluteString{
            if urlLoaded.isEmpty {
                self.urlLoaded = url
            }
        }
    }
}
extension MobileRechargeVC: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        if !contact.phoneNumbers.isEmpty {
            let phone = contact.phoneNumbers[0].value.stringValue.replacingOccurrences(of: "-", with: "")
            let script = "passDataToWebPageView('\(contact.familyName) \(contact.givenName)', '\(phone)')"
            webView.evaluateJavaScript(script) { (result, error) in
                if let result = result {
                    print("phone is updated with message: \(result)")
                } else if let error = error {
                    print("An error occurred: \(error)")
                }
            }
        } else {
            
        }
    }
}
