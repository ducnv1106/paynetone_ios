//
//  AddNewOrderModel.swift
//  PaynetOne
//
//  Created by vinatti on 07/01/2022.
//

import ObjectMapper


class AddNewOrderModel: Mappable {
    var providerCode: String?
    var empID, paynetID, transCategory: Int?
    var mobileNumber: String?
    var paymentCate, paymentType, serviceID, productID: Int?
    var quantity, amount, fee, transAmount: Int?
    var orderDES, fullName, pidNumber, offLine: String?
    var instaType: String?
    var installmentMonth, prepaidAmount, prepaidPercent, installmentAmount: Int?
    var merchantFee, monthlyAmount: Int?
    var orderCode, refCode: String?
    var merchantID: Int?
    var channel: String?
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        providerCode <- map["ProviderCode"]
        empID <- map["EmpID"]
        paynetID <- map["PaynetID"]
        transCategory <- map["TransCategory"]
        mobileNumber <- map["MobileNumber"]
        paymentCate <- map["PaymentCate"]
        paymentType <- map["PaymentType"]
        serviceID <- map["ServiceID"]
        productID <- map["ProductID"]
        quantity <- map["Quantity"]
        amount <- map["Amount"]
        fee <- map["Fee"]
        transAmount <- map["TransAmount"]
        orderDES <- map["OrderDes"]
        fullName <- map["FullName"]
        pidNumber <- map["PIDNumber"]
        offLine <- map["OffLine"]
        instaType <- map["InstaType"]
        installmentMonth <- map["InstallmentMonth"]
        prepaidAmount <- map["PrepaidAmount"]
        prepaidPercent <- map["PrepaidPercent"]
        installmentAmount <- map["InstallmentAmount"]
        merchantFee <- map["MerchantFee"]
        monthlyAmount <- map["MonthlyAmount"]
        orderCode <- map["OrderCode"]
        refCode <- map["RefCode"]
        merchantID <- map["MerchantID"]
        channel <- map["Channel"]
    }
}
