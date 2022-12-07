//
//  PartnerWebviewVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 05/10/2022.
//

import UIKit
import WebKit

class PartnerWebviewVC: UIViewController {
    var urlWebview = ""
    var hideHeader = false
    private var urlLoaded = ""
    var isMayBay = false
    
    private var webView = WKWebView()
    private var activity = UIActivityIndicatorView()
    private var balanceView = POMaker.makeView(backgroundColor: .white, borderWidth: 1, borderColor: .blueColor, radius: 8)
    private var headerView = POMaker.makeView(backgroundColor: .blueColor)
    private let lbNameMerchant = POMaker.makeLabel(text: "Tên Merchant:")
    private let lbNameMerValue = POMaker.makeLabel()
    private let lbSoDu = POMaker.makeLabel(text: "Số dư hạn mức:")
    private let lbSoDuValue = POMaker.makeLabel(text:"0 VNĐ")
    private let imgReload = POMaker.makeButtonIcon(imageName: "ic_reload", tintColor: .black)
    
    override func loadView() {
        super.loadView()
        webView = WKWebView()
        webView.navigationDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizers()
        setupNavigationbar()
        view.addSubviews(views: headerView, webView, balanceView)
        headerView.top(toView: view)
        headerView.horizontal(toView: view)
        var webViewSpace: CGFloat = 0
        if hideHeader {
            headerView.height(37 + topInset + 10)
        } else {
            webViewSpace = 30
            headerView.height(37 + topInset + 10 + 50)
        }
        view.backgroundColor = .white
        webView.top(toAnchor: headerView.bottomAnchor, space: webViewSpace)
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
        initWebView()
    }
    @objc private func imgReload_touchUp(){
        getBalanceMerchant()
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
                for item in result.MerchantBalance {
                    if item.accountType == "S" {//hạn mức bán hàng
                        self.lbSoDuValue.text = Utils.formatCurrency(amount: item.balance)
                    }
                }
            }
        }
    }
//    hide navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if hideHeader {
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        navigationController?.isHiddenHairline = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if hideHeader {
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
        navigationController?.isHiddenHairline = false
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
        if isMayBay {
            navigationController?.popViewController(animated: true)
        } else {
            if webView.canGoBack {
                webView.goBack()
            } else {
                navigationController?.popViewController(animated: true)
            }
        }
    }
    private func initWebView(){
        guard let urlAppend = urlWebview.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            self.showToast(message: "Url không đúng", delay: 2)
            return
        }
        guard let url = URL(string: urlAppend) else {
            self.showToast(message: "Url không convert được", delay: 2)
            return
        }
        self.webView.navigationDelegate = self
        self.webView.load(URLRequest(url: url))
        
        self.webView.addSubview(activity)
        activity.startAnimating()
        activity.hidesWhenStopped = true
        
        let contentController = webView.configuration.userContentController
        contentController.add(self, name: "toggleMessageHandler")
        let js = """
            var _selector = document.querySelectorAll('a');
            for (i = 0; i < _selector.length; i++){
                if (_selector[i].innerText == 'Tải về'){
                    _selector[i].addEventListener('click', function(event) {
                        if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.toggleMessageHandler) {
                            window.webkit.messageHandlers.toggleMessageHandler.postMessage('Tai_Anh');
                        }
                    });
                } else if (_selector[i].innerText == 'Chia sẻ') {
                    _selector[i].addEventListener('click', function(event) {
                        if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.toggleMessageHandler) {
                            window.webkit.messageHandlers.toggleMessageHandler.postMessage('Chia_SE');
                        }
                    });
                }
            }
        var btnGoback = document.querySelector('div[id=btn-header-left]');
            btnGoback.addEventListener('click', function(event) {
                if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.toggleMessageHandler) {
                    window.webkit.messageHandlers.toggleMessageHandler.postMessage('GOBACK');
                }
            });
        """
        
        let scriptString = """
            var Android = {
                handlerCallPhoneClick: function(phone) {
                    window.webkit.messageHandlers.toggleMessageHandler.postMessage('handlerCallPhoneClick'+phone);
                                        
                },
            };
        """
        let script = WKUserScript(source: js, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        contentController.addUserScript(script)
        
        let scriptHotline = WKUserScript(source: scriptString, injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: true)
        contentController.addUserScript(scriptHotline)
    }
    func takeScreenshot() {
        let bounds = UIScreen.main.bounds
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        self.view.drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let activityViewController = UIActivityViewController(activityItems: [img!], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
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
}
extension PartnerWebviewVC: WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let mess = message.body as? String else {return}
        if mess == "Tai_Anh" {
            UIApplication.takeAndSaveScreenshot(view: webView, completion: { err in
                let modal = SuccessModalView()
                modal.message = "Quá trình tải xuống thành công!"
                self.popupWithView(vc: modal, okBtnTitle: "Đóng")
            })
        } else if mess == "Chia_SE" {
            self.takeAndShareScreenshot(view: webView)
        } else if mess == "GOBACK" {
            guard let currentUrl = webView.backForwardList.currentItem?.url else {return}
            if currentUrl.absoluteString.range(of: urlLoaded) != nil {
                navigationController?.popViewController(animated: true)
            } else {
                webView.goBack()
            }
        } else if mess.starts(with: "handlerCallPhoneClick") {
            let phone = mess.replacingOccurrences(of: "handlerCallPhoneClick", with: "")
            callNumber(phoneNumber: phone)
            
        }
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let url = webView.url?.absoluteString{
            if urlLoaded.isEmpty {
                self.urlLoaded = url
            }
        }
        activity.stopAnimating()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activity.stopAnimating()
    }
}
extension UINavigationController {

    var isHiddenHairline: Bool {
        get {
            guard let hairline = findHairlineImageViewUnder(navigationBar) else { return true }
            return hairline.isHidden
        }
        set {
            if let hairline = findHairlineImageViewUnder(navigationBar) {
                hairline.isHidden = newValue
            }
        }
    }

    private func findHairlineImageViewUnder(_ view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1.0 {
            return view as? UIImageView
        }

        for subview in view.subviews {
            if let imageView = self.findHairlineImageViewUnder(subview) {
                return imageView
            }
        }

        return nil
    }
}
