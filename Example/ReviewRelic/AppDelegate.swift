//
//  AppDelegate.swift
//  ReviewRelic
//
//  Created by raheel-sadiq-zameen on 02/23/2021.
//  Copyright (c) 2021 raheel-sadiq-zameen. All rights reserved.
//

import UIKit
import ReviewRelic

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
                
        ReviewRelic.shared.initialize(apiKey: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZTI5MmEwNWFjMzI4MTNkNjJkN2E0MzdlMGFlMTU2YzljNmE4MzM2MjY4NGJjZDBlMmMyMTcxYWEyNGJmYmQ0ZWE1MDY1N2M0NDRhZGJiYzIiLCJpYXQiOjE2MTY4NTUwMzMsIm5iZiI6MTYxNjg1NTAzMywiZXhwIjoxNjQ4MzkxMDMzLCJzdWIiOiI2Iiwic2NvcGVzIjpbXX0.QXqbhhyq17BkGITOQFaeqtKnv6proccnOCYC8w6yrD5wZoo8diODlOdVdeU03WJpPXRqtm9J-C3UNnFFi658gunR9uSdRjPg6k-LSEpz8JMlv6R5gPbd8CLsMJgXaZFCFMQPPivIIiwAIqqz8uZ7MEwkBG345mw9soZooS7ewrjO2Wg1YK6NlqG39ST-JPD_iv-BSbRrcxJiFLVpVm78YmKdOYuvZoUBnV4cnAxrdiW4dFZEb9PG0RSzKKQ8ll1ZMifnfC6pAFBs7RReuyf_d93LRd1blgK5hU3Dgg_mScdtaLWY4cVu9xWCpcJcSppsTQtE8ePzBVKentDaGu44GCITW49qBzbLRZhDjSnyCwk4lX9PFhCj31OjxzRutEuOVwuDXW8BawW6JR5egmXPd0RfzDFpOpa4B21YqLboE1V42PRHe6c9nYWpswSV5CxX49CkK-YjMjKKXrSSKyb2sSfsP-QUMfAwTQy2lNFpQYvSrYc6GIMBSMXE_E-AqFEkqRfa3V1roX9hdsNeLs7KcynJVWuDgrOP74XQHNq_9yL-Q5fW-7IYPdCvpBugXtShkbu_Fgc4HqOQ_wAuNe31lhkB2pEoURQx9f2369BfbPXPiYo6glUkHWFoDMAiu0AWLOr5A_PQHDa79P87Vb2I4_4XPe6xeYgIPK_kdzcOE0w")
    
        return true
    }

}

