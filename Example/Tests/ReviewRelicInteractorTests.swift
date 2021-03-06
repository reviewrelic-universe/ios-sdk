//
//  ReviewRelicInteractorTests.swift
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

class ReviewRelicInteractorTests: XCTestCase
{
    // MARK: Subject under test
    
    var sut: ReviewRelicInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupReviewRelicInteractor()

        let apiKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNTZjNzcxN2ZlYTllNjk1MDE0YzA2YjUyZmFiMzQ2NTVlZTM2MmNlY2Q3M2RhMGU3ZTYwZTM0NmFjMzBiNTdmNjg0NmJiNjk4NzJmYjFhMWMiLCJpYXQiOjE2MTczODMzNjQsIm5iZiI6MTYxNzM4MzM2NCwiZXhwIjoxNjQ4OTE5MzY0LCJzdWIiOiI2Iiwic2NvcGVzIjpbXX0.CNIY0_C-Cp4MjRKy4oLLZJ4lq_Lvyl5rRQmpI_ckPBukEN05OD730XTGW8ECeOKgNLOVLoJ4FHR7ZWl6HmkHLaBwOPUzCJSnHlNjRz66ctepGHgmcVxDMjjGlcFEd_PVJMmqipPApJECH048P5be21JpxS1hxYsNbrclBSxE_N4-eHL_COR84NDKggSlEkNKbHIx8XyiOhczzcLJtjZHFnJpXo1E09wOUfnQKLahLeekOfTpHBNl8s0k7W8Sa_ZhO1mMUTEvr2r-pDLme_vbXoNd6vW4vOcOJ6T5BIKalt69Fg87LHhHFEJ0Lw-vcpj02Nu-nVteFEC9xPZFKzsntWPqcBiZIaWHbiKqorJDVoeNcAqREC3_XS6EGQ6PMl2gS7Xefy1nkvOSpxJsHp0Qo6ZEv7nnKkz0M2CSaB6ywAXQjCW23CVBnuvu04w4v1P7djCE5iKzDN19RQMnLQWA8_DacuzbgYLdXmeSrKq_t02V8HZHSU_2u0wMSPZqLrg7qlsz-WgqN1ol83LngQZ-W6D82z7l05qP3aBCvCVZx1k-D-qGGPXOgpPLkXQ6Zeyywk730gUGHaBmmZmS72v99qQF_6sZOHC-_UuwN6GP0uK2JgE0m5m-H1wju8DzPwmGaVPp4nPbzBLwRPX6vSi9Vb5AlLPH8h0Y6bRzw2oQWQY"
        
        ReviewRelic.shared.initialize(
            apiKey: apiKey,
            appSecret: "7e659a91fefee11b87700e582639ec61d4869a99d1232577c64400c5b17bf103",
            merchantId: "")
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupReviewRelicInteractor()
    {
        sut = ReviewRelicInteractor()
    }
    
    // MARK: Test doubles
    
    class ReviewRelicPresentationLogicSpy: ReviewRelicPresentationLogic {
        
        var presentDataSubmittedSuccessfullyCalled = false
        var presentDataFailureCalled = false
        var dataPresentedCalled = false
        var presentDataSubmittedFailedCalled = false
        
        func presentData(response: ReviewRelicModels.SettingsResponse){
            dataPresentedCalled = true
        }
        
        func presentDataFailure(){
            presentDataFailureCalled = true
        }
        
        func presentDataSubmittedSuccessfully(data: ReviewRelicModels.SumissionResponse) {
            presentDataSubmittedSuccessfullyCalled = true
        }
        
        func presentDataSubmittedFailed(){
            presentDataSubmittedFailedCalled = true
        }
        
    }
    
    
    // MARK: Tests
    
    func testHMAC(){
        let request = ReviewRelicModels.Request(rating: 1, itemId: "11", reviewerId: nil, comments: "comments", title: "", description: "")
        let workerRequest = ReviewRelicModels.WorkerRequest(request: request, time: 1617446778)
        let createdHMACForOneTime = "2f19a1e4bb9a49dc3a021fa190945162da7aaceb17db447b9c3f72099e1b9eea"
        XCTAssertEqual(workerRequest.hmac, createdHMACForOneTime, "Signature is not valid for requests")
    }
    
    func testHMACWithoutTransactionId(){
        let request = ReviewRelicModels.Request(rating: 1, itemId: nil, reviewerId: nil, comments: "comments", title: "", description: "")
        let workerRequest = ReviewRelicModels.WorkerRequest(request: request, time: 1617446778)
        let createdHMACForOneTimeWithoutTransactionId = "5d3ccd40d0db3637ff69ec517298d4f999ea0d2cc061ca6ca4ea19ec9e3d0bd7"
        XCTAssertEqual(workerRequest.hmac, createdHMACForOneTimeWithoutTransactionId, "Signature is not valid for requests")
    }
    
    func testSubmitRequest(){
        
        let expectation = XCTestExpectation(description: "Submitting Data")
        
        let request = ReviewRelicModels.Request(rating: 1, itemId: "11", reviewerId: nil, comments: "comments", title: "", description: "")

        let spy = ReviewRelicPresentationLogicSpy()
        sut.presenter = spy
        
        sut.submitData(request: request, completion: {
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(spy.presentDataSubmittedSuccessfullyCalled, "Data submission failed")
    }
    
    func testRequestReviewDataSuccess() {
        
        let spy = ReviewRelicPresentationLogicSpy()
        sut.presenter = spy
        sut.requestReviewData()
        
        XCTAssertTrue(spy.dataPresentedCalled, "Data not presented")
    }
    
    func testRequestReviewDataFailure() {
        
        let spy = ReviewRelicPresentationLogicSpy()
        sut.presenter = spy
        sut.requestReviewData()
        
        XCTAssertTrue(spy.dataPresentedCalled, "Failure not presented")
    }
}
