//
//  RelicReview.swift
//  Pods-ReviewRelic_Example
//
//  Created by Raheel Sadiq on 28/02/2021.
//

import Foundation

public protocol ReviewRelicItem {
    var sku: String {get set}
}


struct ReviewRelicData {
    let themeColor: UIColor
}


public class ReviewRelic {
    
    public static let shared : ReviewRelic = ReviewRelic()
    public var isLogginEnabled = true
    
    let bundle = Bundle(for: ReviewRelic.self)
    var apiKey: String!
    
    public func initialize(apiKey: String) {
        self.apiKey = apiKey
        getSettings()
    }
    
    func getSettings(){
        let worker = ReviewRelicWorker()
        worker.fetchDataFor(apiKey: apiKey, success: { (responseData) in
            UserDefaults.rRDefaults?.setValue(responseData, forKey: Constants.settings)
            UserDefaults.rRDefaults?.synchronize()
        }, failure: {
            Print("Could not initialize, please check the API Key")
        })
    }
}

public extension UIViewController {
    func presentReviewRelic(item: ReviewRelicItem, completion: (() -> Void)? = nil) {
        let controller = ReviewRelicViewController.instanceFromNib()
        present(controller, animated: true, completion: completion)
    }
}

extension UserDefaults {
    class var rRDefaults: UserDefaults? {
        let userDefaults = UserDefaults.init(suiteName: "RRDefaults")
        return userDefaults
    }
}

struct Constants {
    static let settings = "RRSettings"
}

extension Dictionary where Key == String {
    
    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    func printJson() {
        print(json)
    }
}

func Print(_ object: Any) {
    if ReviewRelic.shared.isLogginEnabled {
        print("Review Relic: ", object)
    }
}
