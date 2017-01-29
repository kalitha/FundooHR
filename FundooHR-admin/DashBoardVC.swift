//
//  DashBoardVC.swift
//  FundooHR
//  Purpose:-
//  1)It is a Dashboard UIClass with IBOutlet and IBAction of DashBoard UIViewController
//  2)In this class we are displaying Number of Unmarked and Marked Employees,FalloutEmployees and Leave summary of Employees
//  
//  Created by BridgeLabz Solutions LLP on 09/12/16.
//  Copyright © 2016 BridgeLabz Solutions LLP. All rights reserved.
//

import UIKit

enum DashBoardControls:Int{
    case ATTENDANCESUMMARY = 0
    case ATTENDANCEFALLOUT
    case LEAVESUMMARY
    case ENGINEERS
    case CLIENTS
}

class DashBoardVC: UIViewController,DashBoardVCProtocol{
   
    //create the variable of type DashBoardViewModel
    var mDashBoardViewModelObj : DashBoardViewModel?
    var mMenuShowing = false
    
    //creating uiview type varible
    var mCustomView = UIView()
    
    //creating UtilityClass object
    let mUtilityClassObj = UtilityClass()
    
    //create outlet of dashboard's header label
    @IBOutlet weak var mHeaderLabel: UILabel!
    //create outlet of tableView
    @IBOutlet weak var mTableView: UITableView!
    //create outlet of slidemenu of dashboard
    @IBOutlet weak var mSlideMenu: UIView!
    //create outlet of collectionview
    @IBOutlet weak var mCollectionView: UICollectionView!
    //create outlet of SlideMenuLeadingConstraint
    @IBOutlet weak var mSlideMenuLeadingConstraint: NSLayoutConstraint!
    //create outlet of date
    @IBOutlet weak var mDate: UILabel!
    //create outlet of activity indicator
    @IBOutlet weak var mActivityIndicator: UIActivityIndicatorView!
    
    // executes when screen gets loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        //enabling the activity indicator
        mActivityIndicator.isHidden = false
        mActivityIndicator.startAnimating()
        mDashBoardViewModelObj = DashBoardViewModel(pDashBoardVCProtocolObj: self)
        
        //registering each xib cell with collectionview cell
        self.mCollectionView.register(UINib(nibName: "AttendanceSummary", bundle: nil), forCellWithReuseIdentifier: "attendanceSummaryCell")
        
        self.mCollectionView.register(UINib(nibName: "AttendanceFallout", bundle: nil), forCellWithReuseIdentifier: "attendanceFalloutCell")
        
        self.mCollectionView.register(UINib(nibName: "LeaveDetails", bundle: nil), forCellWithReuseIdentifier: "leaveSummaryCell")
        
        self.mCollectionView.register(UINib(nibName: "EngineersDetails", bundle: nil), forCellWithReuseIdentifier: "engineersDetailsCell")
        
        self.mCollectionView.register(UINib(nibName: "ClientDetails", bundle: nil), forCellWithReuseIdentifier: "clientDetailsCell")
        
        self.mCollectionView.register(UINib(nibName: "ReportDetails", bundle: nil), forCellWithReuseIdentifier: "reportDetailsCell")
        
        let lConvertedDate = mUtilityClassObj.date()
        
        mDate.text = lConvertedDate
        
