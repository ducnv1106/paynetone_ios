//
//  HistoryVC.swift
//  PaynetOne
//
//  Created by Duoc Nguyen  on 01/12/2022.
//

import UIKit
import BetterSegmentedControl
import PopupDialog

class HistoryVC: BaseUI {
    private var control : BetterSegmentedControl!
    private var tabbarViewController : UITabBarController!
    private let imageFilter = POMaker.makeImage(image: "ic_filter")
    private var transactionHistoryVC: TransactionHistoryVC!
    private var transactionHistoryTopupVC: TransactionHistoryTopupVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "LỊCH SỬ GIAO DỊCH"
        initUI()
        configUI()
        loadViewController()
        configBackgorundColor()
        
        // Do any additional setup after loading the view.
    }
    
    override func configBackgorundColor() {
        if isDarkMode{
            self.view.backgroundColor = .black
        }else{
            self.view.backgroundColor = .white
        }
    }
    
    func loadViewController(){
        tabbarViewController.tabBar.isHidden = true
        transactionHistoryVC = TransactionHistoryVC()
        transactionHistoryTopupVC = TransactionHistoryTopupVC()
        tabbarViewController.viewControllers = [transactionHistoryVC, transactionHistoryTopupVC]
    }
    
    private func initUI(){
        control  = BetterSegmentedControl(
            frame: CGRect(x: 0, y: 0, width: 200.0, height: 30.0),
            segments: LabelSegment.segments(withTitles: ["Thanh toán QR", "Dịch vụ gia tăng"],
                                            normalTextColor: .lightGray,
                                            selectedTextColor: .white),
            options:[.backgroundColor(isDarkMode ? .black : .backgroundColor),
                     .indicatorViewBackgroundColor(.blueColor),
                     .cornerRadius(5.0),
                     .animationSpringDamping(1.0)])
        
        control.addTarget(self,action: #selector(self.navigationSegmentedControlValueChanged(_:)),
                          for: .valueChanged)
        
        tabbarViewController = UITabBarController()
        
        control.layer.borderWidth = 0.3
        control.layer.borderColor = UIColor.blueColor.cgColor
        
        if isDarkMode{
            tabbarViewController.tabBar.backgroundColor = .black
        }else{
            tabbarViewController.tabBar.backgroundColor = .white
           
        }
        
        
    }
    private func configUI(){
        view.addSubview(control)
        control.viewConstraints(top: view.safeTopAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15))
        control.height(45)
        
        view.addSubview(imageFilter)
        imageFilter.viewConstraints(top: control.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 15),size: CGSize(width: 24, height: 24))
        imageFilter.isUserInteractionEnabled = true
        imageFilter.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showFilterHistory)))
        
        addChild(tabbarViewController)
        view.addSubview(tabbarViewController.view)
        tabbarViewController.view.viewConstraints(top: imageFilter.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,padding: UIEdgeInsets(top: 3, left: 0, bottom: 0, right: 0))
        
    }
    
    @objc private func showFilterHistory(){
        if Configs.isAccountStall(){
            self.showToast(message: "Bạn không đủ quyền thực hiện chức năng", delay: 2,position: .bottom)
            return
        }
        let vc = FilterHistoryPaymentVC()
        vc.historyDelegate = self
        let popup = PopupDialog(viewController: vc,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: true)
        self.present(popup, animated: true, completion: nil)
    }
    
    func requestFilter(id:Int){
        if tabbarViewController.selectedIndex == 0 {
            transactionHistoryVC.getHistoryData(isFilter: true, id: id)
        }else{
            transactionHistoryTopupVC.fetchData(isFilter: true, id: id)
        }
    }
    
    // MARK: - Action handlers
    @objc func navigationSegmentedControlValueChanged(_ sender: BetterSegmentedControl) {
        tabbarViewController.selectedIndex = sender.index
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
