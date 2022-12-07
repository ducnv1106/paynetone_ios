//
//  Constants.swift
//  PaynetOne
//
//  Created by vinatti on 28/12/2021.
//

import Foundation
import UIKit

enum Constants {
    static let chanel = "IOS"
    static let loginCode = "EMP_LOGIN"
    static let paynetConfigCode = "PAYNET_GET_BY_ID"
    static let orderGetByCode = "ORDER_GET_BY_CODE"
    static let orderSearchCode = "ORDER_SEARCH"
    static let listBankCode = "DIC_GET_BANK"
    static let getOtpCode = "EMP_GET_OTP"
    static let registerCode = "EMP_ADD_NEW"
    static let editMerchant = "MERCHANT_EDIT"
//    static let checkNumberMer = "MERCHANT_GET_BY_MOBILE_NUMBER"
    static let getBalanceMerchantCode = "MERCHANT_GET_BALANCE"
    static let withdrawCode = "TRANS_WITHDRAW"
    
    static let providerCodeVTMoney = "VIETTEL"
    static let providerCodeZalo = "ZALO"
    static let providerCodeShopee = "SHOPEE"
    static let providerCodeVnpay = "VNPAY"
    
    static let serviceID = 1
    static let fee = 0
    static let transCategory = 1
    static let paymentTypeVTMoney = 3
    static let paymentTypeZalo = 4
    static let paymentTypeShopee = 5
    static let paymentTypeVnpay = 6
    static let paymentCate = 2
    
    static let BUSINESS_TYPE_ENTERPRISE = 1 // doanh nghiệp
    static let BUSINESS_TYPE_HOUSEHILD = 2 // hộ kinh doanh
    static let BUSINESS_TYPE_PERSONAL = 3 // cá nhân kinh doanh
    static let BUSINESS_TYPE_VIETLOTT = 4 // cửa hàng xổ số vietlott
    static let BUSINESS_TYPE_SYNTHETIC = 5 // cửa hàng xổ số tổng hợp
    
    static let userData = "UserData"
    static let configData = "PayNetOneConfigData"
    
    static let baseUrl = "https://gateway.paynetvn.com/Gateway/Execute"
    static let fileUploadUrl = "https://datafile.paynetvn.com"
    static let imageUrl = "https://datafile.paynetvn.com/Assets/Images"
    
    ///dev
//    static let baseUrl = "http://202.134.18.27:2001/Gateway/Execute"
//    static let fileUploadUrl = "http://202.134.18.27:2002"
//    static let imageUrl = "http://202.134.18.27:2002/Assets/Images"
    
