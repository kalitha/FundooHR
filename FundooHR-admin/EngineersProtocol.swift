//
//  EngineersProtocol.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 03/02/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

//protocol of EngineersController
protocol EngineersControllerProtocol{
    func dataFetchedFromService(data:[EngineersModel])
}

//protocol of Engineers viewModel
protocol EngineersviewModelProtocol{
    func dataFetchedFromController(data:[EngineersModel])
    
}

//protocol of enginners 
protocol EngineersVCProtocol {
    func tableviewReload()
}
