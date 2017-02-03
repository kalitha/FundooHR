//
//  AttendanceSummaryProtocol.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 03/02/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

//protocol of AttendanceSummaryViewcontroller
protocol AttendanceSummaryVCProtocol {
    func attendanceSummaryCollectionViewReload()
    func attendanceSummaryTableviewReload()
    func fetchedStatusAfterSendingMail(status:Int)
}

//protocol of AttendanceSummary
protocol AttendanceSummaryProtocol{
    func tableViewContentsFetchedFromRestCall(data:[TableViewContentModel])
    func dataFetchedFromTheRestCall(_ data:[EmployeeDetails],totalEmployeesObj:TotalEmployees)
    func fetchedStatusAfterSendingMail(status:Int)
}
