//
//  LoginService.swift
//  FundooHR-admin

//  Purpose:-
//  1)Making Rest call to fetch token and status


//  Created by BridgeLabz on 08/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit
import  Alamofire

class LoginService: NSObject {
    
    //create object of UtilityClass
    let mUtilityClassObj = UtilityClass()
    
    var loginControllerProtocolObj :LoginControllerProtocol?
    //getting a reference to "defaults" that can access UserDefaults
    let defaults = UserDefaults.standard
    
    init(pLoginControllerProtocolObj : LoginControllerProtocol) {
        loginControllerProtocolObj = pLoginControllerProtocolObj
    }
    
    //making rest api call
    func fetchToken(_ email:String, password:String){
        //getting url from plist
        let url = mUtilityClassObj.fetchUrlFromPlist()
        let urlString: String = "\(url)/login"
        let params = ["emailId":  (email), "password" : (password)]
        Alamofire.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { response in
                print("--response--",response)
                print("result----",response.result)
                if let JSON = response.result.value{
                    let loginData = JSON as! NSDictionary
                    print("---Login Data----",loginData)
                    let status = loginData.value(forKey: "status") as! Int
                    print("status---",status)
                    if(status == 200){
                        
                        let fetchedTokenValue = loginData.value(forKey: "token") as! String
                        print("---fetchedTokenValue---",fetchedTokenValue)
                        
                        //assining the "fetchedTokenValue" value to key "dictionary"
                        self.defaults.set(fetchedTokenValue, forKey: "tokenKey")
                    
                        self.loginControllerProtocolObj?.fetchStatusFromService(status)
                    }
                    else{
                        let token = String(describing:loginData.value(forKey: "token"))
                        print("---token---",token)
                        self.loginControllerProtocolObj?.fetchStatusFromService(status)
                    }
                    
                }
                
        }
}
}
