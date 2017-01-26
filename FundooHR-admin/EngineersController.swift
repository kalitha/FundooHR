//
//  EngineersController.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 19/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class EngineersController: NSObject,EngineersControllerProtocol {
    var engineersServiceObj : EngineersService?
    var protocolEngineersViewModel : EngineersviewModelProtocol?
    
    func fetchNumOfRows(){
        engineersServiceObj = EngineersService()
        engineersServiceObj?.protocolEngineersController = self
        let engineerModelArray = [EngineersModel]()
        engineersServiceObj?.fetchData()
    }
    
    func dataFetchedFromService(data:[EngineersModel]){
        protocolEngineersViewModel?.dataFetchedFromController(data: data)
    }
}
