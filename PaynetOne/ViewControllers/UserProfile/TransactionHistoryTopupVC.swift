//
//  TransactionHistoryTopupVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 19/08/2022.
//

import UIKit
import PopupDialog

class TransactionHistoryTopupVC: BaseUI {
    private var tableView : UITableView!
    private let imageFilter = POMaker.makeImage(image: "ic_filter")
    
    var histories = [HistoryTransactionTopup]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "LỊCH SỬ GIAO DỊCH"
        initUI()
        configUI()
        fetchData()
        configBackgorundColor()
    }
    private func configUI(){
//        view.addSubview(imageFilter)
//        imageFilter.viewConstraints(top: view.safeTopAnchor, left: nil, bottom: nil, right: view.rightAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 15), size: CGSize(width: 24, height: 24))
//        imageFilter.isUserInteractionEnabled = true
//        imageFilter.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showFilterHistory)))
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryTopupTableViewCell.self, forCellReuseIdentifier: "HistoryTopupTableViewCell")
        tableView.viewConstraints(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
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

    func fetchData(isFilter:Bool = false,id:Int = 0){
        self.showLoading()
        let user = StoringService.shared.getUserData()
        let rq = HistoryTransactionTopupRequest()
        if !isFilter {
            rq.paynetID = user?.paynetId
        }else{
            rq.paynetID = id
        }
        let rqString = Utils.objToString(rq)
        ApiManager.shared.requestList(dataRq: rqString, code: "TRANS_SEARCH", returnType: HistoryTransactionTopup.self) { result, err in
            self.hideLoading()
            if let result = result {
                self.histories = result
                self.tableView.reloadData()
            } else {
                self.histories.removeAll()
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
////        vc.delegate = self
//        let popup = PopupDialog(viewController: vc,
//                                buttonAlignment: .horizontal,
//                                transitionStyle: .bounceDown,
//                                tapGestureDismissal: true,
//                                panGestureDismissal: true)
//        self.present(popup, animated: true, completion: nil)
//        
//    }
//    func requestFilter(id:Int){
//        fetchData(isFilter: true, id: id)
//        
//    }
}
extension TransactionHistoryTopupVC: UITableViewDataSource, UITableViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < 0 {
            DispatchQueue.main.async {
                self.fetchData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return histories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTopupTableViewCell") as! HistoryTopupTableViewCell
        cell.model = histories[indexPath.row]
        return cell
    }
}
class HistoryTopupTableViewCell: UITableViewCell {
    private let lbRetRefNumber = POMaker.makeLabel(font: .helvetica.setBold())
    private let lbAmount = POMaker.makeLabel(font: .helvetica.setBold(), color: .red)
    private let lbTransReason = POMaker.makeLabel()
    private let lbTimeCreate = POMaker.makeLabel()
    private let transactionStatus = StatusView()
    private let lbSerivce = POMaker.makeLabel()
    var model = HistoryTransactionTopup() {
        didSet {
            lbRetRefNumber.text = model.RetRefNumber
            lbAmount.text = Utils.currencyFormatter(amount: model.TransAmount)
            lbTransReason.text = model.TransReason
            lbTimeCreate.text = model.TransDate
            lbSerivce.text = "Dịch vụ: \(model.ProviderAcntName)"
            if model.ReturnCode == 0 {
                transactionStatus.label.text = "Thành công"
                transactionStatus.backgroundColor = .statusPaid
            } else if model.ReturnCode == 1 {
                transactionStatus.label.text = "Đang xử lý"
                transactionStatus.backgroundColor = .blueColor
            } else {
                transactionStatus.label.text = "Thất bại"
                transactionStatus.backgroundColor = .thatBaicolo
            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(views: lbRetRefNumber, lbTimeCreate, lbSerivce, lbAmount, lbTransReason, transactionStatus)
        lbRetRefNumber.viewConstraints(top: contentView.topAnchor, left: contentView.leftAnchor, padding: UIEdgeInsets(top: 10, left: 14, bottom: 0, right: 0))
        
        lbTimeCreate.viewConstraints(top: lbRetRefNumber.bottomAnchor, left: contentView.leftAnchor, padding: UIEdgeInsets(top: 4, left: 14, bottom: 0, right: 0))
        
        lbSerivce.top(toAnchor: lbTimeCreate.bottomAnchor, space: 4)
        lbSerivce.left(toView: contentView, space: 14)
        
        lbAmount.viewConstraints(top: contentView.topAnchor, right: contentView.rightAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 14))
        
        lbTransReason.viewConstraints(top: lbSerivce.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, padding: UIEdgeInsets(top: 4, left: 14, bottom: 10, right: 0))
        lbTransReason.width(screenWidth*0.68)

        transactionStatus.viewConstraints(top: lbAmount.bottomAnchor, right: contentView.rightAnchor, padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 14))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
