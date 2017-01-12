//
//  Fallout.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 05/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class Fallout: NSObject {
    var employeeName : String?
    var employeeStatus :String?
    var company :String?
    var emailId : String?
    var mobile : String?
    var blStartDate : String?
    var companyJoinDate : String?
    var companyLeaveDate : String?
    var leaveTaken : Int?
    var falloutEmployee : Int?
    var totalEmployee : Int?
    
    init(employeeName: String, employeeStatus: String, company: String, emailId: String, mobile: String, blStartDate: String, companyJoinDate: String, companyLeaveDate: String, leaveTaken: Int) {
        self.employeeName = employeeName
        self.employeeStatus = employeeStatus
        self.company = company
        self.emailId = emailId
        self.mobile = mobile
        self.blStartDate = blStartDate
        self.companyJoinDate = companyJoinDate
        self.companyLeaveDate = companyLeaveDate
        self.leaveTaken = leaveTaken
        }
}
