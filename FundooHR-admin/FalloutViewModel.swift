//
//  FalloutViewModel.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 05/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class FalloutViewModel: NSObject,CallBackInFalloutViewModel{
    
    //FIXME:-fix FalloutImageModel
    var arrayOfFalloutImageModel = [FalloutImageModel]()
    var arrayOfImages = [UIImage]()
    var countOfFetchedImages = 0
    var count = 0
    //dont fix
    var protocolFalloutVC : CallBackInFalloutVC?
    var arrayOfFalloutEmployees = [Fallout]()
    var falloutControllerObj : FalloutController?
    var falloutTotalEmployeesContents : FalloutTotalEmployees?
    
    func fetchNumberOfCellsFromFalloutController(_ token:String)->Int{
        falloutControllerObj = FalloutController()
        falloutControllerObj?.protocolFalloutViewModel = self
        if(arrayOfFalloutEmployees.count == 0){
            if(self.count == 0){
            falloutControllerObj?.fetchNumberOfCellsFromFalloutService(token)
            count += 1
            }
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
            DispatchQueue.main.async {
                self.protocolFalloutVC?.reload()
            }

        }
}
    func fetchEachImage(i:Int)->UIImage{
        print("i....",i)
        return arrayOfImages[i]
    }

}
