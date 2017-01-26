//
//  DashBoardViewModel.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 02/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class DashBoardViewModel: NSObject,DashBoardViewModelProtocol {
    
    var mArrayOfTableViewContentModel = [TableViewContentModel]()
    var mProtocolDashBoardViewController : DashBoardVCProtocol?
    var mDashBoardContents : DashBoard?
    var mResponseCount = 0
    var mCountForCollectionview = 0
    var mResponseCountForTableView = 0
    var mCount = 0
    var mDashBoardControllerObj : DashBoardController?
    
        
   init(pCallBackInDashBoardVC : DashBoardVCProtocol) {
    mProtocolDashBoardViewController = pCallBackInDashBoardVC
    }
    
    
    func fetchTableViewContentsFromController()->Int{
        // init controller object
        mDashBoardControllerObj = DashBoardController(pDashBoardViewModelProtocolObj: self)
            if(self.mCount==0){
                mDashBoardControllerObj?.fetchTableViewContentsFromService()
                mCount += 1
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
        mResponseCountForTableView = 7
        mArrayOfTableViewContentModel = data
        
        //self.protocolDashBoardViewController?.tableviewReload()
            
        fetchDataFromDashBoardController()
    }
    
    func fetchDataFromDashBoardController()->Int{
        mDashBoardControllerObj = DashBoardController(pDashBoardViewModelProtocolObj: self)
        print("countForCollectionview=-=-=-=",mCountForCollectionview)
        if(mCountForCollectionview == 0){
            mDashBoardControllerObj?.fetchDataFromDashBoardService()
            mCountForCollectionview+=1
        }
        return mResponseCount
    }

    
    
    func dataFetchedFromDashBoardController(_ dashBoardData: DashBoard){
        mResponseCount = 6
        mDashBoardContents = dashBoardData
        mProtocolDashBoardViewController?.dashBoardCollectionviewreload()
    }
}
