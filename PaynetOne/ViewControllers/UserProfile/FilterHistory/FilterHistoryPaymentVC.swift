//
//  FilterHistoryPaymentVC.swift
//  PaynetOne
//
//  Created by Duoc Nguyen  on 14/11/2022.
//

import UIKit
import DownPicker

class FilterHistoryPaymentVC: BaseUI {
    
    private var glH5 = POMaker.makeView(backgroundColor: .clear)
    private var contentView = POMaker.makeView()
    private var lbBranch = POMaker.makeLabel(text: "Chi nhánh",font: .helvetica.withSize(16))
    private var tfBranch = POMaker.makeTextField(text: "", placeholder: "Chọn chi nhánh",font: .helvetica.withSize(16),isSelector: true)
    private var viewBranch = POMaker.makeView()
    
    private var lbStore = POMaker.makeLabel(text: "Cửa hàng",font: .helvetica.withSize(16))
    private var tfStore = POMaker.makeTextField(text: "", placeholder: "Chọn cửa hàng",font: .helvetica.withSize(16),isSelector: true)
    private var viewStore = POMaker.makeView()
    
    private var lbStall = POMaker.makeLabel(text: "Quầy",font: .helvetica.withSize(16))
    private var tfStall = POMaker.makeTextField(text: "", placeholder: "Chọn quầy",font: .helvetica.withSize(16),isSelector: true)
    private var viewStall = POMaker.makeView()
    
    private var btnConfirm = POMaker.makeButton(title: "Xác nhận", font: .helvetica.withSize(16), color: .white, textAlignment: .center, backgroundColor: .blueColor, borderWidth: 0, borderColor: .clear, cornerRadius: 5)
    private var btnClose = POMaker.makeButton(title: "Đóng", font: .helvetica.withSize(16), color: .blueColor, textAlignment: .center, backgroundColor: .white, borderWidth: 1, borderColor: .blueColor, cornerRadius: 5)
    
//    weak var delegate: TransactionHistoryTopupVC!
//
//    weak var delegateHistory: TransactionHistoryVC!
    
    weak var historyDelegate: HistoryVC!
    
    var isFilterHistoryVC = false
    
    
    private var chiNhanhList: [ChiNhanhStore] = []
    private var storeList : [ChiNhanhStore] = []
    private var stallList : [ChiNhanhStore] = []
    
    
    private var branchSelected : ChiNhanhStore?
    private var storeSelected : ChiNhanhStore?
    private var stallSelected : ChiNhanhStore?
    
    private var typeFilter = TypeFillterHistory.Branch
    var branchDownPicker: DownPicker!
    var storeDownPicker: DownPicker!
    var stallDownPicker: DownPicker!
    
