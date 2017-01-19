//
//  EngineersVC.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 13/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class EngineersVC: UIViewController,UITableViewDataSource,UITableViewDelegate,CallBackInEngineersVC {
    
    @IBOutlet weak var tableView: UITableView!
    var menuShowing = false
    var customView = UIView()
    var names: [String] = ["email id", "Dashboard", "Engineers", "Attendance Summary", "Reports" ,"Clients", "Logout"]
    @IBOutlet weak var slideMenu: UIView!
    @IBOutlet weak var slideMenuLeadingConstraint: NSLayoutConstraint!
    
    var engineersViewModelObj : EngineersViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.frame = CGRect.init(x: slideMenu.frame.width, y: 0, width: view.frame.width-slideMenu.frame.width, height: view.frame.height)
        customView.backgroundColor = UIColor.lightGray
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addGestureRecognizer(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        self.customView.addGestureRecognizer(tapGesture)
        
    }
    
    func removeGestureRecognizer(){
        for recognizer in view.gestureRecognizers ?? [] {
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

    @IBAction func onButtonClick(_ sender: Any) {
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
    
    func reload(){
        
        self.tableView.reloadData()//it reloads the tablview so that numberOfRowsInSection and cellForRowAt methods will be called
    }

    
        open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return names.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
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
    
    // MARK:- tableview delegate method
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if(indexPath.row == 1){
            performSegue(withIdentifier: "segueFromFirstIndex", sender: nil)
        }
        
        if(indexPath.row == 3){
            performSegue(withIdentifier: "segueFromThirdIndex", sender: nil)
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
