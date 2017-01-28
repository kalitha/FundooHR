//
//  LeaveSummaryVC.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 20/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class
LeaveSummaryVC: UIViewController,LeaveSummaryVCProtocol,UICollectionViewDataSource,UICollectionViewDelegate{
    
    var leaveSummaryViewModelObj : LeaveSummaryViewModel?
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var unmarkedDate: UILabel!
    @IBOutlet weak var numberOfUnmarkedEmployees: UILabel!
    @IBOutlet weak var totalEmployees: UILabel!
    @IBOutlet weak var outerLabelOfUnmarkedEmployees: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        leaveSummaryViewModelObj = LeaveSummaryViewModel(pLeaveSummaryVCProtocolObj: self)
        //leaveSummaryViewModelObj.protocolLeaveSummaryVC = self
        let currentDate = Date()
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MM yyyy"
        formatter.dateStyle = .long
        // get the date time String from the date object
        let convertedDate = formatter.string(from: currentDate)
        date.text = convertedDate
        
        //notifies when screen is rotated
        //        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        //notifies when collectionview's orientation is changed
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeOrientationFunc), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        //-----========----------==========-------
        self.collectionView!.collectionViewLayout = self.getLayout()
    }
    
    //
    func changeOrientationFunc()
    {
        self.collectionView!.collectionViewLayout = self.getLayout()
    }

    
    func reload() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        numberOfUnmarkedEmployees.text = String(describing:(leaveSummaryViewModelObj?.leaveSummaryTotalEmployeesContent?.employeeLeave)! as Int)
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
            leaveSummaryViewModelObj?.fetchDataFromController(token: token as! String)
        }
        print("arrayOfLeaveEmployees.count",leaveSummaryViewModelObj?.arrayOfLeaveEmployees.count)
        return leaveSummaryViewModelObj!.arrayOfLeaveEmployees.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let color = UIColor.init(red: 240/255, green: 237/255, blue: 234/255, alpha: 1)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LeaveSummaryCollectionViewCell
        cell.employeeName.text = leaveSummaryViewModelObj?.arrayOfLeaveEmployees[indexPath.row].employeeName
        cell.fellowship.text = leaveSummaryViewModelObj?.arrayOfLeaveEmployees[indexPath.row].employeeStatus
        cell.company.text = leaveSummaryViewModelObj?.arrayOfLeaveEmployees[indexPath.row].company
        cell.email.text = leaveSummaryViewModelObj?.arrayOfLeaveEmployees[indexPath.row].emailId
        cell.mobile.text = leaveSummaryViewModelObj?.arrayOfLeaveEmployees[indexPath.row].mobile
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
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "email not sent", preferredStyle: UIAlertControllerStyle.alert)
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
    
}
