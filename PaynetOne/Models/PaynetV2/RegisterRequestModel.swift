//
//  RegisterModel.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 06/09/2022.
//

import ObjectMapper

class RequestOtp: Mappable {
    var mobileNumber = ""
    var isForget = ""
    var otpType = ""
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        mobileNumber >>> map["MobileNumber"]
        isForget >>> map["IsForget"]
        otpType >>> map["OTPType"]
    }
}
class RequestRegisterAccount: Mappable {
    var fullName = "", password = "", mobilenumber = ""
    var address: String = ""
    var email: String = ""
    var isRegister: String = "Y"
    var empID: Int = 0
    var roleID: Int = 1
    var paynetID: Int = 0
    var otp: String = ""
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        fullName >>> map["FullName"]
        password >>> map["password"]
        mobilenumber >>> map["mobilenumber"]
        address >>> map["address"]
        email >>> map["email"]
        isRegister >>> map["IsRegister"]
        paynetID >>> map["PaynetID"]
        roleID >>> map["RoleID"]
        empID >>> map["EmpID"]
        otp >>> map["OTP"]
    }
}
class RegisterBusinessInfo: Mappable {
    var id,provinceID, districtID, wardID, businessServiceID: Int?
    var mobileNumber, name, email, businessType, businessMobile, formalityType, taxCode, fax, contractCode: String?
    var companyName, printQRName, serviceType, address, representativeName, representativeMobile, representativePosition: String?
    var representativePIDNumber, representativePIDImageBefore, representativePIDImageAfter, isSignContract, qROption: String?
    var paymentAccountNumber, paymentAccountName, paymentAccountBank, paymentAccountBranch, documents, linkWebsite: String?
    var imagesApp, posID: String?
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id >>> map["ID"]
        mobileNumber >>> map["MobileNumber"]
        name >>> map["Name"]
        email >>> map["Email"]
        businessType >>> map["BusinessType"]
        businessMobile >>> map["BusinessMobile"]
        formalityType >>> map["FormalityType"]
        taxCode >>> map["TaxCode"]
        fax >>> map["Fax"]
        contractCode >>> map["ContractCode"]
        companyName >>> map["CompanyName"]
        printQRName >>> map["PrintQRName"]
        serviceType >>> map["ServiceType"]
        provinceID >>> map["ProvinceID"]
        districtID >>> map["DistrictID"]
        wardID >>> map["WardID"]
        address >>> map["Address"]
        representativeName >>> map["RepresentativeName"]
        representativeMobile >>> map["RepresentativeMobile"]
        representativePosition >>> map["RepresentativePosition"]
        representativePIDNumber >>> map["RepresentativePIDNumber"]
        representativePIDImageBefore >>> map["RepresentativePIDImageBefore"]
        representativePIDImageAfter >>> map["RepresentativePIDImageAfter"]
        isSignContract >>> map["IsSignContract"]
        qROption >>> map["QROption"]
        paymentAccountNumber >>> map["PaymentAccountNumber"]
        paymentAccountName >>> map["PaymentAccountName"]
        paymentAccountBank >>> map["PaymentAccountBank"]
        paymentAccountBranch >>> map["PaymentAccountBranch"]
        documents >>> map["Documents"]
        linkWebsite >>> map["LinkWebsite"]
        businessServiceID >>> map["BusinessServiceID"]
        imagesApp >>> map["ImagesApp"]
        posID >>> map["PosID"]
    }
}
