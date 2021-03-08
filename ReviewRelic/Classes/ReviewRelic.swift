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
    var data : ReviewRelicData? = ReviewRelicData(themeColor: UIColor.systemBlue)
    let bundle = Bundle(for: ReviewRelic.self)
    var apiKey: String!
    public func initialize(apiKey: String) {
        self.apiKey = apiKey
    }
}

public extension UIViewController {
    func presentReviewRelic(item: ReviewRelicItem, completion: (() -> Void)? = nil) {
        let controller = ReviewRelicViewController.instanceFromNib()
        present(controller, animated: true, completion: completion)
    }
}
