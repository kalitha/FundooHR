//
//  Fallout.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 05/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class EmployeeDetails: NSObject {
    var mEmployeeName : String?
    var mEmployeeStatus :String?
    var mCompany :String?
    var mEmailId : String?
    var mMobile : String?
    var mBlStartDate : String?
    var mCompanyJoinDate : String?
    var mCompanyLeaveDate : String?
    var mLeaveTaken : Int?
    var mEngineerId : String?
    var mImageUrl : String
    init(pEmployeeName: String, pEmployeeStatus: String, pCompany: String, pEmailId: String, pMobile: String, pBlStartDate: String, pCompanyJoinDate: String, pCompanyLeaveDate: String, pLeaveTaken: Int, pEngineerId: String, pImageUrl: String) {
        self.mEmployeeName = pEmployeeName
        self.mEmployeeStatus = pEmployeeStatus
        self.mCompany = pCompany
        self.mEmailId = pEmailId
        self.mMobile = pMobile
        self.mBlStartDate = pBlStartDate
        self.mCompanyJoinDate = pCompanyJoinDate
        self.mCompanyLeaveDate = pCompanyLeaveDate
        self.mLeaveTaken = pLeaveTaken
        self.mEngineerId  = pEngineerId
        self.mImageUrl = pImageUrl
        }
}
