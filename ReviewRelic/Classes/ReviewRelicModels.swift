//
//  ReviewRelicModels.swift
//  Pods
//
//  Created by Raheel Sadiq on 27/02/2021.
//  Copyright (c) 2021 ReviewRelic. All rights reserved.
//

import UIKit

enum ReviewRelicModels {
    
    struct Request {
        let rating: Int?
    }
    
    struct Response {
        
    }
    
    struct ViewModel {
        
        let ratingType: RatingType
        let themeColor: UIColor
        
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
