//
//  EngineersController.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 19/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class EngineersController: NSObject,CallBackInEngineersController {
    var engineersServiceObj : EngineersService?
    var protocolEngineersViewModel : CallBackInEngineersviewModel?
    func fetchNumOfRows(){
        engineersServiceObj = EngineersService()
        engineersServiceObj?.protocolEngineersController = self
        let engineerModelArray = [EngineersModel]()
        
        if(engineerModelArray.count == 0){
        engineersServiceObj?.fetchData()
        }
    }
    
    func dataFetchedFromService(data:[EngineersModel]){
        
    }
}
