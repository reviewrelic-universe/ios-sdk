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
        button.tag = 4
        sut.submitAction(button)
        XCTAssertTrue(spy.submitDataCalled, "Submit rating is not working")
    }
    
    // MARK: Test Spies
    
    class ReviewRelicInteractorSpy: ReviewRelicBusinessLogic {
        var submitDataCalled = false
        func fetchData() {
            
        }
        
        func submitData(request: ReviewRelicModels.Request) {
            submitDataCalled = true
        }
    }
}
