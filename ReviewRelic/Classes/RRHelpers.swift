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

extension UIView {
    func setRoundedCorner(radius value:CGFloat) {
        self.layer.cornerRadius = value
        self.clipsToBounds = true
    }
}
