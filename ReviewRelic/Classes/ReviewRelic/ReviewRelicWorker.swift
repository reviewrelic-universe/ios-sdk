//
//  ReviewRelicWorker.swift
//  Pods
//
//  Created by Raheel Sadiq on 27/02/2021.
//  Copyright (c) 2021 ReviewRelic. All rights reserved.
//

import UIKit

class ReviewRelicWorker {
    
    let network = RRNetwork()
    
    func fetchDataFor(
        apiKey: String,
        success: @escaping ((_ responseData: Data) ->Void),
        failure: @escaping (() ->Void)
        ) {
        
        let url = URL(string:"https://reviewrelic.com/api/v1/settings?lang=en")!
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer " + apiKey, forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "GET"
        
        network.execte(urlRequest: urlRequest) { (data, response, error) in
            
            guard error == nil, let data = data else {
                failure()
                return
            }
            success(data)
        }
    }
}
