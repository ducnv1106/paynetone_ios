//
//  Other.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 16/08/2022.
//

import ObjectMapper

typealias ActionType = () -> ()
struct ItemModel {
    var image = ""
    var title = ""
    var isShowRightIcon = false
    var action: ActionType?
    var level = 0
}
struct PaynetBank {
    var name = ""
    var bankName = ""
    var logo = ""
    var branch = ""
    var bankNumber = ""
}
struct BusinessType {
    var name = ""
    var id = ""
}
struct FormalityType {
    var name = ""
    var id = ""
}
struct ServiceType {
    var name = ""
    var id = ""
}
struct QRCodeType {
    var name = ""
    var id = ""
}

class BusinessServiceModel: Mappable {
    var groupID: Int?
    var groupCode, groupName: String?
    var id: Int?
    var code, name: String?
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        groupID <- map["GroupID"]
        groupCode <- map["GroupCode"]
        groupName <- map["GroupName"]
        id <- map["ID"]
        code <- map["Code"]
        name <- map["Name"]
    }
}
class RequestAddressById: Mappable {
    var id = 0
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["ID"]
    }
}
class BanksModel: Mappable {
    var shortName = ""
    var id = 0
    var code = "", name = ""
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        shortName <- map["ShortName"]
        id <- map["ID"]
        code <- map["Code"]
        name <- map["Name"]
    }
}
class ChangePassRequest: Mappable {
    var mobileNumber: String?
    var OTPType = "N"
    var OTPValue: String?
    var passwordNew: String?
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        mobileNumber >>> map["MobileNumber"]
        OTPType >>> map["OTPType"]
        OTPValue >>> map["OTPValue"]
        passwordNew >>> map["PasswordNew"]
    }
}
class WalletsModel: Mappable {
    var id = 0
    var code = "", name = ""
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["ID"]
        code <- map["Code"]
        name <- map["Name"]
    }
}
class WithdrawRequestModel: Mappable {
    var merchantID: Int?
    var paynetID: Int?
    var transDetail: String?
    var amount: Int?
    var fee: Int?
    var transAmount: Int?
    var transReason: String?
    var bankID: Int?
    var mobileNumber: String?
    var accountNumber: String?
    var fullName: String?
    var withdrawCategory: Int?
    var posID: String?
    var walletID: Int?
    var ProviderAcntID: Int?
    var ShopID: String?
    var BalanceType: String?
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        merchantID >>> map["MerchantID"]
        paynetID >>> map["PaynetID"]
        transDetail >>> map["TransDetail"]
        walletID >>> map["WalletID"]
        amount >>> map["Amount"]
        fee >>> map["Fee"]
        transReason >>> map["TransReason"]
        transAmount >>> map["TransAmount"]
        bankID >>> map["BankID"]
        mobileNumber >>> map["MobileNumber"]
        accountNumber >>> map["AccountNumber"]
        fullName >>> map["FullName"]
        withdrawCategory >>> map["WithdrawCategory"]
        posID >>> map["PosID"]
        ProviderAcntID >>> map["ProviderAcntID"]
        ShopID >>> map["ShopID"]
        BalanceType >>> map["BalanceType"]
    }
}
class MerchantFileModel: Mappable {
    var id, paynetID: Int?
    var code, mobileNumber, name, formalityType: String?
    var businessType, businessMobile, contractCode, taxCode: String?
    var fax, email, companyName, printQRName: String?
    var serviceType: String?
    var provinceID, districtID, wardID: Int?
    var provinceName, districtName, wardName, address: String?
    var representativeName, representativeMobile, representativePosition, representativePIDNumber: String?
    var representativePIDImageBefore, representativePIDImageAfter, isSignContract, isLock: String?
    var qrOption, paymentAccountNumber, paymentAccountName: String?
    var paymentAccountBank: Int?
    var paymentAccountBankName, paymentAccountBranch, documents, status: String?
    var approveEmpName, approveDate, addInfo, addInfoStatus: String?
    var rejectReason, linkWebsite: String?
    var businessServiceID: Int?
    var businessServiceName, imagesApp, contractFile, posID: String?
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["ID"]
        paynetID <- map["PaynetID"]
        code <- map["Code"]
        mobileNumber <- map["MobileNumber"]
        name <- map["Name"]
        formalityType <- map["FormalityType"]
        businessType <- map["BusinessType"]
        businessMobile <- map["BusinessMobile"]
        contractCode <- map["ContractCode"]
        taxCode <- map["TaxCode"]
        fax <- map["Fax"]
        email <- map["Email"]
        companyName <- map["CompanyName"]
        printQRName <- map["PrintQRName"]
        serviceType <- map["ServiceType"]
        provinceID <- map["ProvinceID"]
        districtID <- map["DistrictID"]
        wardID <- map["WardID"]
        provinceName <- map["ProvinceName"]
        districtName <- map["DistrictName"]
        wardName <- map["WardName"]
        address <- map["Address"]
        representativeName <- map["RepresentativeName"]
        representativeMobile <- map["RepresentativeMobile"]
        representativePosition <- map["RepresentativePosition"]
        representativePIDNumber <- map["RepresentativePIDNumber"]
        representativePIDImageBefore <- map["RepresentativePIDImageBefore"]
        representativePIDImageAfter <- map["RepresentativePIDImageAfter"]
        isSignContract <- map["IsSignContract"]
        isLock <- map["IsLock"]
        qrOption <- map["QROption"]
        paymentAccountNumber <- map["PaymentAccountNumber"]
        paymentAccountName <- map["PaymentAccountName"]
        paymentAccountBank <- map["PaymentAccountBank"]
        paymentAccountBankName <- map["PaymentAccountBankName"]
        paymentAccountBranch <- map["PaymentAccountBranch"]
        documents <- map["Documents"]
        status <- map["Status"]
        approveEmpName <- map["ApproveEmpName"]
        approveDate <- map["ApproveDate"]
        addInfo <- map["AddInfo"]
        addInfoStatus <- map["AddInfoStatus"]
        rejectReason <- map["RejectReason"]
        linkWebsite <- map["LinkWebsite"]
        businessServiceID <- map["BusinessServiceID"]
        businessServiceName <- map["BusinessServiceName"]
        imagesApp <- map["ImagesApp"]
        contractFile <- map["ContractFile"]
        posID <- map["PosID"]
    }
}
class GetAddressByPaynetIdRq: Mappable {
    var id = 0
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id >>> map["ID"]
    }
}
class GetAddressByPaynetIdRes: Mappable {
    var WardCode = ""
    var ProvinceCode = ""
    var DistrictCode = ""
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        WardCode <- map["WardCode"]
        ProvinceCode <- map["ProvinceCode"]
        DistrictCode <- map["DistrictCode"]
    }
}
class DicGetPos: Mappable {
    var ID = 0
    var ProvinceID = 0
    var PosCode = 0
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        ID <- map["ID"]
        ProvinceID <- map["ProvinceID"]
        PosCode <- map["PosCode"]
    }
}
class PayNetHasChildrenRes: Mappable {
    var hasChildren = ""
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        hasChildren <- map["hasChildren"]
    }
}
class PayNetHasChildrenRq: Mappable {
    var paynetId = 0
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        paynetId >>> map["PaynetID"]
    }
}

class ChangePasswordRq : Mappable {
    var mobileNumber = ""
    var password = ""
    var passwordNew = ""
    
    init(){}
    required init?(map: Map) {}
    
    init(mobileNumber:String,password:String,passwordNew:String){
        self.mobileNumber = mobileNumber
        self.password = password
        self.passwordNew = passwordNew
    }
    
    func mapping(map: Map) {
        mobileNumber <- map["MobileNumber"]
        password <- map["Password"]
        passwordNew <- map["PasswordNew"]
    }
}
