//
//  Banner.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 13/10/2022.
//

import ObjectMapper

class BannerModel: Mappable {
    var ID = 0
    var BannerValue = "", BannerName = ""
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        ID <- map["ID"]
        BannerValue <- map["BannerValue"]
        BannerName <- map["BannerName"]
    }
}
