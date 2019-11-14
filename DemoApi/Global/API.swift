import UIKit
import SwiftyJSON
//MARK : This class is used to call api funcations, api keys, api messages and tags
//Class also creates singleton instance

let API_SEARCH_DATA = "/search_by_date"


struct APITAG {
    
    static let story    = "story&"
    static let tags = "?tags="
    static let page = "page="
    
}

struct APIKey {
    
    static let results   =   "hits"
    static let nbHits   =   "nbHits"
    static let nbPages   =   "nbPages"
    static let page   =   "page"
    static let createdAt   =   "created_at"
    static let title   =   "title"
   
}


enum APIRESPONSESTATUS:String {
    case OK  = "OK"
}


class API: NSObject {
    
    struct Singleton {
        static let sharedInstance = API()
    }
    
    class var sharedInstance: API {
        return Singleton.sharedInstance
    }
    
    typealias completionHandler = ((Bool,JSON?)->Void)?
    
    fileprivate func displayError(_ error:NSError!,needDismiss:Bool = false){
    
    if error != nil {
        if error.code == -1009 || error.code == -1001{
            Functions.displayAlert(APPERRORMESSAGES.noNetwork,needDismiss: needDismiss);
        }
        else if error.code == -6003
        {
            
        }
        else{
            Functions.displayAlert(APPERRORMESSAGES.serverError,needDismiss: needDismiss)
        }
    }
}
    
    
    //Web APi Call
    //MARK: ---- Get All Data  ----- HOMEVC
    
    func getAllData(_ strApiParameters:String?,block:completionHandler){
        
        Functions.apiGetCall(API_SEARCH_DATA + APITAG.tags + strApiParameters!, block: { (json, error) -> Void in
            
            if error != nil {
                self.displayError(error, needDismiss: false)
                block?(false,nil)
            }else{
                block?(true,json)
                
            }
        })
    
    }
    
}
