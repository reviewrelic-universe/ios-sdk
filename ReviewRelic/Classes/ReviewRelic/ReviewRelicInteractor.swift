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
    func submitData(
        request: ReviewRelicModels.Request,
        completion: (()->())?
        )
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
        
        if let response = try? JSONDecoder().decode(ReviewRelicModels.SettingsResponse.self, from: data) {
            presenter?.presentData(response: response)
        }else{
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            Print(json ?? "Could not parse data")
            presenter?.presentDataFailure()
        }
    }
    
    func submitData(
        request: ReviewRelicModels.Request,
        completion: (()->())? = nil
        ){
    
        worker = ReviewRelicWorker()
        let workerRequst = ReviewRelicModels.WorkerRequest(request: request)
        
        worker?.submitData(
            workerRequest: workerRequst,
            apiKey: ReviewRelic.shared.apiKey,
            merchantId: ReviewRelic.shared.merchantId,
            success: { [weak self](data) in
                
                if let response = try? JSONDecoder().decode(ReviewRelicModels.SumissionResponse.self, from: data) {
                    
                    if response.status == true {
                        self?.presenter?.presentDataSubmittedSuccessfully(data: response)
                    }else{
                        self?.presenter?.presentDataSubmittedFailed()
                    }
                }else{
                    let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                    Print(json ?? "Could not parse data")
                    self?.presenter?.presentDataSubmittedFailed()
                }
                completion?()
                
            }, failure: { [weak self] in
                // save request for future
                self?.presenter?.presentDataSubmittedFailed()
                completion?()
            })
        
    }
}
