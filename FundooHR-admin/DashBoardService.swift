//
//  DashBoardService.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 02/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit
import  Firebase
import Alamofire
class DashBoardService: NSObject {
    var slideMenuContents = [NSDictionary]()
    var arrayOfTableViewContentModel = [TableViewContentModel]()
    var protocolDashBoardController : CallBackInDashBoardController?
    
    init(pCallBackInDashBoardController : CallBackInDashBoardController) {
        protocolDashBoardController = pCallBackInDashBoardController
    }

    func fetchTableViewContents(){
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()//responsible to make a call to firebase
        ref.child("slideMenuContents").observeSingleEvent(of: .value, with: { (snapshot) in
              self.slideMenuContents = (snapshot.value) as! [NSDictionary]
            
            for index in 0..<self.slideMenuContents.count{
                let valueAtEachIndex = self.slideMenuContents[index] as NSDictionary //valueAtEachIndex is 1 nsdictionary
                
                let rowName = valueAtEachIndex["row_name"] as! String
                
                let tableviewContents = TableViewContentModel(rowName: rowName)
                
                self.arrayOfTableViewContentModel.append(tableviewContents)
            }
            print("slideMenuContents",self.slideMenuContents)
            print("count=======",self.arrayOfTableViewContentModel.count)
            self.protocolDashBoardController?.tableViewContentsFetchedFromService(data: self.arrayOfTableViewContentModel)
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func fetchData(){
        let token = UserDefaults.standard.value(forKey: "tokenKey")!
        print("tokenKey=-=-=",token)
        
        let calculatedTimeStamp = Double(Date().timeIntervalSince1970 * 1000)
        print("timestamp@#@#$",calculatedTimeStamp)
        Alamofire.request("http://192.168.0.17:3000/readDashboardData?token=\(token)&timeStamp=\(calculatedTimeStamp)").responseJSON
            { response in
                print("value----",response.result.value)
                
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
                    self.protocolDashBoardController?.fetchedDataFromDashBoardService(dashBoardContent)
                    
                }
        }
        
        
        
    }
}
