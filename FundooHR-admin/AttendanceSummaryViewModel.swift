//
//  AttendanceSummaryViewModel.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 29/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class AttendanceSummaryViewModel: NSObject,AttendanceSummaryProtocol {
    
    //model type array of tableviewcontents
    var mArrayOfTableViewContentModel = [TableViewContentModel]()
    
    //variable of type ui images
    var mArrayOfImages = [UIImage]()
    
    //count of FetchedImages
    var mCountOfFetchedImages = 0
    var mCount = 0
    
    //model type array of falloutemployees
    var mArrayOfUnmarkedEmployees = [EmployeeDetails]()
    
    //variable of type AttendanceSummaryVC protocol
    var mAttendanceSummaryVCProtocolObj : AttendanceSummaryVCProtocol?
    
    //variable of type AttendanceSummaryController
    var mAttendanceSummaryControllerObj : AttendanceSummaryController?
    
    //variable of type TotalEmployees class
    var mTotalEmployeesContents : TotalEmployees?
    
    //initialy setting response count of tableview to 0
    var mResponseCountForTableView = 0
    
    //initially setting the collection count to 0
    var mCountForCollectionview = 0
    
    init(pAttendanceSummaryVCProtocolObj : AttendanceSummaryVCProtocol) {
        mAttendanceSummaryVCProtocolObj = pAttendanceSummaryVCProtocolObj
    }
    
    //making the rest call to fetch tableview contents from api
    func fetchTableviewContentsFromController()->Int{
        mAttendanceSummaryControllerObj = AttendanceSummaryController(pAttendanceSummaryProtocolObj: self)
        if(self.mCount==0){
            mAttendanceSummaryControllerObj?.fetchTableViewContentsFromService()
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
        fetchNumberOfCellsFromController()
        
    }
    
    //making rest call to fetch data of collectionview cells from api
    func fetchNumberOfCellsFromController()->Int{
        mAttendanceSummaryControllerObj = AttendanceSummaryController(pAttendanceSummaryProtocolObj: self)
        if(mCountForCollectionview == 0){
            mAttendanceSummaryControllerObj?.fetchNumberOfCellsFromService()
            mCountForCollectionview += 1
        }
        return mArrayOfUnmarkedEmployees.count
    }
    
    //storing the fetched data of collectionview cells in variable of type falloutemployees model
    func dataFetchedFromTheRestCall(_ data:[EmployeeDetails],totalEmployeesObj:TotalEmployees){
        mArrayOfUnmarkedEmployees = data
        mTotalEmployeesContents = totalEmployeesObj
        
        fetchImageFromUrl(mArrayOfUnmarkedEmployees: data)
    }
    
    //getting image from url
    func fetchImageFromUrl(mArrayOfUnmarkedEmployees:[EmployeeDetails]){
        for i in 0..<self.mArrayOfUnmarkedEmployees.count{
            let lUrlFetched =  mArrayOfUnmarkedEmployees[i].mImageUrl
            if let lUrl = NSURL(string: lUrlFetched){
                if let data = NSData(contentsOf: lUrl as URL){
                    let image = UIImage(data: data as Data)
                    mArrayOfImages.append(image!)
                }
            }
        }
        mAttendanceSummaryVCProtocolObj?.attendanceSummaryCollectionViewReload()
    }
    
    func fetchEachImageOfEmployee(i:Int)->UIImage{
        print("i...",i)
        return mArrayOfImages[i]
    }
    
    //rest call to send mail
    func makingRestCallToSendMail(){
        mAttendanceSummaryControllerObj?.makingRestCallToSendMail()
    }
    
    //fetching the status after sending mail
    func fetchedStatusAfterSendingMail(status:Int){
        mAttendanceSummaryVCProtocolObj?.fetchedStatusAfterSendingMail(status: status)
    }
}
