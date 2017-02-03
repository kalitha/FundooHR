//
//  LeaveSummaryProtocol.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 03/02/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

//protocol of LeaveSummaryVC
protocol LeaveSummaryVCProtocol {
    func reload()
    func leaveSummaryTableviewReload()
    func fetchedDataFromSendEmailFunctionInViewModel(status:Int)
}

//protocol of LeaveSummaryViewModel
protocol LeaveSummaryViewModelProtocol {
    func dataFetchedFromController(data:[EmployeeDetails],leaveSummaryTotalEmployees:TotalEmployees)
    func fetchedDataFromSendEmailFunctionInController(status:Int)
    func tableViewContentsFetchedFromRestCall(data:[TableViewContentModel])
}

//protocol of LeaveSummaryController
protocol LeaveSummaryControllerProtocol{
    func dataFetchedFromService(data:[EmployeeDetails],leaveSummaryTotalEmployees:TotalEmployees)
    func fetchedDataFromSendEmailFunctionInService(status:Int)
    func tableViewContentsFetchedFromRestCall(data:[TableViewContentModel])
}
