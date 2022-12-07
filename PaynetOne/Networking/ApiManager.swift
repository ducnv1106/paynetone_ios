//
//  ApiManager.swift
//  PaynetOne
//
//  Created by vinatti on 04/01/2022.
//

import Alamofire
import ObjectMapper
import Foundation

enum APIError: Error {
    case custom(message: String)
}

typealias Handler = (Swift.Result<Any?, APIError>) -> Void
typealias HandlerBool = (Bool, String) -> Void

class ApiManager {
    let sessionManager: Session = {
        let interceptor = PaynetRequestInterceptor()
        return Session(interceptor: interceptor)
    }()
    
    static let shared = ApiManager()
    
    func requestObject<T: BaseMappable>(dataRq: String = "", code: String, returnType: T.Type, completion: @escaping (_ result: T?, _ err: String?) -> Void){
        guard let signature = RSAUtils.signWithPrivateKey(string: dataRq) else {
            completion(nil, "Lỗi ký chữ ký")
            return
        }
        sessionManager.request(ApiRouter.createRequest(dataRq, signature, code)).cURLDescription { des in
            print("______\(des)______")
        }.response { res in
            self.handleResponse(res: res) { status, data in
                if status {
                    let dataObj = Mapper<T>().map(JSONString: data)
                    completion(dataObj, nil)
                } else {
                    completion(nil, data)
                }
            }
        }
    }
    
    func requestList<T: BaseMappable>(dataRq: String = "", code: String, returnType: T.Type, completion: @escaping (_ result: [T]?, _ err: String?) -> Void){
        guard let signature = RSAUtils.signWithPrivateKey(string: dataRq) else {
            completion(nil, "Lỗi ký chữ ký")
            return
        }
        sessionManager.request(ApiRouter.createRequest(dataRq, signature, code)).cURLDescription { des in
            print("______\(des)______")
        }.response { res in
            self.handleResponse(res: res) { status, data in
                if status {
                    let data = Mapper<T>().mapArray(JSONString: data)
                    completion(data, nil)
                } else {
                    completion(nil, data)
                }
            }
        }
    }
    
    func requestCodeMessage(dataRq: String = "", code: String, completion: @escaping (_ code: String?, _ message: String?) -> Void) {
        guard let signature = RSAUtils.signWithPrivateKey(string: dataRq) else {
            completion(nil, "Lỗi ký chữ ký")
            return
        }
        sessionManager.request(ApiRouter.createRequest(dataRq, signature, code)).cURLDescription { des in
            print("______\(des)______")
        }.response { res in
            switch res.result {
            case .failure(let error):
                completion(String(error.responseCode ?? 0), nil)
            case .success(let data):
                guard let dataString = String(data: data!, encoding: .utf8) else {return}
                if let data = ResponseModel(JSONString: dataString) {
                    completion(data.code, data.message)
                }
            }
        }
    }
    
    func requestCodeMessageData(dataRq: String = "", code: String, completion: @escaping (_ code: String?, _ message: String?,_ responsese:String?) -> Void) {
        guard let signature = RSAUtils.signWithPrivateKey(string: dataRq) else {
            completion(nil, "Lỗi ký chữ ký",nil)
            return
        }
        sessionManager.request(ApiRouter.createRequest(dataRq, signature, code)).cURLDescription { des in
            print("______\(des)______")
        }.response { res in
            switch res.result {
            case .failure(let error):
                completion(String(error.responseCode ?? 0), nil,nil)
            case .success(let data):
                guard let dataString = String(data: data!, encoding: .utf8) else {return}
                if let data = ResponseModel(JSONString: dataString) {
                    completion(data.code, data.message,data.data)
                }
            }
        }
    }
    
//    func getOTP(data: String, completion: @escaping HandlerBool){
//        guard let signature = RSAUtils.signWithPrivateKey(string: data) else {return}
//        sessionManager.request(ApiRouter.getOtp(data, signature, Constants.getOtpCode)).response { response in
//            self.handleResponse(res: response) { status, data in
//                if status == true {
//                    completion(true, "")
//                } else {
//                    completion(false, data)
//                }
//            }
//        }
//    }
    
    func uploadImage(image: Data, name: String, completion: @escaping HandlerBool){
        print(image)
        let url = Constants.fileUploadUrl + Constants.photoUploadPath
        sessionManager.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(image, withName: name, fileName: "avatar.jpg", mimeType: "image/jpeg")
        }, to: url, headers: ["Authorization": "Basic UGF5bmV0T25lOkRhdGFGaWxlQDIxMjEhQCM="]).response { response in
            self.handleResponse(res: response) { status, data in
                if status == true {
                    completion(status, data)
                } else {
                    print("error upload", data)
                }
            }
        }
    }
    
