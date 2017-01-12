//
//  CallBackProtocol.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 03/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import Foundation
protocol CallBackInDashBoardController {
    func fetchedDataFromDashBoardService(_ dashBoardData: DashBoard)
    
    
}

protocol CallBackInDashBoardViewModel{
    func dataFetchedFromDashBoardController(_ dashBoardData: DashBoard)
}

    protocol CallBackInDashBoardVC {
        func reload()
    }

protocol CallBackInFalloutController {
    func dataFetchedFromFalloutService(_ data: [Fallout],totalEmployeeValue:Int,falloutNumberValue:Int)
    
}

protocol CallBackInFalloutViewModel {
    func dataFetchedFromFalloutController(_ data: [Fallout],totalEmployeeValue:Int,falloutNumberValue:Int)
    
}

protocol CallBackInFalloutVC {
    func reload()
}

protocol CallBackInLoginViewModel {
    func fetchTokenFromController(status:Int, token:String)
}

protocol CallBackInLoginController {
    func fetchTokenFromService(status:Int, token:String)
}
