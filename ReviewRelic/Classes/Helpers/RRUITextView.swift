//
//  RRUITextView.swift
//  Pods-ReviewRelic_Example
//
//  Created by Raheel Sadiq on 27/02/2021.
//

import Foundation
import UIKit

class RRUITextView: UITextView, UITextViewDelegate {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setPlaceHolder()
        delegate = self
        textContainerInset = .zero
    }

    let placeHolder = "Add any further comments"
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        setPlaceHolder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        setPlaceHolder()
    }
    
    func setPlaceHolder() {
        if text.trimWhiteSpaces() == "" {
            text = placeHolder
            
            if #available(iOS 13.0, *) {
                textColor = UIColor.secondaryLabel
            }else{
                textColor = UIColor.lightGray
            }
       
        } else if text == placeHolder {
            text = ""
            
            if #available(iOS 13.0, *) {
                textColor = UIColor.label
            } else{
                textColor = UIColor.darkText
            }
        
        } else {
           
            if #available(iOS 13.0, *) {
                textColor = UIColor.label
            } else {
                textColor = UIColor.darkText
            }
        }
        

    }
    
    func textViewDidChange(_ textView: UITextView) {
        manageScrolling()
    }
    
    func manageScrolling(){
        
        if textContainer.size.height > 80 {
            isScrollEnabled = true
        }else{
            isScrollEnabled = false
        }
    }
    
    var rrText: String {
        return text == placeHolder ? "" : text
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if textView.text.count > 1000 {
            shake()
            return false
        }
        return true
    }
}
