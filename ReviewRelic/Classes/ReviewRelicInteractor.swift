//
//  ReviewRelicInteractor.swift
//  Pods
//
//  Created by Raheel Sadiq on 27/02/2021.
//  Copyright (c) 2021 ReviewRelic. All rights reserved.
//

import UIKit

protocol ReviewRelicBusinessLogic {
    func fetchData()
    func submitData(request: ReviewRelicModels.Request)
}

protocol ReviewRelicDataStore {
    
}

class ReviewRelicInteractor: ReviewRelicBusinessLogic, ReviewRelicDataStore {
    
    var presenter: ReviewRelicPresentationLogic?
    var worker: ReviewRelicWorker?
    var relicReviewData: ReviewRelicData?
    
    // MARK: Fetch
    
    func fetchData() {
        
    }
    
    func submitData(request: ReviewRelicModels.Request) {
        worker = ReviewRelicWorker()
        
        let response = ReviewRelicModels.Response()
        presenter?.presentData(response: response)
    }
}
