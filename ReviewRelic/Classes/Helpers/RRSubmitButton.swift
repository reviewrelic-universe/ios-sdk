//
//  RRSubmitButton.swift
//  ReviewRelic_Tests
//
//  Created by Raheel Sadiq on 03/04/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class RRButton: UIButton {
    
    enum State {
        case normal
        case loading
        case submitted
    }
    
    func set(state: State){
        
        switch state {
        
        case .normal:
            setTitle("Submit", for: .normal)
            isEnabled = true
            isUserInteractionEnabled = true
            
        case .loading:
            isEnabled = false
            setTitle(nil, for: .normal)
            self.showActivityIndicator()
        
        case .submitted:
            setTitle("Submited", for: .normal)
            hideActivityIndicator()
            setBackgroundImage(UIColor.successGreen.image(), for: .normal)
            isUserInteractionEnabled = false
        }
    }
}
