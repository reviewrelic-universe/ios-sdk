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
//    func submitData(request: ReviewRelicModels.Request)
    
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
        
        if let response = try? JSONDecoder().decode(ReviewRelicModels.Response.self, from: data) {
            presenter?.presentData(response: response)
        }else{
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
            print(json ?? "Could not parse data")
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
            success: { [weak self](data) in
                
                let success: Bool
                do {
                    let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
                    success = response["status"] as? Bool ?? false
                } catch let error as NSError {
                    Print(error)
                    success = false
                    return
                }
                
                if success {
                    self?.presenter?.presentDataSubmittedSuccessfully()
                    
                }else{
                    // save request for future
                    self?.presenter?.presentDataNotSubmitted()
                }
                
                completion?()
                
            }, failure: { [weak self] in
                // save request for future
                self?.presenter?.presentDataNotSubmitted()
                completion?()
            })
        
    }
}
