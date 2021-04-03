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
        controller.setHeadingLabel(text: "Please share you experience", font: .boldSystemFont(ofSize: 17), textColor: color)
        controller.setDescriptionLabel(text: "How did you like the last order from our Restaurant. Please leave us a review.", textColor: UIColor.black.withAlphaComponent(0.4))
    }
}

struct Item: ReviewRelicItem {
    var transectionId: String = "32"
    var reviewsId: String? = nil
}
