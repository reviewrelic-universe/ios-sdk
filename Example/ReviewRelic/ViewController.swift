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
        presentReviewRelic(item: Item()) {
            
        }
    }
}

struct Item: ReviewRelicItem {
    var sku = "kungfu"
}
