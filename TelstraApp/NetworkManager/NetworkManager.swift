//
//  NetworkManager.swift
//  TelstraApp
//
//  Created by RajeshDeshmukh on 30/06/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import Foundation

class NetworkManager {
  
    static let shared = NetworkManager()
    
    func callAPI(withURLStr: String, onCompletion: @escaping (Data?, Error?) -> Void) {
        
        guard let url = URL.init(string: withURLStr) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                onCompletion(nil, err)
            } else {
                guard let data = data else { return }
                onCompletion(data, nil)
            }
        }.resume()
    }
    
}
