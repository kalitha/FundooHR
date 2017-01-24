//
//  CallBackProtocol.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 03/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import Foundation
import UIKit
protocol CallBackInDashBoardController {
    func fetchedDataFromDashBoardService(_ dashBoardData: DashBoard)
    func tableViewContentsFetchedFromService(data:[TableViewContentModel])
    
}

protocol CallBackInDashBoardViewModel{
    func dataFetchedFromDashBoardController(_ dashBoardData: DashBoard)
    func tableViewContentsFetchedFromController(data:[TableViewContentModel])
    
}

    protocol CallBackInDashBoardVC {
        func dashBoardCollectionviewreload()
        func tableviewReload()
    }

protocol CallBackInFalloutController {
    func tableViewContentsFetchedFromService(data:[TableViewContentModel])
    func dataFetchedFromFalloutService(_ data: [Fallout],falloutTotalEmployeesObj:FalloutTotalEmployees)
    func employeeImageUrlFetchedFromService(url:[FalloutImageModel])
    func imageFetchedFromService(image: UIImage, index: Int)
}

protocol CallBackInFalloutViewModel {
     func tableViewContentsFetchedFromController(data:[TableViewContentModel])
    func dataFetchedFromFalloutController(_ data: [Fallout],falloutTotalEmployeesObj:FalloutTotalEmployees)
    func employeeImageUrlFetchedFromController(data:[FalloutImageModel])
    func imageFetchedFromController(image: UIImage, index: Int)
    }

protocol CallBackInFalloutVC {
    func falloutTableviewReload()
    func falloutCollectionviewReload()
}

protocol CallBackInLoginViewModel {
    func fetchTokenFromController(_ status:Int, token:String)
}

protocol CallBackInLoginController {
    func fetchTokenFromService(_ status:Int, token:String)
}

protocol CallBackInEngineersController {
    func dataFetchedFromService(data:[EngineersModel])
}

protocol CallBackInEngineersviewModel {
    func dataFetchedFromController(data:[EngineersModel])
}

protocol CallBackInEngineersVC {
    func tableviewReload()
    }
protocol CallBackInLeaveSummaryController{
    func dataFetchedFromService(data:[LeaveSummary],leaveSummaryTotalEmployees:LeaveSummaryTotalEmployees)
    func employeeImageUrlFetchedFromService(url:[LeaveSummaryEmployeeImageModel])
    func imageFetchedFromService(image: UIImage, index: Int)
}
protocol CallBackInLeaveSummaryViewModel {
    func dataFetchedFromController(data:[LeaveSummary],leaveSummaryTotalEmployees:LeaveSummaryTotalEmployees)
    func employeeImageUrlFetchedFromController(data:[LeaveSummaryEmployeeImageModel])
    func imageFetchedFromController(image: UIImage, index: Int)
}
protocol CallBackInLeaveSummaryVC {
    func reload()
}
