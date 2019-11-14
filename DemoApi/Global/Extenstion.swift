
//
//  Extenstion.swift


//Class is defined for extension , it will add some more functions to apple controls

import UIKit
import Alamofire
import AlamofireImage

private let arrayParametersKey = "arrayParametersKey"

extension Date {
    public static func convertStringToGiventUTCformate(_ dateinString:String,currntStringForamte:String,convertedtoformate:String)->String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currntStringForamte
        
        let newDate = dateFormatter.date(from: dateinString) ?? Date()
        dateFormatter.dateFormat = convertedtoformate
        
        return dateFormatter.string(from: newDate)
        
    }
    
    public static func convertStringToGiventformateInDate(_ dateinString:String,currntStringForamte:String)->Foundation.Date{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currntStringForamte
        return dateFormatter.date(from: dateinString) ?? Foundation.Date()
        
    }
}


extension NSAttributedString {
    func heightWithWidth(_ width: CGFloat) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], context: nil)
        return actualSize.height
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[self.characters.index(self.startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }

}

extension Int {
    func toString() -> String? {
        return String(format:"%d",self)
    }
    
    func toAbs() -> Int {
        return abs(self)
    }
}

extension Int64 {
    func toString() -> String? {
        return String(format:"%d",self)
    }
    
}

extension String {
    
    func substring(_ from: Int) -> String {
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: from))
    }
    
    var length: Int {
        
        return self.count
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
    
    var isBlank: Bool {
        return trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    func toInt() -> Int? {
        return Int(self)
    }
    
    func toDouble() -> Double? {
        return Double(self)
    }
    
    func toDoubleValue() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    func toFloat() -> Float? {
        return Float(self)
    }
    
    public var toJsonArray: [AnyObject]?{
        return (try? JSONSerialization.jsonObject(with: self.data(using: String.Encoding.utf8, allowLossyConversion: false)!, options: JSONSerialization.ReadingOptions.allowFragments)) as? [AnyObject]
        
    }
    
}

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 3.0
        
//        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    public func setCornerRadiusForView(_ radius:Int) {
        
        self.layoutIfNeeded()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = CGFloat(radius)
        
    }
    
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}


extension UIViewController {
    
    func isUIViewControllerPresentedAsModal() -> Bool {
        if((self.presentingViewController) != nil) {
            return true
        }
        
        if(self.presentingViewController?.presentedViewController == self) {
            return true
        }
        
        if(self.navigationController?.presentingViewController?.presentedViewController == self.navigationController) {
            return true
        }
        
        if((self.tabBarController?.presentingViewController?.isKind(of: UITabBarController.self)) != nil) {
            return true
        }
        
        return false
    }
}


extension UIImageView {
    
    
    func setImageWithPlaceholder(string: String,placeholder:UIImage = UIImage.init(named: "no_data")!) {
        if let url = URL(string: string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!) {
            
            self.af_setImage(withURL: url, placeholderImage: placeholder, filter: nil, progress: nil, progressQueue: DispatchQueue.global(), imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: false, completion: nil)
            
        } else {
            self.image = placeholder
        }
    }
}

extension UIScreen {
    
    enum SizeType: CGFloat {
        case unknown = 0.0
        case iPhone4 = 960.0
        case iPhone5 = 1136.0
        case iPhone6 = 1334.0
        case iPhone6Plus = 1920.0
    }
    
    var sizeType: SizeType {
        let height = nativeBounds.height
        guard let sizeType = SizeType(rawValue: height) else { return .unknown }
        return sizeType
    }
}


extension UIColor {
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha:1)
    }
    
    convenience init(hex: String, alpha: CGFloat) {
        var hexWithoutSymbol = hex
        if hexWithoutSymbol.hasPrefix("#") {
            hexWithoutSymbol = hex.substring(1)
        }
        
        let scanner = Scanner(string: hexWithoutSymbol)
        var hexInt:UInt32 = 0x0
        scanner.scanHexInt32(&hexInt)
        
        var r:UInt32!, g:UInt32!, b:UInt32!
        switch (hexWithoutSymbol.length) {
        case 3: // #RGB
            r = ((hexInt >> 4) & 0xf0 | (hexInt >> 8) & 0x0f)
            g = ((hexInt >> 0) & 0xf0 | (hexInt >> 4) & 0x0f)
            b = ((hexInt << 4) & 0xf0 | hexInt & 0x0f)
            break;
        case 6: // #RRGGBB
            r = (hexInt >> 16) & 0xff
            g = (hexInt >> 8) & 0xff
            b = hexInt & 0xff
            break;
        default:
            // TODO:ERROR
            break;
        }
        
        self.init(
            red: (CGFloat(r)/255),
            green: (CGFloat(g)/255),
            blue: (CGFloat(b)/255),
            alpha:alpha)
    }
    
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
    
}

