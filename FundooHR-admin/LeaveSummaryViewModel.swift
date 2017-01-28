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
    var mCountForCollectionview = 0
    var countOfFetchedImages = 0
    var arrayOfImages = [UIImage]()
    var arrayOfLeaveEmployees = [LeaveSummary]()
    var leaveSummaryControllerObj : LeaveSummaryController?
    var mProtocolDashBoardViewControllerObj : LeaveSummaryVCProtocol?
    var leaveSummaryTotalEmployeesContent : LeaveSummaryTotalEmployees?
    var arrayOfLeaveSummaryEmployeeImages = [LeaveSummaryEmployeeImageModel]()
    
    init(pLeaveSummaryVCProtocolObj : LeaveSummaryVCProtocol) {
        mProtocolDashBoardViewControllerObj = pLeaveSummaryVCProtocolObj
    }
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
    
    func dataFetchedFromController(data:[LeaveSummary],leaveSummaryTotalEmployees:LeaveSummaryTotalEmployees){
        arrayOfLeaveEmployees = data
        leaveSummaryTotalEmployeesContent = leaveSummaryTotalEmployees
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
                self.mProtocolDashBoardViewControllerObj?.reload()
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
    mProtocolDashBoardViewControllerObj?.fetchedDataFromSendEmailFunctionInViewModel(status: status)
    }

}
