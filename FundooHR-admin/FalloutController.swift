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
    
    //rest call to fetch tableview's data
    func fetchTableViewContentsFromService(){
        let arrayOfTableViewContentModel = [TableViewContentModel]()
        let falloutServiceObj = FalloutService(pFalloutControllerProtocolObj: self)
        falloutServiceObj.fetchTableViewContents()
    }
    
    //fetching the tableview contents
    func tableViewContentsFetchedFromService(data:[TableViewContentModel]){
        protocolFalloutViewModel?.tableViewContentsFetchedFromController(data: data)
    }
    
    //making rest call to fetch collection view cells
    func fetchNumberOfCellsFromFalloutService(){
        falloutServiceObj = FalloutService(pFalloutControllerProtocolObj: self)
        
        let arrayOfFalloutEmployees = [EmployeeDetails]()
        
        if(arrayOfFalloutEmployees.count == 0){
            falloutServiceObj?.fetchData()
        }
    }
    
    //fetching collection view cells from rest call
    func dataFetchedFromFalloutService(_ data:[EmployeeDetails],falloutTotalEmployeesObj:TotalEmployees){
        self.protocolFalloutViewModel?.dataFetchedFromFalloutController(data,falloutTotalEmployeesObj: falloutTotalEmployeesObj)
    }
    
    // ----====----- FETCHING IMAGE -----=====----
    //rest call to fetch employee url
    func fetchEmployeeImageUrlFromService(){
        
        falloutServiceObj = FalloutService(pFalloutControllerProtocolObj: self)
        falloutServiceObj?.fetchEmployeeImageUrlFromFirebase()
    }
    
    //storing the employee url fetched from rest call made to firebase
    func employeeImageUrlFetchedFromService(url:[FalloutImageModel]){
        self.protocolFalloutViewModel?.employeeImageUrlFetchedFromController(data: url)
    }
    
    //making rest call to fetch images of employees
    func fetchImageFromService(_ image:[FalloutImageModel]){
        falloutServiceObj = FalloutService(pFalloutControllerProtocolObj: self)
        falloutServiceObj?.protocolFalloutController = self
        falloutServiceObj?.fetchEmployeeImage(image)
    }
    
    //storing image fetched from rest call
    func imageFetchedFromService(image: UIImage, index: Int){
        self.protocolFalloutViewModel?.imageFetchedFromController(image: image, index: index)
    }
    
    //rest call to send mail
    func callSendEmailFunctionInService(){
        falloutServiceObj = FalloutService(pFalloutControllerProtocolObj: self)
        falloutServiceObj?.sendEmailToEmployeesTakenLeave()
    }
    
    //fetching the status after sending mail
    func fetchedDataFromSendEmailFunctionInService(status:Int){
        protocolFalloutViewModel?.fetchedDataFromSendEmailFunctionInController(status: status)
    }
}
