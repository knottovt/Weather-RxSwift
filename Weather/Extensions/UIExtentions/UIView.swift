//
//  UIView.swift
//  Weather
//
//  Created by Visarut Tippun on 1/1/21.
//

import UIKit

extension UIView {
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    class func loadFromNib<T:UIView>(of type: T.Type) -> T {
        return UINib.init(nibName: self.identifier(), bundle: nil).instantiate(withOwner: nil, options: nil).first as! T
    }
    
}