    static let photoUploadPath = "/Handle/UploadImage"
    static let photoIDPath = "/Assets/Images/"
    
    
    static let businessType = [BusinessType(name: "Doanh nghiệp", id: "1"), BusinessType(name: "Hộ kinh doanh", id: "2"), BusinessType(name: "Cá nhân kinh doanh", id: "3"), BusinessType(name: "Cửa hàng xổ số Vietlott", id: "4"), BusinessType(name: "Cửa hàng xổ số tổng hợp", id: "5")]
    static let formalityType = [FormalityType(name: "Kinh doanh Online", id: "1"), FormalityType(name: "Kinh doanh Offline", id: "2")]
    static let serviceType = [ServiceType(name: "Thanh toán QR", id: "1"), ServiceType(name: "Mua ngay - trả sau", id: "2")]
    static let qrCodeType = [QRCodeType(name: "QR code tĩnh", id: "1"), QRCodeType(name: "QR code động", id: "2")]
    static let hinhThucRutTien = [Item(id: 0, text: "Tài khoản ngân hàng",value: 1), Item(id: 1, text: "Ví điện tử",value: 3), Item(id: 2, text: "Tài khoản hạn mức",value: 4)]
    static let hinhThucRutTienXS = [Item(id: 0, text: "Tài khoản ngân hàng",value: 1), Item(id: 1, text: "Ví điện tử",value: 3), Item(id: 2, text: "Tài khoản hạn mức",value: 4), Item(id: 3, text: "Hạn mức Vietlott",value: 2)]
    static let taiKhoanRutTien = [
        Item(id: 0, text: "Tài khoản đã đối soát", type: "P"),
        Item(id: 1, text: "Tài khoản hoa hồng đã đối soát", type: "C")
    ]
    static func businessTypeString(_ type: String) -> String {
        switch type {
        case "1":
            return "Doanh nghiệp"
        case "2":
            return "Hộ kinh doanh"
        case "3":
            return "Cá nhân kinh doanh"
        case "4":
            return "Cửa hàng xổ số Vietlott"
        case "5":
            return "Cửa hàng xổ số tổng hợp"
        default:
            return ""
        }
    }
    static func fomalityString(_ type: String) -> String {
        switch type {
        case "1":
            return "Kinh doanh Online"
        case "2":
            return "Kinh doanh Offline"
        default:
            return ""
        }
    }
    static func qrOptionString(_ type:String) -> String {
        switch type {
        case "1":
            return "QR code tĩnh"
        case "2":
            return "QR code động"
        default:
            return ""
        }
    }
    static func serviceTypeString(_ type:String) -> String {
        switch type {
        case "1":
            return "Thanh toán QR"
        case "2":
            return "Mua ngay - trả sau"
        default:
            return ""
        }
    }
    static let hanMuc = "S"
}

struct Item {
    var id = 0
    var text = ""
    var type = ""
    var value = 0
}

class ProviderType {
    static func status(status:String) -> String? {
        switch status {
        case "L":
            return "Khởi tạo"
        case "A":
            return "Chờ phê duyệt"
        case "W":
            return "Chờ thanh toán"
        case "P":
            return "Duyệt"
        case "C":
            return "Hủy"
        case "R":
            return "Từ chối"
        case "K":
            return "Khách hàng hủy"
        case "S":
            return "Thành công"
        default:
            return ""
        }
    }
    static func color(_ status: String) -> UIColor {
        switch status {
        case "L":
            return .blueColor
        case "A":
            return .red
        case "W":
            return .blueColor
        case "P":
            return .red
        case "C":
            return .red
        case "R":
            return .red
        case "K":
            return .red
        case "S":
            return .statusPaid
        default:
            return .red
        }
    }
    static func logo(_ type: Int) -> String {
        switch type {
        case 8:
            return "ic_viet_qr"
        case 6:
            return "vnpay_logo"
        case 3:
            return "viettel_money_logo"
        case 4:
            return "zalo_logo"
        case 5:
            return "shopee_logo"
        case 7:
            return "grab_moca_logo"
        default:
            return ""
        }
    }
}

class WithdrawStt {
    static func status(_ returnCode: Int) -> String{
        switch returnCode {
        case 0:
            return "Đã chuyển tiền"
        case 1:
            return "Chờ xử lý"
        case 2:
            return "Từ chối"
        case 3:
            return "Chờ xác nhận"
        case 4:
            return "Chuyển tiền lỗi"
        default:
            return ""
        }
    }
    static func color(_ returnCode: Int) -> UIColor {
        switch returnCode {
        case 0:
            return .statusPaid
        case 1:
            return .blueColor
        case 2:
            return .statusReject
        case 3:
            return .statusPending
        case 4:
            return .thatBaicolo
        default:
            return .clear
        }
    }
    static func category(_ category: Int?, walletName: String?, bankname: String?) -> String {
        switch category {
        case 1:
            return bankname ?? ""
        case 2:
            return "Hạn mức Vietlott"
        case 3:
            return walletName ?? ""
        case 4:
            return "Tài khoản hạn mức"
        default:
            return ""
        }
    }
}

enum ProviderCate: Int {
    case payment = 1, service
}
enum QRType: Int {
    case bank = 1, wallet, qr = 4
}
