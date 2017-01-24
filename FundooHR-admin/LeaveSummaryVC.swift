//
//  LeaveSummaryVC.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 20/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class LeaveSummaryVC: UIViewController,CallBackInLeaveSummaryVC,UICollectionViewDataSource,UICollectionViewDelegate{

    var leaveSummaryViewModelObj:LeaveSummaryViewModel = LeaveSummaryViewModel()
    
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
        outerLabelOfUnmarkedEmployees.layer.masksToBounds = true;
        outerLabelOfUnmarkedEmployees.layer.cornerRadius = 10
        leaveSummaryViewModelObj = LeaveSummaryViewModel()
        leaveSummaryViewModelObj.protocolLeaveSummaryVC = self
        let currentDate = Date()
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MM yyyy"
        formatter.dateStyle = .long
        // get the date time String from the date object
        let convertedDate = formatter.string(from: currentDate)
        date.text = convertedDate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reload() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        numberOfUnmarkedEmployees.text = String(describing:(leaveSummaryViewModelObj.leaveSummaryTotalEmployeesContent?.employeeLeave)! as Int)
        totalEmployees.text = String(describing:(leaveSummaryViewModelObj.leaveSummaryTotalEmployeesContent?.totalEmployee)! as Int)
        let timeStampDate = Date.init(timeIntervalSince1970: Double((leaveSummaryViewModelObj.leaveSummaryTotalEmployeesContent?.timeStamp!)!)!/1000)
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
        leaveSummaryViewModelObj.fetchDataFromController(token: token as! String)
        }
        return leaveSummaryViewModelObj.arrayOfLeaveEmployees.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let color = UIColor.init(red: 240/255, green: 237/255, blue: 234/255, alpha: 1)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LeaveSummaryCollectionViewCell
        cell.employeeName.text = leaveSummaryViewModelObj.arrayOfLeaveEmployees[indexPath.row].employeeName
        cell.fellowship.text = leaveSummaryViewModelObj.arrayOfLeaveEmployees[indexPath.row].employeeStatus
        cell.company.text = leaveSummaryViewModelObj.arrayOfLeaveEmployees[indexPath.row].company
        cell.email.text = leaveSummaryViewModelObj.arrayOfLeaveEmployees[indexPath.row].emailId
        cell.mobile.text = leaveSummaryViewModelObj.arrayOfLeaveEmployees[indexPath.row].mobile
        let employeeImage = leaveSummaryViewModelObj.fetchEachImage(i: indexPath.row)
        print("employee image...",employeeImage)
        cell.employeeImage.image = employeeImage
        
        cell.layer.borderWidth = 1.0
        //        cell.layer.cornerRadius = 5
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

}
