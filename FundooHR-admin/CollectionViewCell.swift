//
//  CollectionViewCell.swift
//  FundooHR
//
//  Created by BridgeLabz on 25/12/16.
//  Copyright © 2016 BridgeLabz Solutions LLP. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var unmarkedEmployees: UILabel!
    @IBOutlet weak var markedEmployees: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
}
