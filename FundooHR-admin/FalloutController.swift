//
//  FalloutController.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 05/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class FalloutController: NSObject,CallBackInFalloutController {
    var protocolFalloutViewModel : CallBackInFalloutViewModel?
    
    
    func fetchNumberOfCellsFromFalloutService(token:String){
        let falloutServiceObj = FalloutService()
        falloutServiceObj.protocolFalloutController = self
        let arrayOfFalloutEmployees = [Fallout]()
        
        if(arrayOfFalloutEmployees.count == 0){
            falloutServiceObj.fetchData(token : token)
        }
//        else{
//            for i in 0..<arrayOfFalloutEmployees.count{
//                let eachFalloutEmployeeObj = Fallout(employeeName: arrayOfFalloutEmployees[i].employeeName!, employeeStatus: arrayOfFalloutEmployees[i].employeeStatus!, company: arrayOfFalloutEmployees[i].company!, emailId:arrayOfFalloutEmployees[i].emailId!, mobile: arrayOfFalloutEmployees[i].mobile!, blStartDate: arrayOfFalloutEmployees[i].blStartDate!, companyJoinDate: arrayOfFalloutEmployees[i].companyJoinDate!, companyLeaveDate: arrayOfFalloutEmployees[i].companyLeaveDate!, leaveTaken: arrayOfFalloutEmployees[i].leaveTaken!)
//                
//            }
// dataFetchedFromFalloutService(data: arrayOfFalloutEmployees)
//        }
    }
    
    func dataFetchedFromFalloutService(_ data:[Fallout],totalEmployeeValue:Int,falloutNumberValue:Int){
        self.protocolFalloutViewModel?.dataFetchedFromFalloutController(data,totalEmployeeValue:totalEmployeeValue,falloutNumberValue:falloutNumberValue)
    }
    
}
