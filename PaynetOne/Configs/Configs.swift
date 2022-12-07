//
//  Configs.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 25/08/2022.
//

import Foundation
class Configs{
    static func isAdmin() -> Bool {
        let user = StoringService.shared.getUserData()
        let config = StoringService.shared.getConfigData()
        return user?.roleId == 1 && config?.pnoLevel == "1"
    }
    static func isQLCH() -> Bool {
        let user = StoringService.shared.getUserData()
        let config = StoringService.shared.getConfigData()
        return user?.roleId == 4 && config?.pnoLevel == "3"
    }
    static func isXoSo() -> Bool {
        let config = StoringService.shared.getConfigData()
        return config?.businessType == 4 || config?.businessType == 5
    }
    static func isAccountBranch() ->Bool{ // chi nhánh
        let config = StoringService.shared.getConfigData()
        return config?.pnoLevel ?? "" == "2"
    }
    static func isAccountStall() ->Bool{ // tài khoản quầy
        let config = StoringService.shared.getConfigData()
        return config?.pnoLevel ?? "" == "4"
    }
    static func isAccountStore() ->Bool{ // tài khoản cửa hàng
        let config = StoringService.shared.getConfigData()
        return config?.pnoLevel ?? "" == "3"
    }
    static func isAccountMerchant() ->Bool{ // tài khoản cửa hàng
        let config = StoringService.shared.getConfigData()
        return config?.pnoLevel ?? "" == "1"
    }
}
//qlch                  roleId: Optional(4)             pnoLevel: Optional("3")
//Admin merchant:       roleId: Optional(1)             pnoLevel: Optional("1")  businessType: Optional(3)
//TK quản lý chi nhánh: roleId: Optional(3)             pnoLevel: Optional("2")
//TK quầy:              roleId: Optional(5)             pnoLevel: Optional("4")
//xs vietlot:           roleId: Optional(1)             pnoLevel: Optional("1")  businessType: Optional(4)

//xs vietlot:           roleId: Optional(1)             pnoLevel: Optional("1")  businessType: Optional(5)
