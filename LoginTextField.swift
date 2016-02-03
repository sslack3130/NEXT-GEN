//
//  LoginTextField.swift
//  NEXT-GEN
//
//  Created by Steve Slack on 01/02/2016.
//  Copyright © 2016 Steve Slack. All rights reserved.
//

import UIKit

class LoginTextField: UITextField {

    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.borderWidth = 0
        layer.borderColor = UIColor(red: 87 / 255, green: 87 / 255, blue: 87 / 255, alpha: 1).CGColor
        layer.backgroundColor = UIColor(red: 87 / 255, green: 87 / 255, blue: 87 / 255, alpha: 1).CGColor
        
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }

}
