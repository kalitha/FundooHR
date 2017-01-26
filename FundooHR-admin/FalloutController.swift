//
//  FalloutController.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 05/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class FalloutController: NSObject,FalloutControllerProtocol {
    var protocolFalloutViewModel : FalloutViewModelProtocol?
    var falloutServiceObj : FalloutService?
    
    init(pFalloutViewModelProtocolObj : FalloutViewModelProtocol) {
        protocolFalloutViewModel = pFalloutViewModelProtocolObj
        }
    
    func fetchTableViewContentsFromService(){
        let arrayOfTableViewContentModel = [TableViewContentModel]()
    let falloutServiceObj = FalloutService(pFalloutControllerProtocolObj: self)
        falloutServiceObj.fetchTableViewContents()
    }
    func tableViewContentsFetchedFromService(data:[TableViewContentModel]){
        protocolFalloutViewModel?.tableViewContentsFetchedFromController(data: data)
    }
    
    func fetchNumberOfCellsFromFalloutService(){
          falloutServiceObj = FalloutService(pFalloutControllerProtocolObj: self)
       
        let arrayOfFalloutEmployees = [Fallout]()
        
        if(arrayOfFalloutEmployees.count == 0){
            falloutServiceObj?.fetchData()
        }
    }
    
    func dataFetchedFromFalloutService(_ data:[Fallout],falloutTotalEmployeesObj:FalloutTotalEmployees){
        self.protocolFalloutViewModel?.dataFetchedFromFalloutController(data,falloutTotalEmployeesObj: falloutTotalEmployeesObj)
    }
    
   // ----====----- FETCHING IMAGE -----=====----
    func fetchEmployeeImageUrlFromService(){
     
        falloutServiceObj = FalloutService(pFalloutControllerProtocolObj: self)
        falloutServiceObj?.fetchEmployeeImageUrlFromFirebase()
    }
    
    func employeeImageUrlFetchedFromService(url:[FalloutImageModel]){
        self.protocolFalloutViewModel?.employeeImageUrlFetchedFromController(data: url)
    }
    
    func fetchImageFromService(_ image:[FalloutImageModel]){
        falloutServiceObj = FalloutService(pFalloutControllerProtocolObj: self)
        falloutServiceObj?.protocolFalloutController = self
        falloutServiceObj?.fetchEmployeeImage(image)
    }
    
    func imageFetchedFromService(image: UIImage, index: Int){
        self.protocolFalloutViewModel?.imageFetchedFromController(image: image, index: index)
    }
    
    func makingRestCallToSendEmailInService(){
        
    }
}
