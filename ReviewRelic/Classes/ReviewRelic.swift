//
//  RelicReview.swift
//  Pods-ReviewRelic_Example
//
//  Created by Raheel Sadiq on 28/02/2021.
//

import Foundation

public protocol ReviewRelicItem {
    var transactionId: String? { get set }
    var reviewsId: String? {get set}
}


struct ReviewRelicData {
    let themeColor: UIColor
}


public class ReviewRelic {
    
    
    /// Enable logging
    public var isLogginEnabled = true
    
    ///you can add user identifier using this param. This parameter will go with every reivew
    public var reviewerId: String?
    
    /// Use this single point to change any settings
    public static let shared : ReviewRelic = ReviewRelic()

    let bundle = Bundle(for: ReviewRelic.self)
    var apiKey: String!
    var appSecret: String!
    
    public func initialize(apiKey: String, appSecret: String) {
        self.apiKey = apiKey
        self.appSecret = appSecret
        
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: .main) { [weak self](_) in
            self?.getSettings()
        }
    }
    
    func getSettings(){
        let worker = ReviewRelicWorker()
        worker.fetchDataFor(apiKey: apiKey, success: { (responseData) in
            /// saving a working object state over not working state
            if let _ = try? JSONDecoder().decode(ReviewRelicModels.SettingsResponse.self, from: responseData) {
                UserDefaults.rRDefaults?.setValue(responseData, forKey: Constants.settings)
                UserDefaults.rRDefaults?.synchronize()
            }else{
                Print("Could not initialize, please check the API Key")
            }
        }, failure: {
            Print("Could not initialize, please check the API Key")
        })
    }
}

