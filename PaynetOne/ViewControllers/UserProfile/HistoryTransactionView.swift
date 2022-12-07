//
//  HistoryTransactionView.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 18/08/2022.
//

import SwiftUI

struct HistoryTransactionView: View {
    weak var navigationController: UINavigationController?
    @ObservedObject var history = HistoryObserver()
    var body: some View {
        List(history.histories) { i in
            Text(i.shopName)
        }.onAppear {
            history.getHistoryTransaction()
        }
    }
}

struct HistoryTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryTransactionView()
    }
}
class HistoryObserver: ObservableObject {
    @Published var histories = [HistoryTransactionResponse]()
    @Published var error = ""
    @Published var loading = true
    
    func getHistoryTransaction(){
        let user = StoringService.shared.getUserData()
        let rq = HistoryTransactionRequest()
        rq.empID = user?.id ?? 0
        let rqString = Utils.objToString(rq)
        ApiManager.shared.requestList(dataRq: rqString, code: "ORDER_SEARCH", returnType: HistoryTransactionResponse.self) { result, err in
            self.loading = false
            if let result = result {
                self.histories = result
            } else {
                self.error = err ?? ""
            }
        }
    }
}
