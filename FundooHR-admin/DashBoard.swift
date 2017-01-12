//
//  DashBoard.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 04/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class DashBoard: NSObject {
    var marked : Int?
    var unmarked : NSString?
    var falloutEmployee : Int?
    var totalEmployee : Int?
    var leave : NSString?
    var timeStamp : CLong
    init(marked:Int, unmarked:NSString,falloutEmployee:Int, totalEmployee:Int, leave:NSString, timeStamp:CLong) {
        self.marked = marked
        self.unmarked = unmarked
        self.falloutEmployee = falloutEmployee
        self.totalEmployee = totalEmployee
        self.leave = leave
        self.timeStamp = timeStamp
    }
}
