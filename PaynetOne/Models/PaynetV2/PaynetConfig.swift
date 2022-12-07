//
//  PaynetConfigModel.swift
//  PaynetOne
//
//  Created by vinatti on 08/01/2022.
//

import ObjectMapper

struct PaynetConfig: Mappable {
    var pnoLevel, code, name: String?
    var parentID, merchantID, businessType, id: Int?
    var serviceType: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        parentID <- map["ParentID"]
        pnoLevel <- map["PnoLevel"]
        merchantID <- map["MerchantID"]
        businessType <- map["BusinessType"]
        id <- map["ID"]
        code <- map["Code"]
        name <- map["Name"]
        serviceType <- map["ServiceType"]
    }
    
    
}
