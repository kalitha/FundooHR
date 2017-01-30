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
    
    //model type array of FalloutImageModel
    var arrayOfFalloutImageModel = [FalloutImageModel]()
    
    //variable of type ui images
    var arrayOfImages = [UIImage]()
    var countOfFetchedImages = 0
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
        let path = Bundle.main.path(forResource: "UrlPlist", ofType: "plist")
        if let urlDictionary = NSDictionary(contentsOfFile: path!){
            mResponseCountForTableView = urlDictionary["tableViewCellCount"] as! Int
        }
        
        mArrayOfTableViewContentModel = data
        fetchNumberOfCellsFromFalloutController()
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
        falloutControllerObj?.fetchEmployeeImageUrlFromService()
    }
    
    //storing the employee url fetched from rest call made to firebase
    func employeeImageUrlFetchedFromController(data:[FalloutImageModel]){
        arrayOfFalloutImageModel = data
        print("arrayOfFalloutImageModel count===--==",arrayOfFalloutImageModel.count)
        for i in 0..<self.arrayOfFalloutImageModel.count{
            let image = #imageLiteral(resourceName: "dummyImage")
            arrayOfImages.append(image)
        }
        print("arrayOfImages count=-=-==",arrayOfImages.count)
        fetchImageFromController(arrayOfFalloutImageModel)
    }
    
    
    //making rest call to fetch images of employees
    func fetchImageFromController(_ image: [FalloutImageModel]){
        //falloutControllerObj = FalloutController()
        falloutControllerObj?.fetchImageFromService(image)
    }
    
    //storing image fetched from rest call
    func imageFetchedFromController(image: UIImage, index: Int){
        countOfFetchedImages+=1
        print("index",index)
        print("countOfFetchedImages",countOfFetchedImages)
        print("arrayOfImages.count",arrayOfImages.count)
        print("arrayOfFalloutEmployees=-=-=-",arrayOfFalloutEmployees.count)
        arrayOfImages[index] = image
        if(countOfFetchedImages == arrayOfImages.count){
            print("arrayOfFalloutEmployees==-=-=-",arrayOfFalloutEmployees)
            self.protocolFalloutVC?.falloutCollectionviewReload()
        }
    }
    
    //fetching each image
    func fetchEachImage(i:Int)->UIImage{
        print("i....",i)
        return arrayOfImages[i]
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
