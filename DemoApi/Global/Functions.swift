//  FUnctions.swift

//This Custom class is defined by us
//Class containes many commmon funcations used for customisations


import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift

class Functions: Alamofire.SessionManager {
    
    //Common method to display alert
    class func displayAlert(_ msg:String!,needDismiss:Bool = false,title:String = APP.title)  {
        
        let alertController = UIAlertController(title:title, message:msg, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            if needDismiss {
                UIApplication.topViewController()?.dismiss(animated: true, completion: nil)
            }
            
        }
        alertController.addAction(defaultAction)
        
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
    }
    
    class func displayToast(_ strMessage:String!) {
        
        UIApplication.topViewController()?.view.hideAllToasts()
        UIApplication.topViewController()?.view.makeToast(strMessage)
    }
   
    //Get API method with authentication token
    class func apiGetCall(_ apiName:String,parameters:Dictionary<String,AnyObject>? = nil,block mainBlock:((JSON,NSError?)-> Void?)?) {
        
        if !Connectivity.isConnectedToInternet() {
            displayAlert(APPERRORMESSAGES.noNetwork, needDismiss: false, title: APP.title)
        }
        
        appDelegate.startAnimation()
        
        let headers = ["Content-Type": "application/json","Accept": "application/json"]
        
        self.default.request((API_URL_DEFAULT + API_VERSION + apiName), method: HTTPMethod.get, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseSwiftyJSON { response in
            print("###Success: \(response.result.isSuccess)")
            
            appDelegate.stopAnimation()
            
            //now response.result.value is SwiftyJSON.JSON type
            mainBlock?(response.result.value!,response.result.error as NSError?)
            debugPrint(response.result.value ?? "")
        }
        
        
    }
    
   
    class Connectivity {
        class func isConnectedToInternet() ->Bool {
            return NetworkReachabilityManager()!.isReachable
        }
    }

}
