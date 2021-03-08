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
}

class ReviewRelicPresenter: ReviewRelicPresentationLogic {
    
    weak var viewController: ReviewRelicDisplayLogic?
    
    // MARK: Present
    
    func presentData(response: ReviewRelicModels.Response) {
        let starData = ReviewRelicModels.ViewModel.StarsData(
            starsCount: 5,
            starSelected: UIImage(namedInBundle: "starSelected"),
            starUnSelected: UIImage(namedInBundle: "starUnSelected"))
        
        let viewModel = ReviewRelicModels.ViewModel(
            ratingType: .stars(starData),
            themeColro: ReviewRelic.shared.data!.themeColor)
        viewController?.displayData(viewModel: viewModel)
    }
}
