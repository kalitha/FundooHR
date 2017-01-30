//
//  AttendanceSummaryVC.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 30/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import UIKit

class AttendanceSummaryVC: UIViewController {

    @IBOutlet weak var mDate: UILabel!
    @IBOutlet weak var mUnmarkedDate: UILabel!
    @IBOutlet weak var mNumberOfUnmarkedEmployees: UILabel!
    @IBOutlet weak var mTotalEmployees: UILabel!
    @IBOutlet weak var mCollectionActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mSlideMenu: UIView!
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mTableActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var mSlideMenuLeadingConstraint: NSLayoutConstraint!
    
    var mAttendanceSummaryViewModelObj = AttendanceSummaryViewModel()
    var mCustomView = UIView()
    var mMenuShowing = false
    
    @IBOutlet weak var mCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //function to rotate the screen
    func rotated() {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            print("Landscape")
            print("views width",view.frame.width)
            mCustomView.frame = CGRect.init(x: mSlideMenu.frame.width, y: 0, width: view.frame.width-mSlideMenu.frame.width, height: view.frame.height)
            mCustomView.backgroundColor = UIColor.clear
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            print("Portrait")
            print("views width",view.frame.width)
            mCustomView.frame = CGRect.init(x: mSlideMenu.frame.width, y: 0, width: view.frame.width-mSlideMenu.frame.width, height: view.frame.height)
            mCustomView.backgroundColor = UIColor.clear
        }
    }
    
    //add the gesture recognizer when the menu button is tapped
    func addGestureRecognizer(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        self.mCustomView.addGestureRecognizer(tapGesture)
    }
    
    //remove gesture recognizer after opening the slidemenu
    func removeGestureRecognizer(){
        for recognizer in mCollectionView.gestureRecognizers ?? [] {
            mCustomView.removeGestureRecognizer(recognizer)
        }
    }
    
    //called by addGestureRecognizer method
    func tapBlurButton(_ sender: UIButton) {
        mSlideMenuLeadingConstraint.constant = -250
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        mMenuShowing = !mMenuShowing
        //to remove custom view after removing slidemenu
        self.mCustomView.removeFromSuperview()
        mMenuShowing = !mMenuShowing
        
        //3rd case of removing  gesture when we click on collectionview
        removeGestureRecognizer()
    }


    @IBAction func onClickOfMenuButton(_ sender: UIButton) {
        
    }
    @IBAction func onEmailButton(_ sender: UIButton) {
    }

}
