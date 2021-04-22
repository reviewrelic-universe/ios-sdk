//
//  ViewController.swift
//  ReviewRelic
//
//  Created by raheel-sadiq-zameen on 02/23/2021.
//  Copyright (c) 2021 raheel-sadiq-zameen. All rights reserved.
//

import UIKit
import ReviewRelic

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openReviewForm(){
        let controller = presentReviewRelic(item: Item()) {
            
        }
        
        let color = UIColor(red: 237/255.0, green: 100/255.0, blue: 166/255.0, alpha: 1)
        controller.setHeadingLabel(text: "Please share you experience", font: .boldSystemFont(ofSize: 17))
        controller.setDescriptionLabel(text: "How did you like the last order from our Restaurant. Please leave us a review.")
        controller.setSubmitButton(title: "Ouch")
//        controller.setReview(image: UIImage())
        controller.delegate = self
    }
}

extension ViewController: ReviewRelicDelegate {
    func reviewRelicViewController(_: ReviewRelicViewController, submittedReviewRating data: ReviewRelic.Transaction) {
        
    }
    
    func reviewRelicViewControllerRatingSubmissionFailed(_: ReviewRelicViewController) {
    
    }
    
    func reviewRelicViewControllerLoadSettingsFailed(_: ReviewRelicViewController) {
        
    }
}

struct Item: ReviewRelicItem {
    var transactionId: String = "32"
    var reviewsId: String? = nil
    
}
