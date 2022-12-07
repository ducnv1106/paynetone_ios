//
//  RequestInterceptor.swift
//  PaynetOne
//
//  Created by vinatti on 05/01/2022.
//

import Foundation
import Alamofire

class PaynetRequestInterceptor: RequestInterceptor {
    let retryLimit = 5
    let retryDelay: TimeInterval = 10
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
//        print(urlRequest)
//      var urlRequest = urlRequest
//      if let token = TokenManager.shared.fetchAccessToken() {
//        urlRequest.setValue("token \(token)", forHTTPHeaderField: "Authorization")
//      }
      completion(.success(urlRequest))
    }
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
      let response = request.task?.response as? HTTPURLResponse
      if let statusCode = response?.statusCode, (500...599).contains(statusCode), request.retryCount < retryLimit {
        completion(.retryWithDelay(retryDelay))
      } else {
        return completion(.doNotRetry)
      }
    }
}
