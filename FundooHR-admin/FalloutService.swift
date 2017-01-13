//
//  FalloutService.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 05/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit
import Alamofire
class FalloutService: NSObject {
    //creating the variable of falloutcontroller type
    var protocolFalloutController : CallBackInFalloutController?
    var falloutEmployeeData = [NSDictionary]()
    var arrayOfFalloutEmloyees = [Fallout]() //creating model type array
    
    func fetchData(token:String){
        let calculatedTimeStamp = Double(Date().timeIntervalSince1970 * 1000)
        print("==calculatedTimeStamp===>",calculatedTimeStamp)
        Alamofire.request("http://192.168.0.171:3000/readFalloutAttendanceEmployee?token=\(token)&timeStamp=\(calculatedTimeStamp)").responseJSON
            {response in
            if let JSON = response.result.value{
                let completeFalloutData = JSON as! NSDictionary
                print("---falloutData----",completeFalloutData)
                
                let falloutNumberValue = completeFalloutData.value(forKey: "falloutNumber") as! Int
                let totalEmployeeValue = completeFalloutData.value(forKey: "totalEmployee") as! Int
                let timeStamp = completeFalloutData.value(forKey: "timeStamp") as! String
                let falloutTotalEmployeesObj = FalloutTotalEmployees(unmarkedEmployee: falloutNumberValue, totalEmployee: totalEmployeeValue, timeStamp: timeStamp)
                let falloutEmployeeData =  completeFalloutData.value(forKey: "falloutEmployee") as! [NSDictionary]
                print("--falloutEmployeeData--",falloutEmployeeData)

                for index in 0..<falloutEmployeeData.count{
                    let valueAtEachIndex = falloutEmployeeData[index] as NSDictionary
                    let employeeNameValue = valueAtEachIndex["employeeName"] as! String
                    let employeeStatusValue = valueAtEachIndex["employeeStatus"] as! String
                    let companyValue = valueAtEachIndex["company"] as! String
                    let mobileValue = valueAtEachIndex["mobile"] as! String
                    let emailIdValue = valueAtEachIndex["emailId"] as! String
                    let blStartDateValue = valueAtEachIndex["blStartDate"] as! String
                    let companyJoinDateValue = valueAtEachIndex["companyJoinDate"] as! String
                    let companyLeaveDateValue = valueAtEachIndex["companyLeaveDate"] as! String
                    let leaveTakenValue = valueAtEachIndex["leaveTaken"] as! Int
                    let engineerIdValue = valueAtEachIndex["engineerId"] as! String 
                    let eachFalloutEmployeeObj = Fallout(employeeName: employeeNameValue, employeeStatus: employeeStatusValue, company: companyValue, emailId: emailIdValue, mobile: mobileValue, blStartDate: blStartDateValue, companyJoinDate: companyJoinDateValue, companyLeaveDate: companyLeaveDateValue, leaveTaken: leaveTakenValue, engineerId: engineerIdValue)
                    self.arrayOfFalloutEmloyees.append(eachFalloutEmployeeObj)
                    
                }
                print("---count of employees---",self.arrayOfFalloutEmloyees.count)
                self.protocolFalloutController?.dataFetchedFromFalloutService(self.arrayOfFalloutEmloyees as [Fallout],falloutTotalEmployeesObj: falloutTotalEmployeesObj )
            }
        }
    }
}
