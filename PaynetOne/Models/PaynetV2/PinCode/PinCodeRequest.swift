//
//  PinCodeRequest.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 03/10/2022.
//

import ObjectMapper

class LoginCreatePinRequest: Mappable {
    var empID = 0
    var pIN = "", password = "", mobileNumber = ""
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        empID >>> map["EmpID"]
        pIN >>> map["PIN"]
        password >>> map["Password"]
        mobileNumber >>> map["MobileNumber"]
    }
}
class PinVerifyRequest: Mappable {
    var empID = 0
    var pIN = "", password = "", mobileNumber = ""
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        empID >>> map["EmpID"]
        pIN >>> map["PIN"]
        password >>> map["Password"]
        mobileNumber >>> map["MobileNumber"]
    }
}

class RequestVerifyOtp: Mappable {
    var mobileNumber = ""
    var otpValue = ""
    var otpType = ""
    
    init(){}
    required init?(map: Map) {}
    
    init(mobileNumber:String,otpValue:String,otpType:String){
        self.mobileNumber = mobileNumber
        self.otpType = otpType
        self.otpValue = otpValue
    }
    
    func mapping(map: Map) {
        mobileNumber >>> map["MobileNumber"]
        otpValue >>> map["OTPValue"]
        otpType >>> map["OTPType"]
    }
}
