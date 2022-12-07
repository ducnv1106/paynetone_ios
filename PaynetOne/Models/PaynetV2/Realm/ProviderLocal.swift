//
//  ProviderLocal.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 12/08/2022.
//

import RealmSwift

class ProviderLocal: Object {
    @Persisted var id = 0
    @Persisted var code = ""
    @Persisted var name = ""
    @Persisted var type = 0
    @Persisted var category = 0
    @Persisted var icon = ""
    @Persisted var paymentType = 0
    @Persisted var isActive = ""
    @Persisted var providerACNTCode = ""
}
