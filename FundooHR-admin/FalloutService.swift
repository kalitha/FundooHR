 //
//  FalloutService.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 05/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import FirebaseStorage

class FalloutService: NSObject {
    
    //FIXME:-fix leave string
    var ref: FIRDatabaseReference!
    let falloutControllerObj = FalloutController()
    
    //dont fix
    //creating the variable of falloutcontroller type
    var protocolFalloutController : CallBackInFalloutController?
    //var falloutEmployeeData = [NSDictionary]()
    var arrayOfFalloutEmloyees = [Fallout]() //creating model type array
    var arrayOfFalloutEmployeeImages = [FalloutImageModel]()
    
    func fetchData(_ token:String){
        let calculatedTimeStamp = Double(Date().timeIntervalSince1970 * 1000)
        print("==calculatedTimeStamp===>",calculatedTimeStamp)
        Alamofire.request("http://192.168.0.9:3000/readFalloutAttendanceEmployee?token=\(token)&timeStamp=\(calculatedTimeStamp)").responseJSON
            {response in
            if let JSON = response.result.value{
                let completeFalloutData = JSON as! NSDictionary
                print("---falloutData----",completeFalloutData)
                
                let falloutNumberValue = completeFalloutData.value(forKey: "falloutNumber") as! Int
                let totalEmployeeValue = completeFalloutData.value(forKey: "totalEmployee") as! Int
                let timeStamp = completeFalloutData.value(forKey: "timeStamp") as! String
                let falloutTotalEmployeesObj = FalloutTotalEmployees(unmarkedEmployee: falloutNumberValue, totalEmployee: totalEmployeeValue, timeStamp: timeStamp)
                let falloutEmployeeData =  completeFalloutData.value(forKey: "falloutEmployee") as! [NSDictionary]
                print("--falloutEmployeeData--",falloutEmployeeData)

                for index in 0..<falloutEmployeeData.count{
                    let valueAtEachIndex = falloutEmployeeData[index] as NSDictionary
                    let employeeNameValue = valueAtEachIndex["employeeName"] as! String
                    let employeeStatusValue = valueAtEachIndex["employeeStatus"] as! String
                    let companyValue = valueAtEachIndex["company"] as! String
                    let mobileValue = valueAtEachIndex["mobile"] as! String
                    let emailIdValue = valueAtEachIndex["emailId"] as! String
                    let blStartDateValue = valueAtEachIndex["blStartDate"] as! String
                    let companyJoinDateValue = valueAtEachIndex["companyJoinDate"] as! String
                    let companyLeaveDateValue = valueAtEachIndex["companyLeaveDate"] as! String
                    let leaveTakenValue = valueAtEachIndex["leaveTaken"] as! Int
                    let engineerIdValue = valueAtEachIndex["engineerId"] as! String 
                    let eachFalloutEmployeeObj = Fallout(employeeName: employeeNameValue, employeeStatus: employeeStatusValue, company: companyValue, emailId: emailIdValue, mobile: mobileValue, blStartDate: blStartDateValue, companyJoinDate: companyJoinDateValue, companyLeaveDate: companyLeaveDateValue, leaveTaken: leaveTakenValue, engineerId: engineerIdValue)
                    self.arrayOfFalloutEmloyees.append(eachFalloutEmployeeObj)
                    
                }
                print("---count of employees---",self.arrayOfFalloutEmloyees.count)
                self.protocolFalloutController?.dataFetchedFromFalloutService(self.arrayOfFalloutEmloyees as [Fallout],falloutTotalEmployeesObj: falloutTotalEmployeesObj )
            }
        }
    }
    
    func fetchEmployeeImageUrlFromFirebase(){
        ref = FIRDatabase.database().reference()//responsible to make a call to firebase
        ref.child("falloutEmployee").observeSingleEvent(of: .value, with: { snapshot in
            
            let falloutEmployee = (snapshot.value) as! [NSDictionary]
            
            print("==falloutEmployee==",falloutEmployee)
            for index in 0..<falloutEmployee.count{
                let valueAtEachIndex = falloutEmployee[index] as NSDictionary //valueAtEachIndex is 1 nsdictionary
                let employeeImageValue = valueAtEachIndex["employee_Image"] as! String
                let employeeNameValue = valueAtEachIndex["employee_name"] as! String
                let employeeObj = FalloutImageModel(employeeImage: employeeImageValue, employeeName: employeeNameValue)
                self.arrayOfFalloutEmployeeImages.append(employeeObj)
                }
            print("count of arrayOfFalloutEmloyees ",self.arrayOfFalloutEmloyees.count)
            print("count=======",self.arrayOfFalloutEmployeeImages.count)
            print("arrayOfFalloutEmployeeImages",self.arrayOfFalloutEmployeeImages)
            self.protocolFalloutController?.employeeImageUrlFetchedFromService(url: self.arrayOfFalloutEmployeeImages)
            })
        { (error) in
            print(error.localizedDescription)
        }

    }
    
    func fetchEmployeeImage(_ image:[FalloutImageModel]){
        let storage = FIRStorage.storage()
        let storageRef = storage.reference(forURL: "gs://fundoohr16-3d816.appspot.com")
        for i in 0..<image.count{
            let employeeImageUrl = image[i].employeeImageUrl
            let path = storageRef.child(employeeImageUrl!)
            
            path.data(withMaxSize: 1*1024*1024) {(data,error) -> Void in//we r making rest call here
                print("count of arrayOfFalloutEmloyees ",self.arrayOfFalloutEmloyees.count)
                print("i value",i)
                print("data",data)
                print("image",UIImage(data: data!))
                if(error != nil){
                    print("error occured")
                }else{
                    let image = UIImage(data: data!)
                    self.protocolFalloutController?.imageFetchedFromService(image: image!, index: i)
                   
                }
            }
        }
    }
}
