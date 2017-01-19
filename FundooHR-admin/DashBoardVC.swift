//
//  DashBoardVC.swift
//  FundooHR
//
//  Created by BridgeLabz Solutions LLP on 09/12/16.
//  Copyright © 2016 BridgeLabz Solutions LLP. All rights reserved.
//

import UIKit

class DashBoardVC: UIViewController,CallBackInDashBoardVC{

    //let loginVCObj = LoginVC()
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var slideMenu: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var slideMenuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var date: UILabel!
    
    let dashBoardViewModelObj = DashBoardViewModel()
    var menuShowing = false
    var customView = UIView()
    var names: [String] = ["email id", "Dashboard", "Engineers", "Attendance Summary", "Reports" ,"Clients", "Logout"]
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dashBoardViewModelObj.protocolDashBoardViewController = self
        //token = loginVCObj.token
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell1")
        
        self.collectionView.register(UINib(nibName: "CollectionViewCell2", bundle: nil), forCellWithReuseIdentifier: "cell2")
        
        self.collectionView.register(UINib(nibName: "CollectionViewCell3", bundle: nil), forCellWithReuseIdentifier: "cell3")
        
        self.collectionView.register(UINib(nibName: "CollectionViewCell4", bundle: nil), forCellWithReuseIdentifier: "cell4")
        
        self.collectionView.register(UINib(nibName: "CollectionViewCell5", bundle: nil), forCellWithReuseIdentifier: "cell5")
        
        self.collectionView.register(UINib(nibName: "CollectionViewCell6", bundle: nil), forCellWithReuseIdentifier: "cell6")
       
        let currentDate = Date()
        
        // initialize the date formatter and set the style
        
        formatter.dateFormat = "dd MM yyyy"
        formatter.dateStyle = .long
        // get the date time String from the date object
        let convertedDate = formatter.string(from: currentDate)
        date.text = convertedDate
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        //        slideMenu.layer.shadowOpacity = 1
        //        slideMenu.layer.shadowRadius = 6
    }
    
    
    func rotated() {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            print("Landscape")
            print("views width",view.frame.width)
            customView.frame = CGRect.init(x: slideMenu.frame.width, y: 0, width: view.frame.width-slideMenu.frame.width, height: view.frame.height)
            customView.backgroundColor = UIColor.lightGray
           
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            print("Portrait")
            print("views width",view.frame.width)
            customView.frame = CGRect.init(x: slideMenu.frame.width, y: 0, width: view.frame.width-slideMenu.frame.width, height: view.frame.height)
            customView.backgroundColor = UIColor.lightGray
        }
        
    }
    
    func reload(){
        self.collectionView.reloadData()
    }
    
    func addGestureRecognizer(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        self.customView.addGestureRecognizer(tapGesture)
        
    }
    
    func removeGestureRecognizer(){
        for recognizer in collectionView.gestureRecognizers ?? [] {
            customView.removeGestureRecognizer(recognizer)
        }
    }
    
    func tapBlurButton(_ sender: UIButton) {
        slideMenuLeadingConstraint.constant = -250
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        menuShowing = !menuShowing
        
        //to remove custom view after removing slidemenu
        self.customView.removeFromSuperview()
        menuShowing = !menuShowing
        
        //3rd case of removing  gesture when we click on collectionview
        removeGestureRecognizer()
    }
    
    @IBAction func menuOpen(_ sender: UIButton) {
        //changing the custom view's size while we change to landscape mode
        print("views width",view.frame.width)
        customView.frame = CGRect.init(x: slideMenu.frame.width, y: 0, width: view.frame.width-slideMenu.frame.width, height: view.frame.height)
        customView.backgroundColor = UIColor.lightGray

        if(menuShowing){
            slideMenuLeadingConstraint.constant = -250
            //1st case of removing tap gesture(papre) when we click on the icon
            removeGestureRecognizer()
        }else{
            slideMenuLeadingConstraint.constant = 0
            self.view.addSubview(customView)
            customView.alpha = 0.5
            addGestureRecognizer()
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        menuShowing = !menuShowing
    }
    
}

extension DashBoardVC: UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
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
        
        if(indexPath.row == names.count-1){
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
        
        if(indexPath.row == 3){
            performSegue(withIdentifier: "segueFromSecondCell", sender: nil)
        }
        if(indexPath.row == 4){
            performSegue(withIdentifier: "segueFromFourthIndex", sender: nil)
        }
        if(indexPath.row == 5){
            performSegue(withIdentifier: "segueFromFifthIndex", sender: nil)
        }
        if(indexPath.row == 6){
            performSegue(withIdentifier: "segueFromSixthIndex", sender: nil)
        }
        slideMenuLeadingConstraint.constant = -250
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        menuShowing = !menuShowing
        
        //2nd case of removing the tap gesture(paper) when we click on table view
        self.customView.removeFromSuperview()
        removeGestureRecognizer()
    }
    
    //func to set the height of the cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70.0;//Choose your custom row height
    }
}

