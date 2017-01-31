//
//  AttendanceSummaryController.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 29/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class AttendanceSummaryController: NSObject,AttendanceSummaryProtocol {
    
    //create variable of type AttendanceSummaryProtocol
    var mAttendanceSummaryProtocolObj : AttendanceSummaryProtocol?
    
    //create variable of type AttendanceSummaryService
    var mAttendanceSummaryServiceObj : AttendanceSummaryService?
    
    init(pAttendanceSummaryProtocolObj : AttendanceSummaryProtocol) {
        mAttendanceSummaryProtocolObj = pAttendanceSummaryProtocolObj
    }

    //rest call to fetch tableview's data
    func fetchTableViewContentsFromService(){
        let lArrayOfTableViewContentModel = [TableViewContentModel]()
         mAttendanceSummaryServiceObj = AttendanceSummaryService(pAttendanceSummaryProtocolObj: self)
        mAttendanceSummaryServiceObj?.fetchTableViewContents()

    }
    
    //fetching the tableview contents
    func tableViewContentsFetchedFromRestCall(data:[TableViewContentModel]){
        mAttendanceSummaryProtocolObj?.tableViewContentsFetchedFromRestCall(data: data)
          }
    
    //making rest call to fetch collection view cells
    func fetchNumberOfCellsFromService(){
        mAttendanceSummaryServiceObj = AttendanceSummaryService(pAttendanceSummaryProtocolObj: self)
        let lArrayOfAttendanceEmployees = [EmployeeDetails]()
        
        if(lArrayOfAttendanceEmployees.count == 0){
            mAttendanceSummaryServiceObj?.fetchData()
        }
    }
    
    //fetching collection view cells from rest call
    func dataFetchedFromTheRestCall(_ data:[EmployeeDetails],totalEmployeesObj:TotalEmployees){
        self.mAttendanceSummaryProtocolObj?.dataFetchedFromTheRestCall(data, totalEmployeesObj: totalEmployeesObj)
        }

    //rest call to send mail
    func makingRestCallToSendMail(){
        mAttendanceSummaryServiceObj = AttendanceSummaryService(pAttendanceSummaryProtocolObj: self)
        mAttendanceSummaryServiceObj?.sendEmailToUnmarkedEmployees()
    }
    
    //fetching the status after sending mail
    func fetchedStatusAfterSendingMail(status: Int){
        mAttendanceSummaryProtocolObj?.fetchedStatusAfterSendingMail(status: status)
    }
}
