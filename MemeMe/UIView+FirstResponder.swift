//
//  UIView+FirstResponder.swift
//  MemeMe
//
//  Created by Alex da Silva Ribeiro on 20/06/17.
//  Copyright © 2017 AlexSilR. All rights reserved.
//

import UIKit

extension UIView {
    func findFirstResponder() -> UIView? {
        if self.isFirstResponder {
            return self
        }
        
        for subView in self.subviews {
            let firstResponder = subView.findFirstResponder()
            
            if firstResponder != nil {
                return firstResponder
            }
        }
        
        return nil
    }
}
