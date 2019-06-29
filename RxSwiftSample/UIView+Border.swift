//
//  UIView+Border.swift
//  RxSwiftSample
//
//  Created by uhooi on 2019/06/30.
//  Copyright © 2019 chiba. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: Properties
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = newValue > 0
        }
    }
    
}
