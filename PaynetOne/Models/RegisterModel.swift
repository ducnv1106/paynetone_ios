//
//  RegisterModel.swift
//  PaynetOne
//
//  Created by Ngo Duy Nhat on 16/02/2022.
//

import Foundation
import ObjectMapper

class UploadImageResModel: Mappable {
    var fileName: String?
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        fileName <- map["FileName"]
    }
}

class CheckPhoneRequestModel: Mappable {
    var mobileNumber: String?
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        mobileNumber <- map["MobileNumber"]
    }
}




