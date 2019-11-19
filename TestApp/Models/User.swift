//
//  User.swift
//
//

import Foundation
import UIKit

class User {

    let osVersion = UIDevice.current.systemVersion
    let deviceModel = UIDevice.current.model
    let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "NA"
    let uuid = UIDevice.current.identifierForVendor?.uuidString ?? "NA"
    let deviceName = UIDevice.current.name
    let deviceWidth = UIScreen.main.bounds.width
    let deviceHeight = UIScreen.main.bounds.height
    
    static let shared = User()

    private init() {

    }

}
