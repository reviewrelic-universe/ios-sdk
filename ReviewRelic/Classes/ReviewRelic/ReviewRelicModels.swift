//
//  ReviewRelicModels.swift
//  Pods
//
//  Created by Raheel Sadiq on 27/02/2021.
//  Copyright (c) 2021 ReviewRelic. All rights reserved.
//

import UIKit

public enum ReviewRelicModels {
    
    struct Request {
        let rating: Int
        let itemId: String?
        let reviewerId: String?
        let comments: String
        let title: String
        let description: String
    }
    
    struct WorkerRequest {
        let hmac: String
        let timeStamp: Int
        let request: Request
        
        init(request: Request, time: Int? = nil) {
            self.request = request
            timeStamp = time ?? Int(Date().addingTimeInterval(300).timeIntervalSince1970)
            let signature: String
           
            if let itemId = request.itemId {
                signature = """
{"transaction-id":"\(itemId)","rating":\(request.rating),"time":\(timeStamp)}
"""
            } else {
                signature = """
{"rating":\(request.rating),"time":\(timeStamp)}
"""
            }
            
            hmac = signature.hmac(algorithm: .SHA256, key: ReviewRelic.shared.appSecret)
        }
    }
        
    struct SettingsResponse: Codable {
        let data: DataClass
        
        struct DataClass: Codable {
            let name, merchantID: String
            let settings: Settings
            let reviewSettings: [ReviewSetting]
            
            struct ReviewSetting: Codable {
                let label: String
                let value: Int
            }
            
            struct Settings: Codable {
                let emptyImage, fillImage, appLogo: String
                let type: Int
                let canSkip, shouldShowImages: Bool
                let color: String
                
                enum CodingKeys: String, CodingKey {
                    case emptyImage = "empty-image"
                    case fillImage = "fill-image"
                    case appLogo = "app-logo"
                    case type
                    case canSkip = "can-skip"
                    case shouldShowImages = "should-show-images"
                    case color
                }
            }
            
            enum CodingKeys: String, CodingKey {
                case name
                case merchantID = "merchant-id"
                case settings
                case reviewSettings = "review-settings"
            }
        }
    }
    // MARK: - Resonse
    public struct SumissionResponse: Codable {
        let transaction: ReviewRelic.Transaction
        let status: Bool
        
        enum CodingKeys: String, CodingKey {
            case transaction = "data"
            case status
        }
    }
    
    struct ViewModel {
        
        let ratingType: RatingType
        let themeColor: UIColor
        let appLogo: UIImage

        enum RatingType {
            case stars(StarsData)
            case words(WordsData)
        }
        
        struct StarsData {
            let starsCount: Int
            let starSelected: UIImage
            let starUnSelected: UIImage
        }
        
        struct WordsData {
            let words: [Word]
            
            struct Word {
                let title: String
                let rating: Int
            }
        }

    }
}

extension ReviewRelic {

    public struct Transaction: Codable {
        let transactionID: String?
        let uuid: String
        let rating: Int
        let label, comments: String?
        
        enum CodingKeys: String, CodingKey {
            case transactionID = "transaction-id"
            case uuid, rating, label, comments
        }
    }
}
