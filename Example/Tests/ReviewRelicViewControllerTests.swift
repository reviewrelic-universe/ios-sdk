//
//  ReviewRelicViewControllerTests.swift
//  ReviewRelic_Tests
//
//  Created by Raheel Sadiq on 09/03/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import ReviewRelic

class ReviewRelicViewControllerTests: XCTestCase {

    var sut: ReviewRelicViewController!
    var window: UIWindow!


    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupReviewRelicViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup

    func setupReviewRelicViewController() {
        sut = ReviewRelicViewController.instanceFromNib()
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Tests
    
    func testSubmitRequest() throws {
        
        let spy = ReviewRelicInteractorSpy()
        sut.interactor = spy
        let button = UIButton()
        let viewModel =
            ReviewRelicModels.ViewModel.init(
                ratingType: .stars(.init(starsCount: 5, starSelected: UIImage(), starUnSelected: UIImage())),
                themeColor: .black,
                appLogo: UIImage()
            )
        sut.viewModel = viewModel
        sut.rating = 1
        sut.submitAction(button)
        XCTAssertTrue(spy.submitDataCalled, "ViewModel not found probaboy")
    }
    
    
    func testrequestReviewData() throws {
        
        let spy = ReviewRelicInteractorSpy()
        sut.interactor = spy
        sut.requestData()
        XCTAssertTrue(spy.requestReviewDataCalled, "Data is not requested")
    }
    
    // MARK: Test Spies
    
    class ReviewRelicInteractorSpy: ReviewRelicBusinessLogic {
        var requestReviewDataCalled = false
        func requestReviewData() {
            requestReviewDataCalled = true
        }
        
        var submitDataCalled = false
        func submitData(request: ReviewRelicModels.Request) {
            submitDataCalled = true
        }
        
        
    }
}
