//
//  EngineersController.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 19/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class EngineersController: NSObject,EngineersControllerProtocol {
    
    //create variable of type EngineersService
    var engineersServiceObj : EngineersService?
    
    //create variable of type EngineersviewModelProtocol
    var protocolEngineersViewModel : EngineersviewModelProtocol?
    
    func fetchNumOfRows(){
        engineersServiceObj = EngineersService()
        engineersServiceObj?.protocolEngineersController = self
        engineersServiceObj?.fetchData()
    }
    
    func dataFetchedFromService(data:[EngineersModel]){
        protocolEngineersViewModel?.dataFetchedFromController(data: data)
    }
}
