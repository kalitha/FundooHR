//
//  DashBoardService.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 02/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit
import Alamofire
class DashBoardService: NSObject {
    
    var protocolDashBoardController : CallBackInDashBoardController?
    
    func fetchData(_ token: String){
        let calculatedTimeStamp = Double(Date().timeIntervalSince1970 * 1000)
        print("timestamp@#@#$",calculatedTimeStamp)
        Alamofire.request("http://192.168.0.144:3000/readDashboardData?token=\(token)&timeStamp=\(calculatedTimeStamp)").responseJSON
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
                    //FIXME:-fix leave string
                    let leave = leaveSummary.value(forKey: "leave") as! NSString
                    
                    let dashBoardContent = DashBoard(marked: marked, unmarked: unmarked, falloutEmployee: falloutEmployee, totalEmployee: totalEmployee, leave: leave, timeStamp: timeStamp)
                    
                    //sending fetched data to controller
                    self.protocolDashBoardController?.fetchedDataFromDashBoardService(dashBoardContent)
                    
                }
        }
        
        
        
    }
}
