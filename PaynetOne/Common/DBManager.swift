//
//  DBManager.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 12/08/2022.
//

import RealmSwift

class DBManager {
    static func baseRealm() -> Realm {
        let config = Realm.Configuration(
            schemaVersion: 3,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    migration.enumerateObjects(ofType: ProviderLocal.className()) { oldObject, newObject in
                        newObject!["isActive"] = "\(oldObject!["isActive"] ?? 0)"
                    }
                }
            }
        )
        Realm.Configuration.defaultConfiguration = config
        let db = try! Realm()
        return db
    }
    
    static func providerLocal() -> Results<ProviderLocal> {
        let result = baseRealm().objects(ProviderLocal.self)
        return result
    }
    
//    let task = LocalOnlyQsTask(name: "Do laundry")
//    try! localRealm.write {
//        localRealm.add(task)
//    }
    
    static func writeArray<T: Object>(_ data: [T]){
        let db = baseRealm()
        try! db.write {
            db.add(data)
        }
    }
    
    static func readData<T: Object>(_ returnType: T.Type) -> Results<T> {
        let db = baseRealm()
        let results = db.objects(T.self)
        return results
    }
    
    static func writeData<T: Object>(_ data: T){
        let db = baseRealm()
        try! db.write {
            db.add(data)
        }
    }
    static func updateDataProviderLocal(data: ProviderLocal){
        let db = baseRealm()
        let filtered =  providerLocal().filter{$0.id==data.id}.first
        if filtered != nil {
            try! db.write{
                filtered?.code = data.code
                filtered?.name = data.name
                filtered?.type = data.type
                filtered?.category = data.category
                filtered?.icon = data.icon
                filtered?.paymentType = data.paymentType
                filtered?.isActive = data.isActive
                filtered?.providerACNTCode = data.providerACNTCode
            }
        }
    
    }
    static func realmDeleteAllClassObjects() {
        do {
            let realm = try Realm()

            let objects = realm.objects(ProviderLocal.self)

            try! realm.write {
                realm.delete(objects)
            }
        } catch let error as NSError {
            // handle error
            print("error - \(error.localizedDescription)")
        }
    }
}
