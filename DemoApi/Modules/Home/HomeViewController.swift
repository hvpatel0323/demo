//
//  HomeViewController.swift


import UIKit
import SwiftyJSON


class HomeViewController: UIViewController {
    
    //Local Veriable declarations
    @IBOutlet weak var tblList: UITableView!
    var heatsArray:Array<Hits> = Array()
    var selectedIndexes:Array<Int> = Array()
    
    var pageNumber:Int = 1
    var selectedCount = 0
    var totalPages = 0
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpIntialViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //API CALL to fetch latest Data
        self.setWebApiCallToGetData()
    }
    
    
    //Start User Defined Funcations
    
    /// Funcations to set intial property for views and subviews.
    ///
    /// - returns: void
    @objc func setSelected(_ sender:UISwitch)
    {
        if(sender.isOn)
        {
            self.selectedCount = self.selectedCount + 1
            
        }
        else
        {
            self.selectedCount = self.selectedCount - 1
        }
        
        if(selectedIndexes.contains(sender.tag))
        {
            self.selectedIndexes.removeObjectFromArray(sender.tag)
        }
        else
        {
            self.selectedIndexes.append(sender.tag)
        }
        
        self.navigationItem.title = APPERRORMESSAGES.totalItems + self.selectedCount.toString()!
    }
    
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        self.pageNumber = 1
        self.setWebApiCallToGetData()
    }
    
    func setUpIntialViews(){
        
        self.navigationItem.title = APPERRORMESSAGES.totalItems + self.selectedCount.toString()!
        
        //Tableview Properties
        self.tblList.tableFooterView = UIView.init()
        self.tblList.estimatedRowHeight = 70
        
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Latest records")
        refreshControl.addTarget(self, action: #selector(self.refresh(sender:)), for: UIControl.Event.valueChanged)
        self.tblList.addSubview(refreshControl) // not required when using UITableViewController
        
        
    }
    
    //End User Defined Funcations
    
    
    //MARK : Start WEB API CALLS
    
    /// Funcations to call api for article data fetching
    
    
    func setWebApiCallToGetData(){
        
        let requestUrl = APITAG.story + APITAG.page + pageNumber.toString()!
        
        API.sharedInstance.getAllData(requestUrl) { (status, json) in
            if(status)
            {
                if(json != nil)
                {
                    if(self.pageNumber == 1)
                    {
                        self.selectedCount = 0
                        self.heatsArray.removeAll()
                        self.selectedIndexes.removeAll()
                        self.navigationItem.title = APPERRORMESSAGES.totalItems + self.selectedCount.toString()!
                    }
                    
                    let arrResults = json![APIKey.results].arrayValue
                    
                    self.totalPages = json![APIKey.nbPages].intValue
                    
                    
                    for obj in arrResults {
                        
                        let objHit = Hits.init(fromJson: obj)
                        self.heatsArray.append(objHit)
                    }
                    self.tblList.reloadData()
                    
                    if(self.refreshControl != nil && self.refreshControl.isRefreshing == true)
                    {
                        self.refreshControl.endRefreshing()
                    }
                    
                }
                else
                {
                    Functions.displayAlert(APPERRORMESSAGES.serverError)
                }
                
            }
            else
            {
                
            }
        }
    }
    
    //End  WEB API CALLS
    
}

//MARK:- table datasource/delegate
extension HomeViewController: UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate{
    //Pagination
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        print("scrollViewDidEndDecelerating")
        if ((tblList.contentOffset.y + tblList.frame.size.height) >= tblList.contentSize.height)
        {
            if(self.pageNumber != self.totalPages)
            {
                self.pageNumber = self.pageNumber + 1
                self.setWebApiCallToGetData()
            }
            
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heatsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! DataCell
        cell.selectionStyle = .none
        cell.swSwitch.tag = indexPath.row
        cell.swSwitch.isOn = false
        
        if(self.selectedIndexes.contains(indexPath.row))
        {
            cell.swSwitch.isOn = true
        }
        
        cell.swSwitch.isEnabled = false
//        cell.swSwitch.removeTarget(self, action: nil, for: UIControl.Event.valueChanged)
//        cell.swSwitch.addTarget(self, action: #selector(self.setSelected(_:)), for: UIControl.Event.valueChanged)
        
        let objData = self.heatsArray[indexPath.row]
        
        cell.lblTitle.text = objData.title
        
        let strDate = objData.createdAt.replacingOccurrences(of: "Z", with: "")
        
        cell.lblDate.text = Date.convertStringToGiventUTCformate(strDate, currntStringForamte: "yyyy-MM-dd'T'HH:mm:ss.SSS", convertedtoformate: "dd MMM yyyy hh:mm a")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if(selectedIndexes.contains(indexPath.row))
        {
            self.selectedIndexes.removeObjectFromArray(indexPath.row)
            self.selectedCount = self.selectedCount - 1
        }
        else
        {
            self.selectedIndexes.append(indexPath.row)
            self.selectedCount = self.selectedCount + 1
        }
        self.tblList.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
        self.navigationItem.title = APPERRORMESSAGES.totalItems + self.selectedCount.toString()!
        
    }
}