    private var isShowViewBranch = true
    private var isShowViewStore = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        initdownPicker()
        hideViewWithAccount()
        requestBrach()
        configBackgorundColor()
        // Do any additional setup after loading the view.
    }
    
    private func configUI(){
        view.addSubview(contentView)
        view.bottom(toView: contentView)
        //        view.height(500)
        contentView.viewConstraints(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: UIEdgeInsets(top: 20, left: 15, bottom: 10, right: 15))
        
        view.addSubview(glH5)
        glH5.viewConstraints(top: view.safeTopAnchor, left: nil, bottom: view.bottomAnchor,size: CGSize(width: 0.3, height: 0))
        let xConstraintGL5 = NSLayoutConstraint(item: glH5,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: self.view,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: (Display.width) * 0.45);
        NSLayoutConstraint.activate([xConstraintGL5])
        
        
        contentView.addSubviews(views: viewBranch,viewStore,lbStall,tfStall,btnConfirm,btnClose)
        
        viewBranch.viewConstraints(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor )
        viewBranch.addSubviews(views: lbBranch,tfBranch)
        
        lbBranch.viewConstraints(top: viewBranch.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor)
        tfBranch.viewConstraints(top: lbBranch.bottomAnchor, left: contentView.leftAnchor, bottom: viewBranch.bottomAnchor, right: contentView.rightAnchor, padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
        tfBranch.height(40)
        //        tfBranch.delegate = self
        tfBranch.isUserInteractionEnabled = true
        tfBranch.addTarget(self, action: #selector(requestBrach), for: .touchDown)
        
        viewStore.viewConstraints(top: viewBranch.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor )
        viewStore.addSubviews(views: lbStore,tfStore)
        
        lbStore.viewConstraints(top: viewStore.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor,padding: UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0))
        tfStore.viewConstraints(top: lbStore.bottomAnchor, left: contentView.leftAnchor, bottom: viewStore.bottomAnchor, right: contentView.rightAnchor, padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
        tfStore.height(40)
        //        tfStore.delegate = self
        tfStore.isUserInteractionEnabled = true
        tfStore.addTarget(self, action: #selector(requestStore), for: .touchDown)
        
        lbStall.viewConstraints(top: viewStore.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor,padding: UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0))
        tfStall.viewConstraints(top: lbStall.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
        tfStall.height(40)
        tfStall.isUserInteractionEnabled = true
        //        tfStall.delegate = self
        tfStall.addTarget(self, action: #selector(requestStall), for: .touchDown)
        
        btnConfirm.viewConstraints(top: tfStall.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: glH5.leftAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 20, right: 5))
        btnConfirm.height(40)
        btnConfirm.addTarget(self, action: #selector(requestFilterHistory), for: .touchUpInside)
        
        btnClose.viewConstraints(top: tfStall.bottomAnchor, left: glH5.rightAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, padding: UIEdgeInsets(top: 15, left: 5, bottom: 20, right: 0))
        btnClose.height(40)
        btnClose.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        
        
        //        NSLayoutConstraint.activate([
        //            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 360)])
    }

    
    private func initUI(){
        glH5 = POMaker.makeView(backgroundColor: .clear)
        contentView = POMaker.makeView()
        lbBranch = POMaker.makeLabel(text: "Chi nhánh",font: .helvetica.withSize(16))
        tfBranch = POMaker.makeTextField(text: "", placeholder: "Chọn chi nhánh",font: .helvetica.withSize(16),isSelector: true)
        viewBranch = POMaker.makeView()
        
        lbStore = POMaker.makeLabel(text: "Cửa hàng",font: .helvetica.withSize(16))
        tfStore = POMaker.makeTextField(text: "", placeholder: "Chọn cửa hàng",font: .helvetica.withSize(16),isSelector: true)
        viewStore = POMaker.makeView()
        
        lbStall = POMaker.makeLabel(text: "Quầy",font: .helvetica.withSize(16))
        tfStall = POMaker.makeTextField(text: "", placeholder: "Chọn quầy",font: .helvetica.withSize(16),isSelector: true)
        viewStall = POMaker.makeView()
        
        btnConfirm = POMaker.makeButton(title: "Xác nhận", font: .helvetica.withSize(16), color: .white, textAlignment: .center, backgroundColor: .blueColor, borderWidth: 0, borderColor: .clear, cornerRadius: 5)
        btnClose = POMaker.makeButton(title: "Đóng", font: .helvetica.withSize(16), color: .blueColor, textAlignment: .center, backgroundColor: .white, borderWidth: 1, borderColor: .blueColor, cornerRadius: 5)
    }
    
    override func configBackgorundColor() {
        if isDarkMode {
            view.applyViewDarkMode()
        }else{
            view.backgroundColor = .white
        }
    }
    
    private func initdownPicker(){
        branchDownPicker = DownPicker(textField: tfBranch)
        branchDownPicker.setPlaceholder("Chọn chi nhánh")
        branchDownPicker.setToolbarDoneButtonText("Đồng ý")
        branchDownPicker.setToolbarCancelButtonText("Hủy")
        branchDownPicker.addTarget(self, action: #selector(downPicker_valueChanged(downPicker: )), for: .valueChanged)
        
        
        storeDownPicker = DownPicker(textField: tfStore)
        storeDownPicker.setPlaceholder("Chọn cửa hàng")
        storeDownPicker.setToolbarDoneButtonText("Đồng ý")
        storeDownPicker.setToolbarCancelButtonText("Hủy")
        storeDownPicker.addTarget(self, action: #selector(downPicker_valueChanged(downPicker:)), for: .valueChanged)
        
        stallDownPicker = DownPicker(textField: tfStall)
        stallDownPicker.setPlaceholder("Chọn quầy")
        stallDownPicker.setToolbarDoneButtonText("Đồng ý")
        stallDownPicker.setToolbarCancelButtonText("Hủy")
        stallDownPicker.addTarget(self, action: #selector(downPicker_valueChanged(downPicker:)), for: .valueChanged)
    }
    
    
    @objc private func requestBrach(){
        self.typeFilter = TypeFillterHistory.Branch
        self.clearListStore()
        self.clearListStall()
        fetData()
    }
    @objc private func requestStore(){
        self.typeFilter = TypeFillterHistory.Store
        self.clearListStall()
        
        if isShowViewBranch {
            guard chiNhanhList.indices.contains(branchDownPicker.selectedIndex) else {
                self.showToast(message: "Vui lòng chọn chi nhánh!", delay: 2)
                return
            }
            branchSelected = chiNhanhList[branchDownPicker.selectedIndex]
        }
        
        fetData()
    }
    @objc private func requestStall(){
        self.typeFilter = TypeFillterHistory.Stall
        
        if isShowViewBranch {
            guard chiNhanhList.indices.contains(branchDownPicker.selectedIndex) else {
                self.showToast(message: "Vui lòng chọn chi nhánh!", delay: 2)
                return
                
            }
            branchSelected = chiNhanhList[branchDownPicker.selectedIndex]
        }
        
        if isShowViewStore {
            guard storeList.indices.contains(storeDownPicker.selectedIndex) else {
                self.showToast(message: "Vui lòng chọn cửa hàng!", delay: 2)
                return
                
            }
            storeSelected = storeList[storeDownPicker.selectedIndex]
        }
        
        fetData()
    }
    @objc private func requestFilterHistory(){
        if chiNhanhList.indices.contains(branchDownPicker.selectedIndex){
            branchSelected = chiNhanhList[branchDownPicker.selectedIndex]
        }
        if storeList.indices.contains(storeDownPicker.selectedIndex){
            storeSelected = storeList[storeDownPicker.selectedIndex]
        }
        if stallList.indices.contains(stallDownPicker.selectedIndex){
            stallSelected = stallList[stallDownPicker.selectedIndex]
        }
        if stallSelected != nil{
//            if isFilterHistoryVC {
//                delegateHistory.requestFilter(id: stallSelected?.ID ?? 0)
//            }else{
//                delegate.requestFilter(id: stallSelected?.ID ?? 0)
//            }
            historyDelegate.requestFilter(id: stallSelected?.ID ?? 0)
            closeVC()
            return
        }
        if storeSelected != nil{
//            if isFilterHistoryVC {
//                delegateHistory.requestFilter(id: storeSelected?.ID ?? 0)
//            }else{
//                delegate.requestFilter(id: storeSelected?.ID ?? 0)
//            }
            historyDelegate.requestFilter(id: storeSelected?.ID ?? 0)
            closeVC()
            return
        }
        if branchSelected != nil{
//            if isFilterHistoryVC {
//                delegateHistory.requestFilter(id: branchSelected?.ID ?? 0)
//            }else{
//                delegate.requestFilter(id: branchSelected?.ID ?? 0)
//            }
            historyDelegate.requestFilter(id: branchSelected?.ID ?? 0)
            closeVC()
            return
        }
        
        let user = StoringService.shared.getUserData()
        
//        if isFilterHistoryVC {
//            delegateHistory.requestFilter(id: user?.paynetId ?? 0)
//        }else{
//            delegate.requestFilter(id: user?.paynetId ?? 0)
//        }
        historyDelegate.requestFilter(id: user?.paynetId ?? 0)
        closeVC()
        return
        
    }
    @objc private func closeVC(){
        self.dismiss(animated: true)
    }
    
    private func fetData(){
        let config = StoringService.shared.getConfigData()
        let rq = LayChiNhanhStore()
        switch self.typeFilter {
        case .Branch:
            rq.parentID = config?.id
        case .Store:
            if branchSelected == nil && isShowViewBranch{
                self.showToast(message: "Vui lòng chọn chi nhánh!", delay: 2)
                self.clearListStore()
                return
            }else if branchSelected == nil && !isShowViewBranch{
                rq.parentID = config?.id
            }else{
                rq.parentID = branchSelected?.ID
            }
        case .Stall:
            if storeSelected == nil && isShowViewStore{
                self.showToast(message: "Vui lòng chọn cửa hàng!", delay: 2)
                self.clearListStall()
                return
            }else if storeSelected == nil && !isShowViewStore{
                rq.parentID = config?.id
            }else{
                rq.parentID = storeSelected?.ID
            }
        }
        let rqString = Utils.objToString(rq)
        ApiManager.shared.requestList(dataRq: rqString, code: "PAYNET_GET_BY_PARENT", returnType: ChiNhanhStore.self, completion: { result, err in
            if let result = result {
                switch self.typeFilter {
                case .Branch:
                    self.chiNhanhList.removeAll()
                    self.chiNhanhList = result
                    self.selectBranch()
                case .Store:
                    self.storeList.removeAll()
                    self.storeList = result
                    self.selectStore()
                    
                case .Stall:
                    self.stallList.removeAll()
                    self.stallList = result
                    self.selectStall()
                }
                
            } else {
                switch self.typeFilter {
                case .Branch:
                    self.clearListBranch()
                    
                case .Store:
                    self.clearListStore()
                    
                case .Stall:
                    self.clearListStall()
                }
                self.showToast(message: err ?? "", delay: 2)
            }
        })
    }
    
    
    private func selectBranch(){
        //        var data = [String]()
        //        for item in chiNhanhList {
        //            data.append(item.Name)
        //        }
        let data = chiNhanhList.map{$0.Name}
        branchDownPicker.setData(data)
        branchDownPicker.setPlaceholder("Chọn chi nhánh")
        
        
    }
    
    private func selectStore(){
        //        var data = [String]()
        //        for item in storeList {
        //            data.append(item.Name)
        //        }
        let data = storeList.map{$0.Name}
        storeDownPicker.setData(data)
        storeDownPicker.setPlaceholder("Chọn cửa hàng")
        
    }
    
    
    private func selectStall(){
        //        var data = [String]()
        //        for item in stallList {
        //            data.append(item.Name)
        //        }
        let data = stallList.map{$0.Name}
        stallDownPicker.setData(data)
        stallDownPicker.setPlaceholder("Chọn quầy")
        
    }
    
    @objc private func downPicker_valueChanged(downPicker: DownPicker) {
        if downPicker.getTextField() == tfBranch{
            branchSelected = chiNhanhList[downPicker.selectedIndex]
            self.clearListStore()
            self.clearListStall()
            tfBranch.text = branchSelected?.Name
        }
        if downPicker.getTextField() == tfStore {
            storeSelected = storeList[downPicker.selectedIndex]
            self.clearListStall()
        }
        if downPicker.getTextField() == tfStall {
            stallSelected = stallList[downPicker.selectedIndex]
        }
        
        
        
    }
    private func clearListBranch(){
        branchSelected = nil
        tfBranch.text = ""
        branchDownPicker.setPlaceholder("Chọn chi nhánh")
        self.chiNhanhList.removeAll()
        self.chiNhanhList = []
        self.selectBranch()
    }
    private func clearListStore(){
        storeSelected = nil
        tfStore.text = ""
        storeDownPicker.setPlaceholder("Chọn cửa hàng")
        self.storeList.removeAll()
        self.storeList = []
        self.selectStore()
    }
    private func clearListStall(){
        stallSelected = nil
        stallDownPicker.setPlaceholder("Chọn quầy")
        tfStall.text = ""
        self.stallList.removeAll()
        self.stallList = []
        self.selectStall()
    }
    
    private func hideViewWithAccount(){
        if Configs.isAccountBranch(){
            isShowViewBranch = false
            viewBranch.isHidden = true
            self.viewBranch.height(0)
            self.view.layoutIfNeeded()
            self.typeFilter = TypeFillterHistory.Store
            
            
        }
        if Configs.isAccountStore(){
            isShowViewBranch = false
            isShowViewStore = false
            
            viewBranch.isHidden = true
            viewStore.isHidden = true
            self.viewBranch.height(0)
            self.viewStore.height(0)
            self.view.layoutIfNeeded()
            self.typeFilter = TypeFillterHistory.Stall
        }
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
enum TypeFillterHistory{
    case Branch,Store,Stall
}
