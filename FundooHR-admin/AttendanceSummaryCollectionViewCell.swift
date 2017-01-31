//
//  AttendanceSummaryCollectionViewCell.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 30/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class AttendanceSummaryCollectionViewCell: UICollectionViewCell {
    
    //create outlet of name
    @IBOutlet weak var mName: UILabel!
    
    //create outlet of mFellowship
    @IBOutlet weak var mFellowship: UILabel!
    
    //create outlet of Company
    @IBOutlet weak var mCompany: UILabel!
    
    //create outlet of Mobile
    @IBOutlet weak var mMobile: UILabel!
    
    //create outlet of EmailId
    @IBOutlet weak var mEmailId: UILabel!
    
    //create outlet of EmployeeImage
    @IBOutlet weak var mEmployeeImage: UIImageView!
    
}
