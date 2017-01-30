//
//  CallBackProtocol.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 03/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import Foundation
import UIKit

//protocol of LoginViewController
protocol LoginVCProtocol {
    func performingNavigationToDashboard(status:Int)
}
//protocol of LoginViewModel
protocol LoginViewModelProtocol {
    func fetchStatusFromController(_ status:Int)
}

////protocol of LoginController
protocol LoginControllerProtocol{
    func fetchStatusFromService(_ status:Int)
}

//protocol of dashboard controller
protocol DashBoardControllerProtocol {
    func fetchedDataFromDashBoardService(_ dashBoardData: DashBoard)
    func tableViewContentsFetchedFromService(data:[TableViewContentModel])
    
}
//protocol of dashboard viewmodel
protocol DashBoardViewModelProtocol{
    func dataFetchedFromDashBoardController(_ dashBoardData: DashBoard)
    func tableViewContentsFetchedFromController(data:[TableViewContentModel])
    
}
//protocol of DashDoard ViewController
    protocol DashBoardVCProtocol {
        func dashBoardCollectionviewreload()
        func tableviewReload()
    }
//protocol of FalloutController
protocol FalloutControllerProtocol {
    func tableViewContentsFetchedFromService(data:[TableViewContentModel])
    func dataFetchedFromFalloutService(_ data: [EmployeeDetails],falloutTotalEmployeesObj:TotalEmployees)
    func employeeImageUrlFetchedFromService(url:[FalloutImageModel])
    func imageFetchedFromService(image: UIImage, index: Int)
    func fetchedDataFromSendEmailFunctionInService(status:Int)
}

//protocol of FalloutViewModel
protocol FalloutViewModelProtocol {
     func tableViewContentsFetchedFromController(data:[TableViewContentModel])
    func dataFetchedFromFalloutController(_ data: [EmployeeDetails],falloutTotalEmployeesObj:TotalEmployees)
    func employeeImageUrlFetchedFromController(data:[FalloutImageModel])
    func imageFetchedFromController(image: UIImage, index: Int)
    func fetchedDataFromSendEmailFunctionInController(status:Int)
    }

//protocol of FalloutViewController
protocol FalloutVCProtocol {
    func falloutTableviewReload()
    func falloutCollectionviewReload()
    func fetchedDataFromSendEmailFunctionInViewModel(status:Int)
}

//protocol of LeaveSummaryController
protocol LeaveSummaryControllerProtocol{
    func dataFetchedFromService(data:[EmployeeDetails],leaveSummaryTotalEmployees:TotalEmployees)
    func employeeImageUrlFetchedFromService(url:[LeaveSummaryEmployeeImageModel])
    func imageFetchedFromService(image: UIImage, index: Int)
    func fetchedDataFromSendEmailFunctionInService(status:Int)
}

//protocol of LeaveSummaryViewModel
protocol LeaveSummaryViewModelProtocol {
    func dataFetchedFromController(data:[EmployeeDetails],leaveSummaryTotalEmployees:TotalEmployees)
    func employeeImageUrlFetchedFromController(data:[LeaveSummaryEmployeeImageModel])
    func imageFetchedFromController(image: UIImage, index: Int)
    func fetchedDataFromSendEmailFunctionInController(status:Int)
}

//protocol of LeaveSummaryVC
protocol LeaveSummaryVCProtocol {
    func reload()
    func fetchedDataFromSendEmailFunctionInViewModel(status:Int)
}

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
//protocol of EngineersController
protocol EngineersControllerProtocol{
    func dataFetchedFromService(data:[EngineersModel])
}

protocol EngineersviewModelProtocol{
    func dataFetchedFromController(data:[EngineersModel])
    
}

protocol EngineersVCProtocol {
    func tableviewReload()
}
