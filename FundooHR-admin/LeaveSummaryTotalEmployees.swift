//
//  LeaveSummaryTotalEmployees.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 20/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class LeaveSummaryTotalEmployees: NSObject {
    var employeeLeave : Int?
    var totalEmployee : Int?
    var timeStamp : String?
    
    init(employeeLeave:Int, totalEmployee:Int, timeStamp:String) {
        self.totalEmployee = totalEmployee
        self.employeeLeave = employeeLeave
        self.timeStamp = timeStamp
    }
}
