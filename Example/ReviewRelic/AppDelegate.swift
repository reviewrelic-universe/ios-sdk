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
        let apiKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNTZjNzcxN2ZlYTllNjk1MDE0YzA2YjUyZmFiMzQ2NTVlZTM2MmNlY2Q3M2RhMGU3ZTYwZTM0NmFjMzBiNTdmNjg0NmJiNjk4NzJmYjFhMWMiLCJpYXQiOjE2MTczODMzNjQsIm5iZiI6MTYxNzM4MzM2NCwiZXhwIjoxNjQ4OTE5MzY0LCJzdWIiOiI2Iiwic2NvcGVzIjpbXX0.CNIY0_C-Cp4MjRKy4oLLZJ4lq_Lvyl5rRQmpI_ckPBukEN05OD730XTGW8ECeOKgNLOVLoJ4FHR7ZWl6HmkHLaBwOPUzCJSnHlNjRz66ctepGHgmcVxDMjjGlcFEd_PVJMmqipPApJECH048P5be21JpxS1hxYsNbrclBSxE_N4-eHL_COR84NDKggSlEkNKbHIx8XyiOhczzcLJtjZHFnJpXo1E09wOUfnQKLahLeekOfTpHBNl8s0k7W8Sa_ZhO1mMUTEvr2r-pDLme_vbXoNd6vW4vOcOJ6T5BIKalt69Fg87LHhHFEJ0Lw-vcpj02Nu-nVteFEC9xPZFKzsntWPqcBiZIaWHbiKqorJDVoeNcAqREC3_XS6EGQ6PMl2gS7Xefy1nkvOSpxJsHp0Qo6ZEv7nnKkz0M2CSaB6ywAXQjCW23CVBnuvu04w4v1P7djCE5iKzDN19RQMnLQWA8_DacuzbgYLdXmeSrKq_t02V8HZHSU_2u0wMSPZqLrg7qlsz-WgqN1ol83LngQZ-W6D82z7l05qP3aBCvCVZx1k-D-qGGPXOgpPLkXQ6Zeyywk730gUGHaBmmZmS72v99qQF_6sZOHC-_UuwN6GP0uK2JgE0m5m-H1wju8DzPwmGaVPp4nPbzBLwRPX6vSi9Vb5AlLPH8h0Y6bRzw2oQWQY"
        
        ReviewRelic.shared.initialize(
            apiKey: apiKey,
            appSecret: "7e659a91fefee11b87700e582639ec61d4869a99d1232577c64400c5b17bf103")
    
        return true
    }
}

