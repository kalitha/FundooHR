//
//  UtilityClass.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 23/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class UtilityClass: UIViewController {

    let mFormatter = DateFormatter()
    let mCurrentDate = Date()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func date()->String{
                // initialize the date formatter and set the style
        
        mFormatter.dateFormat = "dd MM yyyy"
        mFormatter.dateStyle = .long
        // get the date time String from the date object
        let convertedDate = mFormatter.string(from: mCurrentDate)
        return convertedDate
    }
    
    
    func cellDesign(cell:UICollectionViewCell, date:Date)->String{
        let color = UIColor.init(red: 111/255, green: 184/255, blue: 217/255, alpha: 1)
        cell.contentView.backgroundColor = UIColor.white
        cell.layer.borderColor = color.cgColor
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        mFormatter.dateFormat = "dd MM yyyy"
        mFormatter.dateStyle = .long
        let convertedDate = mFormatter.string(from: date)
        return convertedDate

    }
    func fetchUrlFromPlist()->String{
        var url :String?
        let path = Bundle.main.path(forResource: "UrlPlist", ofType: "plist")
        
        if let urlDictionary = NSDictionary(contentsOfFile: path!){
             url = (urlDictionary["url"] as! String)
        }
        return url!
        
    }
    


}
