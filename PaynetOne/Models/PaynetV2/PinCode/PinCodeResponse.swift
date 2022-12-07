//
//  PinCodeResponse.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 03/10/2022.
//

import ObjectMapper

class LoginCreatePinRes: Mappable {
    var hasPin = ""
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        hasPin <- map["hasPin"]
    }
}

