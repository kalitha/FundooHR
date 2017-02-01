//
//  LeaveSummaryController.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 20/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class LeaveSummaryController: NSObject ,LeaveSummaryControllerProtocol{
    
    //create variable of type LeavesummaryService
    var leaveSummaryServiceObj : LeavesummaryService?
    
    //create variable of type LeaveSummaryViewModelProtocol
    var protocolLeaveSummaryViewModelObj : LeaveSummaryViewModelProtocol?
    
    init(pLeaveSummaryViewModelProtocolObj : LeaveSummaryViewModelProtocol) {
        protocolLeaveSummaryViewModelObj = pLeaveSummaryViewModelProtocolObj
    }
    
    //rest call to fetch tableview's data
    func fetchTableViewContentsFromService(){
        let lArrayOfTableViewContentModel = [TableViewContentModel]()
        leaveSummaryServiceObj = LeavesummaryService(pLeaveSummaryProtocolObj: self)
        leaveSummaryServiceObj?.fetchTableViewContents()
    }
    
    //fetching the tableview contents
    func tableViewContentsFetchedFromRestCall(data:[TableViewContentModel]){
        protocolLeaveSummaryViewModelObj?.tableViewContentsFetchedFromRestCall(data: data)
    }
    
    func fetchNumberOFCellsFromService(){
        leaveSummaryServiceObj = LeavesummaryService(pLeaveSummaryProtocolObj: self)
        // leaveSummaryServiceObj?.protocolLeaveSummaryControllerObj = self
        let arrayOfLeaveEmployees = [EmployeeDetails]()
        leaveSummaryServiceObj?.fetchData()
    }
    func dataFetchedFromService(data:[EmployeeDetails],leaveSummaryTotalEmployees:TotalEmployees){
        self.protocolLeaveSummaryViewModelObj?.dataFetchedFromController(data: data, leaveSummaryTotalEmployees: leaveSummaryTotalEmployees)
    }
    // ----====----- FETCHING IMAGE -----=====----
    func fetchEmployeeImageUrlFromService(){
        leaveSummaryServiceObj = LeavesummaryService(pLeaveSummaryProtocolObj: self)
        //leaveSummaryServiceObj?.protocolLeaveSummaryController = self
        leaveSummaryServiceObj?.fetchEmployeeImageUrlFromFirebase()
    }
    
    func employeeImageUrlFetchedFromService(url:[LeaveSummaryEmployeeImageModel]){
        self.protocolLeaveSummaryViewModelObj?.employeeImageUrlFetchedFromController(data: url)
    }
    
    func fetchImageFromService(_ image:[LeaveSummaryEmployeeImageModel]){
        leaveSummaryServiceObj = LeavesummaryService(pLeaveSummaryProtocolObj: self)
        //leaveSummaryServiceObj?.protocolLeaveSummaryController = self
        leaveSummaryServiceObj?.fetchEmployeeImage(image)
    }
    func imageFetchedFromService(image: UIImage, index: Int){
        self.protocolLeaveSummaryViewModelObj?.imageFetchedFromController(image: image, index: index)
    }
    
    func callSendEmailFunctionInService(){
        leaveSummaryServiceObj = LeavesummaryService(pLeaveSummaryProtocolObj: self)
        //leaveSummaryServiceObj?.protocolLeaveSummaryController = self
        leaveSummaryServiceObj?.sendEmailToEmployeesTakenLeave()
    }
    func fetchedDataFromSendEmailFunctionInService(status:Int){
        protocolLeaveSummaryViewModelObj?.fetchedDataFromSendEmailFunctionInController(status: status)
    }
}
