//
//  LoginController.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 08/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class LoginController: NSObject,CallBackInLoginController {
    var protocolLoginViewModel : CallBackInLoginViewModel?
    
    func passingEmailAndPasswordToService(_ email:String,password:String){
        let loginServiceObj = LoginService()
        loginServiceObj.protocolLoginController = self
        loginServiceObj.fetchToken(email, password: password)
    }
    func fetchTokenFromService(_ status:Int, token:String){
        self.protocolLoginViewModel?.fetchTokenFromController(status, token: token)
    }
}
