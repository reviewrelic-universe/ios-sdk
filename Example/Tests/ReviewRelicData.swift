//
//  ReviewRelicData.swift
//  ReviewRelic
//
//  Created by Raheel Sadiq on 29/03/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
@testable import ReviewRelic


struct ReviewRelicTestsData {
    static let StarBasedRatingJson = """
{
    "name": "Foodora",
    "merchant-id": "6928ab10-7c4a-4d6c-9dd9-91aeac18caef",
    "settings": {
        "empty-image": "",
        "fill-image": "",
        "app-logo": "",
        "type": 100,
        "can-skip": false,
        "should-show-images": true,
        "color": "#2196F3"
    },
    "review-settings": [
        {
            "label": "bad",
            "value": 1
        },
        {
            "label": "satisfactory",
            "value": 2
        },
        {
            "label": "good",
            "value": 3
        },
        {
            "label": "better",
            "value": 4
        },
        {
            "label": "excellent",
            "value": 5
        }
    ]
}
"""
}
