//
//  LeaveSummaryViewModel.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 20/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class LeaveSummaryViewModel: NSObject,LeaveSummaryViewModelProtocol {
    var arrayOfLeaveSummaryEmployeeImageModel = [LeaveSummaryEmployeeImageModel]()
    var leaveSummaryVCObj : LeaveSummaryVC?
    var count = 0
    var countOfFetchedImages = 0
    var arrayOfImages = [UIImage]()
    var arrayOfLeaveEmployees = [LeaveSummary]()
    var leaveSummaryControllerObj : LeaveSummaryController?
    var protocolLeaveSummaryVC : LeaveSummaryVCProtocol?
    var leaveSummaryTotalEmployeesContent : LeaveSummaryTotalEmployees?
    var arrayOfLeaveSummaryEmployeeImages = [LeaveSummaryEmployeeImageModel]()
    
    func fetchDataFromController(token:String)->Int{
        leaveSummaryControllerObj = LeaveSummaryController()
        leaveSummaryControllerObj?.protocolLeaveSummaryViewModel = self
        if(arrayOfLeaveEmployees.count == 0){
            if(self.count == 0){
                leaveSummaryControllerObj?.fetchNumberOFCellsFromService(token: token)
                count += 1
            }
        }
        return arrayOfLeaveEmployees.count
    }
    func dataFetchedFromController(data:[LeaveSummary],leaveSummaryTotalEmployees:LeaveSummaryTotalEmployees){
        arrayOfLeaveEmployees = data
        leaveSummaryTotalEmployeesContent = leaveSummaryTotalEmployees
        //self.protocolLeaveSummaryVC?.reload()
        leaveSummaryControllerObj?.fetchEmployeeImageUrlFromService()
    }
    
    func employeeImageUrlFetchedFromController(data:[LeaveSummaryEmployeeImageModel]){
        arrayOfLeaveSummaryEmployeeImages = data
        print("arrayOfFalloutImageModel count===--==",arrayOfLeaveSummaryEmployeeImages.count)
        for i in 0..<self.arrayOfLeaveSummaryEmployeeImages.count{
            //        print("employeeImageUrl",arrayOfFalloutImageModel[i].employeeImageUrl)
            //        print("employeeName",arrayOfFalloutImageModel[i].employeeName)
            let image = #imageLiteral(resourceName: "dummyImage")
            arrayOfImages.append(image)
        }
        print("arrayOfImages count=-=-==",arrayOfImages.count)
        fetchImageFromController(arrayOfLeaveSummaryEmployeeImages)
    }
    
    func fetchImageFromController(_ image: [LeaveSummaryEmployeeImageModel]){
        leaveSummaryControllerObj?.fetchImageFromService(image)
    }
    
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
                self.protocolLeaveSummaryVC?.reload()
            }
            
        }
    }
    
    func fetchEachImage(i:Int)->UIImage{
      return arrayOfImages[i]
    }
    func callSendEmailInController(){
    leaveSummaryControllerObj?.callSendEmailFunctionInService()
    }
    func fetchedDataFromSendEmailFunctionInController(status:Int){
    protocolLeaveSummaryVC?.fetchedDataFromSendEmailFunctionInViewModel(status: status)
    }

}
