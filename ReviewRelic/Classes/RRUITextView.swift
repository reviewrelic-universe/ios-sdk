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
        setPlaceHolder(on: true)
    }
    
    let placeHolder = "Add any further comments"
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeHolder {
            setPlaceHolder(on: false)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            setPlaceHolder(on: true)
        }
    }
    
    func setPlaceHolder(on: Bool) {
        if on {
            text = placeHolder
            textColor = UIColor.lightGray
        }else{
            text = ""
            textColor = UIColor.darkText
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "" {
            setPlaceHolder(on: true)
        }else{
            setPlaceHolder(on: false)
        }
        
        return true
    }
}
