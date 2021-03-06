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
    
    func setRoundedFull() {
        self.layer.cornerRadius = self.frame.size.width/2;
        self.clipsToBounds = true;
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
    
    
    func showActivityIndicator(color:UIColor = UIColor.gray) {
        if self.viewWithTag(909) != nil {
            return
        }

        let activityIndicator = UIActivityIndicatorView (style: UIActivityIndicatorView.Style.white)
        activityIndicator.tag = 909
        activityIndicator.startAnimating()
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = color
        self.addSubview(activityIndicator)
        activityIndicator.center = self.center
    }
    
    func hideActivityIndicator() {
        if let activityIndicator = self.viewWithTag(909) as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    func showWithAnimation() {
        
        guard isHidden else { return }
        
        self.alpha = 0;
        self.isHidden = false
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.alpha = 1
        })
    }
    
    func addTapGestureToHideKeyboard(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc fileprivate func hideKeyboard(){
        self.endEditing(true)
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
    
    static let borderColor = UIColor.lightGray.withAlphaComponent(0.3)
    static let successGreen = UIColor(hex: 0x228B22)
    
    public struct Relic {
        public static var textDark: UIColor {
            if #available(iOS 13.0, *) {
                return .label
            } else {
                return.darkText
            }
        }
        
        static var textLight: UIColor {
            if #available(iOS 13.0, *) {
                return .secondaryLabel
            } else {
                return.lightGray
            }
        }
    }
}

public extension UIViewController {
    func presentReviewRelic(item: ReviewRelicItem? = nil, completion: (() -> Void)? = nil) -> ReviewRelicViewController {
        let controller = ReviewRelicViewController.instanceFromNibwith(item: item)
        present(controller, animated: true, completion: completion)
        return controller
    }
}

extension UserDefaults {
    class var rRDefaults: UserDefaults? {
        let userDefaults = UserDefaults.init(suiteName: "RRDefaults")
        return userDefaults
    }
}

struct Constants {
    static let settings = "RRSettings"
}

extension Dictionary where Key == String {
    
    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    func printJson() {
        print(json)
    }
}

func Print(_ object: Any) {
    if ReviewRelic.shared.isLogginEnabled {
        print("Review Relic: ", object)
    }
}
