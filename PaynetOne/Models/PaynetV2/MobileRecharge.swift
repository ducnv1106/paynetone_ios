//
//  MobileRecharge.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 17/08/2022.
//

import ObjectMapper

class MobileRechargeUrlWebViewRequest: Mappable {
    var Code = ""
    var Channel = "IOS"
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        Code >>> map["Code"]
        Channel >>> map["Channel"]
    }
}
class UrlWebView: Mappable {
    var ReturnUrl = ""
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        ReturnUrl <- map["ReturnUrl"]
    }
}
