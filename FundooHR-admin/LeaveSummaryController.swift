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
    
    func fetchNumberOFCellsFromService(token:String){
       leaveSummaryServiceObj = LeavesummaryService(pLeaveSummaryProtocolObj: self)
       // leaveSummaryServiceObj?.protocolLeaveSummaryControllerObj = self
        let arrayOfLeaveEmployees = [LeaveSummary]()
            leaveSummaryServiceObj?.fetchData(token: token)
    }
    func dataFetchedFromService(data:[LeaveSummary],leaveSummaryTotalEmployees:LeaveSummaryTotalEmployees){
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
