//
//  FalloutImageModel.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 16/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class FalloutImageModel: NSObject {
    var employeeImageUrl : String?
    var employeeName : String?
    
    init(employeeImage: String, employeeName: String) {
        self.employeeImageUrl = employeeImage
        self.employeeName = employeeName
    }
}
