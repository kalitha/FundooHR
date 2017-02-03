//
//  FalloutTotalEmployees.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 07/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class TotalEmployees: NSObject {
    var mUnmarkedEmployee : Int?
    var mTotalEmployee : Int?
    var mTimeStamp : String?
    
    init(unmarkedEmployee:Int, totalEmployee:Int, timeStamp:String) {
        self.mTotalEmployee = totalEmployee
        self.mUnmarkedEmployee = unmarkedEmployee
        self.mTimeStamp = timeStamp
    }
}
