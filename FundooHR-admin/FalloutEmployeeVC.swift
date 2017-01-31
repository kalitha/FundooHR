//
//  FalloutEmployeeVC.swift
//  FundooHR
//  Purpose:-
//  1)It is a Fallout UIClass with IBOutlet and IBAction of Fallout UIViewController
//  2)In this class we display the information of fallout employees
//  3)From this class we send mail to fallout employees
//  Created by BridgeLabz on 26/12/16.
//  Copyright © 2016 BridgeLabz Solutions LLP. All rights reserved.
//

import UIKit

enum FalloutTableview:Int{
    case EMAILID = 0
    case DASHBOARD
    case ENGINEERS
    case FALLOUT
    case REPORTS
    case CLIENTS
    case LOGOUT
}

class FalloutEmployeeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,FalloutVCProtocol,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var mTableviewActivityIndicator: UIActivityIndicatorView!
    // create outlet of collectionview
    @IBOutlet weak var mCollectionView: UICollectionView!
    
    //create outlet to store number of fallout employees
    @IBOutlet weak var mNumberOfUnmarkedEmployees: UILabel!
    
    //create outlet to display the month of fallout employees
    @IBOutlet weak var mUnmarkedDate: UILabel!
    
    //create the outlet of total employees
    @IBOutlet weak var mTotalEmployees: UILabel!
    
    //create outlet for date
    @IBOutlet weak var mDate: UILabel!
    
    //create outlet for activity indicator
    @IBOutlet weak var mActivityIndicator: UIActivityIndicatorView!
    
    //create outlet for slidemenu that contains tableview
    @IBOutlet weak var mSlideMenu: UIView!
    
    //create outlet for tableview
    @IBOutlet weak var mTableview: UITableView!
    
    //create outlet for slidemenu leading constraint
    @IBOutlet weak var mSlideMenuLeadingConstraint: NSLayoutConstraint!
    
    //create object of UtilityClass
    let mUtilityClassObj = UtilityClass()
    
    var mMenuShowing = false
    //create a variable of type uiview
    
    var mCustomView = UIView()
    
    //create variable of type FalloutViewModel
    var mFalloutViewModelObj : FalloutViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //enabling activity indicator
        mActivityIndicator.isHidden = false
        mActivityIndicator.startAnimating()
        mFalloutViewModelObj = FalloutViewModel(pFalloutVCProtocolObj: self)
        
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
    
    //collectionview datasource
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if(UserDefaults.standard.value(forKey: "tokenKey") != nil){
            //let token = UserDefaults.standard.value(forKey: "tokenKey")
        mFalloutViewModelObj?.fetchNumberOfCellsFromFalloutController()
        }
        return mFalloutViewModelObj!.arrayOfFalloutEmployees.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let color = UIColor.init(red: 240/255, green: 237/255, blue: 234/255, alpha: 1)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FalloutEmployeeCollectionViewCell
        cell.name.text = mFalloutViewModelObj?.arrayOfFalloutEmployees[indexPath.row].mEmployeeName
        cell.fellowShip.text = mFalloutViewModelObj?.arrayOfFalloutEmployees[indexPath.row].mEmployeeStatus
        cell.company.text = mFalloutViewModelObj?.arrayOfFalloutEmployees[indexPath.row].mCompany
        cell.email.text = mFalloutViewModelObj?.arrayOfFalloutEmployees[indexPath.row].mEmailId
        cell.mobileNum.text = mFalloutViewModelObj?.arrayOfFalloutEmployees[indexPath.row].mMobile
       let employeeImage = mFalloutViewModelObj?.fetchEachImage(i: indexPath.row)
        print("employee image...",employeeImage)
        cell.employeeImage.image = employeeImage
        
        cell.layer.borderColor = color.cgColor
        cell.layer.backgroundColor = color.cgColor
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        print("cells heigth====",cell.bounds.height)
        print("cells width====",cell.bounds.width)
        return cell
    }

    //open slidemenu when clicked on menu button
    @IBAction func openMenuOnButtonclick(_ sender: UIButton) {
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
            mTableviewActivityIndicator.isHidden = false
            mTableviewActivityIndicator.startAnimating()
            mSlideMenuLeadingConstraint.constant = 0
            self.view.addSubview(mCustomView)
            mCustomView.alpha = 0.5
            addGestureRecognizer()
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        mMenuShowing = !mMenuShowing
        falloutTableviewReload()

    }
    //reload tableview data when the data is loaded into it
    func falloutTableviewReload(){
        //disabling the activity indictor
        mTableviewActivityIndicator.isHidden = true
        mTableviewActivityIndicator.startAnimating()
        self.mTableview.reloadData()
    }
    
    //reload collectionview data when the data is loaded into it
    func falloutCollectionviewReload(){
        //disabling the activity indicator
        mActivityIndicator.isHidden = true
        mActivityIndicator.stopAnimating()
        
        mNumberOfUnmarkedEmployees.text = String(describing:(mFalloutViewModelObj?.falloutTotalEmployeesContents?.unmarkedEmployee)! as Int)
        mTotalEmployees.text = String(describing:(mFalloutViewModelObj?.falloutTotalEmployeesContents?.totalEmployee)! as Int)
        let timeStampDate = Date.init(timeIntervalSince1970: Double((mFalloutViewModelObj?.falloutTotalEmployeesContents?.timeStamp!)!)!/1000)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        let convertedtimeStampDate = formatter.string(from: timeStampDate)
        mUnmarkedDate.text = convertedtimeStampDate
        self.mCollectionView.reloadData()
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
    
    //tableview datasource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (mFalloutViewModelObj?.fetchTableviewContentsFromFalloutController())!
    }
    
    //
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = mFalloutViewModelObj?.contentAtEachRow(i: indexPath.row)
        let color = UIColor.init(red: 59/255, green: 83/255, blue: 114/255, alpha: 1)
        cell.textLabel?.textColor = color
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        if (indexPath.row == FalloutTableview.EMAILID.rawValue) {
            let color = UIColor.init(red: 157/255, green: 212/255, blue: 237/255, alpha: 1)
            cell.backgroundColor = color
            cell.imageView?.frame = CGRect(x: (cell.imageView?.frame.origin.x)!, y: (cell.imageView?.frame.origin.y)!, width: 60, height: 60)
            cell.imageView?.image = #imageLiteral(resourceName: "user1")
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        if(indexPath.row == FalloutTableview.LOGOUT.rawValue){
            cell.imageView?.image = #imageLiteral(resourceName: "logout")
        }
        return cell

    }
    
     public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if(indexPath.row == FalloutTableview.DASHBOARD.rawValue){
            performSegue(withIdentifier: "segueFromDashboardCell", sender: nil)
        }
            
        else if(indexPath.row == FalloutTableview.ENGINEERS.rawValue){
            performSegue(withIdentifier: "segueFromEngineersCell", sender: nil)
        }
        else if(indexPath.row == FalloutTableview.REPORTS.rawValue){
            performSegue(withIdentifier: "segueFromReportsCell", sender: nil)
        }
        else if(indexPath.row == FalloutTableview.CLIENTS.rawValue){
            performSegue(withIdentifier: "segueFromClientsCell", sender: nil)
        }
        else if(indexPath.row == FalloutTableview.LOGOUT.rawValue){
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
    
    //used to show alert on the tapping of button
    @IBAction func showAlertOnButtonTapping(_ sender: UIButton) {
        // create the alert
        let alert = UIAlertController(title: "Alert", message: "Would you like to send the email?", preferredStyle: UIAlertControllerStyle.alert)
        // add the actions (buttons)
        let lContinueAction = UIAlertAction(title: "Continue", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.mFalloutViewModelObj?.callSendEmailInController()
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
    //fetch the status after sending mail
    func fetchedDataFromSendEmailFunctionInViewModel(status:Int){
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
