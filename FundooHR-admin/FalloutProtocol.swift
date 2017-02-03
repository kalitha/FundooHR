//
//  FalloutProtocol.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 03/02/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

//protocol of FalloutViewController
protocol FalloutVCProtocol {
    func falloutTableviewReload()
    func falloutCollectionviewReload()
    func fetchedDataFromSendEmailFunctionInViewModel(status:Int)
}

//protocol of FalloutViewModel
protocol FalloutViewModelProtocol {
    func tableViewContentsFetchedFromController(data:[TableViewContentModel])
    func dataFetchedFromFalloutController(_ data: [EmployeeDetails],falloutTotalEmployeesObj:TotalEmployees)
    func fetchedDataFromSendEmailFunctionInController(status:Int)
}

//protocol of FalloutController
protocol FalloutControllerProtocol {
    func tableViewContentsFetchedFromService(data:[TableViewContentModel])
    func dataFetchedFromFalloutService(_ data: [EmployeeDetails],falloutTotalEmployeesObj:TotalEmployees)
    func fetchedDataFromSendEmailFunctionInService(status:Int)
}
