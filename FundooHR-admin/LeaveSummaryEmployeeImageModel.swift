//
//  LeaveSummaryEmployeeImageModel.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 20/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class LeaveSummaryEmployeeImageModel: NSObject {
    var employeeImageUrl : String?
    var employeeName : String?
    
    init(employeeImage: String, employeeName: String) {
        self.employeeImageUrl = employeeImage
        self.employeeName = employeeName
    }
}
