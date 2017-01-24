//
//  DashBoardVC.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP on 09/12/16.
//  Copyright © 2016 BridgeLabz Solutions LLP. All rights reserved.
//

import UIKit

class DashBoardVC: UIViewController,CallBackInDashBoardVC{
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var slideMenu: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var slideMenuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var mActivityIndicator: UIActivityIndicatorView!
    
    var mDashBoardViewModelObj : DashBoardViewModel?
    var mMenuShowing = false
    var mCustomView = UIView()
    let mUtilityClassObj = UtilityClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mActivityIndicator.isHidden = false
        mActivityIndicator.startAnimating()
        mDashBoardViewModelObj = DashBoardViewModel(pCallBackInDashBoardVC: (self))
        
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell1")
        
        self.collectionView.register(UINib(nibName: "CollectionViewCell2", bundle: nil), forCellWithReuseIdentifier: "cell2")
        
        self.collectionView.register(UINib(nibName: "CollectionViewCell3", bundle: nil), forCellWithReuseIdentifier: "cell3")
        
        self.collectionView.register(UINib(nibName: "CollectionViewCell4", bundle: nil), forCellWithReuseIdentifier: "cell4")
        
        self.collectionView.register(UINib(nibName: "CollectionViewCell5", bundle: nil), forCellWithReuseIdentifier: "cell5")
        
        self.collectionView.register(UINib(nibName: "CollectionViewCell6", bundle: nil), forCellWithReuseIdentifier: "cell6")
        
        
        
        let convertedDate = mUtilityClassObj.date()
        
        date.text = convertedDate
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        }
    
    func rotated() {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            print("Landscape")
            print("views width",view.frame.width)
            mCustomView.frame = CGRect.init(x: slideMenu.frame.width, y: 0, width: view.frame.width-slideMenu.frame.width, height: view.frame.height)
            mCustomView.backgroundColor = UIColor.lightGray
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            print("Portrait")
            print("views width",view.frame.width)
            mCustomView.frame = CGRect.init(x: slideMenu.frame.width, y: 0, width: view.frame.width-slideMenu.frame.width, height: view.frame.height)
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
        slideMenuLeadingConstraint.constant = -250
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
    
    @IBAction func menuOpen(_ sender: UIButton) {
        //changing the custom view's size while we change to landscape mode
        print("views width",view.frame.width)
        mCustomView.frame = CGRect.init(x: slideMenu.frame.width, y: 0, width: view.frame.width-slideMenu.frame.width, height: view.frame.height)
        mCustomView.backgroundColor = UIColor.lightGray
        
        if(mMenuShowing){
            slideMenuLeadingConstraint.constant = -250
            //1st case of removing tap gesture(papre) when we click on the icon
            
            removeGestureRecognizer()
            
        }else{
            slideMenuLeadingConstraint.constant = 0
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
    
    func tableviewReload(){
        self.tableView.reloadData()
    }
    
    func dashBoardCollectionviewreload(){
        mActivityIndicator.isHidden = true
        self.mActivityIndicator.stopAnimating()
        self.collectionView.reloadData()
    }
}


//extension of collectionview cell
extension DashBoardVC: UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        print("valueOfDictionary=-=-=-=",UserDefaults.standard.value(forKey: "tokenKey")!)
        if(UserDefaults.standard.value(forKey: "tokenKey") != nil){            mDashBoardViewModelObj?.fetchDataFromDashBoardController()
        }
        print("dashBoardViewModelObj.responseCount",mDashBoardViewModelObj!.responseCount)
        //dashBoardViewModelObj.fetchDataFromDashBoardController(token:self.token!)
        return mDashBoardViewModelObj!.responseCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        
        let colorOfMarkedEmployees = UIColor.init(red: 24/255, green: 136/255, blue: 13/255, alpha: 1)
        let colorOfUnmarkedEmployees = UIColor.init(red: 227/255, green: 86/255, blue: 86/255, alpha: 1)
        let date = Date.init(timeIntervalSince1970: Double((mDashBoardViewModelObj?.dashBoardContents?.timeStamp)!)/1000)
        if(indexPath.row == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! CollectionViewCell
            let retunedDate = mUtilityClassObj.cellDesign(cell: cell, date: date)
            cell.markedEmployees.backgroundColor = colorOfMarkedEmployees
            cell.markedEmployees.layer.masksToBounds = true
            cell.markedEmployees.layer.cornerRadius = 15
            cell.unmarkedEmployees.backgroundColor = colorOfUnmarkedEmployees
            cell.unmarkedEmployees.layer.masksToBounds = true
            cell.unmarkedEmployees.layer.cornerRadius = 15
            cell.markedEmployees.text = String(describing: (mDashBoardViewModelObj?.dashBoardContents?.marked)! as Int)
            cell.unmarkedEmployees.text = mDashBoardViewModelObj?.dashBoardContents?.unmarked! as? String
            cell.date.text = retunedDate
            return cell
        }
        else if(indexPath.row == 1){
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CollectionViewCell2
            cell.falloutEmployees.text = String(describing:(mDashBoardViewModelObj?.dashBoardContents?.falloutEmployee!)! as Int)
            cell.totalEmployees.text = String(describing:(mDashBoardViewModelObj?.dashBoardContents?.totalEmployee!)! as Int)
             let retunedDate = mUtilityClassObj.cellDesign(cell: cell, date: date)
            cell.date.text = retunedDate
            return  cell
        }
        else if(indexPath.row == 2){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! CollectionViewCell3
            cell.leave.text = mDashBoardViewModelObj?.dashBoardContents?.leave! as! String
            let retunedDate = mUtilityClassObj.cellDesign(cell: cell, date: date)
            cell.date.text = retunedDate
            return cell
        }
        else if(indexPath.row == 3) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell4", for: indexPath)
            mUtilityClassObj.cellDesign(cell: cell, date: date)
            return cell
        }
        else if(indexPath.row == 4){
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell5", for: indexPath)
          
            mUtilityClassObj.cellDesign(cell: cell, date: date)
            return cell
        }
        else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell6", for: indexPath)
             mUtilityClassObj.cellDesign(cell: cell, date: date)
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
        let cell = collectionView.cellForItem(at: indexPath)
        if flag {
            cell?.contentView.backgroundColor = UIColor.lightGray
            cell?.contentView.backgroundColor?.withAlphaComponent(0.5)
        } else {
            cell?.contentView.backgroundColor = nil
        }
    }
    
}

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
            performSegue(withIdentifier: "segueFromSixthIndex", sender: nil)
        }
        slideMenuLeadingConstraint.constant = -250
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



