//
//  FalloutViewModel.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 05/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class FalloutViewModel: NSObject,FalloutViewModelProtocol{
    
    //model type array of tableviewcontents
    var mArrayOfTableViewContentModel = [TableViewContentModel]()
    
    //variable of type ui images
    var mArrayOfImages = [UIImage]()
   
    var count = 0
    
    //variable of type falloutViewcontroller protocol
    var protocolFalloutVC : FalloutVCProtocol?
    
    //model type array of falloutemployees
    var arrayOfFalloutEmployees = [EmployeeDetails]()
    
    //variable of type FalloutController
    var falloutControllerObj : FalloutController?
    
    //variable of type FalloutTotalEmployees class
    var falloutTotalEmployeesContents : TotalEmployees?
    
    //initialy setting response count of tableview to 0
    var mResponseCountForTableView = 0
    
    //initially setting the collection count to 0
    var mCountForCollectionview = 0
    
    init(pFalloutVCProtocolObj : FalloutVCProtocol) {
        protocolFalloutVC = pFalloutVCProtocolObj
    }
    
    //making the rest call to fetch tableview contents from api
    func fetchTableviewContentsFromFalloutController()->Int{
        falloutControllerObj = FalloutController(pFalloutViewModelProtocolObj: self)
        if(self.count==0){
            falloutControllerObj?.fetchTableViewContentsFromService()
            count += 1
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
    func tableViewContentsFetchedFromController(data:[TableViewContentModel]){
        mArrayOfTableViewContentModel = data
        mResponseCountForTableView = mArrayOfTableViewContentModel.count
       var _ = fetchNumberOfCellsFromFalloutController()
    }
    
    //making rest call to fetch data of collectionview cells from api
    func fetchNumberOfCellsFromFalloutController()->Int{
        falloutControllerObj = FalloutController(pFalloutViewModelProtocolObj: self)
        if(mCountForCollectionview == 0){
            falloutControllerObj?.fetchNumberOfCellsFromFalloutService()
            mCountForCollectionview += 1
        }
        return arrayOfFalloutEmployees.count
    }
    
    //storing the fetched data of collectionview cells in variable of type falloutemployees model
    func dataFetchedFromFalloutController(_ data:[EmployeeDetails],falloutTotalEmployeesObj:TotalEmployees){
        arrayOfFalloutEmployees = data
        falloutTotalEmployeesContents = falloutTotalEmployeesObj
        fetchImageFromUrl(arrayOfFalloutEmployees:data)
    }
    
    //getting image from url
    func fetchImageFromUrl(arrayOfFalloutEmployees:[EmployeeDetails]){
        for i in 0..<self.arrayOfFalloutEmployees.count{
            let lUrlFetched =  arrayOfFalloutEmployees[i].mImageUrl
            if let lUrl = NSURL(string: lUrlFetched){
                if let data = NSData(contentsOf: lUrl as URL){
                    let image = UIImage(data: data as Data)
                    mArrayOfImages.append(image!)
                }
            }
        }
        protocolFalloutVC?.falloutCollectionviewReload()
    }
    
    //fetch image of each employee
    func fetchEachImageOfEmployee(i:Int)->UIImage{
        print("i...",i)
        return mArrayOfImages[i]
    }
    
    //rest call to send mail
    func callSendEmailInController(){
        falloutControllerObj?.callSendEmailFunctionInService()
    }
    
    //fetching the status after sending mail
    func fetchedDataFromSendEmailFunctionInController(status:Int){
        protocolFalloutVC?.fetchedDataFromSendEmailFunctionInViewModel(status: status)
    }
}
