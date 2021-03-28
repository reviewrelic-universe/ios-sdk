//
//  RRHelpers.swift
//  Pods-ReviewRelic_Example
//
//  Created by Raheel Sadiq on 06/03/2021.
//

import Foundation

extension UIImage {
    
    convenience init(namedInBundle named:String) {
        self.init(named: named, in: ReviewRelic.shared.bundle, compatibleWith: nil)!
    }
    
    convenience init?(base64String: String) {
        
        guard let imageData = Data(base64Encoded: base64String, options: Data.Base64DecodingOptions.ignoreUnknownCharacters) else {
            return nil
        }
        self.init(data: imageData)
    }
    
    class func convertBase64ToImage(imageString: String) -> UIImage {
        let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)!
    }
}

extension String {
    
    func trimWhiteSpaces() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).replacingOccurrences(of: "\n", with: "%0A")
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}

extension UIView {
    
    func animateAfterConstraintChangeDuration(seconds value:Double) {
        UIView.animate(withDuration: value, animations: { [weak self] in
            self?.layoutIfNeeded()
        })
    }
    
    func setBorder(color:UIColor, width:CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
    }
    
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

extension UIColor {
    
    class func randomColor () -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:randomRed, green:randomGreen, blue:randomBlue, alpha:1.0)
    }
    
    convenience init(r: CGFloat, g:CGFloat , b:CGFloat , a: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha:a)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
    
    convenience init(hex: String, alpha: CGFloat = 1) {
        assert(hex[hex.startIndex] == "#", "Expected hex string of format #RRGGBB")
        
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 1  // skip #
        
        var rgb: UInt32 = 0
        scanner.scanHexInt32(&rgb)
        
        self.init(
            red:   CGFloat((rgb & 0xFF0000) >> 16)/255.0,
            green: CGFloat((rgb &   0xFF00) >>  8)/255.0,
            blue:  CGFloat((rgb &     0xFF)      )/255.0,
            alpha: alpha)
    }
    
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
    
    struct General {
        static let BlueColor: UIColor = UIColor(r: 1, g: 177, b: 242, a: 1)
        static let GreenColor: UIColor = UIColor(r: 25, g: 174, b: 68, a: 1)
        static let YellowColor: UIColor = UIColor(r: 255, g: 251, b: 213, a: 1)
        static let RedColor: UIColor = UIColor(r: 255, g: 59, b: 48, a: 1)
        
        static let GrayColor: UIColor = UIColor(r: 40, g: 46, b: 57, a: 1)
        static let PurpleColor: UIColor = UIColor(r: 141, g: 119, b: 173, a: 1)
        static let LightPurpleColor: UIColor = UIColor(r: 157, g: 142, b: 183, a: 1)
        
        static let OrangeColor: UIColor = UIColor(r: 255, g: 121, b: 62, a: 1)
        static let OrangeColorTint: UIColor = UIColor(r: 223, g: 133, b: 85, a: 1)
        
        static let DarkGreenColor: UIColor = UIColor(r: 26, g: 37, b: 45, a: 1)
        static let TurqoiseColor: UIColor = UIColor(r: 23, g: 182, b: 196, a: 1)
        
        static let GreyColor: UIColor = UIColor(r: 141, g: 141, b: 141, a: 1)
        static let GoldColor: UIColor = UIColor(r: 250, g: 160, b: 37, a: 1)
        
        static let DarkGrayColor: UIColor = UIColor(r: 73, g: 73, b: 73, a: 1)
        static let LightGrayColor: UIColor = UIColor(r: 200, g: 200, b: 200, a: 1)
        static let OffWhite: UIColor = UIColor(r: 245, g: 245, b: 245, a: 1)
        
        static let NavyBlue: UIColor = UIColor(r: 22, g: 22, b: 41, a: 1)
    }
}
