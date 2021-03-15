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

//        let starData = ReviewRelicModels.ViewModel.StarsData(
//            starsCount: 5,
//            starSelected: UIImage(namedInBundle: "starSelected"),
//            starUnSelected: UIImage(namedInBundle: "starUnSelected"))
//
//        let viewModel = ReviewRelicModels.ViewModel(
//            ratingType: .stars(starData),
//            themeColor: ReviewRelic.shared.data!.themeColor)
//
        let wordsData = ReviewRelicModels.ViewModel.WordsData(words: [
            .init(title: "Good", rating: 3),
            .init(title: "Better", rating: 4),
            .init(title: "Best", rating: 5),
            .init(title: "Bahtreen", rating: 7),
            .init(title: "Bad", rating: 2),
            .init(title: "Worst", rating: 1),

        ])
        let viewModel = ReviewRelicModels.ViewModel(
            ratingType: .words(wordsData),
            themeColor: ReviewRelic.shared.data!.themeColor)
        
        viewController?.displayData(viewModel: viewModel)
    }
}
