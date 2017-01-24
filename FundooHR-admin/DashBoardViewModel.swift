//
//  DashBoardViewModel.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 02/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class DashBoardViewModel: NSObject,CallBackInDashBoardViewModel {
    
    var mArrayOfTableViewContentModel = [TableViewContentModel]()
    var protocolDashBoardViewController : CallBackInDashBoardVC?
    var dashBoardContents : DashBoard?
    var responseCount = 0
    var countForCollectionview = 0
    var responseCountForTableView = 0
    var count = 0
    var dashBoardControllerObj : DashBoardController?
    
        
   init(pCallBackInDashBoardVC : CallBackInDashBoardVC) {
    protocolDashBoardViewController = pCallBackInDashBoardVC
    }
    
    
    func fetchTableViewContentsFromController()->Int{
        dashBoardControllerObj = DashBoardController(pCallBackInDashBoardViewModel: self)
            if(self.count==0){
                dashBoardControllerObj?.fetchTableViewContentsFromService()
                count += 1
        }
        return mArrayOfTableViewContentModel.count
        
    }
    
    func contentAtEachRow(i:Int)->String{
        var contentInIndex : TableViewContentModel?
        
        contentInIndex = mArrayOfTableViewContentModel[i]
        
        print("content in index=",contentInIndex! )
        let name = contentInIndex?.rowName
        
        return name!

    }
    
    func tableViewContentsFetchedFromController(data:[TableViewContentModel]){
        responseCountForTableView = 7
        mArrayOfTableViewContentModel = data
        
        //self.protocolDashBoardViewController?.tableviewReload()
            
        fetchDataFromDashBoardController()
    }
    
    func fetchDataFromDashBoardController()->Int{
        dashBoardControllerObj = DashBoardController(pCallBackInDashBoardViewModel: self)
        print("countForCollectionview=-=-=-=",countForCollectionview)
        if(countForCollectionview == 0){
            dashBoardControllerObj?.fetchDataFromDashBoardService()
            countForCollectionview+=1
        }
        return responseCount
    }

    
    
    func dataFetchedFromDashBoardController(_ dashBoardData: DashBoard){
        responseCount = 6
        dashBoardContents = dashBoardData
        protocolDashBoardViewController?.dashBoardCollectionviewreload()
    }
}
