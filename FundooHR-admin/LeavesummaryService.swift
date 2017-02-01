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
    
    // create firebase reference
    var ref: FIRDatabaseReference!
    
    //create variable of type NSDictionary
    var mSlideMenuContents = [NSDictionary]()
    
    //create object of type
    var mArrayOfTableViewContentModel = [TableViewContentModel]()

    //creating the variable of LeaveSummaryControllerProtocol type
    var protocolLeaveSummaryControllerObj : LeaveSummaryControllerProtocol?
    
    //model type array of LeaveSummary
    var arrayOfLeaveSummaryEmloyees = [EmployeeDetails]()
    
    //var falloutEmployeeData = [NSDictionary]()
    var arrayOfLeaveSummaryEmployeeImages = [LeaveSummaryEmployeeImageModel]()
    
    //create object of UtilityClass
    let mUtilityClassObj = UtilityClass()
    
    init(pLeaveSummaryProtocolObj : LeaveSummaryControllerProtocol) {
        protocolLeaveSummaryControllerObj = pLeaveSummaryProtocolObj
    }
    
    //making rest call to firebase to fetch tableview contents
    func fetchTableViewContents(){
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()//responsible to make a call to firebase
        ref.child("slideMenuContents").observeSingleEvent(of: .value, with: { (snapshot) in
            self.mSlideMenuContents = (snapshot.value) as! [NSDictionary]
            
            for index in 0..<self.mSlideMenuContents.count{
                let valueAtEachIndex = self.mSlideMenuContents[index] as NSDictionary //valueAtEachIndex is 1 nsdictionary
                
                let rowName = valueAtEachIndex["row_name"] as! String
                
                let tableviewContents = TableViewContentModel(rowName: rowName)
                
                self.mArrayOfTableViewContentModel.append(tableviewContents)
            }
            print("slideMenuContents",self.mSlideMenuContents)
            print("count=======",self.mArrayOfTableViewContentModel.count)
           self.protocolLeaveSummaryControllerObj?.tableViewContentsFetchedFromRestCall(data: self.mArrayOfTableViewContentModel)
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    //making rest call to fetch collectionview contents
    func fetchData(token:String){
        let token = UserDefaults.standard.value(forKey: "tokenKey")! as! String
        print("tokenKey=-=-=",token)
        let url = mUtilityClassObj.fetchUrlFromPlist()
        
        let calculatedTimeStamp = Double(Date().timeIntervalSince1970 * 1000)
        print("timestamp@#@#$",calculatedTimeStamp)
        
        let headers: HTTPHeaders = [
            "x-token" : token
        ]
        
        Alamofire.request("\(url)/readLeaveEmployee?timeStamp=\(calculatedTimeStamp)", headers: headers).responseJSON
            {response in
                if let JSON = response.result.value{
                    let completeleaveOutEmployeeData = JSON as! NSDictionary
                    print("---completeleaveOutEmployeeData----",completeleaveOutEmployeeData)
                    
                    let employeeLeaveValue = completeleaveOutEmployeeData.value(forKey: "employeeLeave") as! Int
                    let totalEmployeeValue = completeleaveOutEmployeeData.value(forKey: "totalEmployee") as! Int
                    let timeStamp = completeleaveOutEmployeeData.value(forKey: "timeStamp") as! String
                    let leaveSummaryTotalEmployeesObj = TotalEmployees(unmarkedEmployee: employeeLeaveValue, totalEmployee: totalEmployeeValue, timeStamp: timeStamp)
                    let leaveOutEmployeeData =  completeleaveOutEmployeeData.value(forKey: "leaveOutEmployee") as! [NSDictionary]
                    print("--leaveOutEmployeeData--",leaveOutEmployeeData)
                    
                    for index in 0..<leaveOutEmployeeData.count{
                        let valueAtEachIndex = leaveOutEmployeeData[index] as NSDictionary
                        let lEmployeeNameValue = valueAtEachIndex["employeeName"] as! String
                        let lEmployeeStatusValue = valueAtEachIndex["employeeStatus"] as! String
                        let lCompanyValue = valueAtEachIndex["company"] as! String
                        let lMobileValue = valueAtEachIndex["mobile"] as! String
                        let lEmailIdValue = valueAtEachIndex["emailId"] as! String
                        let lBlStartDateValue = valueAtEachIndex["blStartDate"] as! String
                        let lCompanyJoinDateValue = valueAtEachIndex["companyJoinDate"] as! String
                        let lCompanyLeaveDateValue = valueAtEachIndex["companyLeaveDate"] as! String
                        let lLeaveTakenValue = valueAtEachIndex["leaveTaken"] as! Int
                        let lEngineerIdValue = valueAtEachIndex["engineerId"] as! String
                        let lEmployeeImageUrl = valueAtEachIndex["imageUrl"] as! String
                        let lEachEmployeeObj = EmployeeDetails(pEmployeeName: lEmployeeNameValue, pEmployeeStatus: lEmployeeStatusValue, pCompany: lCompanyValue, pEmailId: lEmailIdValue, pMobile: lMobileValue, pBlStartDate: lBlStartDateValue, pCompanyJoinDate: lCompanyJoinDateValue, pCompanyLeaveDate: lCompanyLeaveDateValue, pLeaveTaken: lLeaveTakenValue, pEngineerId: lEngineerIdValue, pImageUrl: lEmployeeImageUrl)
                self.arrayOfLeaveSummaryEmloyees.append(lEachEmployeeObj)
                        
                    }
                    print("---count of employees---",self.arrayOfLeaveSummaryEmloyees.count)
                    self.protocolLeaveSummaryControllerObj?.dataFetchedFromService(data: self.arrayOfLeaveSummaryEmloyees, leaveSummaryTotalEmployees: leaveSummaryTotalEmployeesObj)
                }
        }
    }
    
    //making rest call to fetch employee url
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
            self.protocolLeaveSummaryControllerObj?.employeeImageUrlFetchedFromService(url: self.arrayOfLeaveSummaryEmployeeImages)
        })
        { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    //making rest call to fetch employee images
    func fetchEmployeeImage(_ image:[LeaveSummaryEmployeeImageModel]){
        let storage = FIRStorage.storage()
        let storageRef = storage.reference(forURL: "gs://fundoohr16-3d816.appspot.com")
        for i in 0..<image.count{
            let employeeImageUrl = image[i].employeeImageUrl
            let path = storageRef.child(employeeImageUrl!)
            
            path.data(withMaxSize: 1*1024*1024) {(data,error) -> Void in//we r making rest call here
                print("count of arrayOfFalloutEmloyees ",self.arrayOfLeaveSummaryEmloyees.count)
                print("i value",i)
                print("data",
                      data)
                print("image",UIImage(data: data!))
                if(error != nil){
                    print("error occured")
                }else{
                    let image = UIImage(data: data!)
                    self.protocolLeaveSummaryControllerObj?.imageFetchedFromService(image: image!, index: i)
                    
                }
            }
        }
    }
    
    //making rest call to send email
    func sendEmailToEmployeesTakenLeave(){
        let lUrl = mUtilityClassObj.fetchUrlFromPlist()
        let lUrlString: String = "\(lUrl)/sendEmailToFalloutEmployee"
        let lCalculatedTimeStamp = Double(Date().timeIntervalSince1970 * 1000)
        print("timestamp@#@#$",lCalculatedTimeStamp)
        let token = UserDefaults.standard.value(forKey: "tokenKey")! as! String
        print("tokenKey=-=-=",token)
        let headers: HTTPHeaders = [
            "x-token" : token
        ]
        let params = ["timeStamp":  (lCalculatedTimeStamp), "token" : (token)] as [String : Any]
        Alamofire.request(lUrlString, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseJSON{
            response in
                print("value----",response.result.value)
            if let json = response.result.value{
                let emailData = json as! NSDictionary
                print("emailData",emailData)
                let status = emailData.value(forKey: "status") as! Int
                print("status---",status)
                self.protocolLeaveSummaryControllerObj?.fetchedDataFromSendEmailFunctionInService(status: status)
            }
        }
    }
}
