//
//  LoginVC.swift
//  FundooHR
//
//  Created by Kalitha H N on 07/12/16.
//  Copyright © 2016 BridgeLabz Solutions LLP. All rights reserved.
//

import UIKit
//import FirebaseAuth
import Alamofire

class LoginVC: UIViewController {
    
    //creating object of LoginViewModel
    let loginViewModelObj:LoginViewModel = LoginViewModel()
    //let dashboardVC:DashBoardVC = DashBoardVC()
    
    //creating outlets
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    var offsetCheckBOOL = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        loginViewModelObj.loginvcObj = self
        loginButton.layer.cornerRadius = 5
        loginView.layer.cornerRadius = 10
        loginView.layer.shadowColor = UIColor.black.cgColor
        loginView.layer.shadowOffset = CGSize(width:2.0,height: 2.0)
        loginView.layer.shadowOpacity = 0.4
        loginView.layer.shadowRadius = 1.3
        logo.layer.shadowColor = UIColor.black.cgColor
        logo.layer.shadowOffset = CGSize(width:0,height: 2.0)
        logo.layer.shadowOpacity = 0.5
        logo.layer.shadowRadius = 2.0
        
        //adding observer for notification when keyboard appears
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        //adding observer for notification when keyboard disappears
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        print("view.frame.origin.y",view.frame.origin.y)
        
    }
    
    @IBAction func loginAction(_ sender: Any) {
        //enabling the activity idicator
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let emailData = email.text
        let pswd = password.text
        loginViewModelObj.passingEmailAndPasswordToController(email: emailData!, password: pswd!)
    }
    
    func performingNavigationToDashboard(status:Int, token: String){
        activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
        if(status == 200){
            
            
            self.performSegue(withIdentifier: "navigateToDashboard", sender: nil)
        }
        else if(status == 401){
            let alert = UIAlertController(title: "Alert", message: "Unautherized user", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if(status == 304){
            let alert = UIAlertController(title: "Alert", message: "not modified", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            }
        
    }
    
    //Keyboard popup and Hide Notifications
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            let kbHeight = keyboardSize.size.height;
            print("kbHeight",kbHeight)
            print("email.frame.origin.y",email.frame.origin.y)
            print("email.frame.size.height",email.frame.size.height)
            print("self.view.frame.origin.y",self.view.frame.origin.y)
            
            print("password",password.frame.origin.y)
            print("password",password.frame.size.height)
            print("self.view.frame.origin.y",self.view.frame.origin.y)
            
            if (email.frame.origin.y+email.frame.size.height+self.view.frame.origin.y > kbHeight )
            {
                if(offsetCheckBOOL == false)
                {
                    offsetCheckBOOL = true
                    print(self.view.frame.origin.y);
                    self.view.frame.origin.y -= 80
                    print(self.view.frame.origin.y);
                }
                else
                {
                    self.view.frame.origin.y += 80
                    offsetCheckBOOL = false
                    keyboardWillShow(notification: notification)
                }
            }
            else if(password.frame.origin.y+password.frame.size.height+self.view.frame.origin.y < kbHeight )
            {
                //if(offsetCheckBOOL == true)
                if(offsetCheckBOOL == false)
                {
                    //offsetCheckBOOL = false
                    offsetCheckBOOL = true
                    print(self.view.frame.origin.y);
                    self.view.frame.origin.y -= 80
                    print(self.view.frame.origin.y);
                }
                else
                {
                    self.view.frame.origin.y += 80
                    //offsetCheckBOOL = true
                    offsetCheckBOOL = false
                    keyboardWillShow(notification: notification)
                }
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if(offsetCheckBOOL == true)
            {
                offsetCheckBOOL = false
                self.view.frame.origin.y = 0
            }
        }
    }
    
}

