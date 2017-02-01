//
//  DashBoardViewModel.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 02/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class DashBoardViewModel: NSObject,DashBoardViewModelProtocol {
    
    //model type array of tableviewcontents
    var mArrayOfTableViewContentModel = [TableViewContentModel]()
    
    //variable of type dashboardViewcontroller protocol
    var mProtocolDashBoardViewController : DashBoardVCProtocol?
    
    //variable of type dashboard model
    var mDashBoardContents : DashBoard?
    
    //response count is used to get the count of cells fetched from rest api
    var mResponseCount = 0
    
    //used to hold collectionview count
    var mCountForCollectionview = 0
    
    //used to hold tableview count
    var mResponseCountForTableView = 0
    var mCount = 0
    
    //variable of type DashBoardController
    var mDashBoardControllerObj : DashBoardController?
    
    //constructor with aurgument of type dashboardviewcontroller protocol
    init(pDashBoardVCProtocolObj : DashBoardVCProtocol) {
        mProtocolDashBoardViewController = pDashBoardVCProtocolObj
    }
    
    //making the rest call to fetch tableview contents from api
    func fetchTableViewContentsFromController()->Int{
        // init controller object
        mDashBoardControllerObj = DashBoardController(pDashBoardViewModelProtocolObj: self)
        if(self.mCount==0){
            mDashBoardControllerObj?.fetchTableViewContentsFromService()
            mCount += 1
        }
        return mArrayOfTableViewContentModel.count
        
    }
    
    //used to retriew content at each row of tableview
    func contentAtEachRow(i:Int)->String{
        var contentInIndex : TableViewContentModel?
        
        contentInIndex = mArrayOfTableViewContentModel[i]
        
        print("content in index=",contentInIndex! )
        let name = contentInIndex?.mRowName
        
        return name!
    }
    
    //storing the fetched tableview data in a variable and increasing the ResponseCountForTableView
    func tableViewContentsFetchedFromController(data:[TableViewContentModel]){
        let path = Bundle.main.path(forResource: "UrlPlist", ofType: "plist")
        if let urlDictionary = NSDictionary(contentsOfFile: path!){
            mResponseCountForTableView = urlDictionary["tableViewCellCount"] as! Int
        }
        
        mArrayOfTableViewContentModel = data
        fetchDataFromDashBoardController()
    }
    
    //making rest call to fetch data of collectionview cells from api
    func fetchDataFromDashBoardController()->Int{
        mDashBoardControllerObj = DashBoardController(pDashBoardViewModelProtocolObj: self)
        print("countForCollectionview=-=-=-=",mCountForCollectionview)
        if(mCountForCollectionview == 0){
            mDashBoardControllerObj?.fetchDataFromDashBoardService()
            mCountForCollectionview+=1
        }
        return mResponseCount
    }
    
    //storing the fetched data of collectionview cells in variable of type dashboard model
    func dataFetchedFromDashBoardController(_ dashBoardData: DashBoard){
        let path = Bundle.main.path(forResource: "UrlPlist", ofType: "plist")
        if let urlDictionary = NSDictionary(contentsOfFile: path!){
            mResponseCount = urlDictionary["dashBoardCollectionViewCellCount"] as! Int
        }
        mDashBoardContents = dashBoardData
        mProtocolDashBoardViewController?.dashBoardCollectionviewreload()
    }
}
