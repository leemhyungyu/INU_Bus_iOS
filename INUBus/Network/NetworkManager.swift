//
//  NetworkManager.swift
//  INUBus
//
//  Created by zun on 04/08/2019.
//  Copyright © 2019 zun. All rights reserved.
//

import Foundation

final class NetworkManager {
  static let shared = NetworkManager()
  
  private init() { }
  
  func request(url: URL,
               method: HTTPMethod,
               completion: @escaping (Data?, Error?) -> Void) {
//    defer {
//      ProgressIndicator.shared.hide()
//    }
    let session = URLSession(configuration: .default)
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    ProgressIndicator.shared.show()
    let task = session.dataTask(with: urlRequest) { data, _, error in
      completion(data, error)
      session.finishTasksAndInvalidate()
    }
    task.resume()
  }
}
