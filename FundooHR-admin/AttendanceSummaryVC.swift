//
//  AttendanceSummaryVC.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 30/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class AttendanceSummaryVC: UIViewController,AttendanceSummaryVCProtocol,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var mDate: UILabel!
    @IBOutlet weak var mUnmarkedDate: UILabel!
    @IBOutlet weak var mNumberOfUnmarkedEmployees: UILabel!
    @IBOutlet weak var mTotalEmployees: UILabel!
    @IBOutlet weak var mCollectionActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mSlideMenu: UIView!
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mTableActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var mSlideMenuLeadingConstraint: NSLayoutConstraint!
    
    var mAttendanceSummaryViewModelObj : AttendanceSummaryViewModel?
    var mCustomView = UIView()
    var mMenuShowing = false
    
    //create object of UtilityClass
    let mUtilityClassObj = UtilityClass()
    
    //create outlet for collectionview
    @IBOutlet weak var mCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //enabling activity indicator
        mCollectionActivityIndicator.isHidden = false
        mCollectionActivityIndicator.startAnimating()
        mAttendanceSummaryViewModelObj = AttendanceSummaryViewModel(pAttendanceSummaryVCProtocolObj: self)
        // get the date time String from the date object
        let convertedDate = mUtilityClassObj.date()
        mDate.text = convertedDate
        
        //notifies when screen is rotated
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        //notifies when collectionview's orientation is changed
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeOrientationFunc), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        //-----========----------==========-------
        self.mCollectionView!.collectionViewLayout = self.getLayout()
        
    }
    
    //changing the size of collectionview cells when the orientation changes
    func changeOrientationFunc()
    {
        self.mCollectionView!.collectionViewLayout = self.getLayout()
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


    @IBAction func onClickOfMenuButton(_ sender: UIButton) {
        //changing the custom view's size while we change to landscape mode
        print("views width",view.frame.width)
        mCustomView.frame = CGRect.init(x: mSlideMenu.frame.width, y: 0, width: view.frame.width-mSlideMenu.frame.width, height: view.frame.height)
        mCustomView.backgroundColor = UIColor.clear
        
        if(mMenuShowing){
            mSlideMenuLeadingConstraint.constant = -250
            //1st case of removing tap gesture(papre) when we click on the icon
            
            removeGestureRecognizer()
            
        }else{
            //enabling the activity indictor
            mTableActivityIndicator.isHidden = false
            mTableActivityIndicator.startAnimating()
            mSlideMenuLeadingConstraint.constant = 0
            self.view.addSubview(mCustomView)
            mCustomView.alpha = 0.5
            addGestureRecognizer()
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        mMenuShowing = !mMenuShowing
        attendanceSummaryTableviewReload()

    }
    
    func attendanceSummaryCollectionViewReload(){
        //disabling the activity indicator
        mCollectionActivityIndicator.isHidden = true
        mCollectionActivityIndicator.stopAnimating()
        
        mNumberOfUnmarkedEmployees.text = String(describing:(mAttendanceSummaryViewModelObj?.mTotalEmployeesContents?.unmarkedEmployee)! as Int)
        mTotalEmployees.text = String(describing:(mAttendanceSummaryViewModelObj?.mTotalEmployeesContents?.totalEmployee)! as Int)
        let timeStampDate = Date.init(timeIntervalSince1970: Double((mAttendanceSummaryViewModelObj?.mTotalEmployeesContents?.timeStamp)!)!/1000)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        let convertedtimeStampDate = formatter.string(from: timeStampDate)
        mUnmarkedDate.text = convertedtimeStampDate
        self.mCollectionView.reloadData()
        
    }
    
    func attendanceSummaryTableviewReload(){
        //disabling the activity indictor
        mTableActivityIndicator.isHidden = true
        mTableActivityIndicator.stopAnimating()
        self.mTableView.reloadData()
        
    }
    
    //tableview datasource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (mAttendanceSummaryViewModelObj!.fetchTableviewContentsFromController())
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = mAttendanceSummaryViewModelObj?.contentAtEachRow(i: indexPath.row)
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
    
    //collectionview datasource
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if(UserDefaults.standard.value(forKey: "tokenKey") != nil){
            //let token = UserDefaults.standard.value(forKey: "tokenKey")
            mAttendanceSummaryViewModelObj?.fetchNumberOfCellsFromController()
        }
        return (mAttendanceSummaryViewModelObj?.mArrayOfUnmarkedEmployees.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let color = UIColor.init(red: 240/255, green: 237/255, blue: 234/255, alpha: 1)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AttendanceSummaryCollectionViewCell
        cell.mName.text = mAttendanceSummaryViewModelObj?.mArrayOfUnmarkedEmployees[indexPath.row].mEmployeeName
        cell.mFellowship.text = mAttendanceSummaryViewModelObj?.mArrayOfUnmarkedEmployees[indexPath.row].mEmployeeStatus
        cell.mCompany.text = mAttendanceSummaryViewModelObj?.mArrayOfUnmarkedEmployees[indexPath.row].mCompany
        cell.mMobile.text = mAttendanceSummaryViewModelObj?.mArrayOfUnmarkedEmployees[indexPath.row].mEmailId
        cell.mEmailId.text = mAttendanceSummaryViewModelObj?.mArrayOfUnmarkedEmployees[indexPath.row].mMobile
        let employeeImage = mAttendanceSummaryViewModelObj?.fetchEachImageOfEmployee(i: indexPath.row)
        print("employee image...",employeeImage!)
        cell.mEmployeeImage.image = employeeImage
        
        cell.layer.borderColor = color.cgColor
        cell.layer.backgroundColor = color.cgColor
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        print("cells heigth====",cell.bounds.height)
        print("cells width====",cell.bounds.width)
        return cell
    }
    
    @IBAction func onEmailButton(_ sender: UIButton) {
        // create the alert
        let alert = UIAlertController(title: "Alert", message: "Would you like to send the email?", preferredStyle: UIAlertControllerStyle.alert)
        // add the actions (buttons)
        let lContinueAction = UIAlertAction(title: "Continue", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.mAttendanceSummaryViewModelObj?.makingRestCallToSendMail()
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

        
    func fetchedStatusAfterSendingMail(status:Int){
        if(status == 200)
        {
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
}
