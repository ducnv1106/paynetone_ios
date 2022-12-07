//
//  UserDataService.swift
//  PaynetOne
//
//  Created by vinatti on 06/01/2022.
//

import Foundation

class StoringService {
    static let shared = StoringService()
    let userDefault = UserDefaults.standard
    
    func saveData(user: String, key: String){
        userDefault.set(user, forKey: key)
    }
    
    func wirteBool(value:Bool,key:String){
        userDefault.set(value, forKey: key)
    }
    
    func getData(_ key: String) -> String{
        if let data = userDefault.string(forKey: key) {
            return data
        } else {
            return ""
        }
    }
    
    func checkLogin() -> Bool{
        if getData(Constants.userData) == "" {
            return false
        } else {
            return true
        }
    }
    
    func removeData(_ key: String){
        userDefault.removeObject(forKey: key)
    }
    
    func getUserData() -> UserModel? {
        let userData = getData(Constants.userData)
        let data = UserModel(JSONString: userData)
        return data
    }
    func getConfigData() -> PaynetConfig? {
        let config = getData(Constants.configData)
        return PaynetConfig(JSONString: config)
    }
    func getAddress() -> GetAddressByPaynetIdRes? {
        let address = getData("ADDRESS_BY_PAYNETID")
        return GetAddressByPaynetIdRes(JSONString: address)
    }
    func getPayNetHasChildren() -> PayNetHasChildrenRes? {
        return PayNetHasChildrenRes(JSONString: getData("KEY_PAYNET_HAS_CHILDREN"))
    }
    
    func isExistPinCode() -> Bool{
        let pincdoe = getData("KEY_IS_EXST_PIN_CODE")
        if !((getUserData()?.Pin ?? "").isEmpty) {
            return true
        }
        if !(pincdoe.isEmpty){
            return true
        }
        return false
        
    }
    func isDarkMode() -> Bool{
        return userDefault.bool(forKey: "IS_DARK_MODE")
    }
}
