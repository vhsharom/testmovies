//
//  AlertView.swift
//
//

import UIKit

class AlertView: UIView {

    static let alertDurationZero : Double = 0.0
    static let alertDurationShort : Double = 2.0
    static let alertDurationLong : Double = 4.0
    static let alertDurationVeryShort : Double = 0.5

    var height = UIScreen.main.bounds.size.height

    var activityIndicator: UIActivityIndicatorView!
    var alertBackgroundView: UIView!

    let kWidth : CGFloat = UIScreen.main.bounds.size.width
    let kHeight : CGFloat = 240

    var alertWidth : CGFloat = UIScreen.main.bounds.size.width * 0.8
    var alertHeight : CGFloat = UIScreen.main.bounds.size.width * 0.8 * 0.5

    var backgroundView: UIView!
    var messageLabel: UILabel!

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.backgroundColor = UIColor.clear
        let screen: UIScreen = UIScreen.main
        self.frame = CGRect(x: 0, y: 0, width: screen.bounds.size.width, height: screen.bounds.size.height)
        backgroundView = UIView(frame: self.frame)
        backgroundView.backgroundColor = UIColor.clear
        self.addSubview(backgroundView)

        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone{
            alertWidth = UIScreen.main.bounds.size.width * 0.8
            alertHeight = UIScreen.main.bounds.size.width * 0.8 * 0.5
        }else{
            alertWidth = UIScreen.main.bounds.size.width * 0.5
            alertHeight = UIScreen.main.bounds.size.width * 0.5 * 0.5
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        let screen: UIScreen = UIScreen.main
        self.frame = CGRect(x: 0, y: 0, width: screen.bounds.size.width, height: screen.bounds.size.height)
        backgroundView = UIView(frame: self.frame)
        backgroundView.backgroundColor = UIColor.clear
        self.addSubview(backgroundView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show(message : String) {

        alertBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: alertWidth, height: alertHeight))
        alertBackgroundView.center = self.center
        alertBackgroundView.backgroundColor = UIColor.colorAppPurple()
        alertBackgroundView.layer.cornerRadius = 10
        alertBackgroundView.alpha = 0.0
        self.addSubview(alertBackgroundView)

        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        activityIndicator.frame = CGRect(x: 30, y: 30, width: 30, height: 30)

        activityIndicator.center = CGPoint(x: alertWidth*0.5, y: alertHeight*0.3333)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        activityIndicator.tintColor = UIColor.red
        alertBackgroundView.addSubview(activityIndicator)

        messageLabel = UILabel()
        messageLabel.frame = CGRect(x: 5, y: 0, width: alertWidth - 10, height: alertHeight/2.0)
        messageLabel.center = CGPoint(x: alertWidth/2.0, y: alertHeight*0.75)
        messageLabel.font = UIFont(name: AppFontNormal, size: 18)
        messageLabel.textAlignment = NSTextAlignment.center
        messageLabel.textColor = UIColor.white
        messageLabel.numberOfLines = 2
        messageLabel.minimumScaleFactor = 0.3
        messageLabel.adjustsFontSizeToFitWidth = true
        alertBackgroundView.addSubview(messageLabel)

        messageLabel.text = message

        UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {

            self.alertBackgroundView.alpha = 1.0
            self.alertBackgroundView.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.0);
            self.backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        }) { (finished) in

            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {

                self.alertBackgroundView.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0);

            }) { (finished) in

            }
        }

        let application = UIApplication.shared
        let window = application.keyWindow!
        window.addSubview(self)
    }

    func showMessage(message: String) {
        messageLabel.text = message
    }

    func close(delayTime: Double) {
        if self.alertBackgroundView != nil{
            UIView.animate(withDuration: 0.25, delay: delayTime, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.alertBackgroundView.alpha = 0.0
                self.backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
                //self.aiBackgroundView.layer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01)
            }) { (finished) in
                self.removeFromSuperview()
            }
        }
    }

}

