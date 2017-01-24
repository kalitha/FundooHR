//
//  LoginService.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 08/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit
import  Alamofire

class LoginService: NSObject {
    
    var protocolLoginController :CallBackInLoginController?
    //getting a reference to "defaults" that can access UserDefaults
    let defaults = UserDefaults.standard
    
    func fetchToken(_ email:String, password:String){
        let urlString: String = "http://192.168.0.17:3000/login"
        let params = ["emailId":  (email), "password" : (password)]
        Alamofire.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { response in
                // print("--response--",response)
                // print("result----",response.result)
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
                    
                        self.protocolLoginController?.fetchTokenFromService(status, token: fetchedTokenValue)
                    }
                    else{
                        let token = String(describing:loginData.value(forKey: "token"))
                        print("---token---",token)
                        self.protocolLoginController?.fetchTokenFromService(status, token: token)
                    }
                    
                }
                
        }
}
}
