//
//  FalloutViewModel.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 05/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class FalloutViewModel: NSObject,CallBackInFalloutViewModel{
    var protocolFalloutVC : CallBackInFalloutVC?
    var arrayOfFalloutEmployees = [Fallout]()
    let falloutControllerObj = FalloutController()
    var totalEmployeeVariable : Int?
    var falloutNumberVariable : Int?
    
    func fetchNumberOfCellsFromFalloutController(token:String)->Int{
        falloutControllerObj.protocolFalloutViewModel = self
        
        if(arrayOfFalloutEmployees.count == 0){
            falloutControllerObj.fetchNumberOfCellsFromFalloutService(token:token)
        }
        return arrayOfFalloutEmployees.count
    }
    func dataFetchedFromFalloutController(_ data:[Fallout],totalEmployeeValue:Int,falloutNumberValue:Int){
        arrayOfFalloutEmployees = data
        totalEmployeeVariable = totalEmployeeValue
        falloutNumberVariable = falloutNumberValue
        protocolFalloutVC?.reload()
    }
}



