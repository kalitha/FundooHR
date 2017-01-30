//
//  LeaveSummaryViewModel.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 20/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class LeaveSummaryViewModel: NSObject,LeaveSummaryViewModelProtocol {
    
    //create variable of type LeaveSummaryEmployeeImageModel
    var arrayOfLeaveSummaryEmployeeImageModel = [LeaveSummaryEmployeeImageModel]()
    
    //create variable of type LeaveSummaryVC
    var leaveSummaryVCObj : LeaveSummaryVC?
    
    //initially setting the collection count to 0
    var mCountForCollectionview = 0
    
    //initially setting the count of fetched images to 0
    var countOfFetchedImages = 0
    
    //create variable of type ui images
    var arrayOfImages = [UIImage]()
    
    //create the object of type LeaveSummary
    var arrayOfLeaveEmployees = [EmployeeDetails]()
    
    //create variable of type LeaveSummaryController
    var leaveSummaryControllerObj : LeaveSummaryController?
    
    //create variable of type LeaveSummaryVCProtocol
    var mProtocolDashBoardViewControllerObj : LeaveSummaryVCProtocol?
    
    //create variable of type LeaveSummaryTotalEmployees
    var leaveSummaryTotalEmployeesContent : TotalEmployees?
    
    //create the array variable of type LeaveSummaryEmployeeImageModel
    var arrayOfLeaveSummaryEmployeeImages = [LeaveSummaryEmployeeImageModel]()
    
    init(pLeaveSummaryVCProtocolObj : LeaveSummaryVCProtocol) {
        mProtocolDashBoardViewControllerObj = pLeaveSummaryVCProtocolObj
    }
    
    //making rest call to fetch data of collectionview cells from api
    func fetchDataFromController(token:String)->Int{
        leaveSummaryControllerObj = LeaveSummaryController(pLeaveSummaryViewModelProtocolObj: self)
        //leaveSummaryControllerObj?.protocolLeaveSummaryViewModel = self
        if(mCountForCollectionview == 0){
            leaveSummaryControllerObj?.fetchNumberOFCellsFromService(token: token)
            mCountForCollectionview += 1
        }
        print("arrayOfLeaveEmployees.count",arrayOfLeaveEmployees.count)
        return arrayOfLeaveEmployees.count
    }
    
    //storing the fetched data of collectionview cells in variable of type leavesummary model
    func dataFetchedFromController(data:[EmployeeDetails],leaveSummaryTotalEmployees:TotalEmployees){
        arrayOfLeaveEmployees = data
        leaveSummaryTotalEmployeesContent = leaveSummaryTotalEmployees
        leaveSummaryControllerObj?.fetchEmployeeImageUrlFromService()
    }
    
    //storing the employee url fetched from rest call made to firebase
    func employeeImageUrlFetchedFromController(data:[LeaveSummaryEmployeeImageModel]){
        arrayOfLeaveSummaryEmployeeImages = data
        print("arrayOfFalloutImageModel count===--==",arrayOfLeaveSummaryEmployeeImages.count)
        for i in 0..<self.arrayOfLeaveSummaryEmployeeImages.count{
            let image = #imageLiteral(resourceName: "dummyImage")
            arrayOfImages.append(image)
        }
        print("arrayOfImages count=-=-==",arrayOfImages.count)
        fetchImageFromController(arrayOfLeaveSummaryEmployeeImages)
    }
    
    //making rest call to fetch images of employees
    func fetchImageFromController(_ image: [LeaveSummaryEmployeeImageModel]){
        leaveSummaryControllerObj?.fetchImageFromService(image)
    }
    
    //storing image fetched from rest call
    func imageFetchedFromController(image: UIImage, index: Int){
        countOfFetchedImages+=1
        print("index",index)
        print("countOfFetchedImages",countOfFetchedImages)
        print("arrayOfImages.count",arrayOfImages.count)
        print("arrayOfFalloutEmployees=-=-=-",arrayOfLeaveEmployees.count)
        arrayOfImages[index] = image
        if(countOfFetchedImages == arrayOfImages.count){
            //protocolFalloutVC?.reload() //reloading after getting the image
            print("arrayOfFalloutEmployees==-=-=-",arrayOfLeaveEmployees)
            DispatchQueue.main.async {
                self.mProtocolDashBoardViewControllerObj?.reload()
            }
            
        }
    }
    
    //fetching each image
    func fetchEachImage(i:Int)->UIImage{
        return arrayOfImages[i]
    }
    
    //rest call to send mail
    func callSendEmailInController(){
        leaveSummaryControllerObj?.callSendEmailFunctionInService()
    }
    
    //fetching the status after sending mail
    func fetchedDataFromSendEmailFunctionInController(status:Int){
        mProtocolDashBoardViewControllerObj?.fetchedDataFromSendEmailFunctionInViewModel(status: status)
    }
    
}
