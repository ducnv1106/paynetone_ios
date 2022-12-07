//
//  RSAUtils.swift
//  PaynetOne
//
//  Created by vinatti on 05/01/2022.
//
import Foundation
import SwiftyRSA

struct TestError: Error {
    let description: String
}

class RSAUtils {
//    let privateKey = try? PrivateKey(pemNamed: "private")
//    let clear = try? ClearMessage(string: "Clear Text", using: .utf8)
//    let signature = clear?.signed(with: privateKey, digestType: .sha256)
    
    static let bundle = Bundle(for: RSAUtils.self)
    
    
    static public func signWithPrivateKey(string: String) -> String? {
        do {
            let privateKey = try RSAUtils.privateKey(name: "privateKey")
            let string = try ClearMessage(string: string, using: .utf8)
            let signature = try string.signed(with: privateKey, digestType: .sha256)
            let base64String = signature.base64String
            return base64String
        } catch {
            return "Error encrypt"
        }
//        if let privateKey = try? RSAUtils.privateKey(name: "privateKey"), let string = try? ClearMessage(string: string, using: .utf8), let signature = try? string.signed(with: privateKey, digestType: .sha256) {
//            let base64String = signature.base64String
//
//        } else {
//            return "error"
//        }
    }
    
    static public func privateKey(name: String) throws -> PrivateKey {
        guard let path = bundle.path(forResource: name, ofType: "pem") else {
            throw TestError(description: "Couldn't load key for provided path")
        }
        let pemString = try String(contentsOf: URL(fileURLWithPath: path))
        return try PrivateKey(pemEncoded: pemString)
    }
}
