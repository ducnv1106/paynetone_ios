//
//  ChiNhanhStoreModel.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 07/10/2022.
//

import ObjectMapper

class ChiNhanhStore: Mappable {
    var ID = 0, Code = "", Name = "", ParentID = 0, PnoLevel = 0, LinkID = 0
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        ID <- map["ID"]
        Code <- map["Code"]
        Name <- map["Name"]
        ParentID <- map["ParentID"]
        PnoLevel <- map["PnoLevel"]
        LinkID <- map["LinkID"]
    }
}
