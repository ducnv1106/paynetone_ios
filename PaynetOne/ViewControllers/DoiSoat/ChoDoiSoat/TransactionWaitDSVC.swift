//
//  TransactionWaitDSVC.swift
//  PaynetOne
//
//  Created by Ngo Duy Nhat on 28/02/2022.
//

import UIKit
import ObjectMapper

class TransactionWaitDSVC: BaseUI {

    var transactions: [TransactionOutwardModel] = []
    var tableview : UITableView!
    var balanceType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "GIAO DỊCH CHỜ ĐỐI SOÁT"
        initUI()
        fetchData()
        setupTableView()
    }
    
    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
            self.view.subviews.map({ $0.removeFromSuperview() })
            self.initUI()
            self.setupTableView()
            self.view.layoutIfNeeded()
            
        }
        
    }
    private func initUI(){
        tableview = POMaker.makeTableView()
    }

    func setupTableView(){
        tableview.dataSource = self
        tableview.register(TransactionOutwardTableViewCell.self, forCellReuseIdentifier: "TransactionOutwardTableViewCell")
        view.addSubview(tableview)
        tableview.viewConstraints(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func fetchData(){
        self.showLoading()
        let rq = ListChoDoiSoatRq()
        let user = StoringService.shared.getUserData()
        rq.MerchantID = user?.merchantId ?? 0
        rq.BalanceType = balanceType
        let rqString = Utils.objToString(rq)
        ApiManager.shared.requestList(dataRq: rqString, code: "TRANS_GET_OUTWARD", returnType: TransactionOutwardModel.self) { result, err in
            self.hideLoading()
            if let result = result {
                self.transactions = result
                self.tableview.reloadData()
            } else {
                self.showToast(message: err ?? "", delay: 2)
            }
        }
    }
}

extension TransactionWaitDSVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionOutwardTableViewCell") as! TransactionOutwardTableViewCell
        let item = transactions[indexPath.row]
        item.balanceType = balanceType
        cell.item = item
        cell.selectionStyle = .none
        return cell
    }
}

class TransactionOutwardTableViewCell: UITableViewCell {
    private let idLabel = POMaker.makeLabel(font: .helvetica.setBold())
    let logoImageView = POMaker.makeImageView()
    let numberPhoneLabel = POMaker.makeLabel()
    private let amountLabel = POMaker.makeLabel(font: .helvetica.setBold())
    let dateLabel = POMaker.makeLabel()
    private let lbNameService = POMaker.makeLabel()
    
    var item = TransactionOutwardModel() {
        didSet {
            idLabel.text = item.OrderCode
            
            amountLabel.text = Utils.currencyFormatter(amount: item.Amount)
            dateLabel.text = item.TransDate
            if item.balanceType == "H" {
                logoImageView.width(0)
                numberPhoneLabel.text = item.TransReason
            }
            if !item.ProviderAcntName.isEmpty {
                lbNameService.text = "Dịch vụ: \(item.ProviderAcntName)"
            }
            switch item.ProviderCode {
            case "VIETTEL":
                logoImageView.image = UIImage(named: "logo_vtmoney")
            case "ZALO":
                logoImageView.image = UIImage(named: "logo_zalopay")
            case "SHOPEE":
                logoImageView.image = UIImage(named: "logo_shopeepay")
            case "VNPAY":
                logoImageView.image = UIImage(named: "VNPAYQR-logo")
            case "VIETQR":
                logoImageView.image = UIImage(named: "ic_viet_qr")
            case "GRAB":
                logoImageView.image = UIImage(named: "ic_moca")
            default: break
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(views: logoImageView, idLabel, amountLabel, dateLabel, numberPhoneLabel, lbNameService)
        logoImageView.viewConstraints(left: contentView.leftAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0), size: CGSize(width: 50, height: 50), centerY: contentView.centerYAnchor)
        logoImageView.contentMode = .scaleAspectFit
        
        idLabel.viewConstraints(top: contentView.topAnchor, left: logoImageView.rightAnchor, padding: UIEdgeInsets(top: 8, left: 10, bottom: 0, right: 0))

        amountLabel.viewConstraints(right: contentView.rightAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16), centerY: idLabel.centerYAnchor)
        
        dateLabel.viewConstraints(top: idLabel.bottomAnchor, right: contentView.rightAnchor, padding: UIEdgeInsets(top: 4, left: 0, bottom: 8, right: 16))
        
        numberPhoneLabel.viewConstraints(left: logoImageView.rightAnchor, padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0), centerY: dateLabel.centerYAnchor)
        lbNameService.top(toAnchor: dateLabel.bottomAnchor, space: 4)
        lbNameService.left(toAnchor: logoImageView.rightAnchor)
        lbNameService.bottom(toView: contentView, space: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
