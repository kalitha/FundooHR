//
//  CallBackProtocol.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 03/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import Foundation
import UIKit
protocol DashBoardControllerProtocol {
    func fetchedDataFromDashBoardService(_ dashBoardData: DashBoard)
    func tableViewContentsFetchedFromService(data:[TableViewContentModel])
    
}

protocol DashBoardViewModelProtocol{
    func dataFetchedFromDashBoardController(_ dashBoardData: DashBoard)
    func tableViewContentsFetchedFromController(data:[TableViewContentModel])
    
}

    protocol DashBoardVCProtocol {
        func dashBoardCollectionviewreload()
        func tableviewReload()
    }

protocol FalloutControllerProtocol {
    func tableViewContentsFetchedFromService(data:[TableViewContentModel])
    func dataFetchedFromFalloutService(_ data: [Fallout],falloutTotalEmployeesObj:FalloutTotalEmployees)
    func employeeImageUrlFetchedFromService(url:[FalloutImageModel])
    func imageFetchedFromService(image: UIImage, index: Int)
}

protocol FalloutViewModelProtocol {
     func tableViewContentsFetchedFromController(data:[TableViewContentModel])
    func dataFetchedFromFalloutController(_ data: [Fallout],falloutTotalEmployeesObj:FalloutTotalEmployees)
    func employeeImageUrlFetchedFromController(data:[FalloutImageModel])
    func imageFetchedFromController(image: UIImage, index: Int)
    }

protocol FalloutVCProtocol {
    func falloutTableviewReload()
    func falloutCollectionviewReload()
}

protocol LoginViewModelProtocol {
    func fetchTokenFromController(_ status:Int)
}

protocol LoginControllerProtocol{
    func fetchTokenFromService(_ status:Int)
}

protocol EngineersControllerProtocol{
    func dataFetchedFromService(data:[EngineersModel])
}

protocol EngineersviewModelProtocol{
    func dataFetchedFromController(data:[EngineersModel])
}

protocol EngineersVCProtocol {
    func tableviewReload()
    }
protocol LeaveSummaryControllerProtocol{
    func dataFetchedFromService(data:[LeaveSummary],leaveSummaryTotalEmployees:LeaveSummaryTotalEmployees)
    func employeeImageUrlFetchedFromService(url:[LeaveSummaryEmployeeImageModel])
    func imageFetchedFromService(image: UIImage, index: Int)
}
protocol LeaveSummaryViewModelProtocol {
    func dataFetchedFromController(data:[LeaveSummary],leaveSummaryTotalEmployees:LeaveSummaryTotalEmployees)
    func employeeImageUrlFetchedFromController(data:[LeaveSummaryEmployeeImageModel])
    func imageFetchedFromController(image: UIImage, index: Int)
}
protocol LeaveSummaryVCProtocol {
    func reload()
}
