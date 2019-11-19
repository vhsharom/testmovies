//
//  SnackView.swift
//

import UIKit

class SnackView: UIView {
    
    var titleLabel : UILabel!
    var boundsRect = UIScreen.main.bounds
    var skackHeight : CGFloat = 50
    var titlePadding : CGFloat = 5
    
    init() {

        let boundsRect = UIScreen.main.bounds
        let frame = CGRect(x: 0, y: boundsRect.size.height, width: boundsRect.size.width, height: skackHeight)

        super.init(frame: frame)
        self.backgroundColor = UIColor.colorBlack()
        
        titleLabel = UILabel(frame: CGRect(x: titlePadding, y: titlePadding, width:  boundsRect.size.width - titlePadding*2, height: skackHeight - titlePadding - titlePadding))
        titleLabel.textColor = UIColor.white
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.3
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont(name: AppFontNormal, size: 16)
        self.addSubview(titleLabel)
    }
    
    func setTitle(title : String) -> SnackView{
        titleLabel.text = title
        return self
    }
    
    func show(){
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            
            self.frame = CGRect(x: 0, y: self.boundsRect.size.height - self.skackHeight, width: self.boundsRect.size.width, height: self.skackHeight)

            
        }) { (finished) in
            
            UIView.animate(withDuration: 0.2, delay: 2.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                
                self.frame = CGRect(x: 0, y: self.boundsRect.size.height, width: self.boundsRect.size.width, height: self.skackHeight)
                
                
            }) { (finished) in
                
                self.removeFromSuperview()
            }
        }
        
        let application = UIApplication.shared
        let window = application.keyWindow!
        window.addSubview(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
