//
//  PartnerAddressRequest.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 05/10/2022.
//

import ObjectMapper

class DictPartnerAddressRq: Mappable {
    var channel = "IOS"
    var providerACNTCode = "", counterCode = "", provinceCode = "", districtCode = "", wardCode = ""
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        channel >>> map["Channel"]
        providerACNTCode >>> map["ProviderACNTCode"]
        counterCode >>> map["CounterCode"]
        provinceCode >>> map["ProvinceCode"]
        districtCode >>> map["DistrictCode"]
        wardCode >>> map["WardCode"]
    }
}
