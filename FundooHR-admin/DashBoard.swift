//
//  DashBoard.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 04/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class DashBoard: NSObject {
    var mMarked : Int?
    var mUnmarked : NSString?
    var mFalloutEmployee : Int?
    var mTotalEmployee : Int?
    var mLeave : NSString?
    var mTimeStamp : Double!
    init(marked:Int, unmarked:NSString,falloutEmployee:Int, totalEmployee:Int, leave:NSString, timeStamp:Double) {
        self.mMarked = marked
        self.mUnmarked = unmarked
        self.mFalloutEmployee = falloutEmployee
        self.mTotalEmployee = totalEmployee
        self.mLeave = leave
        self.mTimeStamp = timeStamp
    }
}
