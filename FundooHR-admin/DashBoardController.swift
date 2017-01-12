//
//  DashBoardController.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 02/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class DashBoardController: NSObject,CallBackInDashBoardController{
    
    var protocolDashBoardViewModel : CallBackInDashBoardViewModel?
    
    func fetchDataFromDashBoardService(token: String){
        let dashBoardServiceObj = DashBoardService()
        dashBoardServiceObj.protocolDashBoardController = self
        dashBoardServiceObj.fetchData(token: token)
    }
    
    //sending fetched data to the view model
    func fetchedDataFromDashBoardService(_ dashBoardData: DashBoard){
        self.protocolDashBoardViewModel?.dataFetchedFromDashBoardController(dashBoardData)
    }
}