//    func getBusinessServiceList(data: String, completion: @escaping HandlerBool){
//        let signature = RSAUtils.signWithPrivateKey(string: data)
//        sessionManager.request(ApiRouter.businessService(data, signature ?? "", Constants.businessServiceCode)).response { res in
//            self.handleResponse(res: res) { status, data in
//                if status == true {
//                    completion(true, data)
//                } else {
//                    print("error get config", data)
//                }
//            }
//        }
//    }
    
    func getBankList(data: String, completion: @escaping HandlerBool){
        let signature = RSAUtils.signWithPrivateKey(string: data)
        sessionManager.request(ApiRouter.bankList(data, signature ?? "", Constants.listBankCode)).response { res in
            self.handleResponse(res: res) { status, data in
                if status == true {
                    completion(true, data)
                } else {
                    print("error get config", data)
                }
            }
        }
    }
    
    func getOrderByCode(data: String, signature: String, completion: @escaping HandlerBool) {
        sessionManager.request(ApiRouter.getOrderByCode(data, signature, Constants.orderGetByCode)).response {
            response in
            self.handleResponse(res: response) { status, data in
                if status == true {
                    completion(true, data)
                } else {
                    completion(false, data)
                }
            }
        }
    }
    
    func searchOrder(data: String, signature: String, completion: @escaping HandlerBool) {
        sessionManager.request(ApiRouter.orderSearch(data, signature, Constants.orderSearchCode)).response {
            response in
            self.handleResponse(res: response) { status, data in
                if status == true {
                    completion(true, data)
                } else {
                    completion(false, data)
                }
            }
        }
    }
    
    func createRequest(data: String, code: String, completion: @escaping HandlerBool) {
        guard let signature = RSAUtils.signWithPrivateKey(string: data) else {return}
        sessionManager.request(ApiRouter.createRequest(data, signature, code)).cURLDescription { des in
        }.response { response in
            self.handleResponse(res: response) { status, data in
                print("---\(data)---")
                if status == true {
                    completion(true, data)
                } else {
                    completion(false, data)
                }
            }
        }
    }
    
    func createUpdateMerchant(data: String, completion: @escaping (String, String) -> Void) {
//        guard let signature = RSAUtils.signWithPrivateKey(string: data) else {return}
//        sessionManager.request(ApiRouter.createRequest(data, signature, Constants.addRegisterBusiness)).response { response in
//            switch response.result {
//            case .success(let data):
//                let dataString = String(data: data!, encoding: .utf8)
//                let responseData = ResponseModel(JSONString: dataString!)
//                if response.response?.statusCode == 200 {
//                    if responseData?.code == "00" {
//                        completion("00", responseData?.data ?? "")
//                    } else if responseData?.code == "20"{
//                        completion("20", responseData?.message ?? "")
//                    } else {
//                        completion(responseData?.code ?? "", responseData?.message ?? "")
//                    }
//                } else {
//                    completion("error", "có lỗi xảy ra")
//                }
//            case .failure(let error):
//                completion("error", "có lỗi xảy ra")
//                print(error)
//            }
//        }
    }
    
    func checkMerchantExist(data: String, code: String, completion: @escaping HandlerBool) {
        guard let signature = RSAUtils.signWithPrivateKey(string: data) else {return}
        sessionManager.request(ApiRouter.createRequest(data, signature, code)).response { res in
            switch res.result {
            case .success(let data):
                let dataString = String(data: data!, encoding: .utf8)
                let responseData = ResponseModel(JSONString: dataString!)
                if res.response?.statusCode == 200 {
                    if responseData?.code == "00" {
                        completion(true, responseData?.data ?? "")
                    } else if responseData?.code == "01" {
                        completion(true, responseData?.code ?? "")
                    } else {
                        completion(false, responseData?.message ?? "")
                    }
                } else {
                    completion(false, "có lỗi xảy ra")
                }
            case .failure(let error):
                completion(false, "có lỗi xảy ra")
                print(error)
            }
        }
    }
    
    func testRequest(data: String? = "", code: String){
        print("000000", data)
        guard let signature = RSAUtils.signWithPrivateKey(string: data ?? "") else {
            return
        }
        sessionManager.request(ApiRouter.createRequest(data ?? "", signature, code)).cURLDescription { des in
            print("______\(des)______")
        }.response { res in
            switch res.result {
            case .failure(let error):
                print("-=------", error)
            case .success(let data):
                guard let dataString = String(data: data!, encoding: .utf8) else {return}
                if let data = ResponseModel(JSONString: dataString) {
                    print("-------", data)
                }
            }
        }
    }
    
    private func handleResponse(res: AFDataResponse<Data?>, completion: @escaping (Bool, String) -> Void){
        switch res.result {
        case .success(let data):
            let dataString = String(data: data!, encoding: .utf8)
            let responseData = ResponseModel(JSONString: dataString!)
            if res.response?.statusCode == 200 {
                if responseData?.code == "00" {
                    completion(true, responseData?.data ?? "")
                    print("====================>>", responseData)
                } else {
                    completion(false, responseData?.message ?? "Lỗi hệ thống, vui lòng liên hệ quản trị")
                }
            } else {
                completion(false, "Có lỗi xảy ra")
            }
        case .failure(let error):
            completion(false, "có lỗi xảy ra")
            print(error)
        }
    }
}
