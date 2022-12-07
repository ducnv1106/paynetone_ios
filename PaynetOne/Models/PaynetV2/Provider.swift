//
//  Provider.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 12/08/2022.
//

import ObjectMapper

class Provider: Mappable {
    var id = 0
    var code = "", providerACNTCode = ""
    var name = ""
    var type = 0
    var category = 0
    var icon = ""
    var paymentType = 0
    var isActive = ""
    
    init(){}
    required init?(map: Map) {}

    func mapping(map: Map) {
        id <- map["ID"]
        code <- map["Code"]
        name <- map["Name"]
        type <- map["Type"]
        category <- map["Category"]
        icon <- map["Icon"]
        paymentType <- map["PaymentType"]
        isActive <- map["IsActive"]
        providerACNTCode <- map["ProviderACNTCode"]
    }    
}
