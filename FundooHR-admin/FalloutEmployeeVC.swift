//
//  FalloutEmployeeVC.swift
//  FundooHR
//
//  Created by BridgeLabz on 26/12/16.
//  Copyright © 2016 BridgeLabz Solutions LLP. All rights reserved.
//

import UIKit

class FalloutEmployeeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,FalloutVCProtocol,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var numberOfUnmarkedEmployees: UILabel!
    @IBOutlet weak var unmarkedDate: UILabel!
    @IBOutlet weak var totalEmployees: UILabel!
    @IBOutlet weak var outerLabelOfUnmarkedEmployees: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mSlideMenu: UIView!
    @IBOutlet weak var mTableview: UITableView!
    @IBOutlet weak var mSlideMenuLeadingConstraint: NSLayoutConstraint!
    
    let mUtilityClassObj = UtilityClass()
    var mMenuShowing = false
    var mCustomView = UIView()
    var falloutViewModelObj : FalloutViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        falloutViewModelObj = FalloutViewModel(pFalloutVCProtocolObj: self)
        outerLabelOfUnmarkedEmployees.layer.masksToBounds = true;
        outerLabelOfUnmarkedEmployees.layer.cornerRadius = 10
        // get the date time String from the date object
        let convertedDate = mUtilityClassObj.date()
        date.text = convertedDate
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        
        //-----========----------==========-------
        self.collectionView!.collectionViewLayout = self.getLayout()
    }
    
    func changeOrientationFunc()
    {
        self.collectionView!.collectionViewLayout = self.getLayout()
    }
    func rotated() {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            print("Landscape")
            print("views width",view.frame.width)
            mCustomView.frame = CGRect.init(x: mSlideMenu.frame.width, y: 0, width: view.frame.width-mSlideMenu.frame.width, height: view.frame.height)
            mCustomView.backgroundColor = UIColor.lightGray
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            print("Portrait")
            print("views width",view.frame.width)
            mCustomView.frame = CGRect.init(x: mSlideMenu.frame.width, y: 0, width: view.frame.width-mSlideMenu.frame.width, height: view.frame.height)
            mCustomView.backgroundColor = UIColor.lightGray
        }
    }
    func addGestureRecognizer(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        self.mCustomView.addGestureRecognizer(tapGesture)
    }
    
    func removeGestureRecognizer(){
        for recognizer in collectionView.gestureRecognizers ?? [] {
            mCustomView.removeGestureRecognizer(recognizer)
        }
    }
    
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
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if(UserDefaults.standard.value(forKey: "tokenKey") != nil){
            //let token = UserDefaults.standard.value(forKey: "tokenKey")
        falloutViewModelObj?.fetchNumberOfCellsFromFalloutController()
        }
        return falloutViewModelObj!.arrayOfFalloutEmployees.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let color = UIColor.init(red: 240/255, green: 237/255, blue: 234/255, alpha: 1)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FalloutEmployeeCollectionViewCell
        cell.name.text = falloutViewModelObj?.arrayOfFalloutEmployees[indexPath.row].employeeName
        cell.fellowShip.text = falloutViewModelObj?.arrayOfFalloutEmployees[indexPath.row].employeeStatus
        cell.company.text = falloutViewModelObj?.arrayOfFalloutEmployees[indexPath.row].company
        cell.email.text = falloutViewModelObj?.arrayOfFalloutEmployees[indexPath.row].emailId
        cell.mobileNum.text = falloutViewModelObj?.arrayOfFalloutEmployees[indexPath.row].mobile
       let employeeImage = falloutViewModelObj?.fetchEachImage(i: indexPath.row)
        print("employee image...",employeeImage)
        cell.employeeImage.image = employeeImage
        
        cell.layer.borderWidth = 1.0
        // cell.layer.cornerRadius = 5
        cell.layer.borderColor = color.cgColor
        cell.layer.backgroundColor = color.cgColor
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width:2.0,height: 2.0)
        cell.layer.shadowRadius = 3.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false;
        cell.layer.cornerRadius = 5
        cell.employeeImage.layer.masksToBounds = false;
        print("cells heigth====",cell.bounds.height)
        print("cells width====",cell.bounds.width)
        return cell
    }

    
    @IBAction func openMenuOnButtonclick(_ sender: UIButton) {
        //changing the custom view's size while we change to landscape mode
        print("views width",view.frame.width)
        mCustomView.frame = CGRect.init(x: mSlideMenu.frame.width, y: 0, width: view.frame.width-mSlideMenu.frame.width, height: view.frame.height)
        mCustomView.backgroundColor = UIColor.lightGray
        
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
        falloutTableviewReload()

    }
    
    func falloutTableviewReload(){
        self.mTableview.reloadData()
    }
    
    func falloutCollectionviewReload(){
        activityIndicator.isHidden = false
        activityIndicator.stopAnimating()
        numberOfUnmarkedEmployees.text = String(describing:(falloutViewModelObj?.falloutTotalEmployeesContents?.unmarkedEmployee)! as Int)
        totalEmployees.text = String(describing:(falloutViewModelObj?.falloutTotalEmployeesContents?.totalEmployee)! as Int)
        let timeStampDate = Date.init(timeIntervalSince1970: Double((falloutViewModelObj?.falloutTotalEmployeesContents?.timeStamp!)!)!/1000)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        let convertedtimeStampDate = formatter.string(from: timeStampDate)
        unmarkedDate.text = convertedtimeStampDate
        self.collectionView.reloadData()
    }
    
    @IBAction func showAlertOnButtonTapping(_ sender: UIButton) {
        // create the alert
        let alert = UIAlertController(title: "Alert", message: "Would you like to send the email?", preferredStyle: UIAlertControllerStyle.alert)
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
        if(alert.title == "Continue"){
            
        }
    }
    
    // collection view delegate
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width - 20, height: collectionView.frame.size.width - 20)
        }

    //--------===========------------==========------------
    func getLayout() -> UICollectionViewLayout
    {
        let layout:UICollectionViewFlowLayout =  UICollectionViewFlowLayout()
        
        print(self.view.frame.size.width - 30)
        
        layout.itemSize = CGSize(width: self.view.frame.size.width - 30, height: 112)
        layout.sectionInset = UIEdgeInsets(top: 25, left: 50, bottom: 25, right: 50)
        
        return layout as UICollectionViewLayout
    }
    
    //tableview datasource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (falloutViewModelObj?.fetchTableviewContentsFromFalloutController())!
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = falloutViewModelObj?.contentAtEachRow(i: indexPath.row)
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
        
        if(indexPath.row == (falloutViewModelObj?.mArrayOfTableViewContentModel.count)!-1){
            cell.imageView?.image = #imageLiteral(resourceName: "logout")
        }
        return cell

    }
}
