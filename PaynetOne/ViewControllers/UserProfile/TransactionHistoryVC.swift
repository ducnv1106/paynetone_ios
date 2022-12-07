//
//  TransactionHistoryVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 19/08/2022.
//

import UIKit
import PopupDialog
import SwiftTheme

class TransactionHistoryVC: BaseUI {
    private var tableView : UITableView!
    private let imageFilter = POMaker.makeImage(image: "ic_filter")
    
    private var transactionHistory = [HistoryTransactionResponse]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "LỊCH SỬ ĐƠN HÀNG"
        initUI()
        configUI()
        getHistoryData()
        configBackgorundColor() 
    }
    private func configUI(){
//        view.addSubview(imageFilter)
//        imageFilter.viewConstraints(top: view.safeTopAnchor, left: nil, bottom: nil, right: view.rightAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 15), size: CGSize(width: 24, height: 24))
//        imageFilter.isUserInteractionEnabled = true
//        imageFilter.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showFilterHistory)))
        
        setupTableView()
    }
    
    private func initUI(){
         tableView = POMaker.makeTableView()
    }
    
    override func configBackgorundColor() {
        if isDarkMode{
            view.backgroundColor = .black
            tableView.backgroundColor = .black
        }else{
            view.backgroundColor = .white
            tableView.backgroundColor = .white
        }
    }
    
    private func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.viewConstraints(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
        tableView.register(TransactionHistoryCell.self, forCellReuseIdentifier: "TransactionHistoryCell")
    }
    func getHistoryData(isFilter:Bool = false,id:Int = 0){
        let user = StoringService.shared.getUserData()
        let rq = HistoryTransactionRequest()
        rq.empID = user?.id ?? 0
        if !isFilter {
            rq.paynetID = user?.paynetId ?? 0
        }else{
            rq.paynetID = id
        }
        let rqString = Utils.objToString(rq)
        self.showLoading()
        ApiManager.shared.requestList(dataRq: rqString, code: "ORDER_SEARCH", returnType: HistoryTransactionResponse.self) { result, err in
            self.hideLoading()
            if let result = result {
                self.transactionHistory = result
                self.tableView.reloadData()
            } else {
                self.transactionHistory.removeAll()
                self.tableView.reloadData()
                self.showToast(message: err ?? "", delay: 2)
            }
        }
    }
    
//    @objc private func showFilterHistory(){
//        if Configs.isAccountStall(){
//            self.showToast(message: "Bạn không đủ quyền thực hiện chức năng", delay: 2,position: .bottom)
//            return
//        }
//        let vc = FilterHistoryPaymentVC()
////        vc.delegateHistory = self
////        vc.isFilterHistoryVC = true
//        let popup = PopupDialog(viewController: vc,
//                                buttonAlignment: .horizontal,
//                                transitionStyle: .bounceDown,
//                                tapGestureDismissal: true,
//                                panGestureDismissal: true)
//        self.present(popup, animated: true, completion: nil)
//        
//    }
//    func requestFilter(id:Int){
//        getHistoryData(isFilter: true, id: id)
//        
//    }
}

extension TransactionHistoryVC: UITableViewDataSource,UITableViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < 0 {
            DispatchQueue.main.async {
                self.getHistoryData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionHistoryCell") as! TransactionHistoryCell
        cell.model = transactionHistory[indexPath.row]
        return cell
    }
    
}
class TransactionHistoryCell: UITableViewCell {
    private let imgLogo = POMaker.makeImage( contentMode: .scaleAspectFit)
    private let lbOrderCode = POMaker.makeLabel(font: .helvetica.setBold().withSize(16))
    private let statusView = POMaker.makeView(radius: 5)
    private let lbStatus = POMaker.makeLabel(font: .helvetica.setBold(), color: .white)
    private let lbAmount = POMaker.makeLabel(font: .helvetica.setBold(), color: .red)
    private let lbOrderDate = POMaker.makeLabel()
    
    var model = HistoryTransactionResponse() {
        didSet{
            imgLogo.image = UIImage(named: ProviderType.logo(model.paymentType))
            lbOrderCode.text = model.code
            lbAmount.text = Utils.currencyFormatter(amount: model.amount)
            statusView.backgroundColor = ProviderType.color(model.status)
            lbStatus.text = ProviderType.status(status: model.status)
            lbOrderDate.text = model.orderDate
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imgLogo)
        imgLogo.viewConstraints(left: contentView.leftAnchor, padding: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0), size: CGSize(width: 60, height: 60), centerY: contentView.centerYAnchor)
        contentView.addSubview(lbOrderCode)
        lbOrderCode.viewConstraints(top: contentView.topAnchor, left:  imgLogo.rightAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0))
        contentView.addSubview(lbAmount)
        lbAmount.viewConstraints(top: contentView.topAnchor, right: contentView.rightAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 12))
        contentView.addSubview(statusView)
        statusView.viewConstraints(top: lbAmount.bottomAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, padding: UIEdgeInsets(top: 6, left: 0, bottom: 10, right: 12))
        statusView.addSubview(lbStatus)
        lbStatus.viewConstraints(top: statusView.topAnchor, left: statusView.leftAnchor, bottom: statusView.bottomAnchor, right: statusView.rightAnchor, padding: UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6))
        contentView.addSubview(lbOrderDate)
        lbOrderDate.viewConstraints(left: imgLogo.rightAnchor, padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0), centerY: statusView.centerYAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
