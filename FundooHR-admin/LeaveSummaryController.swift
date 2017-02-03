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
    var mLeaveSummaryServiceObj : LeavesummaryService?
    
    //create variable of type LeaveSummaryViewModelProtocol
    var mProtocolLeaveSummaryViewModelObj : LeaveSummaryViewModelProtocol?
    
    init(pLeaveSummaryViewModelProtocolObj : LeaveSummaryViewModelProtocol) {
        mProtocolLeaveSummaryViewModelObj = pLeaveSummaryViewModelProtocolObj
    }
    
    //rest call to fetch tableview's data
    func fetchTableViewContentsFromService(){
        mLeaveSummaryServiceObj = LeavesummaryService(pLeaveSummaryProtocolObj: self)
        mLeaveSummaryServiceObj?.fetchTableViewContents()
    }
    
    //fetching the tableview contents
    func tableViewContentsFetchedFromRestCall(data:[TableViewContentModel]){
        mProtocolLeaveSummaryViewModelObj?.tableViewContentsFetchedFromRestCall(data: data)
    }
    
    //making rest call to fetch collection view cells
    func fetchNumberOFCellsFromService(){
        mLeaveSummaryServiceObj = LeavesummaryService(pLeaveSummaryProtocolObj: self)
        mLeaveSummaryServiceObj?.fetchData()
    }
    
    //fetching collection view cells from rest call
    func dataFetchedFromService(data:[EmployeeDetails],leaveSummaryTotalEmployees:TotalEmployees){
        self.mProtocolLeaveSummaryViewModelObj?.dataFetchedFromController(data: data, leaveSummaryTotalEmployees: leaveSummaryTotalEmployees)
    }
    
    //rest call to send mail
    func callSendEmailFunctionInService(){
        mLeaveSummaryServiceObj = LeavesummaryService(pLeaveSummaryProtocolObj: self)
        //leaveSummaryServiceObj?.protocolLeaveSummaryController = self
        mLeaveSummaryServiceObj?.sendEmailToEmployeesTakenLeave()
    }
    
    //fetching the status after sending mail
    func fetchedDataFromSendEmailFunctionInService(status:Int){
        mProtocolLeaveSummaryViewModelObj?.fetchedDataFromSendEmailFunctionInController(status: status)
    }
}
