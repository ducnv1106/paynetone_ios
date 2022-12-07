//
//  CreateQRCode.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 15/08/2022.
//
import ObjectMapper

class CreateQRCodeRequest: Mappable {
    var providerCode = ""
    var empID = 0, ProviderAcntID = 0
    var paynetID = 0
    var transCategory = 0
    var mobileNumber = ""
    var paymentCate = 0
    var paymentType = 0
    var serviceID = 0
    var productID = 0
    var quantity = 0, amount = 0, fee = 0, transAmount = 0
    var orderDES = "", fullName = "", pidNumber = "", offLine = ""
    var instaType = ""
    var installmentMonth = 0, prepaidAmount = 0, prepaidPercent = 0, installmentAmount = 0
    var merchantFee = 0, monthlyAmount = 0
    var orderCode = "", refCode = ""
    var merchantID = 0
    var channel = ""
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        providerCode >>> map["ProviderCode"]
        empID >>> map["EmpID"]
        paynetID >>> map["PaynetID"]
        transCategory >>> map["TransCategory"]
        mobileNumber >>> map["MobileNumber"]
        paymentCate >>> map["PaymentCate"]
        paymentType >>> map["PaymentType"]
        serviceID >>> map["ServiceID"]
        productID >>> map["ProductID"]
        quantity >>> map["Quantity"]
        amount >>> map["Amount"]
        fee >>> map["Fee"]
        transAmount >>> map["TransAmount"]
        orderDES >>> map["OrderDes"]
        fullName >>> map["FullName"]
        pidNumber >>> map["PIDNumber"]
        offLine >>> map["OffLine"]
        instaType >>> map["InstaType"]
        installmentMonth >>> map["InstallmentMonth"]
        prepaidAmount >>> map["PrepaidAmount"]
        prepaidPercent >>> map["PrepaidPercent"]
        installmentAmount >>> map["InstallmentAmount"]
        merchantFee >>> map["MerchantFee"]
        monthlyAmount >>> map["MonthlyAmount"]
        orderCode >>> map["OrderCode"]
        refCode >>> map["RefCode"]
        merchantID >>> map["MerchantID"]
        channel >>> map["Channel"]
        ProviderAcntID >>> map["ProviderAcntID"]
    }
}

class CreateQRCodeResponse: Mappable {
    var returnURL = ""
    var orderCode = ""
    init(){}
    required init?(map: Map) {}
    func mapping(map: Map) {
        returnURL <- map["ReturnURL"]
        orderCode <- map["OrderCode"]
    }
}
