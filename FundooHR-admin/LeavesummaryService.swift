//
//  LeavesummaryService.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 20/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import FirebaseStorage

class LeavesummaryService: NSObject {
    var ref: FIRDatabaseReference!
    var protocolLeaveSummaryController : CallBackInLeaveSummaryController?
    var arrayOfLeaveSummaryEmloyees = [LeaveSummary]()
    //var falloutEmployeeData = [NSDictionary]()
    var arrayOfLeaveSummaryEmployeeImages = [LeaveSummaryEmployeeImageModel]()
    func fetchData(token:String){
        
        let calculatedTimeStamp = Double(Date().timeIntervalSince1970 * 1000)
        print("==calculatedTimeStamp===>",calculatedTimeStamp)
        Alamofire.request("http://192.168.0.36:3000/readLeaveEmployee?token=\(token)&timeStamp=\(calculatedTimeStamp)").responseJSON
            {response in
                if let JSON = response.result.value{
                    let completeleaveOutEmployeeData = JSON as! NSDictionary
                    print("---completeleaveOutEmployeeData----",completeleaveOutEmployeeData)
                    
                    let employeeLeaveValue = completeleaveOutEmployeeData.value(forKey: "employeeLeave") as! Int
                    let totalEmployeeValue = completeleaveOutEmployeeData.value(forKey: "totalEmployee") as! Int
                    let timeStamp = completeleaveOutEmployeeData.value(forKey: "timeStamp") as! String
                    let leaveSummaryTotalEmployeesObj = LeaveSummaryTotalEmployees(employeeLeave: employeeLeaveValue, totalEmployee: totalEmployeeValue, timeStamp: timeStamp)
                    let leaveOutEmployeeData =  completeleaveOutEmployeeData.value(forKey: "leaveOutEmployee") as! [NSDictionary]
                    print("--leaveOutEmployeeData--",leaveOutEmployeeData)
                    
                    for index in 0..<leaveOutEmployeeData.count{
                        let valueAtEachIndex = leaveOutEmployeeData[index] as NSDictionary
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
                        let eachFalloutEmployeeObj = LeaveSummary(employeeName: employeeNameValue, employeeStatus: employeeStatusValue, company: companyValue, emailId: emailIdValue, mobile: mobileValue, blStartDate: blStartDateValue, companyJoinDate: companyJoinDateValue, companyLeaveDate: companyLeaveDateValue, leaveTaken: leaveTakenValue, engineerId: engineerIdValue)
                        self.arrayOfLeaveSummaryEmloyees.append(eachFalloutEmployeeObj)
                        
                    }
                    print("---count of employees---",self.arrayOfLeaveSummaryEmloyees.count)
                    self.protocolLeaveSummaryController?.dataFetchedFromService(data: self.arrayOfLeaveSummaryEmloyees, leaveSummaryTotalEmployees: leaveSummaryTotalEmployeesObj)
                }
        }
    }
    
    func fetchEmployeeImageUrlFromFirebase(){
        ref = FIRDatabase.database().reference()//responsible to make a call to firebase
        ref.child("leaveOutEmployee").observeSingleEvent(of: .value, with: { snapshot in
            
            let leaveSummaryEmployee = (snapshot.value) as! [NSDictionary]
            
            print("==leaveSummaryEmployee==",leaveSummaryEmployee)
            for index in 0..<leaveSummaryEmployee.count{
                let valueAtEachIndex = leaveSummaryEmployee[index] as NSDictionary //valueAtEachIndex is 1 nsdictionary
                let employeeImageValue = valueAtEachIndex["employee_Image"] as! String
                let employeeNameValue = valueAtEachIndex["employee_name"] as! String
                let employeeObj = LeaveSummaryEmployeeImageModel(employeeImage: employeeImageValue, employeeName: employeeNameValue)
                self.arrayOfLeaveSummaryEmployeeImages.append(employeeObj)
            }
            print("count of arrayOfFalloutEmloyees ",self.arrayOfLeaveSummaryEmloyees.count)
            print("count=======",self.arrayOfLeaveSummaryEmployeeImages.count)
            print("arrayOfFalloutEmployeeImages",self.arrayOfLeaveSummaryEmployeeImages)
            self.protocolLeaveSummaryController?.employeeImageUrlFetchedFromService(url: self.arrayOfLeaveSummaryEmployeeImages)
        })
        { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func fetchEmployeeImage(_ image:[LeaveSummaryEmployeeImageModel]){
        let storage = FIRStorage.storage()
        let storageRef = storage.reference(forURL: "gs://fundoohr16-3d816.appspot.com")
        for i in 0..<image.count{
            let employeeImageUrl = image[i].employeeImageUrl
            let path = storageRef.child(employeeImageUrl!)
            
            path.data(withMaxSize: 1*1024*1024) {(data,error) -> Void in//we r making rest call here
                print("count of arrayOfFalloutEmloyees ",self.arrayOfLeaveSummaryEmloyees.count)
                print("i value",i)
                print("data",data)
                print("image",UIImage(data: data!))
                if(error != nil){
                    print("error occured")
                }else{
                    let image = UIImage(data: data!)
                    self.protocolLeaveSummaryController?.imageFetchedFromService(image: image!, index: i)
                    
                }
            }
        }
    }
}
