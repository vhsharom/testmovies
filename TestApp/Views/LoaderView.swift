//
//  LoaderView.swift
//  TestApp
//
//

import UIKit
import Lottie

class LoaderView: UIView {

    var lottieView : AnimationView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.colorWhite()
        
        let path = Bundle.main.path(forResource: "loadinganim", ofType: "json")
                                
        lottieView = AnimationView(filePath: path!)
        lottieView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        lottieView.center = self.center
        lottieView.loopMode = LottieLoopMode.loop
        lottieView.play()
            //lottieView.backgroundColor = UIColor.colorWhite()
        self.addSubview(lottieView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
