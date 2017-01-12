//
//  DashBoardViewModel.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 02/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class DashBoardViewModel: NSObject,CallBackInDashBoardViewModel {
    
    var protocolDashBoardViewController : CallBackInDashBoardVC?
    var marked : Int?
    var unmarked : NSString?
    var falloutEmployee : Int?
    var totalEmployee : Int?
    var leave : NSString?
    var responseCount = 0
    var count = 0
    var timeStamp : CLong?
    
    func fetchDataFromDashBoardController(token: String)->Int{
        let dashBoardControllerObj = DashBoardController()
        dashBoardControllerObj.protocolDashBoardViewModel = self
        if(count == 0){
            dashBoardControllerObj.fetchDataFromDashBoardService(token: token)
            count+=1
        }
        return responseCount
    }
    
    
    func dataFetchedFromDashBoardController(_ dashBoardData: DashBoard){
        responseCount = 6
        marked = dashBoardData.marked
        unmarked = dashBoardData.unmarked
        falloutEmployee = dashBoardData.falloutEmployee
        totalEmployee = dashBoardData.totalEmployee
        leave = dashBoardData.leave
        timeStamp = dashBoardData.timeStamp
        protocolDashBoardViewController?.reload()
    }
}
