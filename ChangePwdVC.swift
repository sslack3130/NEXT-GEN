//
//  ChangePwdVC.swift
//  NEXT-GEN
//
//  Created by Steve Slack on 02/02/2016.
//  Copyright © 2016 Steve Slack. All rights reserved.
//

import UIKit

class ChangePwdVC: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var newPwd: LoginTextField!
    @IBOutlet weak var confirmPwd: LoginTextField!

    var VC: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.confirmPwd.delegate = self
        
        VC = ViewController()

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    @IBAction func backBtnPressed(sender: AnyObject) {
        
         dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    @IBAction func submitBtnPressed(sender: AnyObject) {
        
        print(newPwd.text)
        print(confirmPwd.text)
        
       if let pwd1 = newPwd.text where pwd1 != "", let pwd2 = confirmPwd.text where pwd2 != "" {
        if (pwd1 == pwd2){
            
            print("ok")
        }else {
            
            VC!.showErrorAlert("Error", msg: "The Passwords do not match!")
            
        }
            
        } else {
        
        VC!.showErrorAlert("Error", msg: "The Passwords do not match!")
            
        }

        
    }
    

}
