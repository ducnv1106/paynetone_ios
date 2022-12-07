//
//  Credentials.swift
//  PaynetOne
//
//  Created by vinatti on 27/12/2021.
//

import ObjectMapper

struct ResponseModel: Mappable {
    var code, message, data: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        code <- map["Code"]
        message <- map["Message"]
        data <- map["Data"]
    }
}

struct UserModel: Mappable {
    var paynetId, roleId, id: Int?
    var fullName, phoneNumber, email: String?
    var merchantId = 0
    var bankId = 0, IDMerAdmin = 0
    var paymentAccNo = ""
    var paymentAccName = ""
    var BankName = "", Pin = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        paynetId <- map["PaynetID"]
        roleId <- map["RoleID"]
        id <- map["ID"]
        fullName <- map["FullName"]
        phoneNumber <- map["MobileNumber"]
        email <- map["Email"]
        merchantId <- map["MerchantID"]
        bankId <- map["BankID"]
        paymentAccNo <- map["PaymentAccNo"]
        paymentAccName <- map["PaymentAccName"]
        BankName <- map["BankName"]
        Pin <- map["Pin"]
        IDMerAdmin <- map["IDMerAdmin"]
    }
}
