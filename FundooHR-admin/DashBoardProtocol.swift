//
//  DashBoardProtocol.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 03/02/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

//protocol of DashDoard ViewController
protocol DashBoardVCProtocol {
    func dashBoardCollectionviewreload()
    func tableviewReload()
}

//protocol of dashboard viewmodel
protocol DashBoardViewModelProtocol{
    func dataFetchedFromDashBoardController(_ dashBoardData: DashBoard)
    func tableViewContentsFetchedFromController(data:[TableViewContentModel])
    
}

//protocol of dashboard controller
protocol DashBoardControllerProtocol {
    func fetchedDataFromDashBoardService(_ dashBoardData: DashBoard)
    func tableViewContentsFetchedFromService(data:[TableViewContentModel])
    
}
