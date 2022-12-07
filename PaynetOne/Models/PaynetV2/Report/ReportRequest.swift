//
//  ReportRequest.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 19/09/2022.
//

import Foundation
import ObjectMapper

class ReportRequest: Mappable {
    var merchantId: Int?, empId: Int?, dateMode = ""
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        merchantId >>> map["MerchantID"]
        empId >>> map["EmpID"]
        dateMode >>> map["DateMode"]
    }
}