        //notifies when screen rotated
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        }
    
    //function to rotate the screen
    func rotated() {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            print("Landscape")
            print("views width",view.frame.width)
            mCustomView.frame = CGRect.init(x: mSlideMenu.frame.width, y: 0, width: view.frame.width-mSlideMenu.frame.width, height: view.frame.height)
            mCustomView.backgroundColor = UIColor.clear
        }
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            print("Portrait")
            print("views width",view.frame.width)
            mCustomView.frame = CGRect.init(x: mSlideMenu.frame.width, y: 0, width: view.frame.width-mSlideMenu.frame.width, height: view.frame.height)
            mCustomView.backgroundColor = UIColor.clear
        }
    }
    
    //add the gesture recognizer when the menu button is tapped
    func addGestureRecognizer(){
        let lTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        self.mCustomView.addGestureRecognizer(lTapGesture)
    }
    
    //remove gesture recognizer after opening the slidemenu
    func removeGestureRecognizer(){
        for recognizer in mCollectionView.gestureRecognizers ?? [] {
            mCustomView.removeGestureRecognizer(recognizer)
        }
    }
    
    //called by addGestureRecognizer method
    func tapBlurButton(_ sender: UIButton) {
        mSlideMenuLeadingConstraint.constant = -250
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        mMenuShowing = !mMenuShowing
        //to remove custom view after removing slidemenu
        self.mCustomView.removeFromSuperview()
        mMenuShowing = !mMenuShowing
        
        //3rd case of removing  gesture when we click on collectionview
        removeGestureRecognizer()
    }
    
    //called when menu button is clicked
    @IBAction func menuOpen(_ sender: UIButton) {
        //changing the custom view's size while we change to landscape mode
        print("views width",view.frame.width)
        mCustomView.frame = CGRect.init(x: mSlideMenu.frame.width, y: 0, width: view.frame.width-mSlideMenu.frame.width, height: view.frame.height)
        mCustomView.backgroundColor = UIColor.clear
        
        if(mMenuShowing){
            mSlideMenuLeadingConstraint.constant = -250
            //1st case of removing tap gesture(papre) when we click on the icon
            
            removeGestureRecognizer()
            
        }else{
            mSlideMenuLeadingConstraint.constant = 0
            self.view.addSubview(mCustomView)
            mCustomView.alpha = 0.5
            addGestureRecognizer()
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        mMenuShowing = !mMenuShowing
        tableviewReload()
    }
    
    //reload tableview data when the data is loaded into it
    func tableviewReload(){
        self.mTableView.reloadData()
    }
    
    //reload collectionview data when the data is loaded into it
    func dashBoardCollectionviewreload(){
        mActivityIndicator.isHidden = true
        self.mActivityIndicator.stopAnimating()
        self.mCollectionView.reloadData()
    }
}


//extension of collectionview cell
extension DashBoardVC: UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        print("valueOfDictionary=-=-=-=",UserDefaults.standard.value(forKey: "tokenKey")!)
        if(UserDefaults.standard.value(forKey: "tokenKey") != nil){            mDashBoardViewModelObj?.fetchDataFromDashBoardController()
        }
        print("dashBoardViewModelObj.responseCount",mDashBoardViewModelObj!.mResponseCount)
        return mDashBoardViewModelObj!.mResponseCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let lDate = Date.init(timeIntervalSince1970: Double((mDashBoardViewModelObj?.mDashBoardContents?.timeStamp)!)/1000)
        let temp = DashBoardControls.ATTENDANCESUMMARY

        if(indexPath.row == temp.rawValue){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "attendanceSummaryCell", for: indexPath) as! AttendanceSummary
            let retunedDate = mUtilityClassObj.cellDesign(cell: cell, date: lDate)
            cell.markedEmployees.text = String(describing: (mDashBoardViewModelObj?.mDashBoardContents?.marked)! as Int)
            cell.unmarkedEmployees.text = mDashBoardViewModelObj?.mDashBoardContents?.unmarked as? String
            cell.date.text = retunedDate
            return cell
        }
        else if(indexPath.row == DashBoardControls.ATTENDANCEFALLOUT.rawValue){
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "attendanceFalloutCell", for: indexPath) as! AttendanceFallout
            cell.falloutEmployees.text = String(describing:(mDashBoardViewModelObj?.mDashBoardContents?.falloutEmployee)! as Int)
            cell.totalEmployees.text = String(describing:(mDashBoardViewModelObj?.mDashBoardContents?.totalEmployee)! as Int)
             let retunedDate = mUtilityClassObj.cellDesign(cell: cell, date: lDate)
            cell.date.text = retunedDate
            return  cell
        }
        else if(indexPath.row == DashBoardControls.LEAVESUMMARY.rawValue){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "leaveSummaryCell", for: indexPath) as! LeaveDetails
            cell.mLeave.text = mDashBoardViewModelObj?.mDashBoardContents?.leave as! String
            let retunedDate = mUtilityClassObj.cellDesign(cell: cell, date: lDate)
            cell.mDate.text = retunedDate
            return cell
        }
        else if(indexPath.row == DashBoardControls.ENGINEERS.rawValue) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "engineersDetailsCell", for: indexPath)
            mUtilityClassObj.cellDesign(cell: cell, date: lDate)
            return cell
        }
        else if(indexPath.row == DashBoardControls.CLIENTS.rawValue){
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clientDetailsCell", for: indexPath)
          
            mUtilityClassObj.cellDesign(cell: cell, date: lDate)
            return cell
        }
        else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reportDetailsCell", for: indexPath)
             mUtilityClassObj.cellDesign(cell: cell, date: lDate)
            return cell
        }
    }
}
//CollectionView Delegate
extension DashBoardVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        if(indexPath.row == 1){
            performSegue(withIdentifier: "segueFromSecondCell", sender: nil)
            highlightCell2(indexPath, flag: true)
        }
        else if(indexPath.row == 2){
            performSegue(withIdentifier: "segueFromThirdCell", sender: nil)
            highlightCell2(indexPath, flag: true)
        }
        
    }
    
    func highlightCell2(_ indexPath : IndexPath, flag: Bool) {
        let cell = mCollectionView.cellForItem(at: indexPath)
        if flag {
            cell?.contentView.backgroundColor = UIColor.lightGray
            cell?.contentView.backgroundColor?.withAlphaComponent(0.5)
        } else {
            cell?.contentView.backgroundColor = nil
        }
    }
    
}

