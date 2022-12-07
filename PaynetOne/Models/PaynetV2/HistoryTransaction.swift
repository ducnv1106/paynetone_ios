//
//  HistoryTransaction.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 18/08/2022.
//

import ObjectMapper

class HistoryTransactionRequest: Mappable {
    var empID = 0, paynetID = 0
    var fromDate = "", toDate = "", code = "", partnerCode = ""
    var mobileNumber = ""
    var serviceID = 0, paymentType = 0
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        empID <- map["EmpID"]
        fromDate <- map["FromDate"]
        toDate <- map["ToDate"]
        code <- map["Code"]
        partnerCode <- map["PartnerCode"]
        mobileNumber <- map["MobileNumber"]
        serviceID <- map["ServiceID"]
        paymentType <- map["PaymentType"]
        paynetID <- map["PaynetID"]
    }
}
class HistoryTransactionResponse: Mappable & Identifiable {
    var id = 0, empID = 0, paynetID = 0
    var code = ""
    var transCategory = 0
    var mobileNumber = "", retRefNumber = ""
    var paymentType = 0, serviceID = 0
    var serviceName = ""
    var quantity = 0, amount = 0, fee = 0, transAmount = 0
    var orderDate = "", orderDES = "", fullName = "", pidNumber = ""
    var status = "", lastChangeDate = "", offLine = "", instaType = ""
    var installmentMonth = 0, prepaidAmount = 0, prepaidPercent = 0, installmentAmount = 0
    var merchantFee = 0, monthlyAmount = 0
    var partnerCode = ""
    var merchantID = 0
    var merchantCode = "", merchantName = ""
    var paymentCate = 0, providerID = 0
    var providerCode = "", providerName = ""
    var serviceFee = 0, merchantAmount = 0
    var transRefNumber = "", counterCode = "", counterName = ""
    var shopCode = "", shopName = ""
    var CustFee = 0
    var BranchCode = "", BranchName = ""
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["ID"]
        empID <- map["EmpID"]
        paynetID <- map["PaynetID"]
        code <- map["Code"]
        transCategory <- map["TransCategory"]
        mobileNumber <- map["MobileNumber"]
        retRefNumber <- map["RetRefNumber"]
        paymentType <- map["PaymentType"]
        serviceID <- map["ServiceID"]
        serviceName <- map["ServiceName"]
        quantity <- map["Quantity"]
        amount <- map["Amount"]
        fee <- map["Fee"]
        transAmount <- map["TransAmount"]
        orderDate <- map["OrderDate"]
        orderDES <- map["OrderDes"]
        fullName <- map["FullName"]
        pidNumber <- map["PIDNumber"]
        status <- map["Status"]
        lastChangeDate <- map["LastChangeDate"]
        offLine <- map["OffLine"]
        instaType <- map["InstaType"]
        installmentMonth <- map["InstallmentMonth"]
        prepaidAmount <- map["PrepaidAmount"]
        prepaidPercent <- map["PrepaidPercent"]
        installmentAmount <- map["InstallmentAmount"]
        merchantFee <- map["MerchantFee"]
        monthlyAmount <- map["MonthlyAmount"]
        partnerCode <- map["PartnerCode"]
        merchantID <- map["MerchantID"]
        merchantCode <- map["MerchantCode"]
        merchantName <- map["MerchantName"]
        paymentCate <- map["PaymentCate"]
        providerID <- map["ProviderID"]
        providerCode <- map["ProviderCode"]
        providerName <- map["ProviderName"]
        serviceFee <- map["ServiceFee"]
        merchantAmount <- map["MerchantAmount"]
        transRefNumber <- map["TransRefNumber"]
        counterCode <- map["CounterCode"]
        counterName <- map["CounterName"]
        shopCode <- map["ShopCode"]
        shopName <- map["ShopName"]
        CustFee <- map["CustFee"]
        BranchCode <- map["BranchCode"]
        BranchName <- map["BranchName"]
    }
}
class HistoryTransactionTopupRequest: Mappable {
    var paynetID: Int?
    var returnCode: Int?
    var fromDate: Int?
    var toDate: Int?
    var retRefNumber: String?
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        paynetID >>> map["PaynetID"]
        returnCode >>> map["ReturnCode"]
        fromDate >>> map["FromDate"]
        toDate >>> map["ToDate"]
        retRefNumber >>> map["RetRefNumber"]
    }
}
class HistoryTransactionTopup: Mappable {
    var TransDate = "", TransReason = "", PaynetCode = "", MerchantCode = "", ProviderAcntName = ""
    var RetRefNumber = "", MobileNumber = "", PaynetName = "", MerchantName = ""
    var Amount = 0, ReturnCode = 0
    var Fee = 0, TransAmount = 0
    var TransCategory = 0, ID = 0
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        TransDate <- map["TransDate"]
        RetRefNumber <- map["RetRefNumber"]
        Amount <- map["Amount"]
        Fee <- map["Fee"]
        TransCategory <- map["TransCategory"]
        TransAmount <- map["TransAmount"]
        TransReason <- map["TransReason"]
        ReturnCode <- map["ReturnCode"]
        MobileNumber <- map["MobileNumber"]
        PaynetCode <- map["PaynetCode"]
        PaynetName <- map["PaynetName"]
        MerchantCode <- map["MerchantCode"]
        MerchantName <- map["MerchantName"]
        ID <- map["ID"]
        ProviderAcntName <- map["ProviderAcntName"]
    }
}
