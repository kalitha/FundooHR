//
//  LeaveSummaryVC.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 20/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class
LeaveSummaryVC: UIViewController,LeaveSummaryVCProtocol,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource{
    
    var leaveSummaryViewModelObj : LeaveSummaryViewModel?
    
    @IBOutlet weak var mSlideMenu: UIView!
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mTableViewActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var unmarkedDate: UILabel!
    @IBOutlet weak var numberOfUnmarkedEmployees: UILabel!
    @IBOutlet weak var totalEmployees: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mSlideMenuLeadingConstraint: NSLayoutConstraint!
    //create a variable of type uiview
    var mCustomView = UIView()
    var mMenuShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        leaveSummaryViewModelObj = LeaveSummaryViewModel(pLeaveSummaryVCProtocolObj: self)
        let currentDate = Date()
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MM yyyy"
        formatter.dateStyle = .long
        // get the date time String from the date object
        let convertedDate = formatter.string(from: currentDate)
        date.text = convertedDate
        
        //notifies when screen is rotated
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        //notifies when collectionview's orientation is changed
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeOrientationFunc), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        //-----========----------==========-------
        self.collectionView!.collectionViewLayout = self.getLayout()
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        self.mCustomView.addGestureRecognizer(tapGesture)
    }
    
    //remove gesture recognizer after opening the slidemenu
    func removeGestureRecognizer(){
        for recognizer in collectionView.gestureRecognizers ?? [] {
            mCustomView.removeGestureRecognizer(recognizer)
        }
    }
    
    //called by addGestureRecognizer method
    func tapBlurButton(_ sender: UIButton) {
        mSlideMenuLeadingConstraint.constant = -250
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        //to remove custom view after removing slidemenu
        self.mCustomView.removeFromSuperview()
        mMenuShowing = !mMenuShowing
        
        //3rd case of removing  gesture when we click on collectionview
        removeGestureRecognizer()
    }
    
    //notifies the change in orientation of collectionview
    func changeOrientationFunc()
    {
        self.collectionView!.collectionViewLayout = self.getLayout()
    }

    @IBAction func onClickOfMenuButton(_ sender: UIButton) {
        //changing the custom view's size while we change to landscape mode
        print("views width",view.frame.width)
        mCustomView.frame = CGRect.init(x: mSlideMenu.frame.width, y: 0, width: view.frame.width-mSlideMenu.frame.width, height: view.frame.height)
        mCustomView.backgroundColor = UIColor.clear
        print("menushowing=-=-=",mMenuShowing)
        if(mMenuShowing){
            mSlideMenuLeadingConstraint.constant = -250
            //1st case of removing tap gesture(papre) when we click on the icon
            
            removeGestureRecognizer()
            
        }else{
            //enabling the activity indictor
            mTableViewActivityIndicator.isHidden = false
            mTableViewActivityIndicator.startAnimating()
            mSlideMenuLeadingConstraint.constant = 0
            self.view.addSubview(mCustomView)
            mCustomView.alpha = 0.5
            addGestureRecognizer()
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        mMenuShowing = !mMenuShowing
        print("menushowing=-=-=",mMenuShowing)
        leaveSummaryTableviewReload()
    }
    
    func leaveSummaryTableviewReload(){
        //disabling the activity indictor
        mTableViewActivityIndicator.isHidden = true
        mTableViewActivityIndicator.stopAnimating()
        self.mTableView.reloadData()
    }
    
    func reload() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        numberOfUnmarkedEmployees.text = String(describing:(leaveSummaryViewModelObj?.leaveSummaryTotalEmployeesContent?.unmarkedEmployee)! as Int)
        totalEmployees.text = String(describing:(leaveSummaryViewModelObj?.leaveSummaryTotalEmployeesContent?.totalEmployee)! as Int)
        let timeStampDate = Date.init(timeIntervalSince1970: Double((leaveSummaryViewModelObj?.leaveSummaryTotalEmployeesContent?.timeStamp!)!)!/1000)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        let convertedtimeStampDate = formatter.string(from: timeStampDate)
        unmarkedDate.text = convertedtimeStampDate
        self.collectionView.reloadData()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if(UserDefaults.standard.value(forKey: "tokenKey") != nil){
            let token
                = UserDefaults.standard.value(forKey: "tokenKey")
            leaveSummaryViewModelObj?.fetchDataFromController()
        }
        print("arrayOfLeaveEmployees.count",leaveSummaryViewModelObj?.arrayOfLeaveEmployees.count)
        return leaveSummaryViewModelObj!.arrayOfLeaveEmployees.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let color = UIColor.init(red: 240/255, green: 237/255, blue: 234/255, alpha: 1)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LeaveSummaryCollectionViewCell
        cell.employeeName.text = leaveSummaryViewModelObj?.arrayOfLeaveEmployees[indexPath.row].mEmployeeName
        cell.fellowship.text = leaveSummaryViewModelObj?.arrayOfLeaveEmployees[indexPath.row].mEmployeeStatus
        cell.company.text = leaveSummaryViewModelObj?.arrayOfLeaveEmployees[indexPath.row].mCompany
        cell.email.text = leaveSummaryViewModelObj?.arrayOfLeaveEmployees[indexPath.row].mEmailId
        cell.mobile.text = leaveSummaryViewModelObj?.arrayOfLeaveEmployees[indexPath.row].mMobile
        let employeeImage = leaveSummaryViewModelObj?.fetchEachImage(i: indexPath.row)
        print("employee image...",employeeImage)
        cell.employeeImage.image = employeeImage
        cell.layer.borderColor = color.cgColor
        cell.layer.backgroundColor = color.cgColor
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        print("cells heigth====",cell.bounds.height)
        print("cells width====",cell.bounds.width)
        return cell
    }
    
    //create action to send email
    @IBAction func showAlertOnButtonTapping(_ sender: UIButton) {
        // create the alert
        let alert = UIAlertController(title: "Alert", message: "Would you like to send the email?", preferredStyle: UIAlertControllerStyle.alert)
        // add the actions (buttons)
        let lContinueAction = UIAlertAction(title: "Continue", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.leaveSummaryViewModelObj?.callSendEmailInController()
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
    
    //notifying whether the mail is sent or not
    func fetchedDataFromSendEmailFunctionInViewModel(status:Int){
        if(status == 200){
            let alert = UIAlertController(title: "Alert", message: "Successfully sent mail to users", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "email not sent", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    // collection view delegate
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width - 20, height: collectionView.frame.size.width - 20)
    }
    
    //decides the size of collectionview cell
    func getLayout() -> UICollectionViewLayout
    {
        let layout:UICollectionViewFlowLayout =  UICollectionViewFlowLayout()
        
        print(self.view.frame.size.width - 20)
        
        layout.itemSize = CGSize(width: self.view.frame.size.width - 20, height: 112)
        layout.sectionInset = UIEdgeInsets(top: 25, left: 50, bottom: 25, right: 50)
        
        return layout as UICollectionViewLayout
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
       return (leaveSummaryViewModelObj!.fetchTableviewContentsFromController())
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = leaveSummaryViewModelObj?.contentAtEachRow(i: indexPath.row)
        let color = UIColor.init(red: 59/255, green: 83/255, blue: 114/255, alpha: 1)
        cell.textLabel?.textColor = color
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        if (indexPath.row == DashBoardTableview.EMAILID.rawValue) {
            let color = UIColor.init(red: 157/255, green: 212/255, blue: 237/255, alpha: 1)
            cell.backgroundColor = color
            cell.imageView?.frame = CGRect(x: (cell.imageView?.frame.origin.x)!, y: (cell.imageView?.frame.origin.y)!, width: 60, height: 60)
            cell.imageView?.image = #imageLiteral(resourceName: "user1")
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        if(indexPath.row == DashBoardTableview.LOGOUT.rawValue){
            cell.imageView?.image = #imageLiteral(resourceName: "logout")
        }
        return cell

    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if(indexPath.row == DashBoardTableview.DASHBOARD.rawValue){
            performSegue(withIdentifier: "segueFromDashboardCell", sender: nil)
        }
        else if(indexPath.row == DashBoardTableview.ATTENDANCESUMMARY.rawValue){
            performSegue(withIdentifier: "segueFromAttendanceSummary", sender: nil)
        }

        else if(indexPath.row == DashBoardTableview.ENGINEERS.rawValue){
            performSegue(withIdentifier: "segueFromEngineersCell", sender: nil)
        }
        else if(indexPath.row == DashBoardTableview.REPORTS.rawValue){
            performSegue(withIdentifier: "segueFromReportsCell", sender: nil)
        }
        else if(indexPath.row == DashBoardTableview.CLIENTS.rawValue){
            performSegue(withIdentifier: "segueFromClientsCell", sender: nil)
        }
        else if(indexPath.row == DashBoardTableview.LOGOUT.rawValue){
            let alert = UIAlertController(title: "Alert", message: "Would you like to logout?", preferredStyle: UIAlertControllerStyle.alert)
            // add the actions (buttons)
            let lContinueAction = UIAlertAction(title: "Continue", style: UIAlertActionStyle.default) {
                UIAlertAction in
                self.performSegue(withIdentifier: "segueFromLogoutCell", sender: nil)
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
}
