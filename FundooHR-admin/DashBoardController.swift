//
//  DashBoardController.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 02/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class DashBoardController: NSObject,DashBoardControllerProtocol{
    
    var protocolDashBoardViewModel : DashBoardViewModelProtocol?
    var dashBoardServiceObj : DashBoardService?
    
    init(pDashBoardViewModelProtocolObj : DashBoardViewModelProtocol) {
        protocolDashBoardViewModel = pDashBoardViewModelProtocolObj
        }
    
    func fetchTableViewContentsFromService(){
        let arrayOfTableViewContentModel = [TableViewContentModel]()
        let dashBoardServiceObj = DashBoardService(pDashBoardControllerProtocolObj: self)
            dashBoardServiceObj.fetchTableViewContents()
    }
    
    func tableViewContentsFetchedFromService(data:[TableViewContentModel]){
        protocolDashBoardViewModel?.tableViewContentsFetchedFromController(data: data)
    }
    
    func fetchDataFromDashBoardService(){
        let dashBoardServiceObj = DashBoardService(pDashBoardControllerProtocolObj: self)
        dashBoardServiceObj.fetchData()
    }
    
    //sending fetched data to the view model
    func fetchedDataFromDashBoardService(_ dashBoardData: DashBoard){
        protocolDashBoardViewModel?.dataFetchedFromDashBoardController(dashBoardData)
    }
}
