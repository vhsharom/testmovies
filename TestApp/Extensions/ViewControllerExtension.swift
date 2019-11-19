//
//  ViewControllerExtension.swift
//  TestApp
//
//

import Foundation
import UIKit

extension UIViewController{
    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
