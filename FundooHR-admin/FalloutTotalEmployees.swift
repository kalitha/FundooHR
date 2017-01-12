//
//  FalloutTotalEmployees.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 07/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class FalloutTotalEmployees: NSObject {
    var unmarkedEmployee : Int?
    var totalEmployee : Int?
    var timeStamp : String?
    
    init(unmarkedEmployee:Int, totalEmployee:Int, timeStamp:String) {
        self.totalEmployee = totalEmployee
        self.unmarkedEmployee = unmarkedEmployee
        self.timeStamp = timeStamp
    }
}
