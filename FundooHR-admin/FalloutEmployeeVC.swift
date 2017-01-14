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
        collectionView.delegate = self
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeOrientationFunc), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        //-----========----------==========-------
        self.collectionView!.collectionViewLayout = self.getLayout()
        
       
        
    }
    
    func changeOrientationFunc()
    {
        self.collectionView!.collectionViewLayout = self.getLayout()
    }
    
    func reload(){
        numberOfUnmarkedEmployees.text = String(describing:(falloutViewModelObj.falloutTotalEmployeesContents?.unmarkedEmployee)! as Int)
        totalEmployees.text = String(describing:(falloutViewModelObj.falloutTotalEmployeesContents?.totalEmployee)! as Int)
        let timeStampDate = Date.init(timeIntervalSince1970: Double((falloutViewModelObj.falloutTotalEmployeesContents?.timeStamp!)!)!/1000)
         let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        let convertedtimeStampDate = formatter.string(from: timeStampDate)
        unmarkedDate.text = convertedtimeStampDate
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
        print("cells heigth====",cell.bounds.height)
        print("cells width====",cell.bounds.width)
        return cell
    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        
//        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
//        return CGSize(width: 100, height: 100)
//        }
//        return CGSize(width: 64, height: 64)
//    }
    
    //cell size modification
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        
//        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
//            return
//        }
//        
//        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
//        
//            flowLayout.itemSize = CGSize(width: 292.0, height: 150)
//        }
//        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
//            flowLayout.itemSize = CGSize(width: 292.0, height: 112.0)
//        }
//        
//        flowLayout.invalidateLayout()
//    }
    
    @IBAction func showAlertOnButtonTapping(_ sender: UIButton) {
        // create the alert
        let alert = UIAlertController(title: "Alert", message: "Would you like to send the email?", preferredStyle: UIAlertControllerStyle.alert)
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // collection view delegate
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width - 20, height: collectionView.frame.size.width - 20)
        
    }

//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let kWhateverHeightYouWant = 100
//        return CGSizeMake(collectionView.bounds.size.width, CGFloat(kWhateverHeightYouWant))
//    }
    
    
    //--------===========------------==========------------
    func getLayout() -> UICollectionViewLayout
    {
        let layout:UICollectionViewFlowLayout =  UICollectionViewFlowLayout()
        
        print(self.view.frame.size.width - 30)
        
        layout.itemSize = CGSize(width: self.view.frame.size.width - 30, height: 112)
        layout.sectionInset = UIEdgeInsets(top: 25, left: 50, bottom: 25, right: 50)
        
        return layout as UICollectionViewLayout
        
    }
    
}
