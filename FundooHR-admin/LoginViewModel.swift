//
//  LoginViewModel.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 07/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class LoginViewModel: NSObject,LoginViewModelProtocol {
    //variable of type login viewcontroller
    var mLoginvcObj : LoginVC?
    //variable of type Login ViewControllerProtocol
    var mLoginVCProtocolObj : LoginVCProtocol?
    
    init(pLoginVCProtocolObj : LoginVCProtocol) {
        mLoginVCProtocolObj = pLoginVCProtocolObj
    }
    //making rest call by passing email and password
    func passingEmailAndPasswordToController(_ email:String,password:String){
        let loginControllerObj = LoginController(pLoginViewModelProtocolObj: self)
        loginControllerObj.passingEmailAndPasswordToService(email, password: password)
    }
    
    //passing the status fetched from rest call
    func fetchStatusFromController(_ status:Int){
        mLoginVCProtocolObj?.performingNavigationToDashboard(status: status)
    }
}
