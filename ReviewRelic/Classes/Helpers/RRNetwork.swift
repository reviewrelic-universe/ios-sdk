//
//  RRNetwork.swift
//  ReviewRelic
//
//  Created by Raheel Sadiq on 27/03/2021.
//

import Foundation

class RRNetwork {
    
    let session: URLSession
    init() {
        session = URLSession(configuration: .default)
    }
    
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> ()

    func execte( urlRequest: URLRequest, dataTaskResult: @escaping DataTaskResult) {
        
        session.dataTask(with: urlRequest)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            dataTaskResult(data, response, error)
        }
        
        task.resume()
    }
}
