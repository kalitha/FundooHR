//
//  LoginViewModel.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 07/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class LoginViewModel: NSObject,CallBackInLoginViewModel {
    var loginvcObj:LoginVC?
    
    func passingEmailAndPasswordToController(_ email:String,password:String){
        let loginControllerObj = LoginController()
        loginControllerObj.protocolLoginViewModel = self
        loginControllerObj.passingEmailAndPasswordToService(email, password: password)
    }
    func fetchTokenFromController(_ status:Int, token:String){
        loginvcObj?.performingNavigationToDashboard(status:status, token:token)
    }
}
