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
    
    init(pCallBackInDashBoardViewModel : CallBackInDashBoardViewModel) {
        protocolDashBoardViewModel = pCallBackInDashBoardViewModel
    }
    
    func fetchDataFromDashBoardService(_ token: String){
        let dashBoardServiceObj = DashBoardService(pCallBackInDashBoardController: self)
                dashBoardServiceObj.fetchData(token)
    }
    
    //sending fetched data to the view model
    func fetchedDataFromDashBoardService(_ dashBoardData: DashBoard){
        protocolDashBoardViewModel?.dataFetchedFromDashBoardController(dashBoardData)
    }
}
