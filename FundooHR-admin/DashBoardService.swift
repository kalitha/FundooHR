//
//  DashBoardService.swift
//  FundooHR-admin

//  Purpose:-
//  1)Making Rest call to fetch tableview contents
//  2)Making rest call to fetch collectionview contents of DashBoard Viewcontroller

//  Created by BridgeLabz on 02/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit
import  Firebase
import Alamofire

class DashBoardService: NSObject {
    
    //create variable of type nsdictionary
    var mSlideMenuContents = [NSDictionary]()
    
    //create  model type variable
    var mArrayOfTableViewContentModel = [TableViewContentModel]()
    
    //create variable of type DashBoardControllerProtocol
    var mProtocolDashBoardController : DashBoardControllerProtocol?
    
    //create object of UtilityClass
    let mUtilityClassObj = UtilityClass()
    
    init(pDashBoardControllerProtocolObj : DashBoardControllerProtocol) {
        mProtocolDashBoardController = pDashBoardControllerProtocolObj
    }
    
    //rest call to fetch tableview contents
    func fetchTableViewContents(){
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()//responsible to make a call to firebase
        ref.child("slideMenuContents").observeSingleEvent(of: .value, with: { (snapshot) in
            self.mSlideMenuContents = (snapshot.value) as! [NSDictionary]
            
            for index in 0..<self.mSlideMenuContents.count{
                let valueAtEachIndex = self.mSlideMenuContents[index] as NSDictionary //valueAtEachIndex is 1 nsdictionary
                
                let rowName = valueAtEachIndex["row_name"] as! String
                
                let tableviewContents = TableViewContentModel(rowName: rowName)
                
                self.mArrayOfTableViewContentModel.append(tableviewContents)
            }
            print("slideMenuContents",self.mSlideMenuContents)
            print("count=======",self.mArrayOfTableViewContentModel.count)
            self.mProtocolDashBoardController?.tableViewContentsFetchedFromService(data: self.mArrayOfTableViewContentModel)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    //rest call to fetch collectionview data
    func fetchData(){
        let token = UserDefaults.standard.value(forKey: "tokenKey")! as! String
        print("tokenKey=-=-=",token)
        let url = mUtilityClassObj.fetchUrlFromPlist()
        
        let calculatedTimeStamp = Double(Date().timeIntervalSince1970 * 1000)
        print("timestamp@#@#$",calculatedTimeStamp)
        
        let headers: HTTPHeaders = [
            "x-token" : token
        ]
        
        Alamofire.request("\(url)/readDashboardData?timeStamp=\(calculatedTimeStamp)", headers: headers).responseJSON
            { response in
                print("value----",response.result.value!)
                
                if let JSON = response.result.value {
                    let dashboardData = JSON as! NSDictionary
                    //let dataArray = response["attendanceSummary"] as! NSDictionary
                    print("---dashboard data----",dashboardData)
                    let timeStamp = dashboardData.value(forKey: "timeStamp") as! Double
                    
                    print("==timeStamp==",timeStamp)
                    
                    let attendanceSummary = dashboardData.value(forKey: "attendanceSummary") as! NSDictionary
                    print("---attendanceSummary---",attendanceSummary)
                    
                    let marked = attendanceSummary.value(forKey: "marked") as! Int
                    let unmarked = attendanceSummary.value(forKey: "unmarked") as! NSString
                    
                    let attendanceFallout = dashboardData.value(forKey: "attendanceFallout") as! NSDictionary
                    
                    let falloutEmployee = attendanceFallout.value(forKey: "falloutEmployee") as! Int
                    let totalEmployee = attendanceFallout.value(forKey: "totalEmployee") as! Int
                    
                    let leaveSummary = dashboardData.value(forKey: "leaveSummary") as! NSDictionary
                    
                    let leave = leaveSummary.value(forKey: "leave") as! NSString
                    
                    let dashBoardContent = DashBoard(marked: marked, unmarked: unmarked, falloutEmployee: falloutEmployee, totalEmployee: totalEmployee, leave: leave, timeStamp: timeStamp)
                    
                    //sending fetched data to controller
                    self.mProtocolDashBoardController?.fetchedDataFromDashBoardService(dashBoardContent)
                    
                }
        }
        
        
        
    }
}
