//
//  AuthModel.swift
//  PaynetOne
//
//  Created by vinatti on 28/12/2021.
//
import ObjectMapper

//struct AuthModel: ImmutableMappable {
//    var channel, code, time, data: String?
//    var signature: String?
//    
//    init(map: Map) throws {}
//    
//    func mapping(map: Map) {
//        channel >>> map["Channel"]
//        code >>> map["Code"]
//        time >>> map["Time"]
//        data >>> map["Data"]
//        signature >>> map["Signature"]
//    }
//}

class LoginRequest: Mappable {
    
    var phoneNumber, password: String?
    var FCMToken: String?
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        phoneNumber <- map["MobileNumber"]
        password <- map["Password"]
        FCMToken <- map["FCMToken"]
    }
}

class ConfigRequestModel: Mappable {
    var id: Int?
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["ID"]
    }
}
