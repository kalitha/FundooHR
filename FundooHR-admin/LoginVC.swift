
//  LoginVC.swift
//  FundooHR
// Purpose :
//  1)It is Login UIClass & holds IBOutlet & IBActions of Login UIViewController
//  2)In this class we validate user credentials
//  3)From this ViewController we navigate to DashBoardViewController

//  Created by Kalitha H N on 07/12/16.
//  Copyright © 2016 BridgeLabz Solutions LLP. All rights reserved.
//

import UIKit
//import FirebaseAuth
import Alamofire

class LoginVC: UIViewController,LoginVCProtocol{
    
    //creating object of LoginViewModel
    var mLoginViewModelObj:LoginViewModel?
    
    //outlet of email id
    @IBOutlet weak var mEmail: UITextField!
    //outlet of password
    @IBOutlet weak var mPassword: UITextField!
    //outlet of activityIndicator
    @IBOutlet weak var mActivityIndicator: UIActivityIndicatorView!
    //outlet of bridgelabz logo
    @IBOutlet weak var mLogo: UIImageView!
    //outlet of loginView
    @IBOutlet weak var mLoginView: UIView!
    // outlet of login buttton
    @IBOutlet weak var mLoginButton: UIButton!
    
    var mOffsetCheckBOOL = false
    
    // executes when screen gets loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        //enabling the activity indicator
        mActivityIndicator.isHidden = true
        mLoginViewModelObj = LoginViewModel(pLoginVCProtocolObj: self)
        mLoginView.layer.shadowColor = UIColor.black.cgColor
        mLogo.layer.shadowColor = UIColor.black.cgColor
      
        //adding observer for notification when keyboard appears
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        //adding observer for notification when keyboard disappears
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        print("view.frame.origin.y",view.frame.origin.y)
        
    }
    //performing client side validation for emailid and password
    func clientSideValidationOfUserCredentials(emailId:String, password: String)->Bool{
        let lEmailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let lPasswordRegEx = "^([a-zA-Z0-9@*#]{8,15})$"
        
        let lEmailChecked = NSPredicate(format:"SELF MATCHES %@", lEmailRegEx)
        let lPasswordChecked = NSPredicate(format:"SELF MATCHES %@", lPasswordRegEx)
        if lEmailChecked.evaluate(with: emailId) && lPasswordChecked.evaluate(with: password){
        return true
    }
        else{
           return false
        }
    }
    
    //creating action for login button
    @IBAction func loginAction(_ sender: Any) {
        //enabling the activity idicator
        let lEmailId = mEmail.text
        let lPassword = mPassword.text
        var lValueOfClientSideValidation : Bool?
        //checking whether emailId or password is nil
        if(lEmailId == "" || lPassword == ""){
            //pop up of alert box if nil
            let lAlert = UIAlertController(title: "Alert", message: "Please enter the credentials", preferredStyle: UIAlertControllerStyle.alert)
            lAlert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(lAlert, animated: true, completion: nil)
        }
        else{
         lValueOfClientSideValidation = self.clientSideValidationOfUserCredentials(emailId:lEmailId!, password:lPassword!)
            print(lValueOfClientSideValidation)
        //disabling the activity indictor
        mActivityIndicator.isHidden = false
        mActivityIndicator.startAnimating()
            
        if(lValueOfClientSideValidation == true){
        //making call to LoginViewModels method for valid user credentials
        mLoginViewModelObj?.passingEmailAndPasswordToController(lEmailId!, password: lPassword!)
        }
            //pop up of alert box for invalid user credentials
        else{
            let alert = UIAlertController(title: "Alert", message: "Please enter the valid credentials", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
    func performingNavigationToDashboard(status:Int){
        //disabling the activity indicator
        mActivityIndicator.isHidden = true
        self.mActivityIndicator.stopAnimating()
        if(status == 200){
            //navigating to dashboard viewController
            self.performSegue(withIdentifier: "navigateToDashboard", sender: nil)
        }
            //alert for unautherized user
        else if(status == 401){
            let lAlert = UIAlertController(title: "Alert", message: "Unautherized user", preferredStyle: UIAlertControllerStyle.alert)
            lAlert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(lAlert, animated: true, completion: nil)
        }
        else if(status == 304){
            let alert = UIAlertController(title: "Alert", message: "not modified", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            }
        
    }
    
    //Keyboard popup and Hide Notifications
    func keyboardWillShow(notification: NSNotification) {
        if let lKeyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            let kBHeight = lKeyboardSize.size.height;
            print("kbHeight",kBHeight)
            print("email.frame.origin.y",mEmail.frame.origin.y)
            print("email.frame.size.height",mEmail.frame.size.height)
            print("self.view.frame.origin.y",self.view.frame.origin.y)
            print("password",mPassword.frame.origin.y)
            print("password",mPassword.frame.size.height)
            print("self.view.frame.origin.y",self.view.frame.origin.y)
            
            if (mEmail.frame.origin.y+mEmail.frame.size.height+self.view.frame.origin.y > kBHeight )
            {
                if(mOffsetCheckBOOL
                    == false)
                {
                    mOffsetCheckBOOL = true
                    print(self.view.frame.origin.y);
                    self.view.frame.origin.y -= 80
                    print(self.view.frame.origin.y);
                }
                else
                {
                    self.view.frame.origin.y += 80
                    mOffsetCheckBOOL = false
                    keyboardWillShow(notification: notification)
                }
            }
            else if(mPassword.frame.origin.y+mPassword.frame.size.height+self.view.frame.origin.y < kBHeight )
            {
                if(mOffsetCheckBOOL == false)
                {
                    mOffsetCheckBOOL = true
                    print(self.view.frame.origin.y);
                    self.view.frame.origin.y -= 80
                    print(self.view.frame.origin.y);
                }
                else
                {
                    self.view.frame.origin.y += 80
                    mOffsetCheckBOOL = false
                    keyboardWillShow(notification: notification)
                }
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        if let lKeyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if(mOffsetCheckBOOL == true)
            {
                mOffsetCheckBOOL = false
                self.view.frame.origin.y = 0
            }
        }
    }
    
}

