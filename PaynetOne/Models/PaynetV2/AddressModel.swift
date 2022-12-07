//
//  AddressModel.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 09/09/2022.
//

import ObjectMapper

class AreaModel: Mappable {
    var id = 0
    var code = ""
    var name = ""
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["ID"]
        code <- map["Code"]
        name <- map["Name"]
    }
}

