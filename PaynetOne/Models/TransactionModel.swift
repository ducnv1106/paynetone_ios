//
//  TransactionModel.swift
//  PaynetOne
//
//  Created by on 24/02/2022.
//

import Foundation
import ObjectMapper

struct WithdrawType {
    var id = 0
    var type = ""
}


class WidthdrawHistoryRequestModel: Mappable {
    var merchantID: Int?
    var mobileNumber: String?
    var returnCode: Int?
    var fromDate: String?
    var toDate: String?
    var withdrawID: Int?
    var withDrawCategory: Int?
    var balanceType: String?
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        merchantID <- map["MerchantID"]
        mobileNumber <- map["MobileNumber"]
        returnCode <- map["ReturnCode"]
        fromDate <- map["FromDate"]
        toDate <- map["ToDate"]
        withdrawID <- map["WithdrawID"]
        withDrawCategory <- map["WithDrawCategory"]
        balanceType >>> map["BalanceType"]
    }
}
class WithdrawHistoryResponse: Mappable {
    var transDate, retRefNumber: String?
    var amount, fee, transAmount: Int?
    var transReason: String?, ShopCode = ""
    var returnCode: Int?
    var mobileNumber, accountNumber, fullName, bankShortName: String?
    var bankName, merchantCode, merchantName, bankRefNumber: String?
    var isCashOut, failReason: String?
    var withDrawCatefory: Int?
    var posID, walletCode, walletName, walletRefNumber: String?
    var id: Int?, ShopName = ""
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        transDate <- map["TransDate"]
        retRefNumber <- map["RetRefNumber"]
        amount <- map["Amount"]
        fee <- map["Fee"]
        transAmount <- map["TransAmount"]
        transReason <- map["TransReason"]
        returnCode <- map["ReturnCode"]
        mobileNumber <- map["MobileNumber"]
        accountNumber <- map["AccountNumber"]
        fullName <- map["FullName"]
        bankShortName <- map["BankShortName"]
        bankName <- map["BankName"]
        merchantCode <- map["MerchantCode"]
        merchantName <- map["MerchantName"]
        bankRefNumber <- map["BankRefNumber"]
        isCashOut <- map["IsCashOut"]
        failReason <- map["FailReason"]
        withDrawCatefory <- map["WithDrawCatefory"]
        posID <- map["PosID"]
        id <- map["ID"]
        walletCode <- map["WalletCode"]
        walletName <- map["WalletName"]
        walletRefNumber <- map["WalletRefNumber"]
        ShopCode <- map["ShopCode"]
        ShopName <- map["ShopName"]
    }
}
