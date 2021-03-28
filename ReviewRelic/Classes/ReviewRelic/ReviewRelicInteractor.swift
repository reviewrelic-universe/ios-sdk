//
//  ReviewRelicInteractor.swift
//  Pods
//
//  Created by Raheel Sadiq on 27/02/2021.
//  Copyright (c) 2021 ReviewRelic. All rights reserved.
//

import UIKit

protocol ReviewRelicBusinessLogic {
    func requestReviewData()
    func submitData(request: ReviewRelicModels.Request)
}

protocol ReviewRelicDataStore {
    
}

class ReviewRelicInteractor: ReviewRelicBusinessLogic, ReviewRelicDataStore {
    
    var presenter: ReviewRelicPresentationLogic?
    var worker: ReviewRelicWorker?
    var relicReviewData: ReviewRelicData?
    
    // MARK: Fetch
    
    func requestReviewData() {
        
        guard let data = UserDefaults.rRDefaults?.value(forKey: Constants.settings) as? Data else {
            presenter?.presentDataFailure()
            return
        }
        
        if let response = try? JSONDecoder().decode(ReviewRelicModels.Response.self, from: data) {
            presenter?.presentData(response: response)
        }else{
            presenter?.presentDataFailure()
        }
    }
    
    func submitData(request: ReviewRelicModels.Request) {
        worker = ReviewRelicWorker()
    }
}
