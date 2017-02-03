//
//  FalloutController.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 05/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class FalloutController: NSObject,FalloutControllerProtocol {
    
    //creating variable of type FalloutViewModelProtocol
    var mFalloutViewModelProtocolObj : FalloutViewModelProtocol?
    
    //create variable of type FalloutService
    var mFalloutServiceObj : FalloutService?
    
    init(pFalloutViewModelProtocolObj : FalloutViewModelProtocol) {
        mFalloutViewModelProtocolObj = pFalloutViewModelProtocolObj
    }
    
    //rest call to fetch tableview's data
    func fetchTableViewContentsFromService(){
        let falloutServiceObj = FalloutService(pFalloutControllerProtocolObj: self)
        falloutServiceObj.fetchTableViewContents()
    }
    
    //fetching the tableview contents
    func tableViewContentsFetchedFromService(data:[TableViewContentModel]){
        mFalloutViewModelProtocolObj?.tableViewContentsFetchedFromController(data: data)
    }
    
    //making rest call to fetch collection view cells
    func fetchNumberOfCellsFromFalloutService(){
        mFalloutServiceObj = FalloutService(pFalloutControllerProtocolObj: self)
        let arrayOfFalloutEmployees = [EmployeeDetails]()
        if(arrayOfFalloutEmployees.count == 0){
            mFalloutServiceObj?.fetchData()
        }
    }
    
    //fetching collection view cells from rest call
    func dataFetchedFromFalloutService(_ data:[EmployeeDetails],falloutTotalEmployeesObj:TotalEmployees){
        self.mFalloutViewModelProtocolObj?.dataFetchedFromFalloutController(data,falloutTotalEmployeesObj: falloutTotalEmployeesObj)
    }
    
    //rest call to send mail
    func callSendEmailFunctionInService(){
        mFalloutServiceObj = FalloutService(pFalloutControllerProtocolObj: self)
        mFalloutServiceObj?.sendEmailToEmployeesTakenLeave()
    }
    
    //fetching the status after sending mail
    func fetchedDataFromSendEmailFunctionInService(status:Int){
        mFalloutViewModelProtocolObj?.fetchedDataFromSendEmailFunctionInController(status: status)
    }
}
