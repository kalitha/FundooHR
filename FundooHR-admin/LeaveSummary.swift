//
//  LeaveSummary.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 20/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class LeaveSummary: NSObject {
    var employeeName : String?
    var employeeStatus :String?
    var company :String?
    var emailId : String?
    var mobile : String?
    var blStartDate : String?
    var companyJoinDate : String?
    var companyLeaveDate : String?
    var leaveTaken : Int?
    var engineerId : String?
    
    init(employeeName: String, employeeStatus: String, company: String, emailId: String, mobile: String, blStartDate: String, companyJoinDate: String, companyLeaveDate: String, leaveTaken: Int, engineerId: String) {
        self.employeeName = employeeName
        self.employeeStatus = employeeStatus
        self.company = company
        self.emailId = emailId
        self.mobile = mobile
        self.blStartDate = blStartDate
        self.companyJoinDate = companyJoinDate
        self.companyLeaveDate = companyLeaveDate
        self.leaveTaken = leaveTaken
        self.engineerId  = engineerId
    }
}
