//
//  FalloutEmployeeVC.swift
//  FundooHR
//
//  Created by BridgeLabz on 26/12/16.
//  Copyright © 2016 BridgeLabz Solutions LLP. All rights reserved.
//

import UIKit

class FalloutEmployeeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,CallBackInFalloutVC {
    
    let falloutViewModelObj = FalloutViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var numberOfUnmarkedEmployees: UILabel!
    @IBOutlet weak var unmarkedDate: UILabel!
    @IBOutlet weak var totalEmployees: UILabel!
    @IBOutlet weak var outerLabelOfUnmarkedEmployees: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        falloutViewModelObj.protocolFalloutVC = self
        outerLabelOfUnmarkedEmployees.layer.masksToBounds = true;
        outerLabelOfUnmarkedEmployees.layer.cornerRadius = 10
        let tokenDictionary = UserDefaults.standard.value(forKey: "dictionaryOfToken") as! NSDictionary
        let token = tokenDictionary.value(forKey: "token") as! String
        falloutViewModelObj.fetchNumberOfCellsFromFalloutController(token:token)
        let currentDate = Date()
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MM yyyy"
        formatter.dateStyle = .long
        // get the date time String from the date object
        let convertedDate = formatter.string(from: currentDate)
        date.text = convertedDate
        
//        let timeStampDate = Date.init(timeIntervalSince1970: Double(dashBoardViewModelObj.timeStamp!)/1000)
//        formatter.dateFormat = "MMMM yyyy"
//        let convertedtimeStampDate = formatter.string(from: timeStampDate)
//        unmarkedDate.text = convertedtimeStampDate
    }
    
    func reload(){
        numberOfUnmarkedEmployees.text = String(describing:(falloutViewModelObj.falloutTotalEmployeesContents?.unmarkedEmployee)! as Int)
        totalEmployees.text = String(describing:(falloutViewModelObj.falloutTotalEmployeesContents?.totalEmployee)! as Int)
        self.collectionView.reloadData()
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        let tokenDictionary = UserDefaults.standard.value(forKey: "dictionaryOfToken") as! NSDictionary
        
        return falloutViewModelObj.arrayOfFalloutEmployees.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let color = UIColor.init(red: 240/255, green: 237/255, blue: 234/255, alpha: 1)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FalloutEmployeeCollectionViewCell
        cell.name.text = falloutViewModelObj.arrayOfFalloutEmployees[indexPath.row].employeeName
        cell.fellowShip.text = falloutViewModelObj.arrayOfFalloutEmployees[indexPath.row].employeeStatus
        cell.company.text = falloutViewModelObj.arrayOfFalloutEmployees[indexPath.row].company
        cell.email.text = falloutViewModelObj.arrayOfFalloutEmployees[indexPath.row].emailId
        cell.mobileNum.text = falloutViewModelObj.arrayOfFalloutEmployees[indexPath.row].mobile
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
        
        return cell
    }
    
    @IBAction func showAlertOnButtonTapping(_ sender: UIButton) {
        // create the alert
        let alert = UIAlertController(title: "Alert", message: "Would you like to send the email?", preferredStyle: UIAlertControllerStyle.alert)
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
}
