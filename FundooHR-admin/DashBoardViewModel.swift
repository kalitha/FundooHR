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
    var dashBoardContents : DashBoard?
    var responseCount = 0
    var count = 0
    var dashBoardControllerObj : DashBoardController?
    
   init(pCallBackInDashBoardVC : CallBackInDashBoardVC) {
    protocolDashBoardViewController = pCallBackInDashBoardVC
    }
    
    func fetchDataFromDashBoardController(_ token: String)->Int{
         dashBoardControllerObj = DashBoardController(pCallBackInDashBoardViewModel: self)
        if(count == 0){
            dashBoardControllerObj?.fetchDataFromDashBoardService(token)
            count+=1
        }
        return responseCount
    }
    
    
    func dataFetchedFromDashBoardController(_ dashBoardData: DashBoard){
        responseCount = 6
        dashBoardContents = dashBoardData
        protocolDashBoardViewController?.dashBoardCollectionviewreload()
    }
}
