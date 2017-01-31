//
//  AttendanceSummaryService.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 30/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class AttendanceSummaryService: NSObject {
    // create firebase reference
    var ref: FIRDatabaseReference!
    
    //create variable of type NSDictionary
    var mSlideMenuContents = [NSDictionary]()
    
    //create object of type
    var mArrayOfTableViewContentModel = [TableViewContentModel]()
    
    //create object of UtilityClass
    let mUtilityClassObj = UtilityClass()
    
    //creating the variable of AttendanceSummaryProtocol type
    var mAttendanceSummaryProtocolObj : AttendanceSummaryProtocol?
    
    //var falloutEmployeeData = [NSDictionary]()
    var mArrayOfUnmarkedEmployees = [EmployeeDetails]()
    
    init(pAttendanceSummaryProtocolObj : AttendanceSummaryProtocol) {
        mAttendanceSummaryProtocolObj = pAttendanceSummaryProtocolObj
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
            self.mAttendanceSummaryProtocolObj?.tableViewContentsFetchedFromRestCall(data: self.mArrayOfTableViewContentModel)
            
            
            
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
        Alamofire.request("\(url)/readUnmarkedAttendanceEmployee?timeStamp=\(calculatedTimeStamp)", headers: headers).responseJSON
            {response in
                if let JSON = response.result.value{
                    let completeUnmarkedAttendanceEmployeeData = JSON as! NSDictionary
                    print("---UnmarkedAttendanceEmployeeData----",completeUnmarkedAttendanceEmployeeData)
                    
                    let lUnmarkedNumberValue = completeUnmarkedAttendanceEmployeeData.value(forKey: "unmarkedNumber") as! Int
                    let lTotalEmployeeValue = completeUnmarkedAttendanceEmployeeData.value(forKey: "totalEmployee") as! Int
                    let timeStamp = completeUnmarkedAttendanceEmployeeData.value(forKey: "timeStamp") as! String
                    let lAttendanceTotalEmployeesObj = TotalEmployees(unmarkedEmployee: lUnmarkedNumberValue, totalEmployee: lTotalEmployeeValue, timeStamp: timeStamp)
                    let lumarkedEmployeeData =  completeUnmarkedAttendanceEmployeeData.value(forKey: "umarkedEmployee") as! [NSDictionary]
                    print("--umarkedEmployeeData--",lumarkedEmployeeData)
                    
                    for index in 0..<lumarkedEmployeeData.count{
                        let valueAtEachIndex = lumarkedEmployeeData[index] as NSDictionary
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
                        let lEachUmarkedEmployeeObj = EmployeeDetails(pEmployeeName: lEmployeeNameValue, pEmployeeStatus: lEmployeeStatusValue, pCompany: lCompanyValue, pEmailId: lEmailIdValue, pMobile: lMobileValue, pBlStartDate: lBlStartDateValue, pCompanyJoinDate: lCompanyJoinDateValue, pCompanyLeaveDate: lCompanyLeaveDateValue, pLeaveTaken: lLeaveTakenValue, pEngineerId: lEngineerIdValue, pImageUrl: lEmployeeImageUrl)
                        self.mArrayOfUnmarkedEmployees.append(lEachUmarkedEmployeeObj)
                        
                    }
                    print("---count of employees---",self.mArrayOfUnmarkedEmployees.count)
                    self.mAttendanceSummaryProtocolObj?.dataFetchedFromTheRestCall(self.mArrayOfUnmarkedEmployees as [EmployeeDetails],totalEmployeesObj: lAttendanceTotalEmployeesObj )
                }
        }
    }
    
    //making rest call to send email
    func sendEmailToUnmarkedEmployees(){
        let lUrl = mUtilityClassObj.fetchUrlFromPlist()
        let lUrlString: String = "\(lUrl)/sendEmailToUnmarkedEmployee"
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
                    self.mAttendanceSummaryProtocolObj?.fetchedStatusAfterSendingMail(status: status)
                }
        }
    }
}
