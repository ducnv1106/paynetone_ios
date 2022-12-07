//
//  Router.swift
//  PaynetOne
//
//  Created by vinatti on 04/01/2022.
//

import Alamofire
    
enum ApiRouter {
    case login(String, String, String)
    case paynetConfig(String, String, String)
    case addNewOrder(String, String, String)
    case getOrderByCode(String, String, String)
    case orderSearch(String, String, String)
    case businessService(String, String, String)
    case bankList(String, String, String)
    case getOtp(String, String, String)
    case createRequest(String, String, String)
    case uploadPhotoID
    
    var baseUrl: String {
        switch self {
        case .login, .paynetConfig, .addNewOrder, .getOrderByCode, .orderSearch, .businessService, .bankList, .getOtp, .createRequest:
            return Constants.baseUrl
        case .uploadPhotoID:
            return Constants.fileUploadUrl
        }
    }
    
    var path: String {
        switch self {
        case .login, .paynetConfig, .addNewOrder, .getOrderByCode, .orderSearch, .businessService, .bankList, .getOtp, .createRequest:
            return ""
        case .uploadPhotoID:
            return Constants.photoUploadPath
        }
    }
    
//    var method: HTTPMethod {
//        switch self {
//        case .login, .paynetConfig:
//            return .post
//        }
//    }
    
    var parameters: [String: String]? {
        switch self {
        case .login(let data, let signature, let code),
            .paynetConfig(let data, let signature, let code),
            .addNewOrder(let data, let signature, let code),
            .getOrderByCode(let data, let signature, let code),
            .orderSearch(let data, let signature, let code),
            .businessService(let data, let signature, let code),
            .bankList(let data, let signature, let code),
            .getOtp(let data, let signature, let code),
            .createRequest(let data, let signature, let code):
            return [
                "Channel": Constants.chanel,
                "Code": code,
                "Time":"",
                "Data": data,
                "Signature": signature
            ]
        case .uploadPhotoID:
            return nil
        }
    }
}
extension ApiRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try baseUrl.asURL()//.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = .post
        request = try JSONParameterEncoder().encode(parameters, into: request)
        request.setValue("Basic UGF5bmV0T25lOkdhdGV3YXlAMjEyMSFAIw==", forHTTPHeaderField: "Authorization")
//        if method == .get {
//            request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
//        } else if method == .post {
//            request = try JSONParameterEncoder().encode(parameters, into: request)
//            request.setValue("Basic UGF5bmV0T25lOkdhdGV3YXlAMjEyMSFAIw==", forHTTPHeaderField: "Authorization")
//        }
        return request
    }
}
