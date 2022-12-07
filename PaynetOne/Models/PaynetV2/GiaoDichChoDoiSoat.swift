//
//  GiaoDichChoDoiSoat.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 12/10/2022.
//

import ObjectMapper

class ListChoDoiSoatRq: Mappable {
    var BalanceType = ""
    var MerchantID = 0
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        BalanceType >>> map["BalanceType"]
        MerchantID >>> map["MerchantID"]
    }
}
class TransactionOutwardModel: Mappable {
    var RetRefNumber = ""
    var TransAmount = 0
    var TransReason = ""
    var OrderCode = ""
    var Amount = 0
    var Fee = 0, TransCategory = 0
    var TransDate = ""
    var ProviderID = 0
    var ProviderCode = ""
    var ProviderName = ""
    var ServiceFee = 0
    var MerchantAmount = 0
    var ProviderAcntName = ""
    var balanceType = ""
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        RetRefNumber <- map["RetRefNumber"]
        TransAmount <- map["TransAmount"]
        TransReason <- map["TransReason"]
        OrderCode <- map["OrderCode"]
        Amount <- map["Amount"]
        Fee <- map["Fee"]
        TransDate <- map["TransDate"]
        ProviderID <- map["ProviderID"]
        ProviderCode <- map["ProviderCode"]
        ProviderName <- map["ProviderName"]
        ServiceFee <- map["ServiceFee"]
        MerchantAmount <- map["MerchantAmount"]
        TransCategory <- map["TransCategory"]
        ProviderAcntName <- map["ProviderAcntName"]
    }
}
