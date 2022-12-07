//
//  HanMucCuaHangVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 06/10/2022.
//

import UIKit
import ObjectMapper

class HanMucCuaHangVC: BaseUI {
    private var tableView = POMaker.makeTableView()
    
    private var hanMucCuaHang = [HanMucCuaHangList]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "HẠN MỨC CỬA HÀNG"
        initUI()
        configUI()
        SwiftEventBus.onMainThread(self, name: "UpdateData") { result in
            // UI thread
            let notify  = result?.object as? NotifyData
            if notify != nil && notify == NotifyData.UPDATE{
                self.fetchData()
            }
        }
    }
    
    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        fetchData()
      
    }
    
    private func initUI(){
        tableView = POMaker.makeTableView()
    }
    private func configUI(){
        view.addSubviews(views: tableView)
        tableView.vertical(toView: view)
        tableView.horizontal(toView: view)
        tableView.dataSource = self
        tableView.register(HanMucCuaHangTBVC.self, forCellReuseIdentifier: "HanMucCuaHangTBVC")
    }
    
    private func fetchData(){
        let user = StoringService.shared.getUserData()
        let rq = OnlyPaynetIdRequest()
        rq.paynetID = user?.paynetId
        let rqString = Utils.objToString(rq)
        self.showLoading()
        ApiManager.shared.requestList(dataRq: rqString, code: "PAYNET_GET_BALANCE_BY_ID", returnType: HanMucCuaHangList.self) { result, err in
            self.hideLoading()
            if let result = result {
                self.hanMucCuaHang = result
                self.tableView.reloadData()
            } else {
                self.showToast(message: err ?? "", delay: 2)
            }
        }
    }
 
    private func getAddressByPaynetId(storeModel:HanMucCuaHangList){
        let rq = GetAddressByPaynetIdRq()
        rq.id = storeModel.PayNetID
        let rqString = Utils.objToString(rq)
        self.showLoading()
        
        ApiManager.shared.requestCodeMessageData(dataRq: rqString, code: "DIC_GET_ADDRESS_BY_PAYNETID") { code, message,response in
            self.hideLoading()
            if code == "00" {
                let responseAddress = Mapper<GetAddressByPaynetIdRes>().map(JSONString: response ?? "")
                self.showRechargeLimitVC(storeModel:storeModel,provinceCode: responseAddress?.ProvinceCode ?? "")
            } else if code == "01" {
                self.showRechargeLimitVC(storeModel:storeModel,provinceCode: "")
            }else{
                self.showToast(message: message ?? "", delay: 2, position: .center)
            }
        }
        
    }
    private func showRechargeLimitVC(storeModel:HanMucCuaHangList,provinceCode:String){
        let vc = RechargeLimitVC()
        vc.limitAmount = storeModel.Amount
        vc.provinceCode = provinceCode
        vc.code = storeModel.Code
        vc.storeModel = storeModel
//        vc.storeModel = self.hanMucCuaHang[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
                  
    }
}
extension HanMucCuaHangVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hanMucCuaHang.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HanMucCuaHangTBVC") as! HanMucCuaHangTBVC
        cell.model = hanMucCuaHang[indexPath.row]
        cell.btnNapHanMucAction = {
            let storeModel = self.hanMucCuaHang[indexPath.row]
            self.getAddressByPaynetId(storeModel:storeModel)
        }
        return cell
    }
}
class HanMucCuaHangTBVC: UITableViewCell {
    private let avatarDefault = POMaker.makeImage(image: "user_profile_default")
    private let lbAmount = POMaker.makeLabel(color: .systemRed)
    private let btnNapHanMuc = POMaker.makeButton(title: "Nạp hạn mức", font: .helvetica, cornerRadius: 5)
    private let lbNameStore = POMaker.makeLabel(color: .blueColor)
    private let lbCode = POMaker.makeLabel(color: .blueColor)
    
    var model = HanMucCuaHangList() {
        didSet {
            lbAmount.text = Utils.formatCurrency(amount: model.Amount)
            lbNameStore.text = model.Name
            lbCode.text = model.Code
        }
    }
    var btnNapHanMucAction: (() -> ())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(views: avatarDefault, lbAmount, btnNapHanMuc, lbNameStore, lbCode)
        
        avatarDefault.left(toView: contentView, space: 14)
        avatarDefault.size(CGSize(width: 50, height: 50))
        avatarDefault.centerY(toView: contentView)
        
        lbAmount.top(toView: contentView, space: 10)
        lbAmount.right(toView: contentView, space: 14)
        
        btnNapHanMuc.top(toAnchor: lbAmount.bottomAnchor, space: 6)
        btnNapHanMuc.right(toView: contentView, space: 14)
        btnNapHanMuc.bottom(toView: contentView, space: 10)
        btnNapHanMuc.width(screenWidth*0.25)
        
        lbNameStore.centerY(toView: lbAmount, space: 6)
        lbNameStore.left(toAnchor: avatarDefault.rightAnchor, space: 4)
        lbNameStore.right(toAnchor: btnNapHanMuc.leftAnchor, space: 6)
        lbCode.centerY(toView: btnNapHanMuc)
        lbCode.left(toAnchor: avatarDefault.rightAnchor, space: 4)
        
        btnNapHanMuc.addTarget(self, action: #selector(btnNapHanMuc_touchUp), for: .touchUpInside)
    }
    @objc private func btnNapHanMuc_touchUp(){
        btnNapHanMucAction?()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
