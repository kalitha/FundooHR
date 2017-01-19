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
    //let token : String?
    let defaults = UserDefaults.standard
    
    func fetchToken(_ email:String, password:String){
        let urlString: String = "http://192.168.0.144:3000/login"
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
                        
                        let fetchedTokenFromRestCall = loginData.value(forKey: "token") as! String
                        print("---token---",fetchedTokenFromRestCall)
                        let tokenDictionary : [String:String] = (["token": fetchedTokenFromRestCall] as! NSDictionary) as! [String : String]
                        
                        print("token dictionary===",tokenDictionary)
                        
                        //assining the tokenDictionary value to dictionaryOfToken
                        self.defaults.set(tokenDictionary, forKey: "dictionary")
                        //fetching the dictionary value from dictionary
                        let dictionaryOfToken = self.defaults.value(forKey: "dictionary") as! NSDictionary
                        print("dictionaryOfToken===",dictionaryOfToken)
                        let tokenValue = dictionaryOfToken.value(forKey: "token") as! String
                        
                        self.protocolLoginController?.fetchTokenFromService(status, token: tokenValue)
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
