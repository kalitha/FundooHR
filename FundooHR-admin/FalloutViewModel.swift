//
//  FalloutViewModel.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 05/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class FalloutViewModel: NSObject,FalloutViewModelProtocol{
    
    var mArrayOfTableViewContentModel = [TableViewContentModel]()
    var arrayOfFalloutImageModel = [FalloutImageModel]()
    var arrayOfImages = [UIImage]()
    var countOfFetchedImages = 0
    var count = 0
    //dont fix
    var protocolFalloutVC : FalloutVCProtocol?
    var arrayOfFalloutEmployees = [Fallout]()
    var falloutControllerObj : FalloutController?
    var falloutTotalEmployeesContents : FalloutTotalEmployees?
    var mResponseCountForTableView = 0
    var mResponseCount = 0
    var mCountForCollectionview = 0
    init(pFalloutVCProtocolObj : FalloutVCProtocol) {
        protocolFalloutVC = pFalloutVCProtocolObj
    }

    
    func fetchTableviewContentsFromFalloutController()->Int{
         falloutControllerObj = FalloutController(pFalloutViewModelProtocolObj: self)
        if(self.count==0){
            falloutControllerObj?.fetchTableViewContentsFromService()
            count += 1
        }
        return mArrayOfTableViewContentModel.count
    }
    
    func contentAtEachRow(i:Int)->String{
        var contentInIndex : TableViewContentModel?
        
        contentInIndex = mArrayOfTableViewContentModel[i]
        
        print("content in index=",contentInIndex! )
        let name = contentInIndex?.rowName
        
        return name!
        
    }
    func tableViewContentsFetchedFromController(data:[TableViewContentModel]){
        mResponseCountForTableView = 7
        mArrayOfTableViewContentModel = data
        fetchNumberOfCellsFromFalloutController()
    }
    
    func fetchNumberOfCellsFromFalloutController()->Int{
        falloutControllerObj = FalloutController(pFalloutViewModelProtocolObj: self)
            if(mCountForCollectionview == 0){
            falloutControllerObj?.fetchNumberOfCellsFromFalloutService()
            mCountForCollectionview += 1
            }
        return arrayOfFalloutEmployees.count
    }
    
    func dataFetchedFromFalloutController(_ data:[Fallout],falloutTotalEmployeesObj:FalloutTotalEmployees){
        arrayOfFalloutEmployees = data
        falloutTotalEmployeesContents = falloutTotalEmployeesObj
        falloutControllerObj?.fetchEmployeeImageUrlFromService()
        }
    
    func employeeImageUrlFetchedFromController(data:[FalloutImageModel]){
        arrayOfFalloutImageModel = data
        print("arrayOfFalloutImageModel count===--==",arrayOfFalloutImageModel.count)
        for i in 0..<self.arrayOfFalloutImageModel.count{
//        print("employeeImageUrl",arrayOfFalloutImageModel[i].employeeImageUrl)
//        print("employeeName",arrayOfFalloutImageModel[i].employeeName)
            let image = #imageLiteral(resourceName: "dummyImage")
            arrayOfImages.append(image)
        }
        print("arrayOfImages count=-=-==",arrayOfImages.count)
       fetchImageFromController(arrayOfFalloutImageModel)
        }
    
    
    func fetchImageFromController(_ image: [FalloutImageModel]){
        //falloutControllerObj = FalloutController()
        falloutControllerObj?.fetchImageFromService(image)

}

    func imageFetchedFromController(image: UIImage, index: Int){
        countOfFetchedImages+=1
        print("index",index)
        print("countOfFetchedImages",countOfFetchedImages)
        print("arrayOfImages.count",arrayOfImages.count)
        print("arrayOfFalloutEmployees=-=-=-",arrayOfFalloutEmployees.count)
        arrayOfImages[index] = image
        if(countOfFetchedImages == arrayOfImages.count){
            //protocolFalloutVC?.reload() //reloading after getting the image
            print("arrayOfFalloutEmployees==-=-=-",arrayOfFalloutEmployees)
                self.protocolFalloutVC?.falloutCollectionviewReload()
        }
}
    func fetchEachImage(i:Int)->UIImage{
        print("i....",i)
        return arrayOfImages[i]
    }

    func makingRestCallToSendEmailInController(){
        
    }
}
