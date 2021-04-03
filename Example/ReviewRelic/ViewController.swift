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
        
        controller.setHeadingLabel(text: "This is the text being set from app", textColor: .purple)
        controller.setDescriptionLabel(text: "This is a multiline text.\n This is a multiline text.\nThis is a multiline text.\n.", textColor: UIColor.purple.withAlphaComponent(0.7))
    }
}

struct Item: ReviewRelicItem {
    var transectionId: String = "32"
    var reviewsId: String? = nil
}
