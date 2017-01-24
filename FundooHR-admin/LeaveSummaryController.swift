//
//  LeaveSummaryController.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 20/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class LeaveSummaryController: NSObject ,CallBackInLeaveSummaryController{
    var leaveSummaryServiceObj : LeavesummaryService?
    var protocolLeaveSummaryViewModel : CallBackInLeaveSummaryViewModel?
    
    func fetchNumberOFCellsFromService(token:String){
       leaveSummaryServiceObj = LeavesummaryService()
        leaveSummaryServiceObj?.protocolLeaveSummaryController = self
        let arrayOfLeaveEmployees = [LeaveSummary]()
            leaveSummaryServiceObj?.fetchData(token: token)
    }
    func dataFetchedFromService(data:[LeaveSummary],leaveSummaryTotalEmployees:LeaveSummaryTotalEmployees){
        self.protocolLeaveSummaryViewModel?.dataFetchedFromController(data: data, leaveSummaryTotalEmployees: leaveSummaryTotalEmployees)
    }
    // ----====----- FETCHING IMAGE -----=====----
    func fetchEmployeeImageUrlFromService(){
        leaveSummaryServiceObj = LeavesummaryService()
        leaveSummaryServiceObj?.protocolLeaveSummaryController = self
        leaveSummaryServiceObj?.fetchEmployeeImageUrlFromFirebase()
    }
    
    func employeeImageUrlFetchedFromService(url:[LeaveSummaryEmployeeImageModel]){
        self.protocolLeaveSummaryViewModel?.employeeImageUrlFetchedFromController(data: url)
    }
    
    func fetchImageFromService(_ image:[LeaveSummaryEmployeeImageModel]){
        leaveSummaryServiceObj = LeavesummaryService()
        leaveSummaryServiceObj?.protocolLeaveSummaryController = self
        leaveSummaryServiceObj?.fetchEmployeeImage(image)
    }
    func imageFetchedFromService(image: UIImage, index: Int){
        self.protocolLeaveSummaryViewModel?.imageFetchedFromController(image: image, index: index)
    }
}
