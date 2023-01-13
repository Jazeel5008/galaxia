//
//  UIView+Extensions.swift
//  galaxia
//
//  Created by Meridian Mac Mini on 11/01/23.
//


import UIKit

@IBDesignable
extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        }
        set {
            let cornerRadius = newValue
            
            if UIDevice.current.userInterfaceIdiom == .phone {
                DispatchQueue.main.async {
                    self.layer.cornerRadius = cornerRadius
                }
                
            } else {
                DispatchQueue.main.async {
                    self.layer.cornerRadius = cornerRadius + 5
                }
                
            }
            
        }
    }
    
    @IBInspectable var cornerDivided: CGFloat {
        get {
            return self.cornerDivided
        }
        set {
            DispatchQueue.main.async {
                let cornerRadius = self.frame.size.height / newValue
                self.layer.cornerRadius = CGFloat(Double(cornerRadius))
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    
    

}