//extension of collectionview cell
extension DashBoardVC: UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
       let tokenDictionary = UserDefaults.standard.value(forKey: "dictionaryOfToken") as! NSDictionary
       let token = tokenDictionary.value(forKey: "token") as! String
        dashBoardViewModelObj.fetchDataFromDashBoardController(token)
        
        //dashBoardViewModelObj.fetchDataFromDashBoardController(token:self.token!)
        return dashBoardViewModelObj.responseCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let color = UIColor.init(red: 111/255, green: 184/255, blue: 217/255, alpha: 1)
        
        if(indexPath.row == 0){
            let colorOfMarkedEmployees = UIColor.init(red: 24/255, green: 136/255, blue: 13/255, alpha: 1)
            
            let colorOfUnmarkedEmployees = UIColor.init(red: 227/255, green: 86/255, blue: 86/255, alpha: 1)
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! CollectionViewCell
            cell.markedEmployees.backgroundColor = colorOfMarkedEmployees
            cell.markedEmployees.layer.masksToBounds = true
            cell.markedEmployees.layer.cornerRadius = 15
            cell.unmarkedEmployees.backgroundColor = colorOfUnmarkedEmployees
            cell.unmarkedEmployees.layer.masksToBounds = true
            cell.unmarkedEmployees.layer.cornerRadius = 15
            cell.contentView.backgroundColor = UIColor.white
            cell.layer.borderWidth = 2.0
            cell.layer.borderColor = color.cgColor
            cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.layer.shadowOffset = CGSize(width:2.0,height: 2.0)
            cell.layer.shadowRadius = 3.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.masksToBounds = false
            cell.layer.cornerRadius = 5
            cell.markedEmployees.text = String(describing: (dashBoardViewModelObj.dashBoardContents?.marked)! as Int)
           // cell.unmarkedEmployees.text = String(describing:dashBoardViewModelObj.dashBoardContents?.unmarked! )
             cell.unmarkedEmployees.text = dashBoardViewModelObj.dashBoardContents?.unmarked! as! String
           let date = Date.init(timeIntervalSince1970: Double((dashBoardViewModelObj.dashBoardContents?.timeStamp)!)/1000)
            formatter.dateFormat = "dd MM yyyy"
            formatter.dateStyle = .long
           let convertedDate = formatter.string(from: date)
            cell.date.text = convertedDate
            return cell
        }
        else if(indexPath.row == 1){
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CollectionViewCell2
            cell.contentView.backgroundColor = UIColor.white
            cell.layer.borderWidth = 2.0
            cell.layer.borderColor = color.cgColor
            cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.layer.shadowOffset = CGSize(width:2.0,height: 2.0)
            cell.layer.shadowRadius = 3.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.masksToBounds = false
            cell.layer.cornerRadius = 5
            //cell.falloutEmployees.text = String(describing:dashBoardViewModelObj.dashBoardContents?.falloutEmployee!)
            cell.falloutEmployees.text = String(describing:(dashBoardViewModelObj.dashBoardContents?.falloutEmployee!)! as Int
            )

            cell.totalEmployees.text = String(describing:(dashBoardViewModelObj.dashBoardContents?.totalEmployee!)! as Int)
            
            let date = Date.init(timeIntervalSince1970: Double((dashBoardViewModelObj.dashBoardContents?.timeStamp)!)/1000)
            formatter.dateFormat = "MMMM yyyy"
           let convertedDate = formatter.string(from: date)
            cell.date.text = convertedDate
            return  cell
        }
        else if(indexPath.row == 2){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! CollectionViewCell3
            cell.contentView.backgroundColor = UIColor.white
            cell.layer.borderWidth = 2.0
            cell.layer.borderColor = color.cgColor
            cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.layer.shadowOffset = CGSize(width:2.0,height: 2.0)
            cell.layer.shadowRadius = 3.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.masksToBounds = false
            cell.layer.cornerRadius = 5
            cell.leave.text = dashBoardViewModelObj.dashBoardContents?.leave! as! String
            let date = Date.init(timeIntervalSince1970: Double((dashBoardViewModelObj.dashBoardContents?.timeStamp)!)/1000)
            formatter.dateFormat = "dd MM yyyy"
            formatter.dateStyle = .long
            let convertedDate = formatter.string(from: date)
            cell.date.text = convertedDate
            return cell
        }
        else if(indexPath.row == 3) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell4", for: indexPath)
            cell.contentView.backgroundColor = UIColor.white
            cell.layer.borderWidth = 2.0
            cell.layer.borderColor = color.cgColor
            cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.layer.shadowOffset = CGSize(width:2.0,height: 2.0)
            cell.layer.shadowRadius = 3.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.masksToBounds = false
            cell.layer.cornerRadius = 5
            
            return cell
        }
        else if(indexPath.row == 4){
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell5", for: indexPath)
            cell.contentView.backgroundColor = UIColor.white
            cell.layer.borderWidth = 2.0
            cell.layer.borderColor = color.cgColor
            cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.layer.shadowOffset = CGSize(width:2.0,height: 2.0)
            cell.layer.shadowRadius = 3.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.masksToBounds = false
            cell.layer.cornerRadius = 5
            return cell
        }
        else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell6", for: indexPath)
            cell.contentView.backgroundColor = UIColor.white
            cell.layer.borderWidth = 2.0
            cell.layer.borderColor = color.cgColor
            cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.layer.shadowOffset = CGSize(width:2.0,height: 2.0)
            cell.layer.shadowRadius = 3.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.masksToBounds = false
            cell.layer.cornerRadius = 5
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


