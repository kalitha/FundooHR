//
//  EngineersViewModel.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 19/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class EngineersViewModel: NSObject,EngineersviewModelProtocol {
    
    var engineersModelArray = [EngineersModel]()
    var engineersControllerObj : EngineersController?
    var count = 0
    var protocolEngineersVC : EngineersVCProtocol?
    
    func fetchNumberOfRows()->Int{
        engineersControllerObj = EngineersController()
        engineersControllerObj?.protocolEngineersViewModel = self
        
        if(engineersModelArray.count==0){//when arrayOfTeams.count=0 then make a rest call
            if(self.count==0){
                engineersControllerObj?.fetchNumOfRows()
                count += 1
            }
        }
        print("engineersModelArray count=-=-=-",engineersModelArray)
        return engineersModelArray.count
    }
    
    func contentAtEachRow(i:Int)->String{
        var contentInIndex : EngineersModel?
        
        contentInIndex = engineersModelArray[i]
        let name = contentInIndex?.rowName
        
        return name!
    }
    
    
    func dataFetchedFromController(data:[EngineersModel]){
        engineersModelArray = data// here the data is taken from the i/p arg and stors in arrayOfTeams
        print("engineersModelArray count=--=-",engineersModelArray.count)
        self.protocolEngineersVC?.tableviewReload()
    }
}

