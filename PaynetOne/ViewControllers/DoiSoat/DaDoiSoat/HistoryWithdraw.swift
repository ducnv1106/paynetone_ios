//
//  HistoryWithdraw.swift
//  PaynetOne
//
//  Created by on 24/02/2022.
//

import UIKit
import ObjectMapper

class HistoryWithdrawVC: BaseUI {
    
    private var tableHistory : UITableView!
    var historyWithdraw: [WithdrawHistoryResponse] = []
    var balanceType = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LỊCH SỬ RÚT TIỀN"
        initUI()
        setupTableView()
        fetchData()
    }    
    private func initUI(){
        tableHistory = POMaker.makeTableView()
    }
    
    func setupTableView(){
        view.addSubview(tableHistory)
        tableHistory.dataSource = self
        tableHistory.register(HistoryWithdrawTBVC.self, forCellReuseIdentifier: HistoryWithdrawTBVC.identifier)
        tableHistory.vertical(toView: view)
        tableHistory.horizontal(toView: view)
    }
    
    func fetchData(){
        let config = StoringService.shared.getConfigData()
        let rq = WidthdrawHistoryRequestModel()
        rq.merchantID = config?.merchantID
        rq.balanceType = balanceType

        let rqString = Utils.objToString(rq)
        ApiManager.shared.requestList(dataRq: rqString, code: "TRANS_WITHDRAW_SEARCH", returnType: WithdrawHistoryResponse.self) { result, err in
            if let result = result {
                self.historyWithdraw = result
                self.tableHistory.reloadData()
            } else {
                self.showToast(message: err ?? "", delay: 2)
            }
        }
    }
}
extension HistoryWithdrawVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.historyWithdraw.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryWithdrawTBVC.identifier, for: indexPath) as! HistoryWithdrawTBVC
        let data = historyWithdraw[indexPath.row]
        cell.data = data
        return cell
    }
}
