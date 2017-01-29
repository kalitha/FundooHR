//
//  CollectionViewCell.swift
//  FundooHR
//
//  Created by BridgeLabz on 25/12/16.
//  Copyright © 2016 BridgeLabz Solutions LLP. All rights reserved.
//

import UIKit

class AttendanceSummary: UICollectionViewCell {

    //outlet for date in the first cell of dashboard
    @IBOutlet weak var date: UILabel!
    //outlet for unmarkedEmployees in the first cell of dashboard
    @IBOutlet weak var unmarkedEmployees: UILabel!
    //outlet for markedEmployees in the first cell of dashboard
    @IBOutlet weak var markedEmployees: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
}
