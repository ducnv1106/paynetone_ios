//
//  Balance.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 12/08/2022.
//
import ObjectMapper


class Balance: Mappable {
    var MerchantBalance: [MerchantBalance] = []
    var ShopBalance: [ShopBalance] = []
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        MerchantBalance <- map["MerchantBalance"]
        ShopBalance <- map["ShopBalance"]
    }
}
class ShopBalance: Mappable {
    var ID = 0, Amount = 0, LinkID = 0
    var Code = "", Name = "", AccountType = ""
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        ID <- map["ID"]
        Code <- map["Code"]
        Name <- map["Name"]
        Amount <- map["Amount"]
        LinkID <- map["LinkID"]
        AccountType <- map["AccountType"]
    }
}
class MerchantBalance: Mappable {
    var balance = 0
    var accountType = ""
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        balance <- map["Balance"]
        accountType <- map["AccountType"]
    }
}

class BalanceMerchantRequest: Mappable {
    var paynetID: Int?
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        paynetID <- map["PaynetID"]
    }
}
