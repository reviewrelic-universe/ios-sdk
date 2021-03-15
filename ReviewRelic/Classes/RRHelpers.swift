//
//  RRHelpers.swift
//  Pods-ReviewRelic_Example
//
//  Created by Raheel Sadiq on 06/03/2021.
//

import Foundation

extension UIImage {
    
    convenience public init(namedInBundle named:String) {
        self.init(named: named, in: ReviewRelic.shared.bundle, compatibleWith: nil)!
    }
}


extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}

extension String {
    func trimWhiteSpaces() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).replacingOccurrences(of: "\n", with: "%0A")
    }
}

extension UIView {
    
    func setRoundedCorner(radius value:CGFloat) {
        self.layer.cornerRadius = value
        self.clipsToBounds = true
    }
    
    func shake() {
        self .shake(8, direction:1, currentTimes:0, delta: 8, interval: 0.03, shakeDirection: .horizontal)
    }
    
    private func shake(_ times:Int, direction:Int, currentTimes:Int, delta:CGFloat, interval:TimeInterval, shakeDirection:ShakeDirection) {
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            
            if shakeDirection == ShakeDirection.horizontal {
                self.layer.setAffineTransform(CGAffineTransform(translationX: delta * CGFloat(direction), y: 0))
            } else{
                self.layer.setAffineTransform(CGAffineTransform(translationX: 0, y: delta * CGFloat(direction)))
            }
            
        }, completion: { (finish) -> Void in
            if currentTimes >= times {
                UIView.animate(withDuration: interval, animations: { () -> Void in
                    self.layer.setAffineTransform(CGAffineTransform.identity)
                })
                return
            }
            self.shake(times-1, direction: direction * -1, currentTimes: currentTimes+1, delta: delta, interval: interval, shakeDirection: shakeDirection)
        })
        
    }
}

enum ShakeDirection:Int {
    case horizontal = 0
    case vertical = 1
}
