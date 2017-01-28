//
//  LoginController.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 08/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class LoginController: NSObject,LoginControllerProtocol{
    //creating variable of type LoginViewModelProtocol
    var loginViewModelProtocolObj : LoginViewModelProtocol?
    
    init(pLoginViewModelProtocolObj : LoginViewModelProtocol) {
        loginViewModelProtocolObj = pLoginViewModelProtocolObj
    }
    //making rest call by passing email and password
    func passingEmailAndPasswordToService(_ email:String,password:String){
        let loginServiceObj = LoginService(pLoginControllerProtocolObj: self)
        loginServiceObj.fetchToken(email, password: password)
    }
    
    //passing the status fetched from rest call
    func fetchStatusFromService(_ status:Int){
        self.loginViewModelProtocolObj?.fetchStatusFromController(status)
    }
}
