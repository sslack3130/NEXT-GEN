//
//  ViewController.swift
//  NEXT-GEN
//
//  Created by Steve Slack on 01/02/2016.
//  Copyright © 2016 Steve Slack. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController, UITextFieldDelegate {
    
    //IBOutlets
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loggedIN: UIButton!
    @IBOutlet weak var logoImg: UIImageView!
    
    var isSelected: Bool = false
    var keepLoggedIN: Bool = false
    var tempPwd: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.secureTextEntry = true
        self.passwordTextField.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            
            performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
            
        }
    }
    
    // Setup the Alert
    
    func showErrorAlert(title: String, msg: String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func loginBtnPressed(sender: AnyObject) {
        
        if let email = emailTextField.text where email != "", let pwd = passwordTextField.text where pwd != "" {
            
            DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: {error, authData in
            
                if (error != nil) {
                 
                    if let errorCode = FAuthenticationError(rawValue: error.code) {
                     
                        switch (errorCode) {
                        
                        case .UserDoesNotExist:
                            self.showErrorAlert("Sorry", msg: "Account is not recognised")
                        case .InvalidEmail:
                            self.showErrorAlert("Sorry", msg: "Your email address isn't formatted correctly")
                        case .InvalidPassword:
                            self.showErrorAlert("Sorry", msg: "Your password is incorrect")
                        case .NetworkError:
                            self.showErrorAlert("Error", msg: "You don't appear to a Internet connection.")
                        default:
                            print("default")
                        }
                    }
                } else {
                    
                    if self.keepLoggedIN == true {
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_UID)
                    }
                    
                    if (authData.providerData["isTemporaryPassword"] != nil) {
                      
                    self.performSegueWithIdentifier(SEGUE_CHANGE_PASSWORD, sender: nil)
                        
                    } else {
                    
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                    }
                }
            })
            
        } else {
            
            self.showErrorAlert("Sorry", msg: "Please enter a Username and Password")
        }
    }
    
    @IBAction func resetPasswordBtnPressed(sender: AnyObject) {
        
        if let email = emailTextField.text where email != "" {
            
            DataService.ds.REF_BASE.resetPasswordForUser(email, withCompletionBlock: {error in
            
                if (error != nil) {
                    
                      print(error)

                }else {
                  
                    self.showErrorAlert("Success", msg: "A new password has been sent to your email!")
                }
            
            })
            
        } else {
            
            showErrorAlert("Ooops", msg: "Please enter a email address")
        }
        
    }
    
    @IBAction func keepLoggedInBtnSelected(sender: UIButton) {
    
        if ( isSelected != true) {
            loggedIN.setImage(UIImage(named: "LoggedINYes.png"), forState: UIControlState.Normal)
            keepLoggedIN = true
            isSelected = true
        } else {
            loggedIN.setImage(UIImage(named: "LoggedINNo.png"), forState: UIControlState.Normal)
            isSelected = false
        }
    
    }
}

