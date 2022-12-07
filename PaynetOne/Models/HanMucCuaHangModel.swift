//
//  HanMucCuaHangModel.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 06/10/2022.
//

import ObjectMapper

class HanMucCuaHangList: Mappable {
    var ID = 0, Code = "", Name = "", Amount = 0, LinkID = 0, PayNetID = 0, AccountType = ""
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        ID <- map["ID"]
        Code <- map["Code"]
        Name <- map["Name"]
        Amount <- map["Amount"]
        LinkID <- map["LinkID"]
        AccountType <- map["AccountType"]
        PayNetID <- map["PaynetID"]
    }
}
