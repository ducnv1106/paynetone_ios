//
//  MuaVeMayBayVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 14/10/2022.
//

import UIKit

class MuaVeMayBayVC: BaseUI {

    override func viewDidLoad() {
        super.viewDidLoad()

        let config = StoringService.shared.getConfigData()
        let rq = OrderGetByCodeModel()
        rq.code = config?.code
        let rqString = Utils.objToString(rq)
        ApiManager.shared.testRequest(data: rqString, code: "DIC_GET_VBOOKING_ADDRESS")
    }
}
