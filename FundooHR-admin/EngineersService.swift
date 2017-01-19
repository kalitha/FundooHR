//
//  EngineersService.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 19/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit
import Firebase
class EngineersService: NSObject {
    var ref: FIRDatabaseReference!
    var slideMenuContents = [NSDictionary]()
    var arrayOfEngineerNames = [EngineersModel]()
    let engineersControllerObj = EngineersController()
    var protocolEngineersController : CallBackInEngineersController?
    
    func fetchData()  {
          ref = FIRDatabase.database().reference()//responsible to make a call to firebase
        ref.child("teams").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            //            self.teams = (snapshot.value as? NSArray)!
            //            self.teamsDataControllerObj?.fetchDataFromService(data: self.teams)
            self.slideMenuContents = (snapshot.value) as! [NSDictionary]
            
            for index in 0..<self.slideMenuContents.count{
                let valueAtEachIndex = self.slideMenuContents[index] as NSDictionary //valueAtEachIndex is 1 nsdictionary
                
                let rowName = valueAtEachIndex["row_name"] as! String
                
                let engineersObj = EngineersModel(rowName: rowName)
                
                self.arrayOfEngineerNames.append(engineersObj)
            }
            print("count=======",self.arrayOfEngineerNames.count)
            self.protocolEngineersController?.dataFetchedFromService(data: self.arrayOfEngineerNames)
           
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
