//
//  ReviewRelicPresenterTests.swift
//  ReviewRelic
//
//  Created by Raheel Sadiq on 27/03/2021.
//  Copyright (c) 2021 CocoaPods. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import ReviewRelic
import XCTest

class ReviewRelicPresenterTests: XCTestCase
{
    // MARK: Subject under test
    
    var sut: ReviewRelicPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupReviewRelicPresenter()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupReviewRelicPresenter()
    {
        sut = ReviewRelicPresenter()
    }
    
    // MARK: Test doubles
    
    class ReviewRelicDisplayLogicSpy: ReviewRelicDisplayLogic {
        var displayDataSubmittedSuccessfullyCalled = false
        func displayDataSubmittedSuccessfully(data: ReviewRelicModels.SumissionResponse) {
            displayDataSubmittedSuccessfullyCalled = true
        }
        
        
        var displayDataCalled = false
        func displayData(viewModel: ReviewRelicModels.ViewModel) {
            displayDataCalled = true
        }
        
        var displayDataFailureCalled = false
        func displayDataFailure() {
            displayDataFailureCalled = true
        }
        
        var displayDataSubmittedFailedCalled = false
        func displayDataSubmittedFailed() {
            displayDataSubmittedFailedCalled = true
        }
    
    }
    
    // MARK: Tests
    
    func asynExpectation(execute:(()->Void)){
        let expectation = XCTestExpectation(description: "")
        execute()
        Timer.scheduledTimer(withTimeInterval: 0.001, repeats: false) { (_) in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.0011)
    }
    
    func testPresentDataFailure(){
        let spy = ReviewRelicDisplayLogicSpy()
        sut.viewController = spy
        
        asynExpectation {
            sut.presentDataFailure()
        }
        
        XCTAssertTrue(spy.displayDataFailureCalled, "Data not presented")

    }
    
    func testPresentDataSubmittedSuccessfully(){
        let spy = ReviewRelicDisplayLogicSpy()
        sut.viewController = spy
        
        asynExpectation {
            sut.presentDataSubmittedSuccessfully(data: .init(transaction: .init(transactionID: "", uuid: "", rating: 0, label: "", comments: ""), status: true))
        }
        
        XCTAssertTrue(spy.displayDataSubmittedSuccessfullyCalled, "Data not presented")

    }
    
    func testPresentDataSubmittedFailed(){
        let spy = ReviewRelicDisplayLogicSpy()
        sut.viewController = spy
        
        asynExpectation {
            sut.presentDataSubmittedFailed()
        }
        
        XCTAssertTrue(spy.displayDataSubmittedFailedCalled, "Data not presented")

    }
    
    func testDataPresentaiton() {
        
        guard
            let data = ReviewRelicTestsData.StarBasedRatingJson.data(using: .utf8),
            let response = try? JSONDecoder().decode(ReviewRelicModels.SettingsResponse.self, from: data) else {
           
            XCTAssertTrue(false,  "Settings data encoding failed")
            return
        }
    
        let spy = ReviewRelicDisplayLogicSpy()
        sut.viewController = spy
        
        asynExpectation {
            sut.presentData(response: response)
        }
        
        XCTAssertTrue(spy.displayDataCalled, "Display data not called")
    }
}
