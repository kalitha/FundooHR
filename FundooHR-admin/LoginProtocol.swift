//
//  CallBackProtocol.swift
//  FundooHR-admin
//
//  Created by BridgeLabz on 03/01/17.
//  Copyright © 2017 BridgeLabz. All rights reserved.
//

import Foundation
import UIKit

//protocol of LoginViewController
protocol LoginVCProtocol {
    func performingNavigationToDashboard(status:Int)
}
//protocol of LoginViewModel
protocol LoginViewModelProtocol {
    func fetchStatusFromController(_ status:Int)
}

//protocol of LoginController
protocol LoginControllerProtocol{
    func fetchStatusFromService(_ status:Int)
}