//MARK:-TableView Datasource
extension DashBoardVC: UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
           return (mDashBoardViewModelObj?.fetchTableViewContentsFromController())!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = mDashBoardViewModelObj?.contentAtEachRow(i: indexPath.row)
        let color = UIColor.init(red: 59/255, green: 83/255, blue: 114/255, alpha: 1)
        cell.textLabel?.textColor = color
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        if (indexPath.row == 0) {
            let color = UIColor.init(red: 157/255, green: 212/255, blue: 237/255, alpha: 1)
            cell.backgroundColor = color
            cell.imageView?.frame = CGRect(x: (cell.imageView?.frame.origin.x)!, y: (cell.imageView?.frame.origin.y)!, width: 60, height: 60)
            cell.imageView?.image = #imageLiteral(resourceName: "user1")
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        if(indexPath.row == (mDashBoardViewModelObj?.mArrayOfTableViewContentModel.count)!-1){
            cell.imageView?.image = #imageLiteral(resourceName: "logout")
        }
        return cell
    }
    
}

//extension of tableview cell
extension DashBoardVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        if(indexPath.row == 2){
            performSegue(withIdentifier: "segueFromSecondIndex", sender: nil)
        }
            
        else if(indexPath.row == 3){
            performSegue(withIdentifier: "segueFromSecondCell", sender: nil)
        }
        else if(indexPath.row == 4){
            performSegue(withIdentifier: "segueFromFourthIndex", sender: nil)
        }
        else if(indexPath.row == 5){
            performSegue(withIdentifier: "segueFromFifthIndex", sender: nil)
        }
        else if(indexPath.row == 6){
            let alert = UIAlertController(title: "Alert", message: "Would you like to logout?", preferredStyle: UIAlertControllerStyle.alert)
            // add the actions (buttons)
            let lContinueAction = UIAlertAction(title: "Continue", style: UIAlertActionStyle.default) {
                UIAlertAction in
               self.performSegue(withIdentifier: "segueFromSixthIndex", sender: nil)
                NSLog("Continue Pressed")
            }
            
            let lCancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }
            alert.addAction(lContinueAction)
            alert.addAction(lCancelAction)
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }
        mSlideMenuLeadingConstraint.constant = -250
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        mMenuShowing = !mMenuShowing
        
        //2nd case of removing the tap gesture(paper) when we click on table view
        self.mCustomView.removeFromSuperview()
        
        removeGestureRecognizer()
        
    }
    
    //func to set the height of the cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70.0;//Choose your custom row height
    }
}



