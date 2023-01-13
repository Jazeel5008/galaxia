//
//  UIViewController+Extension.swift
//  galaxia
//
//  Created by Meridian Mac Mini on 11/01/23.
//

import UIKit
import Lottie

extension UIViewController{
    
    func activityStartAnimating() {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        backgroundView.backgroundColor = UIColor.APP_TEXTDARK!.withAlphaComponent(0.5)
        backgroundView.tag = 475647
        backgroundView.alpha = 0
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundView.addSubview(blurEffectView)
        
        let activityIndicator: LottieAnimationView? = .init(name: "loader")
        activityIndicator!.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        activityIndicator!.center = backgroundView.center
        activityIndicator!.backgroundColor = .clear
        activityIndicator!.contentMode = .scaleAspectFit
        activityIndicator!.loopMode = .loop
        activityIndicator!.animationSpeed = 2
        activityIndicator!.play()
        
        self.view.isUserInteractionEnabled = false
        
        backgroundView.addSubview(activityIndicator!)
        
        
        DispatchQueue.main.async {
            self.view.addSubview(backgroundView)

            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut) {
                backgroundView.alpha = 1.0
            } completion: { status in

            }


        }
        
    }
    
    func activityStopAnimating() {
        if let background = self.view.viewWithTag(475647){
            
            UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseIn) {
                background.alpha = 0
            } completion: { status in
                background.removeFromSuperview()
            }
        }
        self.view.isUserInteractionEnabled = true
    }

}