extension Array {
  
    mutating func removeObjectFromArray<T>(_ obj: T) where T : Equatable {
        self = self.filter({$0 as? T != obj})
    }
 
    func contains<T>(_ obj: T) -> Bool where T : Equatable {
            return self.filter({$0 as? T == obj}).count > 0
    }
    
    func containsObject(object: Any) -> Bool
    {
        if let anObject: AnyObject = object as? AnyObject
        {
            for obj in self
            {
                if let anObj: AnyObject = obj as? AnyObject
                {
                    if anObj === anObject
                    {
                        return true
                        
                    }
                }
            }
        }
        return false
    }
    
    
}

extension NSDictionary{
    
    func getDoubleValue(key: String) -> Double{
        
        if let any: AnyObject = self.object(forKey: key) as AnyObject?{
            if let number = any as? NSNumber{
                return number.doubleValue
            }else if let str = any as? NSString{
                return str.doubleValue
            }
        }
        return 0
    }
    
    func getFloatValue(key: String) -> Float{
        
        if let any: AnyObject = self.object(forKey: key) as AnyObject? {
            if let number = any as? NSNumber{
                return number.floatValue
            }else if let str = any as? NSString{
                return str.floatValue
            }
        }
        return 0
    }
    
    func getIntValue(key: String) -> Int{
        
        if let any: Any = self.object(forKey: key) as Any? {
            if let number = any as? NSNumber{
                return number.intValue
            }else if let str = any as? NSString{
                return str.integerValue
            }
        }
        return 0
    }
    
    func getInt64Value(key: String) -> Int64{
        
        if let any: Any = self.object(forKey: key) as Any? {
            if let number = any as? NSNumber{
                return number.int64Value
            }else if let str = any as? NSString{
                return Int64(str as String)!
            }
        }
        return 0
    }
    
    
    func getStringValue(key: String) -> String{
        
        if let any: AnyObject = self.object(forKey: key) as AnyObject? {
            if let number = any as? NSNumber{
                return number.stringValue
            }else if let str = any as? String{
                return str
            }
        }
        return ""
    }
    
    func getBooleanValue(key: String) -> Bool {
        
        if let any:AnyObject = self.object(forKey: key) as AnyObject? {
            if let num = any as? NSNumber {
                return num.boolValue
            } else if let str = any as? NSString {
                return str.boolValue
            }
        }
        return false
    }
    
    func getStringArrayValue(key: String) -> [String]{
        
        if let any:AnyObject = self.object(forKey: key) as AnyObject? {
            if let ary = any as? [String] {
                return ary
            }
        }
        return []
    }
    
    func getStringDictionaryValue(key : String) -> NSDictionary {
        if let any:AnyObject = self.object(forKey: key) as AnyObject? {
            if let ary = any as? NSDictionary {
                return ary
            }
        }
        return [:]
    }
    
    func getArrayValue(key : String) -> NSArray {
        if let any:AnyObject = self.object(forKey: key) as AnyObject? {
            if let ary = any as? NSArray {
                return ary
            }
        }
        return []
    }
    
}

extension Dictionary {
    
    public var toJsonString: String?{
        return NSString(data:try! JSONSerialization.data(withJSONObject: self as AnyObject, options: JSONSerialization.WritingOptions.prettyPrinted), encoding:String.Encoding.utf8.rawValue) as String?
        
    }
    
}

extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func fadeIn(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
            }, completion: completion)  }
    
    func fadeOut(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
            }, completion: completion)
    }

    func setBorderWithColor(_ width:Int, colorName:UIColor) {
        
        self.layoutIfNeeded()
        self.layer.borderWidth = CGFloat(width)
        self.layer.masksToBounds = true
        self.layer.borderColor = colorName.cgColor
        
    }

}

extension UIStoryboard {
    
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
  
    var identifier: String {
        if let name = self.value(forKey: "name") as? String {
            return name
        }
        return ""
    }
    
    /// Get view controller from storyboard by its class type
    /// Usage: let profileVC = storyboard!.get(ProfileViewController.self) / profileVC is of type ProfileViewController /
    /// Warning: identifier should match storyboard ID in storyboard of identifier class
    public func get<T:UIViewController>(_ identifier: T.Type) -> T? {
        let storyboardID = String(describing: identifier)
        
        guard let viewController = instantiateViewController(withIdentifier: storyboardID) as? T else {
            return nil
        }
        
        return viewController
    }
    
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}


