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
    
    // create firebase reference
    var ref: FIRDatabaseReference!
    
    //create variable of type NSDictionary
    var mSlideMenuContents = [NSDictionary]()
    
    //create object of type
    var mArrayOfTableViewContentModel = [TableViewContentModel]()
    
    //create object of UtilityClass
    let mUtilityClassObj = UtilityClass()
    
    //creating the variable of FalloutControllerProtocol type
    var protocolFalloutController : FalloutControllerProtocol?
    
    //var falloutEmployeeData = [NSDictionary]()
    var arrayOfFalloutEmloyees = [EmployeeDetails]()
    
    init(pFalloutControllerProtocolObj : FalloutControllerProtocol) {
        protocolFalloutController = pFalloutControllerProtocolObj
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
            self.protocolFalloutController?.tableViewContentsFetchedFromService(data: self.mArrayOfTableViewContentModel)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    //making rest call to fetch collectionview contents
    func fetchData(){
        let token = UserDefaults.standard.value(forKey: "tokenKey")! as! String
        print("tokenKey=-=-=",token)
        let url = mUtilityClassObj.fetchUrlFromPlist()
        let calculatedTimeStamp = Double(Date().timeIntervalSince1970 * 1000)
        print("==calculatedTimeStamp===>",calculatedTimeStamp)
        let headers: HTTPHeaders = [
            "x-token" : token
        ]
        Alamofire.request("\(url)/readFalloutAttendanceEmployee?timeStamp=\(calculatedTimeStamp)", headers: headers).responseJSON
            {response in
                if let JSON = response.result.value{
                    let completeFalloutData = JSON as! NSDictionary
                    print("---falloutData----",completeFalloutData)
                    
                    let falloutNumberValue = completeFalloutData.value(forKey: "falloutNumber") as! Int
                    let totalEmployeeValue = completeFalloutData.value(forKey: "totalEmployee") as! Int
                    let timeStamp = completeFalloutData.value(forKey: "timeStamp") as! String
                    let falloutTotalEmployeesObj = TotalEmployees(unmarkedEmployee: falloutNumberValue, totalEmployee: totalEmployeeValue, timeStamp: timeStamp)
                    let falloutEmployeeData =  completeFalloutData.value(forKey: "falloutEmployee") as! [NSDictionary]
                    print("--falloutEmployeeData--",falloutEmployeeData)
                    
                    for index in 0..<falloutEmployeeData.count{
                        let valueAtEachIndex = falloutEmployeeData[index] as NSDictionary
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
                        let lEachFalloutEmployeeObj = EmployeeDetails(pEmployeeName: lEmployeeNameValue, pEmployeeStatus: lEmployeeStatusValue, pCompany: lCompanyValue, pEmailId: lEmailIdValue, pMobile: lMobileValue, pBlStartDate: lBlStartDateValue, pCompanyJoinDate: lCompanyJoinDateValue, pCompanyLeaveDate: lCompanyLeaveDateValue, pLeaveTaken: lLeaveTakenValue, pEngineerId: lEngineerIdValue, pImageUrl: lEmployeeImageUrl)
                        self.arrayOfFalloutEmloyees.append(lEachFalloutEmployeeObj)
                        
                    }
                    print("---count of employees---",self.arrayOfFalloutEmloyees.count)
                    self.protocolFalloutController?.dataFetchedFromFalloutService(self.arrayOfFalloutEmloyees as [EmployeeDetails],falloutTotalEmployeesObj: falloutTotalEmployeesObj )
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
                    self.protocolFalloutController?.fetchedDataFromSendEmailFunctionInService(status: status)
                }
        }
    }
 }
