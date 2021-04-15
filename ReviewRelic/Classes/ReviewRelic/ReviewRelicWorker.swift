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
    
    func submitData(
        workerRequest: ReviewRelicModels.WorkerRequest,
        apiKey: String,
        success: @escaping ((_ responseData: Data) ->Void),
        failure: @escaping (() -> Void)
        ) {
        
        let url = URL(string:"https://reviewrelic.com/api/v1/store")!
        var urlRequest = URLRequest(url: url)
        
        
        var params: [String: Any] = [
            "transaction-id": workerRequest.request.itemId,
            "rating": workerRequest.request.rating,
            "time" : workerRequest.timeStamp,
            "comments": workerRequest.request.comments,
            "extra": [
                "title": workerRequest.request.title,
                "description": workerRequest.request.description
            ]
        ]
        
        if let reviewId = workerRequest.request.reviewerId {
            params["reviewer-id"] = reviewId
        }
        
        do{
            let paramsData = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
            urlRequest.httpBody = paramsData
        }catch{
            Print("Error creating body")
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer " + apiKey, forHTTPHeaderField: "Authorization")
        urlRequest.addValue(workerRequest.hmac, forHTTPHeaderField: "Relic-Signature")
        urlRequest.httpMethod = "POST"
        
        
        network.execte(urlRequest: urlRequest) { (data, response, error) in
            
            guard error == nil, let data = data else {
                failure()
                return
            }
            
            success(data)
        }
    }
}
