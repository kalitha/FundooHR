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
    
    //used to make only one rest call
    var mCount = 0
    
    //initialy setting response count of tableview to 0
    var mResponseCountForTableView = 0
    
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
    
    //variable of type ui images
    var mArrayOfImages = [UIImage]()
    
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
        fetchDataFromController()
    }
    
    //making rest call to fetch data of collectionview cells from api
    func fetchDataFromController()->Int{
        leaveSummaryControllerObj = LeaveSummaryController(pLeaveSummaryViewModelProtocolObj: self)
        //leaveSummaryControllerObj?.protocolLeaveSummaryViewModel = self
        if(mCountForCollectionview == 0){
            leaveSummaryControllerObj?.fetchNumberOFCellsFromService()
            mCountForCollectionview += 1
        }
        print("arrayOfLeaveEmployees.count",arrayOfLeaveEmployees.count)
        return arrayOfLeaveEmployees.count
    }
    
    //storing the fetched data of collectionview cells in variable of type leavesummary model
    func dataFetchedFromController(data:[EmployeeDetails],leaveSummaryTotalEmployees:TotalEmployees){
        arrayOfLeaveEmployees = data
        leaveSummaryTotalEmployeesContent = leaveSummaryTotalEmployees
        fetchImageFromUrl(arrayOfLeaveEmployees: data)
    }
    
    //getting image from url
    func fetchImageFromUrl(arrayOfLeaveEmployees:[EmployeeDetails]){
        for i in 0..<self.arrayOfLeaveEmployees.count{
            let lUrlFetched =  arrayOfLeaveEmployees[i].mImageUrl
            if let lUrl = NSURL(string: lUrlFetched){
                if let data = NSData(contentsOf: lUrl as URL){
                    let image = UIImage(data: data as Data)
                    mArrayOfImages.append(image!)
                }
            }
        }
        mLeaveSummaryVCProtocolObj?.reload()
    }
    
    func fetchEachImageOfEmployee(i:Int)->UIImage{
        print("i...",i)
        return mArrayOfImages[i]
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
