//
//  EngineersViewModel.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 19/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class EngineersViewModel: NSObject,CallBackInEngineersviewModel {
    var engineersModelArray = [EngineersModel]()
    var engineersControllerObj : EngineersController?
    var count = 0
    var protocolEngineersVC : CallBackInEngineersVC?
    
    func fetchNumberOfRows()->Int{
        engineersControllerObj = EngineersController()
        engineersControllerObj?.protocolEngineersViewModel = self
        
        if(engineersModelArray.count==0){//when arrayOfTeams.count=0 then make a rest call
            if(self.count==0){
                engineersControllerObj?.fetchNumOfRows()
                count += 1
            }
        }
        
        return engineersModelArray.count
    }
    
    func dataFetchedFromController(data:[EngineersModel]){
        
    }
}
