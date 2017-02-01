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
    
    //used to make only one rest call
    var mCount = 0
    
    //initialy setting response count of tableview to 0
    var mResponseCountForTableView = 0
    
    //create variable of type ui images
    var arrayOfImages = [UIImage]()
    
    //create the object of type LeaveSummary
    var arrayOfLeaveEmployees = [EmployeeDetails]()
    
    //create variable of type LeaveSummaryController
    var leaveSummaryControllerObj : LeaveSummaryController?
    
    //create variable of type LeaveSummaryVCProtocol
    var mLeaveSummaryVCProtocolObj : LeaveSummaryVCProtocol?
    
    //create variable of type LeaveSummaryTotalEmployees
    var leaveSummaryTotalEmployeesContent : TotalEmployees?
    
    //create the array variable of type LeaveSummaryEmployeeImageModel
    var arrayOfLeaveSummaryEmployeeImages = [LeaveSummaryEmployeeImageModel]()
    
    //model type array of tableviewcontents
    var mArrayOfTableViewContentModel = [TableViewContentModel]()

    
    init(pLeaveSummaryVCProtocolObj : LeaveSummaryVCProtocol) {
        mLeaveSummaryVCProtocolObj = pLeaveSummaryVCProtocolObj
    }
    
    //making the rest call to fetch tableview contents from api
    func fetchTableviewContentsFromController()->Int{
        leaveSummaryControllerObj = LeaveSummaryController(pLeaveSummaryViewModelProtocolObj: self)
        if(self.mCount==0){
            leaveSummaryControllerObj?.fetchTableViewContentsFromService()
            mCount += 1
        }
        return mArrayOfTableViewContentModel.count
        
    }
    
    //used to retriew content at each row of tableview
    func contentAtEachRow(i:Int)->String{
        var contentInIndex : TableViewContentModel?
        
        contentInIndex = mArrayOfTableViewContentModel[i]
        
        print("content in index=",contentInIndex! )
        let name = contentInIndex?.mRowName
        
        return name!
    }
    
    //storing the fetched tableview data in a variable and increasing the ResponseCountForTableView
    func tableViewContentsFetchedFromRestCall(data:[TableViewContentModel]){
        let path = Bundle.main.path(forResource: "UrlPlist", ofType: "plist")
        if let urlDictionary = NSDictionary(contentsOfFile: path!){
            mResponseCountForTableView = urlDictionary["tableViewCellCount"] as! Int
        }
        
        mArrayOfTableViewContentModel = data
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
                self.mLeaveSummaryVCProtocolObj?.reload()
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
        mLeaveSummaryVCProtocolObj?.fetchedDataFromSendEmailFunctionInViewModel(status: status)
    }
    
}
