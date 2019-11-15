
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
    
    var length: Int {
        
        return self.count
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
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

extension Array {
  
    mutating func removeObjectFromArray<T>(_ obj: T) where T : Equatable {
        self = self.filter({$0 as? T != obj})
    }
 
    func contains<T>(_ obj: T) -> Bool where T : Equatable {
            return self.filter({$0 as? T == obj}).count > 0
    }
    
    func containsObject(object: Any) -> Bool
    {
        for obj in self
        {
            if (obj as AnyObject) === (object as AnyObject)
            {
                return true
                
            }
            
        }
        return false
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


