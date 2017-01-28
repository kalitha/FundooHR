//
//  DashBoardController.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 02/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class DashBoardController: NSObject,DashBoardControllerProtocol{
    
    //create variable of type DashBoardViewModelProtocol
    var mProtocolDashBoardViewModel : DashBoardViewModelProtocol?
    //create variable of type DashBoardService
    var mDashBoardServiceObj : DashBoardService?
    
    init(pDashBoardViewModelProtocolObj : DashBoardViewModelProtocol) {
        mProtocolDashBoardViewModel = pDashBoardViewModelProtocolObj
        }
    
    //making the rest call to fetch tableview contents from api
    func fetchTableViewContentsFromService(){
        let arrayOfTableViewContentModel = [TableViewContentModel]()
        let dashBoardServiceObj = DashBoardService(pDashBoardControllerProtocolObj: self)
            dashBoardServiceObj.fetchTableViewContents()
    }
    
    //storing the fetched tableview data in a variable and increasing the ResponseCountForTableView
    func tableViewContentsFetchedFromService(data:[TableViewContentModel]){
        mProtocolDashBoardViewModel?.tableViewContentsFetchedFromController(data: data)
    }
    
    //making rest call to fetch data of collectionview cells from api
    func fetchDataFromDashBoardService(){
        let dashBoardServiceObj = DashBoardService(pDashBoardControllerProtocolObj: self)
        dashBoardServiceObj.fetchData()
    }
    
    //sending fetched data to the view model
    func fetchedDataFromDashBoardService(_ dashBoardData: DashBoard){
        mProtocolDashBoardViewModel?.dataFetchedFromDashBoardController(dashBoardData)
    }
}
