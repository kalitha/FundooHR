//
//  FalloutController.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 05/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class FalloutController: NSObject,CallBackInFalloutController {
    var protocolFalloutViewModel : CallBackInFalloutViewModel?
    var falloutServiceObj : FalloutService?
    
    func fetchNumberOfCellsFromFalloutService(_ token:String){
          falloutServiceObj = FalloutService()
        falloutServiceObj?.protocolFalloutController = self
        let arrayOfFalloutEmployees = [Fallout]()
        
        if(arrayOfFalloutEmployees.count == 0){
            falloutServiceObj?.fetchData(token)
        }
    }
    
    func dataFetchedFromFalloutService(_ data:[Fallout],falloutTotalEmployeesObj:FalloutTotalEmployees){
        self.protocolFalloutViewModel?.dataFetchedFromFalloutController(data,falloutTotalEmployeesObj: falloutTotalEmployeesObj)
    }
    
   // ----====----- FETCHING IMAGE -----=====----
    func fetchEmployeeImageUrlFromService(){
     
        falloutServiceObj = FalloutService()
        falloutServiceObj?.protocolFalloutController = self
        falloutServiceObj?.fetchEmployeeImageUrlFromFirebase()
    }
    
    func employeeImageUrlFetchedFromService(url:[FalloutImageModel]){
        //FIXME:-fix leave string
        
        self.protocolFalloutViewModel?.employeeImageUrlFetchedFromController(data: url)
    }
    
    func fetchImageFromService(_ image:[FalloutImageModel]){
         falloutServiceObj = FalloutService()
        falloutServiceObj?.protocolFalloutController = self
        falloutServiceObj?.fetchEmployeeImage(image)
        
    }
    
    func imageFetchedFromService(image: UIImage, index: Int){
        
        self.protocolFalloutViewModel?.imageFetchedFromController(image: image, index: index)
    }
}
