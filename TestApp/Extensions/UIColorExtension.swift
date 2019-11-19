//
//  Colores.swift
//
//

import Foundation
import UIKit

let colorDebugMode = false

extension UIColor{
    
    // MARK: - Client Colors
    
    class func colorAppPurple() -> UIColor{
        return colorDebugMode == true ? UIColor.randomColor() : UIColor.hexColor(hex: "#5248BF")
    }

    class func colorAppGreen() -> UIColor{
        return colorDebugMode == true ? UIColor.randomColor() : UIColor.hexColor(hex: "#95ac2f")
    }

    class func colorAppOrange() -> UIColor{
        return colorDebugMode == true ? UIColor.randomColor() : UIColor.hexColor(hex: "#ff6600")
    }

    // MARK: - Basic Colors
    
    class func colorVeryLightGray() -> UIColor{
        if colorDebugMode{
            return randomColor()
        }else{
            return UIColor.hexColor(hex: "#e9e9e9")
        }
    }
    
    class func colorLightGray() -> UIColor{
        if colorDebugMode{
            return randomColor()
        }else{
            return UIColor.lightGray
        }
    }
    
    class func colorGray() -> UIColor{
        if colorDebugMode{
            return randomColor()
        }else{
            return UIColor.gray
        }
    }
    
    class func colorClear() -> UIColor{
        if colorDebugMode{
            return randomColor()
        }else{
            return UIColor.clear
        }
    }
    
    class func colorWhite() -> UIColor{
        if colorDebugMode{
            return randomColor()
        }else{
            return UIColor.white
        }
    }
    
    class func colorBlue() -> UIColor{
        if colorDebugMode{
            return randomColor()
        }else{
            return UIColor(red: 18.0/255.0, green: 143.0/255.0, blue: 218.0/255.0, alpha: 1.0)
        }
    }
    
    class func colorDarkGray() -> UIColor{
        if colorDebugMode{
            return randomColor()
        }else{
            return UIColor.darkGray
        }
    }
    
    class func colorGreen() -> UIColor{
        if colorDebugMode{
            return randomColor()
        }else{
            return UIColor(red: 85.0/255.0, green: 255.0/255.0, blue: 73.0/255.0, alpha: 1.0)
        }
    }
    
    class func colorRed() -> UIColor{
        if colorDebugMode{
            return randomColor()
        }else{
            return UIColor(red: 251.0/255.0, green: 9.0/255.0, blue: 57.0/255.0, alpha: 1.0)
        }
    }
    
    class func colorBlack() -> UIColor{
        if colorDebugMode{
            return randomColor()
        }else{
            return UIColor.black
        }
    }
    
    class func hexColor(hex:String) -> UIColor {
        if colorDebugMode{
            return UIColor.randomColor()
        }else{
            var cString : String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
            if (cString.hasPrefix("#")) {
                cString.remove(at: cString.startIndex)
            }
            if ((cString.count) != 6) {
                return UIColor.gray
            }
            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
    }
    
    class func randomColor() -> UIColor {
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
