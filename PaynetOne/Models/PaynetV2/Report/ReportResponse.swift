//
//  ReportResponse.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 19/09/2022.
//

import ObjectMapper

class ReportReponse: Mappable {
    var listThreeDay = [ReportItem]()
    var listDateCustomize = [ReportItem]()
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        listThreeDay <- map["listThreeDay"]
        listDateCustomize <- map["listDateCustomize"]
    }
}

class ReportItem: Mappable {
    var yield = 0, transAmount = 0, countQROnline = 0, countGTGT = 0
    var countINSTA = 0, sumQROnline = 0, sumGTGT = 0, sumINSTA = 0
    var transDate = "", nameDate = ""
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        yield <- map["Yield"]
        transAmount <- map["TransAmount"]
        countQROnline <- map["CountQROnline"]
        countGTGT <- map["CountGTGT"]
        countINSTA <- map["CountINSTA"]
        sumQROnline <- map["SumQROnline"]
        sumGTGT <- map["SumGTGT"]
        sumINSTA <- map["SumINSTA"]
        transDate <- map["TransDate"]
        nameDate <- map["NameDate"]
    }
}
