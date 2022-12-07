//
//  OrderModel.swift
//  PaynetOne
//
//  Created by vinatti on 08/01/2022.
//

import Foundation
import ObjectMapper

class OrderGetByCodeModel: Mappable {
    var code: String?
    
    init(){}
    required init?(map: Map) {}

    func mapping(map: Map) {
        code <- map["Code"]
    }
}

class OrderSearchModel: Mappable {
    var empID: Int?
    var fromDate, toDate, code, partnerCode: String?
    var mobileNumber: String?
    var serviceID, paymentType: Int?
    
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
    }
}

class OrderNewModel: Mappable {
    var returnURL: String?
    var orderCode: String?
    init(){}
    required init?(map: Map) {}
    func mapping(map: Map) {
        returnURL <- map["ReturnURL"]
        orderCode <- map["OrderCode"]
    }
}

class StatusOrderModel: Mappable {
    var id = 0, empId = 0, paynetId = 0, transCategory = 0, paymentType = 0, serviceID = 0
    var amount = 0, fee = 0, transAmount = 0, installmentMonth = 0, prepaidAmount = 0, prepaidPercent = 0
    var installmentAmount = 0, merchantFee = 0, monthlyAmount = 0, merchantID = 0, PaymentCate = 0
    var ServiceFee = 0, MerchantAmount = 0, CustFee = 0, quantity = 0, ProviderID = 0
    var code = "", mobileNumber = "", retRefNumber = "", serviceName = "", orderDate = "", orderDes = ""
    var fullName = "", pIDNumber = "", status = "", lastChangeDate = "", offLine = "", instaType = ""
    var partnerCode = "", merchantCode = "", merchantName = "", ProviderCode = "", ProviderName = "", BranchName = ""
    var TransRefNumber = "", CounterCode = "", CounterName = "", ShopCode = "", ShopName = "", BranchCode = ""
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["ID"]
        empId <- map["EmpID"]
        paynetId <- map["PaynetID"]
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
        orderDes <- map["OrderDes"]
        fullName <- map["FullName"]
        pIDNumber <- map["PIDNumber"]
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
        PaymentCate <- map["PaymentCate"]
        CounterCode <- map["CounterCode"]
        ProviderID <- map["ProviderID"]
        ProviderCode <- map["ProviderCode"]
        ProviderName <- map["ProviderName"]
        ServiceFee <- map["ServiceFee"]
        MerchantAmount <- map["MerchantAmount"]
        TransRefNumber <- map["TransRefNumber"]
        CounterName <- map["CounterName"]
        ShopCode <- map["ShopCode"]
        ShopName <- map["ShopName"]
        CustFee <- map["CustFee"]
        BranchCode <- map["BranchCode"]
        BranchName <- map["BranchName"]
    }
}

class OrderHistoryResponseModel: Mappable {
    var id, empID, paynetID: Int?
    var code: String?
    var transCategory: Int?
    var mobileNumber, retRefNumber: String?
    var paymentType, serviceID: Int?
    var serviceName: String?
    var quantity, amount, fee, transAmount: Int?
    var orderDate, orderDES, fullName, pidNumber: String?
    var status, lastChangeDate, offLine, instaType: String?
    var installmentMonth, prepaidAmount, prepaidPercent, installmentAmount: Int?
    var merchantFee, monthlyAmount: Int?
    var partnerCode: String?
    var merchantID: Int?
    var merchantCode, merchantName: String?
    var paymentCate, providerID: Int?
    var providerCode, providerName: String?
    var serviceFee, merchantAmount: Int?
    var transRefNumber, counterCode, counterName: String?
    
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
    }
}
class OrderProviderPayment {
    var image: String = ""
    var providerName: String = ""
    var paymentType: Int = Constants.paymentTypeVTMoney
    
    init(){}
    init(image: String, providerName: String, paymentType: Int) {
        self.image = image
        self.providerName = providerName
        self.paymentType = paymentType
    }
}
class OnlyPaynetIdRequest: Mappable {
    var paynetID: Int?
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        paynetID >>> map["ID"]
    }
}
class LayChiNhanhStore: Mappable {
    var parentID: Int?
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        parentID >>> map["ParentID"]
    }
}
