//
//  LoginController.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 08/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class LoginController: NSObject,LoginControllerProtocol {
    var loginViewModelProtocolObj : LoginViewModelProtocol?
    
    init(pLoginViewModelProtocolObj : LoginViewModelProtocol) {
        loginViewModelProtocolObj = pLoginViewModelProtocolObj
    }
    func passingEmailAndPasswordToService(_ email:String,password:String){
        let loginServiceObj = LoginService(pLoginControllerProtocolObj: self)
        loginServiceObj.fetchToken(email, password: password)
    }
    func fetchTokenFromService(_ status:Int){
        self.loginViewModelProtocolObj?.fetchTokenFromController(status)
    }
}
