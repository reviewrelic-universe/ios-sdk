//
//  ReviewRelicPresenter.swift
//  Pods
//
//  Created by Raheel Sadiq on 27/02/2021.
//  Copyright (c) 2021 ReviewRelic. All rights reserved.
//

import UIKit

protocol ReviewRelicPresentationLogic {
    func presentData(response: ReviewRelicModels.Response)
    func presentDataFailure()
    func presentDataSubmittedSuccessfully()
    func presentDataNotSubmitted()
}

class ReviewRelicPresenter: ReviewRelicPresentationLogic {
    
    weak var viewController: ReviewRelicDisplayLogic?
    
    // MARK: Present
    
    func presentDataSubmittedSuccessfully() {
        
    }

    func presentDataFailure() {
        
    }
    
    func presentDataNotSubmitted() {
        
    }
    
    func presentData(response: ReviewRelicModels.Response) {
        
        let viewModel: ReviewRelicModels.ViewModel
        
        let appLogo: UIImage
        if let string = response.settings.appLogo.components(separatedBy: ",").last, let image = UIImage(base64String: string){
            appLogo = image
        }else{
            appLogo = UIImage(namedInBundle: "RRLogo")
        }
        
        if response.settings.shouldShowImages {
            
            let selectedImage: UIImage
            if let string = response.settings.fillImage.components(separatedBy: ",").last, let image = UIImage(base64String: string){
                selectedImage = image
            }else{
                selectedImage = UIImage(namedInBundle: "starSelected")
            }
            
            let unSelectedImage: UIImage
            if let string = response.settings.emptyImage.components(separatedBy: ",").last, let image = UIImage(base64String: string){
                unSelectedImage = image
            }else{
                unSelectedImage = UIImage(namedInBundle: "starSelected")
            }
            
            let starData = ReviewRelicModels.ViewModel.StarsData(
                starsCount: response.reviewSettings.count,
                starSelected: selectedImage,
                starUnSelected: unSelectedImage)
            
            viewModel = ReviewRelicModels.ViewModel(
                ratingType: .stars(starData),
                themeColor: UIColor(hex: response.settings.color),
                appLogo: appLogo)
            
        }else{
            
            var words = [ReviewRelicModels.ViewModel.WordsData.Word]()
            for setting in response.reviewSettings {
                words.append(.init(title: setting.label, rating: setting.value))
            }
            
            let wordsData = ReviewRelicModels.ViewModel.WordsData(words: words)
            viewModel = ReviewRelicModels.ViewModel(
                ratingType: .words(wordsData),
                themeColor: UIColor(hex: response.settings.color),
                appLogo: appLogo)
        }
        
        viewController?.displayData(viewModel: viewModel)
    }
}
