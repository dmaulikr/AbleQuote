//
//  PersonalViewController.swift
//  AbleQuote
//
//  Created by James Scoltock on 1/8/17.
//  Copyright © 2017 Able. All rights reserved.
//

import UIKit

class PersonalViewController: UIViewController {

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtJobTitle: UITextField!
    @IBOutlet weak var txtEmail: UITextField!

    @IBAction func DonePersonal(sender: AnyObject) {
        
        if isValidEmail(txtEmail.text!) || txtEmail.text == "" {
            gFirstName = txtFirstName.text!
            gLastName = txtLastName.text!
            gJobTitle = txtJobTitle.text!
            gEmail = txtEmail.text!
        
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            let alertController = UIAlertController(title: "Invalid Email", message:
                "Email address is not valid. Try again!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        txtFirstName.text! = gFirstName
        txtLastName.text! = gLastName
        txtJobTitle.text! = gJobTitle
        txtEmail.text! = gEmail
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PersonalViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PersonalViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let range = testStr.rangeOfString(emailRegEx, options:.RegularExpressionSearch)
    let result = range != nil ? true : false
    return result
}


